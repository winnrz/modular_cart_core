import 'package:equatable/equatable.dart';
import 'package:modular_cart_core/src/cart_selected_option.dart';
import 'package:modular_cart_core/src/product.dart';

/// A single line in the cart representing a selected product,
/// its selected options, and the quantity of the product.
///
/// This is the core unit of the cart SDK. Multiple lines can exist
/// for different products or different option combinations.
class CartLine extends Equatable {
  /// The selected product for this line.
  final Product product;

  /// The selected options for this product.
  ///
  /// This list is normalized by sorting by `option.id` during construction.
  /// This ensures two lines with the same product/options are considered equal
  /// regardless of the order the options were provided.
  final List<CartSelectedOption> selectedOptions;

  /// Quantity of the product in this line.
  ///
  /// Quantity is **not** included in equality checks. This allows merging
  /// multiple lines with the same product and options into a single line
  /// with the sum of quantities.
  final int quantity;

  /// Creates a new immutable [CartLine].
  ///
  /// [selectedOptions] is copied and sorted by `option.id` for normalization.
  CartLine({
    required this.product,
    List<CartSelectedOption> selectedOptions = const [],
    this.quantity = 1,
  }) : selectedOptions = List.unmodifiable(
         [...selectedOptions]..sort((a, b) => a.option.id.compareTo(b.option.id)),
       );

  /// Equality for cart lines is based on [product] and [selectedOptions].
  ///
  /// Quantity is intentionally excluded to allow merging.
  @override
  List<Object?> get props => [product, selectedOptions];

  @override
  String toString() {
    final options = selectedOptions.isEmpty
        ? 'None'
        : selectedOptions.map((o) => o.option.id).join(', ');
    return 'CartLine(product: ${product.id}, quantity: $quantity, options: [$options])';
  }
}

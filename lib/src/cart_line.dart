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
  /// [selectedOptions] is normalized to a canonical form:
  /// - Options with the same `option.id` are merged by summing their quantities
  /// - The resulting list is sorted by `option.id`
  ///
  /// This ensures:
  /// - Equality checks are order-insensitive
  /// - Duplicate options inside a single line are avoided
  /// - Pricing and cart behavior remain consistent
  CartLine({
    required this.product,
    List<CartSelectedOption> selectedOptions = const [],
    this.quantity = 1,
  }) : assert(quantity > 0, 'Quantity must be > 0'),
       selectedOptions = List.unmodifiable(() {
         final merged = <String, CartSelectedOption>{};

         for (final selected in selectedOptions) {
           final id = selected.option.id;

           final existing = merged[id];
           if (existing == null) {
             merged[id] = selected;
           } else {
             merged[id] = existing.withAddedQuantity(selected.quantity);
           }
         }

         final result = merged.values.toList()
           ..sort((a, b) => a.option.id.compareTo(b.option.id));

         return result;
       }());

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------
  /// The total price for a cartline.
  double get totalPrice =>
      quantity *
      (product.price + selectedOptions.fold(0, (sum, o) => sum + o.totalPrice));

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Returns a new [CartLine] with optional updated fields.
  ///
  /// Quantity and selected options are normalized automatically.
  CartLine copyWith({
    Product? product,
    List<CartSelectedOption>? selectedOptions,
    int? quantity,
  }) {
    return CartLine(
      product: product ?? this.product,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      quantity: quantity ?? this.quantity,
    );
  }

  // Added for debugging purposes. Not part of the core cart API.
  @override
  String toString() {
    final options = selectedOptions.isEmpty
        ? 'None'
        : selectedOptions.map((o) => o.option.id).join(', ');
    return 'CartLine(product: ${product.id}, quantity: $quantity, options: [$options])';
  }

  // ---------------------------------------------------------------------------
  // Equality
  // ---------------------------------------------------------------------------

  /// Equality for cart lines is based on [product] and [selectedOptions].
  ///
  /// Quantity is intentionally excluded to allow merging.
  @override
  List<Object?> get props => [product, selectedOptions];
}

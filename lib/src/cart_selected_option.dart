import 'package:equatable/equatable.dart';
import 'package:modular_cart_core/src/product_option.dart';

/// A selected option inside a cart line with its own quantity.
///
/// This is a cart-layer model and represents a user's selection,
/// not the option definition itself.
class CartSelectedOption extends Equatable {
  /// The option definition.
  final ProductOption option;

  /// The quantity of this option in the cart line.
  final int quantity;

  /// Creates a new immutable [CartSelectedOption].
  const CartSelectedOption({
    required this.option,
    this.quantity = 1,
  });

  /// Equality is based only on [option] identity.
  ///
  /// Quantity is **not** included so that cart normalization/merging
  /// works properly.
  @override
  List<Object?> get props => [option];

  @override
  String toString() {
    return 'CartSelectedOption(option: ${option.id}, quantity: $quantity)';
  }
}

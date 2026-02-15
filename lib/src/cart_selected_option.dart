import 'package:equatable/equatable.dart';
import 'package:modular_cart_core/src/product_option.dart';

/// A selected option inside a cart line with its own quantity.
///
/// This is a cart-layer model and represents a user's selection,
/// not the option definition itself.
class CartSelectedOption extends Equatable {
  /// The option definition.
  final ProductOption option;

  /// The selected quantity of this option.
  final int quantity;

  const CartSelectedOption({
    required this.option,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [option, quantity];

  @override
  String toString() {
    return 'CartSelectedOption(option: ${option.id}, quantity: $quantity)';
  }
}

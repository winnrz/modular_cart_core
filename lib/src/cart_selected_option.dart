import 'package:equatable/equatable.dart';
import 'package:modular_cart_core/src/product_option.dart';

/// A selected option inside a cart line with its own quantity.
///
/// This is a cart-layer model and represents a user's selection,
/// not the option definition itself.
class CartSelectedOption extends Equatable {
  /// The option definition.
  final ProductOption option;

  /// The quantity of this option in the cart line, per product unit.
  final int quantity;

  /// Creates a new immutable [CartSelectedOption].
  ///
  /// Quantity must be greater than zero.
  const CartSelectedOption({required this.option, this.quantity = 1})
    : assert(quantity > 0, 'Quantity must be > 0');

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------
  /// The total price for this option (quantity * option price).
  double get totalPrice => quantity * option.price;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Returns a copy with updated fields.
  CartSelectedOption copyWith({ProductOption? option, int? quantity}) {
    return CartSelectedOption(
      option: option ?? this.option,
      quantity: quantity ?? this.quantity,
    );
  }

  /// Returns a new instance with [delta] added to the quantity.
  CartSelectedOption withAddedQuantity(int delta) {
    if (delta <= 0) {
      throw ArgumentError('Delta must be greater than zero');
    }

    return copyWith(quantity: quantity + delta);
  }

  /// Returns a new instance with [delta] removed from the quantity.
  ///
  /// The resulting quantity must remain greater than zero.
  CartSelectedOption withRemovedQuantity(int delta) {
    if (delta <= 0) {
      throw ArgumentError('Delta must be greater than zero');
    }

    final newQuantity = quantity - delta;

    if (newQuantity <= 0) {
      throw ArgumentError('Resulting quantity must be greater than zero');
    }

    return copyWith(quantity: newQuantity);
  }

  // Added for debugging purposes. Not part of the core cart API.
  @override
  String toString() {
    return 'CartSelectedOption(option: ${option.id}, quantity: $quantity)';
  }

  // ---------------------------------------------------------------------------
  // Equality
  // ---------------------------------------------------------------------------

  /// Equality is based on both [option] identity and [quantity].
  ///
  /// Two instances with the same [option] but different [quantity] values
  /// are therefore NOT equal.
  ///
  /// This allows a [CartLine] to treat two selections of the same option
  /// with different quantities as different when comparing its
  /// [selectedOptions] list for equality.
  ///
  /// As a result, two [CartLine] instances with the same product but
  /// different option quantities are not considered equal.
  ///
  /// Note that a [CartLine] constructor normalizes its [selectedOptions]
  /// into a canonical representation by merging entries with the same option
  /// and summing their quantities (for example, eggs x2 and eggs x3 become
  /// eggs x5).
  ///
  /// This avoids duplicate option entries inside a single cart line and
  /// guarantees stable equality and pricing behavior.
  @override
  List<Object?> get props => [option, quantity];
}

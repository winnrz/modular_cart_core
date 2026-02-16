import 'package:modular_cart_core/src/cart_line.dart';

/// Represents the shopping cart.
///
/// The cart contains a list of [CartLine] items.
/// The list is immutable — you cannot directly add or remove items.
/// All manipulation should be done via SDK-provided helper methods (to be implemented later).
class Cart {
  /// All lines in the cart.
  final List<CartLine> lines;

  /// Creates a new cart with an optional list of [lines].
  ///
  /// The list is defensively copied and made unmodifiable to preserve immutability.
  Cart({List<CartLine>? lines}) : lines = List.unmodifiable(lines ?? []);
}

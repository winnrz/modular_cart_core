import 'package:modular_cart_core/src/cart_line.dart' show CartLine;

/// Represents the shopping cart.
/// 
/// The cart contains a list of [CartLine] items.  
/// The list is immutable — you cannot directly add/remove items.
/// Use helper methods to manipulate cart lines.
class Cart {
  /// All lines in the cart.
  final List<CartLine> lines;

  Cart({List<CartLine>? lines}) : lines = List.unmodifiable(lines ?? []);
}

import 'package:modular_cart_core/src/cart_line.dart';

/// Represents the shopping cart.
///
/// The cart contains a list of [CartLine] items.
/// The list is immutable — you cannot directly add or remove items.
/// All manipulation returns a new [Cart] instance.
class Cart {
  /// All lines in the cart.
  final List<CartLine> lines;

  /// Creates a new cart with an optional list of [lines].
  ///
  /// The list is defensively copied and made unmodifiable to preserve immutability.
  Cart({List<CartLine>? lines}) : lines = List.unmodifiable(lines ?? []);

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------
  /// The total price of all items in the cart.
  double get totalPrice => lines.fold(0, (sum, line) => sum + line.totalPrice);

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Returns a new [Cart] with [line] added.
  ///
  /// If a line with the same product and selected options already exists
  /// (as defined by [CartLine] equality), their quantities are merged.
  ///
  /// The quantity from [line.quantity] is added to the existing line.
  Cart withAddedLine(CartLine line) {
    final updated = List<CartLine>.from(lines);

    final index = updated.indexOf(line);

    if (index == -1) {
      // No matching line exists — add it directly.
      updated.add(line);
    } else {
      final existing = updated[index];

      updated[index] = CartLine(
        product: existing.product,
        selectedOptions: existing.selectedOptions,
        quantity: existing.quantity + line.quantity,
      );
    }

    return Cart(lines: updated);
  }

  /// Returns a new [Cart] with [delta] removed from the matching cart line.
  ///
  /// The line to be affected is identified using [CartLine] equality
  /// (product + normalized selected options).
  ///
  /// If the resulting quantity becomes zero, the line is removed entirely.
  ///
  /// If the line does not exist, the cart is returned unchanged.
  Cart withRemovedLineQuantity(CartLine line, int delta) {
    if (delta <= 0) {
      throw ArgumentError('Delta must be greater than zero');
    }

    final updated = List<CartLine>.from(lines);

    final index = updated.indexOf(line);

    if (index == -1) {
      // Nothing to remove.
      return this;
    }

    final existing = updated[index];
    final newQuantity = existing.quantity - delta;

    if (delta > existing.quantity) {
      throw ArgumentError('Cannot remove more than current quantity');
    }

    if (newQuantity > 0) {
      updated[index] = CartLine(
        product: existing.product,
        selectedOptions: existing.selectedOptions,
        quantity: newQuantity,
      );
    } else {
      // Quantity reached zero (or below) — remove the line entirely.
      updated.removeAt(index);
    }

    return Cart(lines: updated);
  }
}

// Added for debugging purposes. Not part of the core cart API.
extension CartDebug on Cart {
  /// Returns a detailed string representation of the cart for debugging.
  String getString() {
    if (lines.isEmpty) return 'Cart is empty';

    final buffer = StringBuffer();
    buffer.writeln('Cart contents:');
    buffer.writeln('-------------------------');

    for (final line in lines) {
      buffer.writeln('Product: ${line.product.id}');
      buffer.writeln('  Base price: ${line.product.price}');
      buffer.writeln('  Quantity: ${line.quantity}');
      buffer.writeln('  Options:');

      if (line.selectedOptions.isEmpty) {
        buffer.writeln('    None');
      } else {
        for (final opt in line.selectedOptions) {
          buffer.writeln(
            '    ${opt.option.id} - quantity: ${opt.quantity}, unit price: ${opt.option.price}, total: ${opt.totalPrice}',
          );
        }
      }

      buffer.writeln('  Line subtotal: ${line.totalPrice}');
      buffer.writeln('-------------------------');
    }

    buffer.writeln('Cart total: $totalPrice');
    return buffer.toString();
  }
}

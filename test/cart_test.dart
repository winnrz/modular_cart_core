import 'package:modular_cart_core/src/cart.dart';
import 'package:modular_cart_core/src/cart_line.dart';
import 'package:modular_cart_core/src/product.dart';
import 'package:test/test.dart';

void main() {
  group('Cart', () {
    test('defaults lines to empty unmodifiable list', () {
      final cart = Cart();

      expect(cart.lines, isEmpty);
      expect(
        () => cart.lines.add(CartLine(product: Product(id: 'p1', price: 10))),
        throwsUnsupportedError,
      );
    });

    test('makes defensive unmodifiable copy of provided lines', () {
      final source = [CartLine(product: Product(id: 'p1', price: 10))];

      final cart = Cart(lines: source);
      source.add(CartLine(product: Product(id: 'p2', price: 20)));

      expect(cart.lines, hasLength(1));
      expect(cart.lines.first.product.id, 'p1');
      expect(() => cart.lines.clear(), throwsUnsupportedError);
    });
  });
}

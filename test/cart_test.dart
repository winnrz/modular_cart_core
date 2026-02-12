import 'package:test/test.dart';
import 'package:modular_cart_core/src/cart.dart';
import 'package:modular_cart_core/src/cart_product.dart';

void main() {
  group('Cart', () {
    test('defaults to an empty product list', () {
      final cart = Cart();

      expect(cart.cartProducts, isEmpty);
    });

    test('uses provided products list', () {
      final products = [
        CartProduct(
          id: 'p1',
          name: 'Coffee',
          price: 3.5,
          photoUrl: 'photo://coffee',
        ),
      ];

      final cart = Cart(products);

      expect(cart.cartProducts, same(products));
      expect(cart.cartProducts, hasLength(1));
    });
  });
}

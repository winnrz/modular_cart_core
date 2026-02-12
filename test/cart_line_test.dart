import 'package:test/test.dart';
import 'package:modular_cart_core/src/cart_line.dart';
import 'package:modular_cart_core/src/cart_option.dart';
import 'package:modular_cart_core/src/cart_product.dart';

void main() {
  group('CartLine', () {
    test('calculates total price from product and options', () {
      final product = CartProduct(
        id: 'p1',
        name: 'Coffee',
        price: 10.0,
        photoUrl: 'photo://coffee',
        selectedOptions: [
          CartOption(
            id: 'o1',
            name: 'Milk',
            price: 1.5,
            quantity: 2,
            photoUrl: null,
          ),
          CartOption(
            id: 'o2',
            name: 'Sugar',
            price: 0.5,
            quantity: 1,
            photoUrl: null,
          ),
        ],
      );
      final line = CartLine(product: product, quantity: 3);

      expect(line.totalPrice, 33.5);
    });

    test('isSameAs compares product identity by value', () {
      final product = CartProduct(
        id: 'p1',
        name: 'Coffee',
        price: 10.0,
        photoUrl: 'photo://coffee',
      );
      final lineA = CartLine(product: product, quantity: 1);
      final lineB = CartLine(
        product: CartProduct(
          id: 'p1',
          name: 'Coffee',
          price: 10.0,
          photoUrl: 'photo://coffee',
        ),
        quantity: 10,
      );

      expect(lineA.isSameAs(lineB), isTrue);
    });

    test('toString uses fixed 2-decimal total and option names', () {
      final line = CartLine(
        product: CartProduct(
          id: 'p1',
          name: 'Coffee',
          price: 10.0,
          photoUrl: 'photo://coffee',
          selectedOptions: [
            CartOption(
              id: 'o1',
              name: 'Milk',
              price: 2.0,
              photoUrl: null,
            ),
          ],
        ),
        quantity: 2,
      );

      expect(
        line.toString(),
        'Coffee x2, total: \$22.00, options: Milk',
      );
    });
  });
}

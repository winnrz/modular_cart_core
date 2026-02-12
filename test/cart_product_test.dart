import 'package:test/test.dart';
import 'package:modular_cart_core/src/cart_option.dart';
import 'package:modular_cart_core/src/cart_product.dart';

void main() {
  group('CartProduct', () {
    test('applies defaults', () {
      final product = CartProduct(
        id: 'p1',
        name: 'Coffee',
        price: 3.5,
        photoUrl: 'photo://coffee',
      );

      expect(product.quantity, 1);
      expect(product.description, 'This product has no description.');
      expect(product.selectedOptions, isEmpty);
    });

    test('supports value equality including selected options', () {
      final options = [
        CartOption(
          id: 'o1',
          name: 'Milk',
          price: 0.5,
          photoUrl: 'photo://milk',
        ),
      ];
      final a = CartProduct(
        id: 'p1',
        name: 'Coffee',
        price: 3.5,
        quantity: 2,
        photoUrl: 'photo://coffee',
        description: 'Fresh brew',
        selectedOptions: options,
      );
      final b = CartProduct(
        id: 'p1',
        name: 'Coffee',
        price: 3.5,
        quantity: 2,
        photoUrl: 'photo://coffee',
        description: 'Fresh brew',
        selectedOptions: options,
      );

      expect(a, equals(b));
    });

    test('toString renders None for empty options', () {
      final product = CartProduct(
        id: 'p1',
        name: 'Coffee',
        price: 3.5,
        photoUrl: 'photo://coffee',
      );

      expect(
        product.toString(),
        'CartProduct(id: p1, name: Coffee, price: 3.5, quantity: 1, options: [None], description: This product has no description.)',
      );
    });
  });
}

import 'package:test/test.dart';
import 'package:modular_cart_core/src/cart_option.dart';

void main() {
  group('CartOption', () {
    test('applies default quantity and supports null photoUrl', () {
      final option = CartOption(
        id: 'o1',
        name: 'Milk',
        price: 0.5,
        photoUrl: null,
      );

      expect(option.quantity, 1);
      expect(option.photoUrl, isNull);
    });

    test('supports value equality', () {
      final a = CartOption(
        id: 'o1',
        name: 'Milk',
        price: 0.5,
        quantity: 2,
        photoUrl: 'photo://milk',
      );
      final b = CartOption(
        id: 'o1',
        name: 'Milk',
        price: 0.5,
        quantity: 2,
        photoUrl: 'photo://milk',
      );

      expect(a, equals(b));
    });

    test('toString includes all fields', () {
      final option = CartOption(
        id: 'o1',
        name: 'Milk',
        price: 0.5,
        quantity: 2,
        photoUrl: 'photo://milk',
      );

      expect(
        option.toString(),
        'CartOption(id: o1, name: Milk, price: 0.5, quantity: 2, photoUrl: photo://milk)',
      );
    });
  });
}

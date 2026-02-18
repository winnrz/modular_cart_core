import 'package:modular_cart_core/src/cart_selected_option.dart';
import 'package:modular_cart_core/src/product_option.dart';
import 'package:test/test.dart';

void main() {
  group('CartSelectedOption', () {
    test('stores option and default quantity', () {
      final selected = CartSelectedOption(
        option: ProductOption(id: 'o1', price: 1),
      );

      expect(selected.option.id, 'o1');
      expect(selected.quantity, 1);
    });

    test('stores custom quantity', () {
      final selected = CartSelectedOption(
        option: ProductOption(id: 'o1', price: 1),
        quantity: 3,
      );

      expect(selected.quantity, 3);
    });

    test('equality is based on option identity and quantity', () {
      final a = CartSelectedOption(
        option: ProductOption(id: 'o1', price: 1),
        quantity: 2,
      );
      final b = CartSelectedOption(
        option: ProductOption(id: 'o1', price: 99),
        quantity: 7,
      );
      final c = CartSelectedOption(
        option: ProductOption(id: 'o2', price: 1),
        quantity: 2,
      );

      expect(a, isNot(equals(b)));
      expect(a, isNot(equals(c)));
      expect(
        a,
        equals(
          CartSelectedOption(
            option: ProductOption(id: 'o1', price: 500),
            quantity: 2,
          ),
        ),
      );
    });

    test('toString shows option id and quantity', () {
      final selected = CartSelectedOption(
        option: ProductOption(id: 'o1', price: 1),
        quantity: 2,
      );

      expect(
        selected.toString(),
        'CartSelectedOption(option: o1, quantity: 2)',
      );
    });
  });
}

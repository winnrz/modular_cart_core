import 'package:modular_cart_core/src/cart_line.dart';
import 'package:modular_cart_core/src/cart_selected_option.dart';
import 'package:modular_cart_core/src/product.dart';
import 'package:modular_cart_core/src/product_option.dart';
import 'package:test/test.dart';

void main() {
  group('CartLine', () {
    test('stores product, default quantity, and empty options', () {
      final line = CartLine(
        product: Product(id: 'p1', price: 10),
      );

      expect(line.product.id, 'p1');
      expect(line.quantity, 1);
      expect(line.selectedOptions, isEmpty);
    });

    test('stores unmodifiable copy of selected options', () {
      final input = [
        CartSelectedOption(option: ProductOption(id: 'o1', price: 1), quantity: 2),
      ];

      final line = CartLine(
        product: Product(id: 'p1', price: 10),
        selectedOptions: input,
      );

      input.add(CartSelectedOption(option: ProductOption(id: 'o2', price: 1)));

      expect(line.selectedOptions, hasLength(1));
      expect(() => line.selectedOptions.clear(), throwsUnsupportedError);
    });

    test('equality uses product and selected options only', () {
      final product = Product(id: 'p1', price: 10);
      final option = CartSelectedOption(option: ProductOption(id: 'o1', price: 1));

      final a = CartLine(product: product, selectedOptions: [option], quantity: 1);
      final b = CartLine(product: Product(id: 'p1', price: 999), selectedOptions: [option], quantity: 5);
      final c = CartLine(product: Product(id: 'p1', price: 999), selectedOptions: const [], quantity: 5);

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('toString includes product id, quantity, and option ids', () {
      final line = CartLine(
        product: Product(id: 'p1', price: 10),
        quantity: 2,
        selectedOptions: [
          CartSelectedOption(option: ProductOption(id: 'o1', price: 1), quantity: 2),
          CartSelectedOption(option: ProductOption(id: 'o2', price: 2), quantity: 1),
        ],
      );

      expect(
        line.toString(),
        'CartLine(product: p1, quantity: 2, options: [o1, o2])',
      );
    });

    test('toString prints None when no options', () {
      final line = CartLine(product: Product(id: 'p1', price: 10));

      expect(
        line.toString(),
        'CartLine(product: p1, quantity: 1, options: [None])',
      );
    });
  });
}

import 'package:modular_cart_core/src/cart_line.dart';
import 'package:modular_cart_core/src/cart_selected_option.dart';
import 'package:modular_cart_core/src/product.dart';
import 'package:modular_cart_core/src/product_option.dart';
import 'package:test/test.dart';

void main() {
  group('CartLine', () {
    test('stores product, default quantity, and empty options', () {
      final line = CartLine(product: Product(id: 'p1', price: 10));

      expect(line.product.id, 'p1');
      expect(line.quantity, 1);
      expect(line.selectedOptions, isEmpty);
    });

    test('normalizes selectedOptions order by option id and makes list unmodifiable', () {
      final source = [
        CartSelectedOption(option: ProductOption(id: 'o2', price: 2)),
        CartSelectedOption(option: ProductOption(id: 'o1', price: 1)),
      ];

      final line = CartLine(
        product: Product(id: 'p1', price: 10),
        selectedOptions: source,
      );

      source.add(CartSelectedOption(option: ProductOption(id: 'o3', price: 3)));

      expect(line.selectedOptions.map((s) => s.option.id).toList(), ['o1', 'o2']);
      expect(() => line.selectedOptions.clear(), throwsUnsupportedError);
    });

    test('equality uses only product and selected options (not quantity)', () {
      final a = CartLine(
        product: Product(id: 'p1', price: 10),
        selectedOptions: [
          CartSelectedOption(option: ProductOption(id: 'o2', price: 2)),
          CartSelectedOption(option: ProductOption(id: 'o1', price: 1)),
        ],
        quantity: 1,
      );
      final b = CartLine(
        product: Product(id: 'p1', price: 999),
        selectedOptions: [
          CartSelectedOption(option: ProductOption(id: 'o1', price: 9)),
          CartSelectedOption(option: ProductOption(id: 'o2', price: 8)),
        ],
        quantity: 7,
      );
      final c = CartLine(
        product: Product(id: 'p1', price: 10),
        selectedOptions: [
          CartSelectedOption(option: ProductOption(id: 'o3', price: 3)),
        ],
        quantity: 1,
      );

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('toString includes product id, quantity, and normalized option ids', () {
      final line = CartLine(
        product: Product(id: 'p1', price: 10),
        quantity: 2,
        selectedOptions: [
          CartSelectedOption(option: ProductOption(id: 'o2', price: 2), quantity: 1),
          CartSelectedOption(option: ProductOption(id: 'o1', price: 1), quantity: 2),
        ],
      );

      expect(line.toString(), 'CartLine(product: p1, quantity: 2, options: [o1, o2])');
    });

    test('toString prints None when no options', () {
      final line = CartLine(product: Product(id: 'p1', price: 10));

      expect(line.toString(), 'CartLine(product: p1, quantity: 1, options: [None])');
    });
  });
}

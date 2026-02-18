import 'package:modular_cart_core/src/cart.dart';
import 'package:modular_cart_core/src/cart_line.dart';
import 'package:modular_cart_core/src/cart_selected_option.dart';
import 'package:modular_cart_core/src/product.dart';
import 'package:modular_cart_core/src/product_option.dart';
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

    test('CartDebug getString returns empty message for empty cart', () {
      final cart = Cart();

      expect(cart.getString(), 'Cart is empty');
    });

    test('withAddedLine merges equivalent lines and increments quantity', () {
      final source1 = [
        CartSelectedOption(option: ProductOption(id: 'o2', price: 2)),
        CartSelectedOption(option: ProductOption(id: 'o1', price: 1)),
      ];
      final source2 = [
        CartSelectedOption(option: ProductOption(id: 'o2', price: 2)),
        CartSelectedOption(option: ProductOption(id: 'o1', price: 1)),
      ];

      final line1 = CartLine(
        product: Product(id: 'p1', price: 10),
        selectedOptions: source1,
      );
      final line2 = CartLine(
        product: Product(id: 'p1', price: 10),
        selectedOptions: source2,
      );

      final cart = Cart().withAddedLine(line1).withAddedLine(line2);

      expect(cart.lines, hasLength(1));
      expect(cart.lines.first.quantity, 2);
      expect(
        cart.lines.first.selectedOptions.map((s) => s.option.id).toList(),
        ['o1', 'o2'],
      );
      expect(cart.lines.first.selectedOptions.map((s) => s.quantity).toList(), [
        1,
        1,
      ]);
      expect(cart.totalPrice, 26);
    });

    test(
      'withAddedLine doesn\'t merge lines with same product and options, but different option quantities',
      () {
        final source1 = [
          CartSelectedOption(
            option: ProductOption(id: 'o2', price: 3),
            quantity: 2,
          ),
          CartSelectedOption(option: ProductOption(id: 'o1', price: 1)),
        ];

        final source2 = [
          CartSelectedOption(
            option: ProductOption(id: 'o2', price: 3),
            quantity: 3,
          ),
          CartSelectedOption(option: ProductOption(id: 'o1', price: 1)),
        ];

        final line1 = CartLine(
          product: Product(id: 'p1', price: 10),
          selectedOptions: source1,
        );

        final line2 = CartLine(
          product: Product(id: 'p1', price: 10),
          selectedOptions: source2,
        );

        final line3 = CartLine(
          product: Product(id: 'p1', price: 10),
          selectedOptions: source1,
          quantity: 4,
        );

        final line4 = CartLine(
          product: Product(id: 'p2', price: 10),
          selectedOptions: source2,
          quantity: 1,
        );

        final cart = Cart()
            .withAddedLine(line1)
            .withAddedLine(line2)
            .withAddedLine(line3)
            .withAddedLine(line4);

        print(cart.getString());

        expect(cart.lines, hasLength(3));
        expect(cart.lines.first.quantity, 5);
        expect(cart.totalPrice, 125);
      },
    );

    test('CartDebug getString returns detailed cart output', () {
      final cart = Cart(
        lines: [
          CartLine(
            product: Product(id: 'p1', price: 10),
            quantity: 2,
            selectedOptions: [
              CartSelectedOption(
                option: ProductOption(id: 'o1', price: 1),
                quantity: 3,
              ),
            ],
          ),
          CartLine(product: Product(id: 'p2', price: 5)),
        ],
      );

      final output = cart.getString();

      expect(output, contains('Cart contents:'));
      expect(output, contains('Product: p1'));
      expect(output, contains('Base price: 10.0'));
      expect(output, contains('Quantity: 2'));
      expect(output, contains('o1 - quantity: 3, unit price: 1.0, total: 3.0'));
      expect(output, contains('Line subtotal: 26.0'));
      expect(output, contains('Product: p2'));
      expect(output, contains('None'));
      expect(output, contains('Line subtotal: 5.0'));
      expect(output, contains('Cart total: 31.0'));
    });
  });
}

import 'package:modular_cart_core/src/product_option.dart';
import 'package:test/test.dart';

void main() {
  group('ProductOption', () {
    test('exposes constructor values through getters', () {
      final option = ProductOption(
        id: 'o1',
        price: 2.5,
        metadata: {'name': 'Milk', 'group': 'extras'},
      );

      expect(option.id, 'o1');
      expect(option.price, 2.5);
      expect(option.metadata, {'name': 'Milk', 'group': 'extras'});
    });

    test('metadata is defensively copied and unmodifiable', () {
      final input = {'name': 'Milk'};
      final option = ProductOption(id: 'o1', price: 1, metadata: input);

      input['name'] = 'Sugar';

      expect(option.metadata['name'], 'Milk');
      expect(() => option.metadata['name'] = 'Ice', throwsUnsupportedError);
    });

    test('getMeta returns typed value or null', () {
      final option = ProductOption(
        id: 'o1',
        price: 1,
        metadata: {'name': 'Milk', 'rank': 1},
      );

      expect(option.getMeta<String>('name'), 'Milk');
      expect(option.getMeta<int>('rank'), 1);
      expect(option.getMeta<bool>('rank'), isNull);
      expect(option.getMeta<String>('missing'), isNull);
    });

    test('equality is based on id only', () {
      final a = ProductOption(id: 'o1', price: 1, metadata: {'name': 'A'});
      final b = ProductOption(id: 'o1', price: 999, metadata: {'name': 'B'});
      final c = ProductOption(id: 'o2', price: 1);

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('toString includes id, price, and metadata', () {
      final option = ProductOption(
        id: 'o1',
        price: 1,
        metadata: {'name': 'Milk'},
      );

      expect(
        option.toString(),
        'ProductOption(id: o1, price: 1.0, metadata: {name: Milk})',
      );
    });
  });
}

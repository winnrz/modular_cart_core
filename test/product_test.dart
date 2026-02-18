import 'package:modular_cart_core/src/product.dart';
import 'package:test/test.dart';

void main() {
  group('Product', () {
    test('exposes constructor values through getters', () {
      final product = Product(
        id: 'p1',
        price: 12.5,
        metadata: {'name': 'Coffee', 'hot': true},
      );

      expect(product.id, 'p1');
      expect(product.price, 12.5);
      expect(product.metadata, {'name': 'Coffee', 'hot': true});
    });

    test('metadata is defensively copied and unmodifiable', () {
      final input = {'name': 'Coffee'};
      final product = Product(id: 'p1', price: 10, metadata: input);

      input['name'] = 'Tea';

      expect(product.metadata['name'], 'Coffee');
      expect(() => product.metadata['name'] = 'Water', throwsUnsupportedError);
    });

    test('getMeta returns typed value or null', () {
      final product = Product(
        id: 'p1',
        price: 10,
        metadata: {'name': 'Coffee', 'stock': 3},
      );

      expect(product.getMeta<String>('name'), 'Coffee');
      expect(product.getMeta<int>('stock'), 3);
      expect(product.getMeta<bool>('stock'), isNull);
      expect(product.getMeta<String>('missing'), isNull);
    });

    test('equality is based on id only', () {
      final a = Product(id: 'p1', price: 10, metadata: {'name': 'A'});
      final b = Product(id: 'p1', price: 999, metadata: {'name': 'B'});
      final c = Product(id: 'p2', price: 10);

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('toString includes id, price, and metadata', () {
      final product = Product(
        id: 'p1',
        price: 10,
        metadata: {'name': 'Coffee'},
      );

      expect(
        product.toString(),
        'Product(id: p1, price: 10.0, metadata: {name: Coffee})',
      );
    });
  });
}

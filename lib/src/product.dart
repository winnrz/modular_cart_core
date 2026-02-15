import 'package:equatable/equatable.dart';

/// A minimal, immutable product model used by the cart SDK.
///
/// This class is intentionally database-agnostic and UI-agnostic.
/// Consumers can attach any extra information through [metadata].
class Product extends Equatable {
  /// Unique identifier of the product.
  final String _id;

  /// Base unit price of the product.
  final double _price;

  /// Arbitrary, user-defined metadata attached to this product.
  ///
  /// This can contain anything such as:
  /// - name
  /// - image URL
  /// - category
  /// - custom flags, etc.
  ///
  /// The map is immutable.
  final Map<String, Object?> _metadata;

  /// Creates a new immutable [Product].
  ///
  /// [metadata] is defensively copied and made unmodifiable.
  Product({
    required String id,
    required double price,
    Map<String, Object?> metadata = const {},
  })  : _id = id,
        _price = price,
        _metadata = Map.unmodifiable(metadata);

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------

  /// The unique identifier of the product.
  String get id => _id;

  /// The base unit price of the product.
  double get price => _price;

  /// All user-defined metadata attached to this product.
  ///
  /// This map is read-only.
  Map<String, Object?> get metadata => _metadata;

  // ---------------------------------------------------------------------------
  // Metadata helpers
  // ---------------------------------------------------------------------------

  /// Returns a typed value from [metadata] if it exists and matches [T].
  ///
  /// Returns `null` if the key is missing or the value is not of type [T].
  ///
  /// Example:
  /// ```dart
  /// final name = product.getMeta<String>('name');
  /// ```
  T? getMeta<T>(String key) {
    final value = _metadata[key];
    return value is T ? value : null;
  }

  // ---------------------------------------------------------------------------
  // Equality
  // ---------------------------------------------------------------------------

  /// Products are considered equal if they share the same [id].
  ///
  /// This is intentional so cart normalization and merging
  /// are based on stable product identity.
  @override
  List<Object?> get props => [_id];

  // ---------------------------------------------------------------------------
  // Debugging
  // ---------------------------------------------------------------------------

  @override
  String toString() {
    return 'Product(id: $_id, price: $_price, metadata: $_metadata)';
  }
}

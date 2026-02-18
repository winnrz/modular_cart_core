import 'package:equatable/equatable.dart';

/// A selectable option that can be attached to a cart item (product).
///
/// This model is intentionally lightweight and database-agnostic.
/// Any display or domain-specific fields (name, image, group, etc.)
/// should be provided through [metadata].
class ProductOption extends Equatable {
  /// Unique identifier of the option.
  final String _id;

  /// Unit price of this option.
  final double _price;

  /// Arbitrary, user-defined metadata attached to this option.
  ///
  /// Examples:
  /// - name
  /// - imageUrl
  /// - group (e.g. "sauces", "extras")
  /// - any custom fields
  ///
  /// The map is immutable.
  final Map<String, Object?> _metadata;

  /// Creates a new immutable [ProductOption].
  ///
  /// [metadata] is defensively copied and made unmodifiable.
  ProductOption({
    required String id,
    required double price,
    Map<String, Object?> metadata = const {},
  }) : _id = id,
       _price = price,
       _metadata = Map.unmodifiable(metadata);

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------

  /// The unique identifier of the option.
  String get id => _id;

  /// The unit price of the option.
  double get price => _price;

  /// All user-defined metadata attached to this option.
  ///
  /// This map is read-only.
  Map<String, Object?> get metadata => _metadata;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Returns a typed value from [metadata] if it exists and matches [T].
  ///
  /// Returns `null` if the key is missing or the value is not of type [T].
  ///
  /// Example:
  /// ```dart
  /// final name = option.getMeta<String>('name');
  /// ```
  T? getMeta<T>(String key) {
    final value = _metadata[key];
    return value is T ? value : null;
  }

  // Added for debugging purposes. Not part of the core cart API.
  @override
  String toString() {
    return 'ProductOption(id: $_id, price: $_price, metadata: $_metadata)';
  }

  // ---------------------------------------------------------------------------
  // Equality
  // ---------------------------------------------------------------------------

  /// Options are considered equal if they share the same [id].
  @override
  List<Object?> get props => [_id];
}

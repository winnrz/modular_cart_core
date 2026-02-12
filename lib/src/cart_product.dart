import 'package:equatable/equatable.dart';
import 'cart_option.dart';

class CartProduct extends Equatable {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String photoUrl;
  final String? description;
  final List<CartOption> selectedOptions;

  CartProduct({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.photoUrl,
    this.description = 'This product has no description.',
    this.selectedOptions = const [],
  });

  @override
  List<Object?> get props => [id, name, price, quantity, photoUrl, description, selectedOptions];

  @override
  String toString() {
    final options = selectedOptions.isEmpty
        ? 'None'
        : selectedOptions.map((o) => o.name).join(', ');
    return 'CartProduct(id: $id, name: $name, price: $price, quantity: $quantity, options: [$options], description: $description)';
  }
}

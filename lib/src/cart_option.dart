import 'package:equatable/equatable.dart';

class CartOption extends Equatable {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String? photoUrl;

  CartOption({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.photoUrl,
  });
  
  @override
  List<Object?> get props => [id, name, price, quantity, photoUrl];

  @override
  String toString() {
    return 'CartOption(id: $id, name: $name, price: $price, quantity: $quantity, photoUrl: $photoUrl)';
  }
}

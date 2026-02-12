import 'cart_product.dart';

class Cart {
  final List<CartProduct> cartProducts;

  Cart([List<CartProduct>? products]) : cartProducts = products ?? [];

  //TODO: add methods to add/remove products, calculate total price, etc.

  
}

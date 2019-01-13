import 'package:nintendo_fans/model/game.dart';

class CartViewModel {
  final Game product;
  int get totalQuantity => product.eshopPrice;
  void addQuantity() => product.eshopPrice < 10 ? product.eshopPrice++ : null;
  void deleteQuantity() => product.eshopPrice > 0 ? product.eshopPrice-- : null;

  CartViewModel({this.product});
}

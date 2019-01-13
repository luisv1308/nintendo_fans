import 'package:flutter/material.dart';
import 'package:nintendo_fans/logic/block/product_block.dart';

class ProductProvider extends InheritedWidget {
  final ProductBloc productBloc;
  final Widget child;

  ProductProvider({this.productBloc, this.child}) : super(child: child);

  static ProductProvider of(BuildContext context) => context.inheritFromWidgetOfExactType(ProductProvider);

  @override
  bool updateShouldNotify(ProductProvider oldWidget) => productBloc != oldWidget.productBloc;
}

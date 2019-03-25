import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nintendo_fans/inherited/product_provider.dart';
import 'package:nintendo_fans/logic/block/product_block.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/pages/store_details/shopping_widget.dart';
import 'package:nintendo_fans/widgets/common_scaffold.dart';
import 'package:nintendo_fans/widgets/login_background.dart';

class StoreDetailsPage extends StatelessWidget {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  final Game game;

  StoreDetailsPage({this.game});

  Widget bodyData(Game product) => StreamBuilder<List<Game>>(builder: (context, snapshot) {
        return product != null
            ? Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LoginBackground(
                    showIcon: false,
                    image: product.image,
                  ),
                  ShoppingWidgets(product: product),
                ],
              )
            : Center(child: CircularProgressIndicator());
      });

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = ProductBloc();
    return ProductProvider(
      productBloc: productBloc,
      child: CommonScaffold(
        backGroundColor: Colors.orange[200],
        actionFirstIcon: null,
        appTitle: this.game.title,
        showFAB: true,
        scaffoldKey: _scaffoldState,
        showDrawer: false,
        centerDocked: true,
        floatingIcon: Icons.add_shopping_cart,
        bodyData: bodyData(this.game),
        showBottomNav: true,
        game: game,
      ),
    );
  }
}

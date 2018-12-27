import 'dart:async';

import 'package:nintendo_fans/logic/viewmodel/product_view_model.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:nintendo_fans/services/store/store_service.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Game>>();
  Stream<List<Game>> get productItems => productController.stream;
  StoreService service = StoreService(RestClient());

  ProductBloc() {
    var res = service.allGames();
    List<Game> gameList = List();
    res.then((data) {
      List<dynamic> games = data.content;
      games.forEach((game) {
        Game newGame = Game.fromJson(game);
        gameList.add(newGame);
      });
      productController.add(gameList);
    });
  }
}

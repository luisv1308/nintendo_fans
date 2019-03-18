import 'dart:async';

import 'package:nintendo_fans/logic/viewmodel/product_view_model.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:nintendo_fans/services/store/store_service.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Game>>();
  Stream<List<Game>> get productItems => productController.stream;
  List<Game> gamesItems = List();
  StoreService service = StoreService(RestClient());
  dynamic meta;

  // ProductBloc() {
  //   var res = service.allGames();
  //   List<Game> gameList = List();
  //   res.then((data) {
  //     List<dynamic> games = data.content;
  //     this.meta = data.meta;

  //     games.forEach((game) {
  //       Game newGame = Game.fromJson(game);
  //       gameList.add(newGame);
  //     });
  //     productController.add(gameList);
  //   });
  // }

  Future<List<Game>> getGameList() async {
    var res = service.allGames();

    return res.then((data) {
      List<dynamic> games = data.content;
      List<Game> gamesList = List();
      this.meta = data.meta;
      games.forEach((game) {
        Game newGame = Game.fromJson(game);
        gamesList.add(newGame);
      });

      return gamesList;
    });
  }

  Future<List<Game>> moreProducts(String url) async {
    var res = service.pageGames(url);

    return await res.then((data) {
      List<dynamic> games = data.content;
      List<Game> gamesList = List();
      this.meta = data.meta;
      games.forEach((game) {
        Game newGame = Game.fromJson(game);
        gamesList.insert(0, newGame);
      });

      return gamesList;
    });
  }

  Future<List<Game>> getGameListQuery(query) async {
    var res = service.fullGames();

    return res.then((data) {
      List<dynamic> games = data.content;
      List<Game> gamesList = List();
      this.meta = data.meta;
      games.forEach((game) {
        Game newGame = Game.fromJson(game);
        if (newGame.title.toLowerCase().contains(query)) {
          gamesList.add(newGame);
        }
      });

      return gamesList;
    });
  }
}

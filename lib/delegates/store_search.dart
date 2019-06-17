import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/logic/block/product_block.dart';
import 'package:nintendo_fans/pages/store_details_page.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:nintendo_fans/services/store/store_service.dart';
import 'package:transparent_image/transparent_image.dart';

class StoreSearch extends SearchDelegate<Game> {
  Future<List<Game>> games;
  ProductBloc productBloc = ProductBloc();
  final storage = new FlutterSecureStorage();
  final StoreService service = StoreService(RestClient());
  var userID;

  StoreSearch() {
    // games = productBloc.getGameList().then((res) {
    //   return res;
    // });
  }

  Future<List<Game>> load() {
    if (productBloc.meta == null) {
      return games = productBloc
          .moreProducts(
              'http://phplaravel-175876-509694.cloudwaysapps.com/api/recentGames?page=1')
          .then((res) {
        return res;
      });
    } else {
      return games =
          productBloc.moreProducts(productBloc.meta['next']).then((res) {
        return res;
      });
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search Games",
            ),
          )
        ],
      );
    }
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    // TODO: implement buildResults
    return PagewiseGridView.count(
      // key: new PageStorageKey('myListView'),
      pageSize: 40,
      crossAxisCount:
          (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childAspectRatio: 0.888,
      padding: EdgeInsets.all(15.0),
      itemBuilder: _itemBuilder,
      noItemsFoundBuilder: (context) {
        return Text('No Items Found');
      },
      pageFuture: (pageIndex) async {
        await Future.delayed(Duration(seconds: 0, milliseconds: 700));
        if (pageIndex == 0) {
          Future<List<Game>> list2;
          list2 = productBloc.getGameListQuery(query.toLowerCase()).then((res) {
            return res;
          });
          return list2;
        } else {
          // end
          if (this.productBloc.meta['next'] == null) {
            throw 'I am an exception!';
          }
          return load();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(
      child: new Text(
        "Search Games",
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  Widget _itemBuilder(context, entry, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.yellow,
        child: InkResponse(
          // onDoubleTap: () => this.favourite(entry, index),
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreDetailsPage(game: entry),
                ),
              ),
          child: Material(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                imageStack(entry.image),
                descStack(entry),
                ratingStack(entry.rating),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageStack(String img) => FadeInImage.memoryNetwork(
        image: img,
        placeholder: kTransparentImage,
        fit: BoxFit.cover,
      );

  //stack2
  Widget descStack(Game product) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                product.eshopPrice.toString() != "0"
                    ? Text("\$ ${product.eshopPrice.toString()}",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold))
                    : Text("N/A")
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(String rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.cyanAccent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating,
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );

  Widget favoriteStack(bool fav) => Positioned(
        top: 0.0,
        right: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: fav ? Colors.redAccent : Colors.transparent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
            ],
          ),
        ),
      );

  void favourite(Game game, int index) {
    if (game.favourite) {
      deleteFavourite(game, index);
    } else {
      saveFavourite(game, index);
    }
  }

  void saveFavourite(Game game, int index) async {
    this.userID = await this.storage.read(key: 'user_id');
    this.service.userFavourite(this.userID, game.id.toString()).then((res) {
      this.showSnackBar(
          "You are now following " + game.title + "!", game, index);
      // setState(() {
      game.favourite = true;
      // });
    });
  }

  void deleteFavourite(Game game, int index) async {
    this.userID = await this.storage.read(key: 'user_id');
    this
        .service
        .userDeleteFavourite(this.userID, game.id.toString())
        .then((res) {
      print(res.message);
      this.showSnackBar(
          "You are not more  following " + game.title + "!", game, index);
      // setState(() {
      game.favourite = false;
      // });
    });
  }

  void showSnackBar(String message, Game game, int index) async {
    // this.scaffoldKey.currentState.showSnackBar(SnackBar(
    //   backgroundColor: Colors.orange[800],
    //   content: Text(
    //     message,
    //   ),
    //   // action: SnackBarAction(
    //   //   textColor: Colors.white,
    //   //   label: "Undo",
    //   //   onPressed: () {
    //   //     deleteFavourite(game, index);
    //   //   },
    //   // ),
    // ));
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:nintendo_fans/logic/block/product_block.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/pages/store_details_page.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:nintendo_fans/services/store/store_service.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreNewReleasesPage extends StatefulWidget {
  final scaffoldKey;
  final storage = new FlutterSecureStorage();
  final StoreService service = StoreService(RestClient());

  StoreNewReleasesPage(this.scaffoldKey);

  @override
  _StoreNewReleasesPageState createState() => _StoreNewReleasesPageState();
}

class _StoreNewReleasesPageState extends State<StoreNewReleasesPage>
    with AutomaticKeepAliveClientMixin<StoreNewReleasesPage> {
  var list = List();
  var userID;
  Future<List<Game>> games;
  ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    games = productBloc.getNewReleasesList().then((res) {
      return res;
    });
    super.initState();
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

  Widget _itemBuilder(context, Game entry, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.yellow,
        child: InkResponse(
          onDoubleTap: () => this.favourite(entry, index),
          onTap: () => Navigator.of(context).push(
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
                favoriteStack(entry.favourite)
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
    this.userID = await widget.storage.read(key: 'user_id');
    widget.service.userFavourite(this.userID, game.id.toString()).then((res) {
      this.showSnackBar(
          "You are now following " + game.title + "!", game, index);
      setState(() {
        game.favourite = true;
      });
    });
  }

  void deleteFavourite(Game game, int index) async {
    this.userID = await widget.storage.read(key: 'user_id');
    widget.service
        .userDeleteFavourite(this.userID, game.id.toString())
        .then((res) {
      print(res.message);
      this.showSnackBar(
          "You are not more  following " + game.title + "!", game, index);
      setState(() {
        game.favourite = false;
      });
    });
  }

  void showSnackBar(String message, Game game, int index) async {
    widget.scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.orange[800],
      content: Text(
        message,
      ),
      // action: SnackBarAction(
      //   textColor: Colors.white,
      //   label: "Undo",
      //   onPressed: () {
      //     deleteFavourite(game, index);
      //   },
      // ),
    ));
  }

  @override
  Widget build(BuildContext context) {
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
          return games;
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

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

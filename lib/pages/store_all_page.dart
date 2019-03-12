import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:nintendo_fans/logic/block/product_block.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/pages/store_details_page.dart';
import 'package:transparent_image/transparent_image.dart';

class StoreAllPage extends StatefulWidget {
  final scaffoldKey;
  StoreAllPage(this.scaffoldKey);
  @override
  _StoreAllPageState createState() => _StoreAllPageState();
}

class _StoreAllPageState extends State<StoreAllPage> with AutomaticKeepAliveClientMixin<StoreAllPage> {
  var list = List();
  Future<List<Game>> games;
  ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    games = productBloc.getGameList().then((res) {
      return res;
    });
    super.initState();
  }

  Future<List<dynamic>> load() {
    if (productBloc.meta == null) {
      return games = productBloc.moreProducts('http://phplaravel-175876-509694.cloudwaysapps.com/api/recentGames?page=2').then((res) {
        return res;
      });
    } else {
      return games = productBloc.moreProducts(productBloc.meta['next']).then((res) {
        return res;
      });
    }
  }

  Widget _itemBuilder(context, entry, _) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.yellow,
        child: InkResponse(
          onDoubleTap: () => showSnackBar(entry.title),
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
              children: <Widget>[imageStack(entry.image), descStack(entry), ratingStack(4.00), favoriteStack(entry.favourite)],
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
                product.eshopPrice.toString() != "0" ? Text("\$ ${product.eshopPrice.toString()}", style: TextStyle(color: Colors.yellow, fontSize: 18.0, fontWeight: FontWeight.bold)) : Text("N/A")
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(double rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.9), borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
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
                rating.toString(),
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
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.9), borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
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

  void showSnackBar(String title) {
    widget.scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.orange[800],
      content: Text(
        "You are now following $title!",
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: "Undo",
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PagewiseGridView.count(
      // key: new PageStorageKey('myListView'),
      pageSize: 40,
      crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childAspectRatio: 0.888,
      padding: EdgeInsets.all(15.0),
      itemBuilder: _itemBuilder,
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

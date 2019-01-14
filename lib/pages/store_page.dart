import 'package:flutter/material.dart';
import 'package:nintendo_fans/logic/block/product_block.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/pages/store_details_page.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/widgets/common_drawer.dart';
import 'package:nintendo_fans/widgets/custom_float.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class StorePage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // _context = context;
    return CommonScaffoldMutable(
      scaffoldKey: scaffoldKey,
      appTitle: "Products",
      showDrawer: true,
      showFAB: false,
      actionFirstIcon: Icons.shopping_cart,
      // bodyData: bodyData(),
    );
  }
}

class CommonScaffoldMutable extends StatefulWidget {
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final floatingIcon;
  final centerDocked;
  final elevation;

  CommonScaffoldMutable({this.appTitle, this.bodyData, this.showFAB = false, this.showDrawer = false, this.backGroundColor, this.actionFirstIcon = Icons.search, this.scaffoldKey, this.showBottomNav = false, this.centerDocked = false, this.floatingIcon, this.elevation = 4.0});

  @override
  _MyCommonScaffoldState createState() => new _MyCommonScaffoldState();
}

class _MyCommonScaffoldState extends State<CommonScaffoldMutable> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext _context;
  ProductBloc productBloc = ProductBloc();
  Future<List<Game>> games;

  void initState() {
    games = productBloc.getGameList().then((res) {
      return res;
    });
    super.initState();
    // list.addAll(List.generate(30, (v) => v));
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

  Widget myBottomBar() => BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Ink(
          height: 50.0,
          decoration: new BoxDecoration(gradient: new LinearGradient(colors: UIData.kitGradients)),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                child: new InkWell(
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  onTap: () {},
                  child: Center(
                    child: new Text(
                      "ADD TO WISHLIST",
                      style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
              new SizedBox(
                width: 20.0,
              ),
              SizedBox(
                height: double.infinity,
                child: new InkWell(
                  onTap: () {},
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  child: Center(
                    child: new Text(
                      "ORDER PAGE",
                      style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

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
              children: <Widget>[
                imageStack(entry.image),
                descStack(entry),
                ratingStack(4.00),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      key: widget.scaffoldKey != null ? widget.scaffoldKey : null,
      backgroundColor: widget.backGroundColor != null ? widget.backGroundColor : null,
      appBar: AppBar(
        elevation: widget.elevation,
        backgroundColor: Colors.orange[800],
        title: Text(widget.appTitle, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(widget.actionFirstIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: widget.showDrawer ? CommonDrawer() : null,
      // body: bodyData(),
      body: PagewiseGridView.count(
        pageSize: 40,
        crossAxisCount: (MediaQuery.of(_context).orientation == Orientation.portrait) ? 2 : 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.888,
        padding: EdgeInsets.all(15.0),
        itemBuilder: _itemBuilder,
        pageFuture: (pageIndex) async {
          await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
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
      ),
      floatingActionButton: widget.showFAB
          ? CustomFloat(
              builder: widget.centerDocked
                  ? Text(
                      "5",
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    )
                  : null,
              icon: widget.floatingIcon,
              qrCallback: () {},
            )
          : null,
      floatingActionButtonLocation: widget.centerDocked ? FloatingActionButtonLocation.centerDocked : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: widget.showBottomNav ? myBottomBar() : null,
    );
  }
}

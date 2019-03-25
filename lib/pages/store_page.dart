import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nintendo_fans/delegates/store_search.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/pages/store_all_page.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/widgets/common_drawer.dart';
import 'package:nintendo_fans/widgets/custom_float.dart';

class StorePage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // _context = context;
    return CommonScaffoldMutable(
      scaffoldKey: scaffoldKey,
      appTitle: "Games",
      showDrawer: true,
      showFAB: false,
      actionFirstIcon: Icons.search,
      floatingIcon: Icons.thumb_up,
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
  Future<List<Game>> games;

  void hungryBear(Future<List<Game>> games) {
    setState(() {
      this.games = games;
    });
  }

  void initState() {
    super.initState();
    // list.addAll(List.generate(30, (v) => v));
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          key: widget.scaffoldKey != null ? widget.scaffoldKey : null,
          // key: new PageStorageKey('myListView'),
          backgroundColor: widget.backGroundColor != null ? widget.backGroundColor : null,
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.white),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 48.0,
                  alignment: Alignment.center,
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Text("All"),
                      Text("New Releases"),
                      Text("Sales"),
                      Text("Coming Soon"),
                      Text("Favourites"),
                    ],
                  ),
                ),
              ),
            ),
            elevation: widget.elevation,
            backgroundColor: Colors.orange[800],
            title: Text(widget.appTitle, style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: StoreSearch());
                },
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
          body: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            key: new PageStorageKey('myListView'),
            children: [
              StoreAllPage(widget.scaffoldKey),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
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
        ),
      ),
    );
  }
}

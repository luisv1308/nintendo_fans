import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nintendo_fans/model/game.dart';
import 'package:nintendo_fans/pages/login_page.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/widgets/common_drawer.dart';
import 'package:nintendo_fans/widgets/custom_float.dart';
import 'package:nintendo_fans/widgets/popup_menu.dart';
import 'package:share/share.dart';

class CommonScaffold extends StatelessWidget {
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
  final Game game;
  BuildContext context;
  // Create storage
  final storage = new FlutterSecureStorage();

  CommonScaffold(
      {this.appTitle,
      this.bodyData,
      this.showFAB = false,
      this.showDrawer = false,
      this.backGroundColor,
      this.actionFirstIcon = Icons.search,
      this.scaffoldKey,
      this.showBottomNav = false,
      this.centerDocked = false,
      this.floatingIcon,
      this.elevation = 4.0,
      this.game});

  Widget myBottomBar(BuildContext context) => BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Ink(
          height: 50.0,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: UIData.kitGradients)),
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
                      "ADD TO FAVOURITES",
                      style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                  onTap: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share(
                        'Check ${this.game.title} Nintendo Switch! https://www.nintendo.com/games/detail/${this.game.slug}');
                  },
                  radius: 10.0,
                  splashColor: Colors.yellow,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "SHARE",
                          style: new TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        new SizedBox(
                          width: 20.0,
                        ),
                        Icon(Icons.share),
                      ],
                    ),
                  ),
                  // child: Center(
                  //   child: new Text(
                  //     "SHARE",
                  //     style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      );

  Choice _selectedChoice = choices[0];

  Future _select(Choice choice) async {
    if (choice.title == 'Logout') {
      await storage.deleteAll();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
    }
    // Causes the app to rebuild with the new _selectedChoice.
    // setState(() {
    _selectedChoice = choice;
    // });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      appBar: AppBar(
        elevation: elevation,
        backgroundColor: Colors.orange[800],
        title: Text(appTitle, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(actionFirstIcon),
          ),
          // overflow menu
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.skip(0).map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: showDrawer ? CommonDrawer() : null,
      body: bodyData,
      // floatingActionButton: showFAB
      //     ? CustomFloat(
      //         builder: centerDocked
      //             ? Text(
      //                 "5",
      //                 style: TextStyle(color: Colors.white, fontSize: 10.0),
      //               )
      //             : null,
      //         icon: floatingIcon,
      //         qrCallback: () {},
      //       )
      //     : null,
      // floatingActionButtonLocation: centerDocked ? FloatingActionButtonLocation.centerDocked : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: showBottomNav ? myBottomBar(context) : null,
    );
  }
}

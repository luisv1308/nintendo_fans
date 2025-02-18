import 'package:flutter/material.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/widgets/common_drawer.dart';
import 'package:nintendo_fans/widgets/custom_float.dart';

class CommonTabs extends StatelessWidget {
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

  CommonTabs({this.appTitle, this.bodyData, this.showFAB = false, this.showDrawer = false, this.backGroundColor, this.actionFirstIcon = Icons.search, this.scaffoldKey, this.showBottomNav = false, this.centerDocked = false, this.floatingIcon, this.elevation = 4.0});

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
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.share),
                    alignment: Alignment(0.0, 0.0),
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

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
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
      bottomNavigationBar: showBottomNav ? myBottomBar() : null,
    );
  }
}

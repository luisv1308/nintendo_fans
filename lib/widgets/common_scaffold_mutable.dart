import 'package:flutter/material.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/widgets/common_drawer.dart';
import 'package:nintendo_fans/widgets/custom_float.dart';

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
    return Scaffold(
      key: widget.scaffoldKey != null ? widget.scaffoldKey : null,
      backgroundColor: widget.backGroundColor != null ? widget.backGroundColor : null,
      appBar: AppBar(
        elevation: widget.elevation,
        backgroundColor: Colors.red[400],
        title: Text(widget.appTitle),
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
      body: widget.bodyData,
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

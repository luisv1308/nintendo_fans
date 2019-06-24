import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nintendo_fans/pages/news_page.dart';
import 'package:nintendo_fans/pages/profile_page.dart';
import 'package:nintendo_fans/pages/settings_page.dart';
import 'package:nintendo_fans/pages/store_page.dart';
import 'package:nintendo_fans/widgets/about_tile.dart';

class CommonDrawer extends StatefulWidget {
  final storage = new FlutterSecureStorage();
  String username = "";
  String email = "";

  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  void initState() {
    this.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return creatingBodyData();
  }

  Widget creatingBodyData() => FutureBuilder<String>(
        future: this.getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.orange[800]),
                  accountName: Text(
                    widget.username,
                  ),
                  accountEmail: Text(
                    widget.email,
                  ),
                  // currentAccountPicture: new CircleAvatar(
                  //   backgroundImage: new AssetImage(UIData.pkImage),
                  // ),
                ),
                new ListTile(
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      ),
                  title: Text(
                    "Profile",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ),
                new ListTile(
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StorePage(),
                        ),
                      ),
                  title: Text(
                    "Store",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                ),
                new ListTile(
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewsPage(),
                        ),
                      ),
                  title: Text(
                    "News",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.dashboard,
                    color: Colors.red,
                  ),
                ),
                new ListTile(
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      ),
                  title: Text(
                    "Settings",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                  ),
                  leading: Icon(
                    Icons.timeline,
                    color: Colors.cyan,
                  ),
                ),
                Divider(),
                Divider(),
                MyAboutTile()
              ],
            ),
          );
        },
      );
  Future<String> getUserInfo() async {
    String usname = await widget.storage.read(key: 'user_name');
    String em = await widget.storage.read(key: 'user_email');
    // setState(() {
    widget.username = usname;
    widget.email = em;
    // });
    return usname;
  }
}

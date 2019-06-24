import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nintendo_fans/pages/profile_fields/password_field.dart';
import 'package:nintendo_fans/pages/profile_fields/username_field.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/widgets/common_scaffold_mutable.dart';
import 'package:nintendo_fans/widgets/common_switch.dart';

class ProfilePage extends StatefulWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final storage = new FlutterSecureStorage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    this.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldMutable(
        scaffoldKey: widget.scaffoldKey,
        appTitle: "Profile",
        showDrawer: false,
        showFAB: false,
        backGroundColor: Colors.grey.shade300,
        bodyData: creatingBodyData(),
        actionFirstIcon: null);
  }

  Widget creatingBodyData() => FutureBuilder<String>(
        future: this.getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return SingleChildScrollView(
            child: Theme(
              data: ThemeData(fontFamily: UIData.ralewayFont),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //1
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "General Information",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          title: Text(this.username),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UsernameField(),
                                ),
                              ),
                          // trailing: Icon(Icons.arrow_right),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.red,
                          ),
                          title: Text(this.email),
                          // trailing: Icon(Icons.arrow_right),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          title: Text("Password"),
                          trailing: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PasswordField(),
                                ),
                              ),
                          // trailing: Icon(Icons.arrow_right),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Future<String> getUserInfo() async {
    String usname = await widget.storage.read(key: 'user_name');
    String em = await widget.storage.read(key: 'user_email');
    // setState(() {
    this.username = usname;
    this.email = em;
    // });
    return usname;
  }
}

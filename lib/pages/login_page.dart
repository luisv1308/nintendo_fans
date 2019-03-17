import 'package:flutter/material.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:nintendo_fans/utils/translations.dart';
import 'package:nintendo_fans/services/login/login_service.dart';
import 'package:nintendo_fans/services/restclientlogin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nintendo_fans/utils/uidata.dart';

class LoginPage extends StatefulWidget {
  final LoginService service = LoginService(RestClientLogin());
  final storage = new FlutterSecureStorage();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => new _CreateLogin();
}

class _CreateLogin extends State<LoginPage> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    // for testing
    _usernameController.text = 'l.velasquez1308@gmail.com';
    _passwordController.text = 'testing';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Center(
          child: loginBody(context),
        ),
      ),
    );
  }

  loginBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields(context)],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            colors: Colors.orange,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome to ${UIData.appName}",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign in to continue",
            // style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  loginFields(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a username';
                  }
                },
                controller: _usernameController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  labelText: "Username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                },
                controller: _passwordController,
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  Translations.of(context).text("login"),
                  // style: TextStyle(color: Colors.white),
                ),
                // color: Colors.green,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world, you'd
                    // often want to call a server or save the information in a database
                    widget.scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
                    var res = widget.service.login(_usernameController.text, _passwordController.text);
                    res.then((data) async {
                      print(data.message);
                      widget.scaffoldKey.currentState.removeCurrentSnackBar();
                      await widget.storage.write(key: 'access_token', value: data.content['access_token']);
                      // print(data.content['access_token']);
                      widget.service.getUser().then((dat) async {
                        print(dat.content);
                        await widget.storage.write(key: 'user_name', value: dat.content['name']);
                        await widget.storage.write(key: 'user_email', value: dat.content['email']);
                        await widget.storage.write(key: 'user_id', value: dat.content['id'].toString());
                        Navigator.pushReplacementNamed(context, UIData.homeRoute);
                      });
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              child: Text(
                "SIGN UP FOR AN ACCOUNT",
                // style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      );
}

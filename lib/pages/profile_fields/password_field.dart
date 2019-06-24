import 'package:flutter/material.dart';
import 'package:nintendo_fans/widgets/common_scaffold.dart';
import 'package:nintendo_fans/widgets/label_below_icon.dart';

class PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: 'NEW PASSWORD',
      actionFirstIcon: null,
      bodyData: bodyData(),
    );
  }

  Widget bodyData() => Material(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a Password';
                      }
                    },
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  shape: StadiumBorder(),
                  child: Text(
                    "UPDATE",
                    // style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      );
}

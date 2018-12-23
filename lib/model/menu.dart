import 'package:flutter/material.dart';

class Menu {
  String title;
  IconData icon;
  String image;
  String url;
  BuildContext context;
  Color menuColor;

  Menu({this.title, this.icon, this.image, this.url, this.context, this.menuColor = Colors.black});
}

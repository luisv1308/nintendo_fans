import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nintendo_fans/pages/home_page.dart';
import 'package:nintendo_fans/pages/login_page.dart';
import 'package:nintendo_fans/pages/news_page.dart';
import 'package:nintendo_fans/pages/notfound_page.dart';
import 'package:nintendo_fans/pages/store_details_page.dart';
import 'package:nintendo_fans/pages/store_page.dart';
import 'package:nintendo_fans/services/login/login_service.dart';
import 'package:nintendo_fans/services/restclientlogin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nintendo_fans/utils/translations.dart';
import 'package:nintendo_fans/utils/uidata.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  final LoginService service = LoginService(RestClientLogin());
  final storage = new FlutterSecureStorage();

  Widget _defaultHome = new HomePage();
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      var _result = await service.getUser();
      if (_result.message == '(401) {"message":"Unauthenticated."}') {
        _defaultHome = new LoginPage();
      }
    }
  } on SocketException catch (_) {
    _defaultHome = new NotFoundPage(
      appTitle: 'No Connection',
      icon: FontAwesomeIcons.sadCry,
      title: 'No Connection',
      message: 'No connected to internet',
      iconColor: Colors.green,
    );
  }

  runApp(MaterialApp(
      title: UIData.appName,
      theme: ThemeData(
        // canvasColor: Colors.red[800],
        buttonTheme: new ButtonThemeData(
            buttonColor: Colors.orangeAccent,
            textTheme: ButtonTextTheme.primary),
        primaryColor: Colors.orange[800],
        brightness: Brightness.light,
        fontFamily: UIData.quickFont,
        primarySwatch: Colors.red,

        textTheme: new TextTheme(
            body1: new TextStyle(color: Colors.black),
            headline: TextStyle(color: Colors.white),
            title: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: _defaultHome,
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("es", "ES"),
      ],
      // initialRoute: UIData.notFoundRoute,

      //routes
      routes: <String, WidgetBuilder>{
        UIData.loginOneRoute: (BuildContext context) => LoginPage(),
        UIData.homeRoute: (BuildContext context) => HomePage(),
        UIData.newsRoute: (BuildContext context) => NewsPage(),
        UIData.storeRoute: (BuildContext context) => StorePage(),
        UIData.storeDetailsRoute: (BuildContext context) =>
            new StoreDetailsPage(),
      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
                appTitle: UIData.coming_soon,
                icon: FontAwesomeIcons.solidSmile,
                title: UIData.coming_soon,
                message: Translations.of(context).text('under_development'),
                iconColor: Colors.green,
              ))));
}

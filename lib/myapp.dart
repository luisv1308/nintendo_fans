import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nintendo_fans/pages/home_page.dart';
import 'package:nintendo_fans/pages/login_page.dart';
import 'package:nintendo_fans/pages/notfound_page.dart';
import 'package:nintendo_fans/utils/translations.dart';
import 'package:nintendo_fans/utils/uidata.dart';

class MyApp extends StatelessWidget {
  final materialApp = MaterialApp(
      title: UIData.appName,
      theme: ThemeData(
        buttonTheme: new ButtonThemeData(buttonColor: Colors.orangeAccent, textTheme: ButtonTextTheme.primary),
        primaryColor: Colors.orangeAccent,
        brightness: Brightness.light,
        fontFamily: UIData.quickFont,
        primarySwatch: Colors.orange,
        textTheme: new TextTheme(body1: new TextStyle(color: Colors.orange[800]), headline: TextStyle(color: Colors.white), title: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: LoginPage(),
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
      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
                appTitle: UIData.coming_soon,
                icon: FontAwesomeIcons.solidSmile,
                title: UIData.coming_soon,
                message: Translations.of(context).text('under_development'),
                iconColor: Colors.green,
              )));

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}

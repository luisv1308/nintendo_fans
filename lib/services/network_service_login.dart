import 'package:nintendo_fans/services/restclientlogin.dart';

abstract class NetworkServiceLogin {
  RestClientLogin rest;
  NetworkServiceLogin(this.rest);
}

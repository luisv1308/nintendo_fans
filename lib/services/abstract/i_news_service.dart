import 'dart:async';

import 'package:nintendo_fans/model/news.dart';
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:xml/xml.dart';

abstract class INewsService {
  Future<NetworkServiceResponse<XmlDocument>> fetchStoreResponse();
}

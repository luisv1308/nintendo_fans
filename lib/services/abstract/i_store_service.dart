import 'dart:async';

import 'package:nintendo_fans/model/store.dart';
import 'package:nintendo_fans/services/network_service_response.dart';

abstract class IStoreService {
  Future<NetworkServiceResponse<List<dynamic>>> allGames();
}

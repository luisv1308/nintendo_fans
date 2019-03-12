import 'dart:async';

import 'package:nintendo_fans/services/network_service_response.dart';

abstract class ILoginService {
  Future<NetworkServiceResponse<Map<String, dynamic>>> login(String username, String password);

  Future<NetworkServiceResponse<Map<String, dynamic>>> getUser();
}

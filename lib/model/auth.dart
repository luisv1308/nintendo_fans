import 'package:flutter/material.dart';
import 'package:nintendo_fans/model/login.dart';

// class CreateStoreResponse {
//   String status;
//   CreateStoreResponse({this.status});

//   CreateStoreResponse.fromJson(Map<String, dynamic> json) : status = json['status'];
// }

class StoreResponse {
  String status;
  Login data;
  StoreResponse({this.status, this.data});

  StoreResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = Login.fromJson(json['data']);
}

class StoreData {
  final String authToken;
  final String userId;
  const StoreData({@required this.authToken, @required this.userId});

  StoreData.fromJson(Map<String, dynamic> json)
      : authToken = json['authToken'],
        userId = json['userId'];
}

import 'dart:convert';
import 'dart:developer';

import 'package:crud_operation/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  Future<UserModel> fetchUserDetails() async {
    String url = "https://reqres.in/api/users?page=1";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      log(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return UserModel.fromJson(body);
    }
    throw Exception("Error");
  }
}

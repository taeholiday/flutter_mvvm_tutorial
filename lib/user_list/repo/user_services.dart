import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mvvm_tutorial/user_list/models/user_list_model.dart';
import 'package:mvvm_tutorial/user_list/repo/api_status.dart';
import 'package:mvvm_tutorial/utils/constants.dart';

class UserServices {
  static Future<Object?> getUsers() async {
    try {
      var response = await http.get(Uri.parse(USERS_LIST));
      print(response.statusCode);
      if (response.statusCode == SUCCESS) {
        return Success(response: userListModelFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOW_ERROR, errorResponse: 'Unknow Error');
    }
  }
}

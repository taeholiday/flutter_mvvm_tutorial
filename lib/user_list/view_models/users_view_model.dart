// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:mvvm_tutorial/user_list/models/user_error.dart';
import 'package:mvvm_tutorial/user_list/models/user_list_model.dart';
import 'package:mvvm_tutorial/user_list/repo/api_status.dart';
import 'package:mvvm_tutorial/user_list/repo/user_services.dart';

class UsersViewModel extends ChangeNotifier {
  bool _looding = false;
  List<UserModel> _userListModel = [];
  UserError? _userError;
  UserModel? _selectedUser;
  UserModel _addingUser = UserModel();

  bool get loading => _looding;
  List<UserModel> get userListModel => _userListModel;
  UserError? get userError => _userError;
  UserModel? get selectedUser => _selectedUser;
  UserModel get addingUser => _addingUser;

  UsersViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _looding = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModdel) {
    _userListModel = userListModdel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setSelectedUser(UserModel userModel) {
    _selectedUser = userModel;
  }

  addUser() async {
    if (!isValid()) {
      print("test");
      return;
    }
    _userListModel.add(addingUser);
    _addingUser = UserModel();
    notifyListeners();
    return true;
  }

  bool isValid() {
    if (addingUser.name == null || addingUser.name!.isEmpty) {
      print("test2 = ${addingUser.name}");
      return false;
    }
    if (addingUser.email == null || addingUser.name!.isEmpty) {
      print("test3 = ${addingUser.email}");
      return false;
    }
    return true;
  }

  getUsers() async {
    setLoading(true);
    var response = await UserServices.getUsers();
    print(response);
    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code!,
        message: response.errorResponse!.toString(),
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}

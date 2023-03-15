import 'package:flutter/material.dart';
import 'package:mvvm_tutorial/components/app_error.dart';
import 'package:mvvm_tutorial/components/app_loading.dart';
import 'package:mvvm_tutorial/components/user_list_row.dart';
import 'package:mvvm_tutorial/user_list/models/user_list_model.dart';
import 'package:mvvm_tutorial/user_list/view_models/users_view_model.dart';
import 'package:mvvm_tutorial/utils/navigation_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              openAddUser(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ui(usersViewModel),
          ],
        ),
      ),
    );
  }
}

_ui(UsersViewModel usersViewModel) {
  if (usersViewModel.loading) {
    return const AppLoading();
  }
  if (usersViewModel.userError != null) {
    return AppError(
      errorTxt: usersViewModel.userError!.message,
    );
  }
  return Expanded(
    child: ListView.separated(
      itemBuilder: (context, index) {
        UserModel userModel = usersViewModel.userListModel[index];
        return UserListRow(
          userModel: userModel,
          onTap: () async {
            print("on click index = $index");
            usersViewModel.setSelectedUser(userModel);
            openUserDetails(context);
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: usersViewModel.userListModel.length,
    ),
  );
}

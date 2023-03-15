import 'package:flutter/material.dart';
import 'package:mvvm_tutorial/components/app_title.dart';
import 'package:mvvm_tutorial/user_list/view_models/users_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(usersViewModel.selectedUser!.name!),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(
              title: usersViewModel.selectedUser!.name!,
            ),
            Text(
              usersViewModel.selectedUser!.email!,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

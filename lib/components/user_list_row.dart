import 'package:flutter/material.dart';
import 'package:mvvm_tutorial/components/app_title.dart';

import '../user_list/models/user_list_model.dart';

class UserListRow extends StatelessWidget {
  final UserModel userModel;
  final VoidCallback onTap;
  const UserListRow({super.key, required this.userModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(title: userModel.name!),
            Text(
              userModel.email!,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

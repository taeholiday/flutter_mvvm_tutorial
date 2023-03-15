// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mvvm_tutorial/user_list/view_models/users_view_model.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Users'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool userAdded = await usersViewModel.addUser();
              print(userAdded);
              if (!userAdded) {
                return;
              }
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Name'),
              onChanged: (value) async {
                usersViewModel.addingUser.name = value;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
              onChanged: (value) async {
                usersViewModel.addingUser.email = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

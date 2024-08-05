import 'package:flutter/material.dart';

import '../../../controller/home_controller/home_controller.dart';
import '../../../services/auth_services.dart';
import '../../../services/firestore_service.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key, required this.mutable, required this.immutable});

  final HomeController mutable;
  final HomeController immutable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                arrowColor: Colors.black,
                otherAccountsPictures: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ],
                accountName:
                    Text(FirestoreServices.instance.currentUser?.name ?? ''),
                accountEmail:
                    Text(FirestoreServices.instance.currentUser?.email ?? ''),
                currentAccountPicture: FirestoreServices
                            .instance.currentUser?.profilePic !=
                        null
                    ? Image.network(
                        FirestoreServices.instance.currentUser?.profilePic)
                    : const CircleAvatar(child: CircularProgressIndicator()),
              ),
              ListTile(
                title: const Text(
                  'Find Friends',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.findFriend,
                      arguments: FirestoreService.instance.currentUser?.email);
                },
              ),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                onTap: () {
                  // Scaffold.of(context).openEndDrawer();

                  showDialog(
                    context: context,
                    builder: (c) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure want to logout ?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                            onPressed: () async {
                              immutable.loading();
                              await AuthServices.instance.signOut();
                              immutable.loading();
                              Navigator.of(context).pushNamed('signin');
                            },
                            child: const Text('Yes')),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
        if (mutable.isLoading) const CircularProgressIndicator(),
      ],
    );
  }
}

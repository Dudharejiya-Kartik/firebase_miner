import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../services/firestore_service.dart';
import 'components/drawer.dart';
import 'components/themebutton.dart';

class UserprofilePage extends StatelessWidget {
  const UserprofilePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController mutable = Provider.of<HomeController>(context);
    HomeController immutable =
        Provider.of<HomeController>(context, listen: false);
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.sizeOf(context).width,
      appBar: AppBar(
        title: const Text("UserProfile"),
        centerTitle: true,
        actions: [
          themeButton(context: context),
        ],
      ),
      drawer: UserDrawer(mutable: mutable, immutable: immutable),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: FirestoreService.instance.getUser(email: email),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Drawer(
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
                      accountName: Text(
                          FirestoreService.instance.currentUser?.displayName ??
                              ''),
                      accountEmail: Text(
                          FirestoreService.instance.currentUser?.email ?? ''),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

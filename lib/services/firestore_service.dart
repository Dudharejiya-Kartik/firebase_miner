import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../model/user_model.dart';
import 'auth_services.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();
  final firestore = FirebaseFirestore.instance;

  String userCollection = "allUsers";

  UserModel? currentUser;

  Future<void> adduser({required User user}) async {
    Map<String, dynamic> data = {
      'uid': user.uid,
      'displayName': user.displayName ?? "Kartik",
      'email': user.email ?? "demo_mail",
      'phoneNumber': user.phoneNumber ?? "NO DATA",
      'photoURL': user.photoURL ??
          "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg",
    };

    Logger().i(data);
    await firestore.collection(userCollection).doc(user.uid).set(data);
    Logger().i("User added...");
  }

  Future<void> getUser({required String email}) async {
    DocumentSnapshot snapshot = await firestore
        .collection(userCollection)
        .doc(AuthServices.instance.auth.currentUser!.uid)
        .get();

    currentUser = UserModel.froMap(snapshot.data() as Map);
    Logger().i(currentUser!.displayName);
  }
}

class UserModel {
  var uid;
  var displayName;
  var email;
  var photoURL;
  var phoneNumber;

  UserModel(this.uid, this.displayName, this.email, this.photoURL,
      this.phoneNumber) {}

  factory UserModel.froMap(Map data) => UserModel(
        data['uid'],
        data['displayName'],
        data['email'],
        data['photoURL'],
        data['phoneNumber'],
      );

  Map<String, dynamic> get toMap => {
        'uid': uid,
        'displayName': displayName ?? "DEMO USER",
        'email': email ?? "demo_mail",
        'phoneNumber': phoneNumber ?? "NO DATA",
        'photoURL': photoURL ??
            "https://avatars.githubusercontent.com/u/137186473?s=400&u=3a4e58ea0fe31b7197141d08e9e8dd76d13af764&v=4",
      };
}

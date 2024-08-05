import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../services/auth_services.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    bool passToggle = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Page",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off),
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = await AuthServices.instance
                    .signIn(email: email.text, psw: password.text);
                if (user != null) {
                  Navigator.of(context).pushReplacementNamed('home_page');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login Failed"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text("Login"),
            ),
            const SizedBox(
              height: 20,
            ),
//Google
            ElevatedButton(
              onPressed: () async {
                UserCredential credential =
                    await AuthServices.instance.signInWithGoogle();

                User? user = credential.user;

                if (user != null) {
                  Logger().i(user.email);
                  Navigator.of(context).pushReplacementNamed('home_page');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login Failed"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                child: Image.asset("assets/images/google-logo-2020.jpg"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = await AuthServices.instance.anonymouslogin();

                if (user != null) {
                  Navigator.of(context).pushReplacementNamed('home_page');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login Failed"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text("Anonymous Login"),
            ),
          ],
        ),
      ),
    );
  }
}

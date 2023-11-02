import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/screens/forget_pass_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  loginUser() async {
    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text, password: passController.text))
          .user;
      if (firebaseUser != null) {
        Get.to(() => const HomeScreen());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 300,
                  child: Lottie.asset("assets/Animation - 1698576737948.json"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Colors.pinkAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Colors.pinkAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.pink,
                      ),
                      suffixIcon: const Icon(
                        Icons.visibility,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shadowColor: Colors.deepPurple,
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      loginUser();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      Get.to(() => const ForgetPassScreen());
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.redAccent),
                    )),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      Get.to(() => const SignupScreen());
                    },
                    child: const Text(
                      "Dont Have an Account?",
                      style: TextStyle(color: Colors.redAccent),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

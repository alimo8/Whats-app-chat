import 'package:chatapp/constans.dart';
import 'package:chatapp/helper/show_snak_bar.dart';
import 'package:chatapp/pages/chat_interface.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/widgets/custom_Text_field.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/images/scholar.png', height: 100),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'WhatsApp Chat',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'pacifico',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(height: 20),
                CustomButton(
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatInterface.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'wrong-password') {
                          showSnakbar(context, 'Incorrect password');
                        } else if (ex.code == 'user-not-found') {
                          showSnakbar(context, 'No user found with this email');
                        } else {
                          showSnakbar(context, 'Login failed');
                        }
                      } catch (ex) {
                        showSnakbar(context, 'An unexpected error occurred');
                      } finally {
                        setState(() => isLoading = false);
                      }
                    }
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}

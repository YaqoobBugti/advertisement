import 'package:advertisement/Screen/home_page.dart';
import 'package:advertisement/providers/my_provider.dart';
import 'package:advertisement/widget/my_button.dart';
import 'package:advertisement/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget textFieldCall() {
    return Column(
      children: [
        MyTextField(
          textInputType: TextInputType.emailAddress,
          controller: email,
          obscureText: false,
          labelText: 'Email',
        ),
        SizedBox(
          height: 30,
        ),
        MyTextField(
          textInputType: TextInputType.visiblePassword,
          controller: password,
          obscureText: true,
          labelText: 'Password',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    GlobalKey globalKey = provider.throwGlobleKey;
    return Scaffold(
      key: globalKey,
      body: KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(2.0, 3.0),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-2.0, -2.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textFieldCall(),
                    MyButton(
                      onPressed: () {
                        provider.loginValidation(
                          email: email,
                          password: password,
                          context: context,
                        );
                      },
                      text: "Login",
                    ),
                   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

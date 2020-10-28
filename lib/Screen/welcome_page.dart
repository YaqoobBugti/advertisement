import 'package:advertisement/Screen/home_page.dart';
import 'package:advertisement/Screen/login_page.dart';
import 'package:advertisement/widget/my_button.dart';
import 'package:flutter/material.dart';
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
              child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: Colors.black,
                child: Image.asset('images/logo.png'),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                //color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Welcome To Advertisement",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Column(
                      children: [
                        Text("This App Crator Yaqoob Bugti & Aqeel Baloxh"),
                        SizedBox(height: 10,),
                        Text("Designer:Aqeel Baloxh")
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                //color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      text: 'Log In Admin',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                    ),
                    MyButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      text: 'User Mode',
                    )
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

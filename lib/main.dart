
import 'package:advertisement/Screen/home_page.dart';
import 'package:advertisement/Screen/login_page.dart';
import 'package:advertisement/Screen/tab_bars.dart';
import 'package:advertisement/Screen/welcome_page.dart';
import 'package:advertisement/providers/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MyProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              if (user != null) {
                return TabBars();
              } else {
                return HomePage();
              }
            }
            return WelcomePage();
          },
        ),
       
      ),
    );
  }
}

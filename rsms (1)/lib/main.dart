import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsms/providers/auth.dart';
import 'package:rsms/providers/homeprovider.dart';
import 'package:rsms/screens/myAds.dart';
import 'package:rsms/screens/signup-screen.dart';
import 'package:rsms/screens/tab_screen.dart';
import 'package:rsms/screens/welcome-screen.dart';
import 'package:rsms/screens/homeinput.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (context) => Homes(),
          ),
          
        ],
        child: Consumer<Auth>(
            builder: (context, auth, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'MyShop',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: auth.isAuth ? BottomNavBar() : AuthScreen(),
                  routes: {
                    WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
                    userInputScreen.routeName: (ctx) => userInputScreen(),
                    MyadsScreen.routeName: (ctx) => MyadsScreen()
                  },
                )));
  }
}

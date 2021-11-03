import 'package:flutter/material.dart';
import 'package:positive_conversion_reframing/view/home_screen.dart';
import 'package:positive_conversion_reframing/view/login/login_screen.dart';
import 'package:positive_conversion_reframing/view_models/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'di/providers.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); //198 3
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<LoginViewModel>();
    return MaterialApp(
      title: "positive_conversion_reframing",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: loginViewModel.isSignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

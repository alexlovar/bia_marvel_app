import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marvel_app/screens/home_navigation_screen.dart';
import 'package:marvel_app/common/constants.dart';
import 'common/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  hasInternetConnection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData.dark(),
        home: const HomeNavigationView(),
        navigatorKey: navigatorkey,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

/// Used to set the whole app theme
/// Also used to launche the home_page widget
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: "PostfixCalculator",
        // TODO: set the app theme
        theme: ThemeData(
          backgroundColor: Colors.white,
        ),
        home: HomePage(),
      ),
    );
  }

}

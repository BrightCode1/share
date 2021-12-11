import 'package:content_share/src/pages/dynamic_page.dart';
import 'package:content_share/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Share Test',
      onGenerateRoute: generateRoute,
      home: HomePage(),
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  var args = settings.arguments;
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => HomePage());
      break;
    case '/link':
      return MaterialPageRoute(builder: (context) => DynamicPage(data: args));
      break;
    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}

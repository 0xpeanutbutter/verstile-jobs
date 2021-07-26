import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verstile/providers/select_category.dart';
import 'package:verstile/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (context) => SelectedCategory(),
          child: MyHomePage(title: 'category')),
    );
  }
}

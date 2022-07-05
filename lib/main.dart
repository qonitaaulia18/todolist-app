import 'package:flutter/material.dart';
import 'package:list/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import '../screens/splash_screen.dart';
import '../providers/todo_list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoListProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo List",
        home: SplashScreen(),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import 'presentation/presentation.dart';
import 'theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'App'),
    );
  }
}

import 'package:flutter/material.dart';

import 'presentation/presentation.dart';
import 'theme/theme.dart';

//--dart-define="http_get=true"
//flutter build apk --dart-define="http_get=true" --analyze-size --target-platform=android-arm64

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
import 'package:flutter/material.dart';

import 'app.dart';
import 'domain/domain.dart';

void main() {
  Settings.httpGet = const bool.fromEnvironment('http_get', defaultValue: false);
  runApp(const MyApp());
}


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/core.dart';
import 'domain/domain.dart';

///Без домена пока и прочего. Сделаем на последующем этапе
Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/students.json');
  final data = await json.decode(response);
  if(data == null) {
    throw('Error json recognize.Response is empty!');
  } else if (data is Map<String, dynamic>){
    BDStudents.instance().fromJson(data, 0);
  } else {
    throw('Error json recognize. Response is not Map<String, dynamic>! :${data.runtimeType}:$data');
  }
}


void main() {
  try {
    BDStudents.instance();
    readJson();
  } catch (e, t){
    Logger.print('$e', error: true, level: 1, name: 'e _ readJson()');
    Logger.print('$t', error: true, level: 1, name: 't _ readJson()');
  }
  runApp(const MyApp());
}


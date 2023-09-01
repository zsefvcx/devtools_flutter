
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';

class NetworkStatusCaption extends StatefulWidget {
  const NetworkStatusCaption({super.key});

  @override
  State<NetworkStatusCaption> createState() => _NetworkStatusCaptionState();
}

class _NetworkStatusCaptionState extends State<NetworkStatusCaption> {
  final dio = Dio();
  late Timer timer;
  int count = 0;
  ///что то выкачаем из инета
  Future<void> getHttp() async {
    final response = await dio.get('https://ya.ru');
    Logger.print('${response.realUri}', error: true, level: 1, name: 't _ getHttp()');
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
      await getHttp();
      setState(() {
        count = timer.tick;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('-> Network count: >$count<');
  }
}

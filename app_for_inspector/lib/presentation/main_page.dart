
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/logger.dart';
import '../domain/domain.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ///Без домена пока и прочего. Сделаем на последующем этапе
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/students.json');
    final data = await json.decode(response)['data'];
    if(data == null) {
      throw('Error json recognize.Response is empty!');
    } else if (data is Map<String, dynamic>){
      BDStudents.instance().fromJson(data, 0);
      Logger.print(BDStudents.instance().toString(),level: 0, name: 'test show db');
    } else {
      throw('Error json recognize. Response is not Map<String, dynamic>! :${data.runtimeType}:$data');
    }
  }

  void rdb(){
    try {
      BDStudents.instance();
      readJson();
    } catch (e, t){
      Logger.print('$e', error: true, level: 1, name: 'e _ readJson()');
      Logger.print('$t', error: true, level: 1, name: 't _ readJson()');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${BDStudents.instance().len}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          rdb();
          Logger.print('Press floatingActionButton and setState', level: 0, name: 'test');
        }),
        tooltip: 'setState',
        child: const Icon(Icons.update),

      ),
    );
  }
}

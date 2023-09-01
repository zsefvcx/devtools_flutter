
import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/core.dart';
import '../domain/domain.dart';
import 'network.dart';
import 'widget/widgets.dart';

final List<Student> leakStudents = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  late TabController _tabController;

  int _currentTabIndex = 0;

  bool _isLoading = false;
  bool _isError = false;
  ///Без домена пока и прочего. Сделаем на последующем этапе
  Future<void> readJson() async {
    setState(() {
      _isLoading = false;
      _isError = false;
    });
    await Future.delayed(const Duration(seconds: 1));
    final String response = await rootBundle.loadString('assets/students.json');
    final data = await json.decode(response)['data'];
    if(data == null) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      throw('Error json recognize.Response is empty!');
    } else if (data is Map<String, dynamic>){
      BDStudents.instance().fromJson(data, 0);
      Logger.print(BDStudents.instance().toString(),level: 0, name: 'test show db');
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      throw('Error json recognize. Response is not Map<String, dynamic>! :${data.runtimeType}:$data');
    }
  }

  ///Запрос
  void rdb(){
    try {
      BDStudents.instance();
      readJson();
    } catch (e, t){
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      Logger.print('$e', error: true, level: 1, name: 'e _ readJson()');
      Logger.print('$t', error: true, level: 1, name: 't _ readJson()');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    rdb();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Text(widget.title),
            Visibility(
              visible: Settings.httpGet,
                child: const NetworkStatusCaption(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          _tabController.index = currentIndex;
          setState(() {
            _currentTabIndex = currentIndex;
            _tabController.animateTo(_currentTabIndex);
          });
        },
        currentIndex: _currentTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            activeIcon: Icon(Icons.account_circle_outlined),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            activeIcon: Icon(Icons.local_activity_outlined),
            label: 'Activist',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StudentsTabView(isLoading: _isLoading, isError: _isError),
          StudentsTabView(isLoading: _isLoading, isError: _isError, activistOnly: true),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          rdb();
          ///Добавим утечку памяти по кнопке
          int id = 0;
          leakStudents.clear();
          while (leakStudents.length < 10000000) {
            id++;
            leakStudents.add(
              Student(
                  id: id,
                  lastName: 'lastName',
                  name: 'name',
                  secondName: 'secondName',
                  image: 'image',
                  averageScore: 5,
                  age: 21,
                  group: 4,
                  activist: false),
            );
          }
          Logger.print('Memory leak ${leakStudents.length}', level: 0, name: 'test');
          Logger.print('Press floatingActionButton and setState', level: 0, name: 'test');
        }),
        tooltip: 'setState and read from db',
        child: const Icon(Icons.update),

      ),
    );
  }
}



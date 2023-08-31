import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import 'widgets.dart';

class StudentsTabView extends StatelessWidget {
  const StudentsTabView({
    super.key,
    required bool isLoading,
    required bool isError,
    bool activistOnly = false,
  }) : _isLoading = isLoading, _isError = isError, _activistOnly = activistOnly;

  final bool _isLoading;
  final bool _isError;
  final bool _activistOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if(_isLoading==false && _isError==false)
          const Center(child: CircularProgressIndicator(),),
        if(_isError==true)
          const Text(
            'is Error! Try again!',
          ),
        if(_isLoading==true && _isError==false)
          Text(
            'Number of students: ${_activistOnly?BDStudents.instance().lenAct: BDStudents.instance().len}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        if(_isLoading==true && _isError==false)
          Expanded(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(
                   _activistOnly?BDStudents.instance().lenAct: BDStudents.instance().len,
                    (i) {
                    final List<String> keyMarkers = BDStudents.instance().getKeysAct(activistOnly: _activistOnly);

                  String keyMarker = keyMarkers[i];
                  Student? students = BDStudents.instance().gId(keyMarker);
                  if (students != null) {
                    return CardStudentWidget(
                      student: students, keyMarker: keyMarker, activistOnly: _activistOnly,);
                  } else {
                    throw('Error db students!');
                  }
                },
              ).toList(),
            ),
          ),
      ],
    );
  }
}
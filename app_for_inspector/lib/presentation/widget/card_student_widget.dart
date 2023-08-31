
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';

class CardStudentWidget extends StatelessWidget {
  const CardStudentWidget({
    super.key,
    required this.student,
    required this.keyMarker,
    this.activistOnly = false,
  });

  final String keyMarker;
  final Student student;
  final bool activistOnly;



  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> activistNotifier = ValueNotifier<bool>(student.activist);
    return Card(
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder<bool>(
                      valueListenable:  activistNotifier,
                      builder: (_, value, __) => !activistOnly?buildImage(): value?buildImage():const Center(child: Text('Removed from activist')),
                    ),
                  ),
                  Text('GPA: ${student.averageScore}', style: TextStyle(backgroundColor: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    Text('${student.lastName} ${student.name} ${student.secondName}' ),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(const Size(180,25)),
                      ),
                      onPressed: (){
                        activistNotifier.value = !activistNotifier.value;
                        int res = BDStudents.instance().mod(key: keyMarker, val: student.copyWith(activist: activistNotifier.value));
                        Logger.print('Change status a students ${BDStudents.instance().gId(keyMarker)} with result:$res ', level: 0, name: 'test');
                      },
                      child: ValueListenableBuilder<bool>(
                        valueListenable:  activistNotifier,
                        builder: (_, value, __) => value
                            ?const Text('Delete from Activist')
                            :const Text('Make Activist'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image buildImage() {
    return Image.asset(
      'assets/images/${student.image}',
      fit: BoxFit.cover,
    );
  }
}

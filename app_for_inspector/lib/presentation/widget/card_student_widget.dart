
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';

class CardStudentWidget extends StatelessWidget {
  const CardStudentWidget({
    super.key,
    required this.student,
    required this.keyMarker,
  });

  final String keyMarker;
  final Student student;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> activistNotifier = ValueNotifier<bool>(student.activist);
    return Card(
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/${student.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Full name: ${student.lastName} ${student.name} ${student.secondName}' ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('GPA: ${student.averageScore}' ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                activistNotifier.value = !activistNotifier.value;
                int res = BDStudents.instance().mod(key: keyMarker, val: student.copyWith(activist: activistNotifier.value));
                Logger.print('Change status a students ${BDStudents.instance().gId(keyMarker)} with result:$res ', level: 0, name: 'test');
              }, child: ValueListenableBuilder<bool>(
                valueListenable:  activistNotifier,
                builder: (_, value, __) => value
                    ?const Text('Remove from activist')
                    :const Text('Make an Activist'),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

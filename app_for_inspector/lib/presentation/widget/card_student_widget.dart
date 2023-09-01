
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
                      builder: (_, value, __) => !activistOnly?BuildImage(image: student.image,): value?BuildImage(image: student.image,):const Center(child: Text('Removed from activist list!')),
                    ),
                  ),
                  Text('GPA: ${student.averageScore}', style: TextStyle(
                      backgroundColor: Colors.white.withOpacity(0.6)),

                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    Text('${student.lastName} ${student.name} ${student.secondName}' ),
                    Expanded(
                      child: IconButton(
                        style: ButtonStyle(
                          mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
                        ),
                        onPressed: (){
                          activistNotifier.value = !activistNotifier.value;
                          int res = BDStudents.instance().mod(key: keyMarker, val: student.copyWith(activist: activistNotifier.value));
                          Logger.print('Change status a students ${BDStudents.instance().gId(keyMarker)} with result:$res ', level: 0, name: 'test');
                        },
                        icon: ValueListenableBuilder<bool>(
                          valueListenable:  activistNotifier,
                          builder: (_, value, __) => value
                              ?const Text('Delete from Activist')
                              :const Text('Make Activist'),
                        ),
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

  // Image buildImage() {
  //   return Image.asset(
  //     'assets/images_lite/${student.image}',
  //     fit: BoxFit.cover,
  //   );
  // }
}

class BuildImage extends StatelessWidget {
  const BuildImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images_lite/$image',
      fit: BoxFit.cover,
    );
  }
}

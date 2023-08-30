import 'package:equatable/equatable.dart';

///База данных Студентов
class BDStudents {
  final Map<String, Student> data = {};

  ///Добавляем в базу
  bool add({required String key, required Student val}) {
    Student? valBD =  data[key];
    if( valBD == null) {
      data[key] = val;//добавляем
      return true;
    } else {
      return false;//уже есть
    }
  }

  ///Удаляем из базы
  bool rem({required String key}){
    Student? valBD =  data[key];
    if( valBD == null) {
      return false;//такого нет
    } else {
      data.remove(key);
      return true;//удаляем
    }
  }

  ///Меняем в базе
  int mod({required String key, required Student val}){
    Student? valBD =  data[key];
    if( valBD == null) {
      return -1;//такого нет в базу и добавлять не будем
    } else {
      if(val == valBD){
        return 1;//есть такой элемент и он такойже в базе и делать ничего не будем
      } else {
        data[key] = valBD.copyWith(//заменяем в базе, как то так...
                    id: val.id          ==valBD.id          ?null:val.id,
              lastName: val.lastName    ==valBD.lastName    ?null:val.lastName,
                  name: val.name        ==valBD.name        ?null:val.name,
            secondName: val.secondName  ==valBD.secondName  ?null:val.secondName,
                 image: val.image       ==valBD.image       ?null:val.image,
          averageScore: val.averageScore==valBD.averageScore?null:val.averageScore,
                   age: val.age         ==valBD.age         ?null:val.age,
                 group: val.group       ==valBD.group       ?null:val.group,
              activist: val.activist    ==valBD.activist    ?null:val.activist,
        );
        return 0;//поменяли
      }
    }
  }

  ///очищаем базу
  void clear() => data.clear();

  static BDStudents? _instance;
  ///синглтон - один он в приложении...
  factory BDStudents.instance() => _instance ??= BDStudents._();
  BDStudents._();
}

///Один студент с возможностью сравнения....
class Student  extends Equatable{
  final int id;
  final String lastName;
  final String name;
  final String secondName;
  final String image;
  final int averageScore;
  final int age;
  final int group;
  final bool activist;

  const Student({
    required this.id,
    required this.lastName,
    required this.name,
    required this.secondName,
    required this.image,
    required this.averageScore,
    required this.age,
    required this.group,
    required this.activist,
  });

  Student copyWith({
    int? id,
    String? lastName,
    String? name,
    String? secondName,
    String? image,
    int? averageScore,
    int? age,
    int? group,
    bool? activist,
  }) =>
      Student(
        id: id ?? this.id,
        lastName: lastName ?? this.lastName,
        name: name ?? this.name,
        secondName: secondName ?? this.secondName,
        image: image ?? this.image,
        averageScore: averageScore ?? this.averageScore,
        age: age ?? this.age,
        group: group ?? this.group,
        activist: activist ?? this.activist,
      );

  @override
  List<Object?> get props => [
    id,
    lastName,
    name,
    secondName,
    image,
    averageScore,
    age,
    group,
    activist,
  ];
}

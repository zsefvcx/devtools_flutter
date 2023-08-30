import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

///Один студент с возможностью сравнения....
@JsonSerializable()
class Student  extends Equatable{
  @JsonKey(defaultValue: 0, )
  final int id;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String name;
  @JsonKey(name: 'second_name')
  final String secondName;
  @JsonKey(defaultValue: '')
  final String image;
  @JsonKey(defaultValue: 0, name: 'average_score')
  final int averageScore;
  @JsonKey(defaultValue: 0)
  final int age;
  @JsonKey(defaultValue: 0)
  final int group;
  @JsonKey(defaultValue: false)
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

  /// Connect the generated [_$StudentFromJson] function to the `fromJson`
  /// factory.
  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  /// Connect the generated [_$StudentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  String toString() {
    return "$id:$group:$activist: $lastName $name $secondName $age $averageScore $image";
  }
}

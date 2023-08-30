// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as int? ?? 0,
      lastName: json['last_name'] as String,
      name: json['name'] as String,
      secondName: json['second_name'] as String,
      image: json['image'] as String? ?? '',
      averageScore: json['average_score'] as int? ?? 0,
      age: json['age'] as int? ?? 0,
      group: json['group'] as int? ?? 0,
      activist: json['activist'] as bool? ?? false,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'last_name': instance.lastName,
      'name': instance.name,
      'second_name': instance.secondName,
      'image': instance.image,
      'average_score': instance.averageScore,
      'age': instance.age,
      'group': instance.group,
      'activist': instance.activist,
    };

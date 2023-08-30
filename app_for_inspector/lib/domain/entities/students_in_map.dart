
import '../../core/core.dart';

///База данных Студентов
class BDStudents {
  //final int _currentPage;
  final Map<String, Student> _data;

  ///Число студенто в базе
  int get len => _data.length;

  ///Читаем из базы
  Student? gId(int id) => _data[id];

  ///Добавляем в базу
  bool add({required String key, required Student val}) {
    Student? valBD =  _data[key];
    if( valBD == null) {
      _data[key] = val;//добавляем
      return true;
    } else {
      return false;//уже есть
    }
  }

  ///Удаляем из базы
  bool rem({required String key}){
    Student? valBD =  _data[key];
    if( valBD == null) {
      return false;//такого нет
    } else {
      _data.remove(key);
      return true;//удаляем
    }
  }

  ///Меняем в базе
  int mod({required String key, required Student val}){
    Student? valBD =  _data[key];
    if( valBD == null) {
      return -1;//такого нет в базу и добавлять не будем
    } else {
      if(val == valBD){
        return 1;//есть такой элемент и он такойже в базе и делать ничего не будем
      } else {
        _data[key] = valBD.copyWith(//заменяем в базе, как то так...
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
  void clr() => _data.clear();

  static BDStudents? _instance;
  ///синглтон - один он в приложении...
  factory BDStudents.instance() => _instance ??= BDStudents._();

  BDStudents._() : _data = {};

  /// `fromJson`
  void fromJson(Map<String, dynamic> json, int page) {
    if (json.length > 20){
      throw('Error json recognize. Length is json too match for one page! json.length:${json.length}');
    }
    _data.clear();
    //_currentPage = page;
    for (var key in json.keys) {
      var val = json[key];
      if(val == null){
        throw('Error json recognize. Value for key:$key is empty!');
      } else if (val is Map<String, dynamic>) {
        _data[key] = Student.fromJson(val);
      } else {
        throw('Error json recognize. Value for key:$key is not Map<String, dynamic>! :${val.runtimeType}:$val');
      }
    }
  }

  /// to the `toJson` method.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {};
    for(var key in _data.keys){
      var student = _data[key];
      if (student == null){
        throw('Error save to json. Value for key:$key is empty!');
      } else {
        result[key] = student.toJson();
      }

    }
    return result;
  }

  @override
  String toString() {
    return _data.toString();
  }
}
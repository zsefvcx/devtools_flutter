import 'dart:developer' as dev;

///Логгер в систему.
abstract class Logger {
  /// - [message] is the log message
  /// - [name] (optional) is the name of the source of the log message
  /// - [level] (optional) is the severity level (a value between 0 and 2000);
  /// - [error] (optional) an error bool associated with this log event
  static print(String message, {
      String name = '',
      int level = 0,
      bool error = false,
    }) => dev.log(":${error?'E':'N'}:|$message",
      time: DateTime.now(),
      name: name,
      level: level,
  );


}
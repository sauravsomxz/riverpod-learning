import 'dart:developer' as developer;

class AppLogger {
  /// Log general info messages
  static void info(String message, {String name = "APP"}) {
    developer.log(message, name: name, level: 0);
  }

  /// Log warning messages
  static void warning(String message, {String name = "APP"}) {
    developer.log(message, name: name, level: 900);
  }

  /// Log error messages with optional stack trace
  static void error(String message,
      {String name = "APP", Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log debug messages (useful for development, hide in production)
  static void debug(String message, {String name = "APP"}) {
    assert(() {
      developer.log(message, name: name, level: 500);
      return true;
    }());
  }
}

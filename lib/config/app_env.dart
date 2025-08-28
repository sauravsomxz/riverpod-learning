import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static late final String baseUrl;
  static late final bool enableLogging;

  /// Load environment variables (call this at app startup)
  static Future<void> load() async {
    await dotenv.load(fileName: ".env.dev");

    baseUrl = dotenv.env['BASE_URL']!;
    enableLogging = dotenv.env['ENABLE_LOGGING'] == "true";
  }
}

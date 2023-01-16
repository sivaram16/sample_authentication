import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  PreferenceHelper._();
  static Future saveIsLoggedIn({required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_loggedin", value);
  }

  static Future<bool?> getIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_loggedin");
  }

  static Future saveNumber({required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("number", value);
  }

  static Future<String?> getNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("number");
  }
}

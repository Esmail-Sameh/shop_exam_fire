import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // function get data with key
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // function save all data
  static Future<bool> savaData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value); //when data string add data with string type
    if (value is int) return await sharedPreferences.setInt(key, value); //when data integer add data with Integer type
    if (value is double) return await sharedPreferences.setDouble(key, value); //when data double add data with double type
    if (value is bool) return await sharedPreferences.setBool(key, value); //when data bool add data with bool type.
    return false;
  }

  // remove data with key
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}

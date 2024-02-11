import 'package:http/http.dart' as http;

class CheckInternet {
  static Future<bool> checkInternet() async {
    try {
      final result = await http.get(Uri.parse('https://google.com'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}

import 'dart:io';

class InternetConnection {
  late final bool status;
  final String apiUrl = "https://api.openweathermap.org/";

  checkForInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = true;
      } else {
        status = false;
      }
    } on SocketException catch (_) {
      status = false;
    }
  }
}

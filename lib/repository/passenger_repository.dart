import 'dart:io';

import 'package:flutterlazyloading/model/passenger.dart';
import 'package:http/http.dart' as http;

class GenericHttpException implements Exception {}

class NoConnectionException implements Exception {}

class PassengerRepository {
  PassengerRepository();

  static Future<List<Passenger>> getPassengers(int page, int pageSize) async {
    final Uri uri = Uri.parse(
        "https://api.instantwebtools.net/v1/passenger?page=$page&size=$pageSize");
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final result = passengerDataFromJson(response.body);
        return result.data;
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}

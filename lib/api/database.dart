import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movieproject/constant.dart';
import 'package:movieproject/models/lokal.dart';

class DatabaseApi {
  static const _filmUrl = 'https://asia-southeast2-core-advice-401502.cloudfunctions.net/getallfilm';

  Future<List<Lokal>> getFilmDetails() async {
    final response = await http.get(Uri.parse(_filmUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Jika data adalah List (sepertinya data film lokal adalah List)
      if (jsonData is List) {
        // Menggunakan metode fromJson untuk mengonversi setiap elemen JSON ke objek Lokal
        List<Lokal> lokalList = jsonData.map((lokal) => Lokal.fromJson(lokal)).toList();
        return lokalList;
      } else {
        throw Exception('Unexpected data format');
      }
    } else {
      throw Exception('Something went wrong');
    }
  }
}

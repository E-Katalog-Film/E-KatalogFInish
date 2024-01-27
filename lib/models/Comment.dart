import 'dart:convert';
import 'package:http/http.dart' as http;

class Comment {
  final String name;
  final String tanggal;
  final String komentar;

  Comment({
    required this.name,
    required this.tanggal,
    required this.komentar,
  });

  // Metode untuk mengirim komentar
  Future<void> postComment() async {
    try {
      final String apiUrl =
          'https://asia-southeast2-core-advice-401502.cloudfunctions.net/createkomentator';

      final Map<String, dynamic> postData = {
        'Name': name,
        'Tanggal': tanggal,
        'Komentar': komentar,
      };

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        print('Komentar berhasil dikirim.');
      } else {
        print('Gagal mengirim komentar. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

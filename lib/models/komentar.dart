import 'package:movieproject/api/api_komentar.dart';

class Comment {
  final id;
  final String idFilm;
  final String komentar;

  Comment({
    required this.id,
    required this.idFilm,
    required this.komentar,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['ID'],
      idFilm: json['ID_FILM'],
      komentar: json['Komentar'],
    );
  }
}
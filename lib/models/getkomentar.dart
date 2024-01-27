import 'package:movieproject/api/api_komentar.dart';

class AmbilComment {
  final id;
  final String name;
  final String idFilm;
  final String komentar;

  AmbilComment({
    required this.id,
    required this.name,
    required this.idFilm,
    required this.komentar,
  });

  factory AmbilComment.fromJson(Map<String, dynamic> json) {
    return AmbilComment(
      id: json['ID'],
      name: json['Name'],
      idFilm: json['ID_FILM'],
      komentar: json['Komentar'],
    );
  }
}
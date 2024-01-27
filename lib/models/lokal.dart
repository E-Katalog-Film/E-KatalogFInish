import 'package:flutter/physics.dart';

class Lokal {
  final String id;
  final String judul;
  final String image;
  final String tanggal;
  final String genre;
  final String sinopsis;
  final String penulis;
  final String sutradara;
  final String aktor;

  Lokal({
    required this.id,
    required this.judul,
    required this.image,
    required this.tanggal,
    required this.genre,
    required this.sinopsis,
    required this.penulis,
    required this.sutradara,
    required this.aktor,
  });

  factory Lokal.fromJson(Map<String, dynamic> json) {
    return Lokal(
      id: json['id'],
      judul: json['judul'],
      image: json['image'],
      tanggal: json['tanggal'],
      genre: json['genre'],
      sinopsis: json['sinopsis'],
      penulis: json['penulis'],
      sutradara: json['sutradara'],
      aktor: json['aktor'],
    );
  }
}
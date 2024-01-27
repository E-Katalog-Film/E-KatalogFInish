import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieproject/constant.dart';
import 'package:movieproject/widgets/back_button.dart';
import 'package:movieproject/models/lokal.dart';
import 'package:movieproject/models/komentar.dart';
import 'package:movieproject/models/getkomentar.dart';
import 'package:movieproject/api/api_komentar.dart';
import 'package:movieproject/api/api_komentar_get.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreenLokal extends StatefulWidget {
  final Lokal filmData;

  const DetailScreenLokal({Key? key, required this.filmData}) : super(key: key);

  @override
  _DetailScreenLokalState createState() => _DetailScreenLokalState();
}

class _DetailScreenLokalState extends State<DetailScreenLokal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('${Constants.imageUrl}${widget.filmData.image}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    // Gambar film
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.6,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Image.network(
                            widget.filmData.image,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Informasi film
                    Text(
                      'Judul: ${widget.filmData.judul}',
                      style: GoogleFonts.openSans(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tanggal: ${widget.filmData.tanggal}',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Genre: ${widget.filmData.genre}',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Sinopsis: ${widget.filmData.sinopsis}',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Form input komentar
                    TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'Tambahkan Komentar',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 3,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _addComment,
                          child: Text('Kirim Komentar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Daftar komentar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: comments.map((comment) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '${comment.komentar}',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getComments() async {
    try {
      // Call the function to fetch comments for the specific film ID
      List<AmbilComment> fetchedComments = await GetApiKomentar().ambilComment(
          widget.filmData.id, context);

      // Map fetched comments to Comment objects
      List<Comment> convertedComments = fetchedComments.map((ambilComment) {
        return Comment(
          id: ambilComment.id,
          idFilm: ambilComment.idFilm,
          komentar: ambilComment.komentar,
        );
      }).toList();

      // Update the comments list with the converted comments
      setState(() {
        comments = convertedComments;
      });
    } catch (e) {
      print('Error fetching comments: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch comments. Please try again.'),
        ),
      );
    }
  }


  void _addComment() {
    String id = uuid.v4();
    String komentar = commentController.text;
    Comment newComment = Comment(
      id: id,
      idFilm: widget.filmData.id,
      komentar: komentar,
    );

    // Tambahkan komentar baru ke awal list komentar
    setState(() {
      comments.insert(0, newComment);
    });
    ApiKomentar apiKomentar = ApiKomentar(); // Inisialisasi ApiKomentar
    apiKomentar.postComment(context, newComment);

    // Bersihkan input
    commentController.clear();
  }
}
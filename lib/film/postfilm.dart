import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:movieproject/authentication/login_page.dart';

class PostFilm extends StatefulWidget {
  const PostFilm({Key? key}) : super(key: key);

  @override
  _PostFilmState createState() => _PostFilmState();
}

class _PostFilmState extends State<PostFilm> {
  TextEditingController judulController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController sinopsisController = TextEditingController();
  TextEditingController penulisController = TextEditingController();
  TextEditingController sutradaraController = TextEditingController();
  TextEditingController aktorController = TextEditingController();

  Future<void> createFilm() async {
    final String apiUrl = 'https://asia-southeast2-core-advice-401502.cloudfunctions.net/createfilm';

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'Judul': judulController.text,
          'Image': imageController.text,
          'Tanggal': tanggalController.text,
          'Genre': genreController.text,
          'Sinopsis': sinopsisController.text,
          'Penulis': penulisController.text,
          'Sutradara': sutradaraController.text,
          'Aktor': aktorController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Film added successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add film. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }
  void _logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('loginTime');
    prefs.remove('role');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(title: 'Sign In')),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Film'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: judulController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: tanggalController,
              decoration: InputDecoration(labelText: 'Tanggal'),
            ),
            TextField(
              controller: genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: sinopsisController,
              decoration: InputDecoration(labelText: 'Sinopsis'),
            ),
            TextField(
              controller: penulisController,
              decoration: InputDecoration(labelText: 'Penulis'),
            ),
            TextField(
              controller: sutradaraController,
              decoration: InputDecoration(labelText: 'Sutradara'),
            ),
            TextField(
              controller: aktorController,
              decoration: InputDecoration(labelText: 'Aktor'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: createFilm,
              child: Text('Add Film'),
            ),
            IconButton(
              onPressed: _logout,
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

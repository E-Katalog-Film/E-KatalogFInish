import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieproject/models/getkomentar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetApiKomentar {
  static const _komentarUrl =
      'https://asia-southeast2-core-advice-401502.cloudfunctions.net/createkomentator';

  Future<List<AmbilComment>> ambilComment(String filmId, BuildContext context) async {
    try {
      String? token = await getTokenFromSharedPreferences();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You are not logged in.'),
          ),
        );
        return []; // Return an empty list or handle the case when the user is not logged in
      }

      final http.Response response = await http.get(
        Uri.parse('$_komentarUrl/$filmId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<AmbilComment> fetchedComments =
        jsonResponse.map((json) => AmbilComment.fromJson(json)).toList();

        return fetchedComments;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to fetch comments. Please try again.'),
          ),
        );
        return [];
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
      return [];
    }
  }

  Future<String?> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

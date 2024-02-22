import 'dart:convert';

import 'package:bicho_pedia/encounters/model/encounter_simple_response.dart';
import 'package:bicho_pedia/encounters/repository/encounters_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class EncountersRepositoryImpl extends EncountersRepository {
  final Client _httpClient = Client();

  @override
  Future<List<EncounterSimpleResponse>> getMostLikedEncounters(
      int count, int page) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String? token = _prefs.getString('token');

    final response = await _httpClient.get(
        Uri.parse(
            "http://10.0.2.2:8080/encounters/most-liked/simple?c=$count&p=$page"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((map) => EncounterSimpleResponse.fromJson(map))
          .toList();
    } else {
      throw Exception('Falied to fetch data');
    }
  }
}
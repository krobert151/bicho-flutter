import 'dart:convert';

import 'package:bicho_pedia/species/model/specie_response.dart';
import 'package:bicho_pedia/species/model/species_simple_response.dart';
import 'package:bicho_pedia/species/repositories/species_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecieRepositoryImpl extends SpecieRepository {
  final Client _httpClient = Client();

  @override
  Future<List<SpeciesSimpleResponse>> getDangerSpeciesSimple(
      int count, int page) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    final String? token = _prefs.getString('token');
    final response = await _httpClient.get(
        Uri.parse(
            "http://10.0.2.2:8080/species/danger-extinction/simple?c=$count&p=$page"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((map) => SpeciesSimpleResponse.fromJson(map))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future<List<SpeciesResponse>> getSpeciesLists(
      int count, int page, String specie) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String? token = _prefs.getString('token');
    final String? search = 'search=scientificName:*$specie*';

    if (search == 'search=scientificName:**') {
      final response = await _httpClient.get(
          Uri.parse("http://10.0.2.2:8080/species/allspecies?c=$count&p=$page"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((map) => SpeciesResponse.fromJson(map))
            .toList();
      } else {
        throw Exception('Failed to Fecth data');
      }
    } else {
      final response = await _httpClient.get(
          Uri.parse("http://10.0.2.2:8080/species/allspecies?$search"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((map) => SpeciesResponse.fromJson(map))
            .toList();
      } else {
        throw Exception('Failed to Fecth data');
      }
    }
  }
}

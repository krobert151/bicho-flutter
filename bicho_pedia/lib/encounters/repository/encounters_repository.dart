import 'package:bicho_pedia/encounters/model/encounter_simple_response.dart';

abstract class EncountersRepository {
  Future<List<EncounterSimpleResponse>> getMostLikedEncounters(
      int count, int page);
}

import 'package:bicho_pedia/species/model/species_simple_response.dart';

abstract class SpecieRepository {
  Future<List<SpeciesSimpleResponse>> getDangerSpeciesSimple(
      int count, int page);
}

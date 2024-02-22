import 'package:bicho_pedia/encounters/bloc/encounter_simple/encounter_simple_bloc.dart';
import 'package:bicho_pedia/encounters/repository/encounters_repository.dart';
import 'package:bicho_pedia/encounters/repository/encounters_repository_impl.dart';
import 'package:bicho_pedia/encounters/widgets/simple_encounters_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleEncountersList extends StatefulWidget {
  const SimpleEncountersList({super.key});

  @override
  State<SimpleEncountersList> createState() => _SimpleEncountersListState();
}

class _SimpleEncountersListState extends State<SimpleEncountersList> {
  late EncountersRepository encountersRepository;

  @override
  void initState() {
    encountersRepository = EncountersRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EncounterSimpleBloc(encountersRepository)
        ..add(DoEncounterSimpleEvent(10, 0)),
      child: _simpleEncountersList(),
    );
  }

  _simpleEncountersList() {
    return BlocBuilder<EncounterSimpleBloc, EncounterSimpleState>(
      builder: (BuildContext context, EncounterSimpleState state) {
        if (state is EncounterSimpleSuccess) {
          return SizedBox(
            height: 340,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        textAlign: TextAlign.end,
                        'Show All',
                        style: GoogleFonts.openSans(
                            color: Color.fromARGB(255, 190, 227, 97)),
                      )),
                ),
                SizedBox(
                  height: 290,
                  child: ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      return SimpleEncounterItem(
                          encounterResponse: state.list[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is EncounterSimpleError) {
          return Text(state.errorMessage,
              style: GoogleFonts.openSans(color: Colors.white));
        }
        return Text('Manolo', style: GoogleFonts.openSans(color: Colors.white));
      },
    );
  }
}

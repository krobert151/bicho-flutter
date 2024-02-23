import 'package:bicho_pedia/species/bloc/specie/specie_bloc.dart';
import 'package:bicho_pedia/species/repositories/species_repository.dart';
import 'package:bicho_pedia/species/repositories/species_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecieList extends StatefulWidget {
  const SpecieList({super.key, required this.search});
  final String search;

  @override
  State<SpecieList> createState() => _SpecieListState();
}

class _SpecieListState extends State<SpecieList> {
  late SpecieRepository specieRepository;

  @override
  void initState() {
    specieRepository = SpecieRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecieBloc(specieRepository)
        ..add(DoSpecieEvent(10, 0, widget.search)),
      child: _simpleSpeciesList(),
    );
  }

  _simpleSpeciesList() {
    return BlocBuilder<SpecieBloc, SpecieState>(
      builder: (BuildContext context, SpecieState state) {
        if (state is SpecieSuccess) {
          return SizedBox.expand(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100, // Adjust the height of the static widget
                    child: Text('Manolo',
                        style: GoogleFonts.openSans(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 50, // Adjust the height of each item
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Text(
                        state.list[index].scientificName!,
                        style: GoogleFonts.openSans(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      );
                    },
                    childCount: state.list.length,
                  ),
                ),
              ],
            ),
          );
        } else if (state is SpecieError) {
          return Text(state.errorMessage);
        }
        return const Text('Manolo');
      },
    );
  }
}

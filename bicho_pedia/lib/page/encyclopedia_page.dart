import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bicho_pedia/species/bloc/specie/specie_bloc.dart';
import 'package:bicho_pedia/species/repositories/species_repository_impl.dart';
import 'package:google_fonts/google_fonts.dart';

class EncyClopediaPage extends StatefulWidget {
  const EncyClopediaPage({Key? key}) : super(key: key);

  @override
  State<EncyClopediaPage> createState() => _EncyClopediaPageState();
}

class _EncyClopediaPageState extends State<EncyClopediaPage> {
  late TextEditingController _searchController;
  late String search = '';

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void updateSearch(String value) {
    setState(() {
      search = value;
    });
  }

  void searchSpecies() {
    if (search.isEmpty) {
      BlocProvider.of<SpecieBloc>(context).add(DoSpecieEvent(10, 0, ''));
    } else {
      BlocProvider.of<SpecieBloc>(context).add(DoSpecieEvent(10, 0, search));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecieBloc(SpecieRepositoryImpl()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 20, 13),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 19, 20, 13),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  onChanged: updateSearch,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search by scientific name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: searchSpecies,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: BlocBuilder<SpecieBloc, SpecieState>(
          builder: (BuildContext context, SpecieState state) {
            print('State received: $state');
            if (state is SpecieInitial) {
              return Text(
                'Cargando',
                style: GoogleFonts.openSans(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              );
            } else if (state is SpecieSuccess) {
              return SizedBox.expand(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                        child: Text(
                          'Manolo',
                          style: GoogleFonts.openSans(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                    SliverFixedExtentList(
                      itemExtent: 50,
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
        ),
      ),
    );
  }
}

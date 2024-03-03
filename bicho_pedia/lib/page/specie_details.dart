import 'package:bicho_pedia/species/bloc/specie_details/specie_details_bloc.dart';
import 'package:bicho_pedia/species/model/specie_details_response.dart';
import 'package:bicho_pedia/species/repositories/species_repository.dart';
import 'package:bicho_pedia/species/repositories/species_repository_impl.dart';
import 'package:bicho_pedia/species/widgets/articles_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecieDetailsPage extends StatefulWidget {
  final String id;
  const SpecieDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<SpecieDetailsPage> createState() => _SpecieDetailsPageState();
}

class _SpecieDetailsPageState extends State<SpecieDetailsPage> {
  late SpecieRepository specieRepository;
  late List<Article> lists = [];

  @override
  void initState() {
    super.initState();
    specieRepository = SpecieRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecieDetailsBloc(specieRepository)
        ..add(DoSpecieDetailsEvent(widget.id)),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 20, 13),
        body: BlocBuilder<SpecieDetailsBloc, SpecieDetailsState>(
          builder: (BuildContext context, SpecieDetailsState state) {
            if (state is SpecieDetailsSuccess) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: 450,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        image: DecorationImage(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          image: NetworkImage(state.detail.mainPhoto!),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 50),
                        alignment: Alignment.bottomCenter,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.1, 0.55],
                            colors: [
                              Color.fromARGB(0, 0, 0, 0),
                              Color.fromARGB(233, 19, 20, 13),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 40,
                              child: Row(
                                children: [
                                  Text(
                                    state.detail.scientificName!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        image: AssetImage('assets/' +
                                            state.detail.danger! +
                                            ".png")),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                width: 370, height: 1, color: Colors.white54),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        lists = state.detail.info!;
                                      });
                                    },
                                    child: const Text(
                                      'Info',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Colors.white54),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        lists = state.detail.identification!;
                                      });
                                    },
                                    child: const Text(
                                      'Identification',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Colors.white54),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        lists = state.detail.cares!;
                                      });
                                    },
                                    child: const Text(
                                      'Cares',
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          color: Colors.white54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 19, 20, 13),
                        ),
                        height: 435, // Altura del NavigationBar
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ArticlesLists(list: lists),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SpecieDetailsError) {
              return Text(state.errorMessage);
            }
            return Text('Manola');
          },
        ),
      ),
    );
  }
}

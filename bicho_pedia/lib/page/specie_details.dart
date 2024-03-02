import 'package:bicho_pedia/species/bloc/specie_details/specie_details_bloc.dart';
import 'package:bicho_pedia/species/repositories/species_repository.dart';
import 'package:bicho_pedia/species/repositories/species_repository_impl.dart';
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
  String selectedText = '';

  @override
  void initState() {
    specieRepository = SpecieRepositoryImpl();
    super.initState();
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
                margin: EdgeInsets.all(8),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(state.detail.mainPhoto!),
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.5],
                      colors: [
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(233, 19, 20, 13),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text(state.detail.scientificName!),
                      ),
                      SizedBox(
                        height: 100, // Altura del NavigationBar
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(Icons.home),
                                onPressed: () {
                                  setState(() {
                                    selectedText = 'Inicio seleccionado';
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  setState(() {
                                    selectedText = 'Búsqueda seleccionada';
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.notifications),
                                onPressed: () {
                                  setState(() {
                                    selectedText =
                                        'Notificaciones seleccionadas';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              selectedText,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

import 'package:bicho_pedia/encounters/model/encounter_detail_response.dart';
import 'package:bicho_pedia/encounters/widgets/encounter_detail_location.dart';
import 'package:bicho_pedia/encounters/widgets/encounters_details_gallery.dart';
import 'package:flutter/material.dart';

class EncounterDetailsWidget extends StatefulWidget {
  final EncounterDetailsResponse encounter;

  const EncounterDetailsWidget({super.key, required this.encounter});

  @override
  State<EncounterDetailsWidget> createState() => _EncounterDetailsWidgetState();
}

class _EncounterDetailsWidgetState extends State<EncounterDetailsWidget> {
  late Container container = Container();

  @override
  void initState() {
    super.initState();
    container = Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 19, 20, 13),
      ),
      height: 435, // Altura del NavigationBar
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          widget.encounter.description!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 450,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: NetworkImage(widget.encounter.mainPhoto!),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 40,
                    child: Row(
                      children: [
                        Text(
                          widget.encounter.scientificName!,
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
                                  widget.encounter.danger! +
                                  ".png")),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      height: 20,
                      child: Row(
                        children: [
                          const Text(
                            'By ',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            widget.encounter.username!,
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.amber,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(width: 370, height: 1, color: Colors.white54),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              container = Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 19, 20, 13),
                                ),
                                height: 435, // Altura del NavigationBar
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    widget.encounter.description!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            });
                          },
                          child: const Text(
                            'Info',
                            style: TextStyle(
                                fontFamily: 'OpenSans', color: Colors.white54),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              container = Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 19, 20, 13),
                                ),
                                height: 435, // Altura del NavigationBar
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SafeArea(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                        child: EncounterDetailsGallery(
                                            media: widget.encounter.media!))
                                  ],
                                )),
                              );
                            });
                          },
                          child: const Text(
                            'Gallery',
                            style: TextStyle(
                                fontFamily: 'OpenSans', color: Colors.white54),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              container = Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Color.fromARGB(255, 19, 20, 13),
                                ),
                                height: 435, // Altura del NavigationBar
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SafeArea(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                        child: EncounterDetailsLocation(
                                      lat: double.parse(widget.encounter.lat!),
                                      long: double.parse(widget.encounter.lon!),
                                    ))
                                  ],
                                )),
                              );
                            });
                          },
                          child: const Text(
                            'Location',
                            style: TextStyle(
                                fontFamily: 'OpenSans', color: Colors.white54),
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
              child: container,
            ),
          ),
        ],
      ),
    );
    ;
  }
}

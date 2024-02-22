import 'package:bicho_pedia/encounters/model/encounter_simple_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleEncounterItem extends StatefulWidget {
  final EncounterSimpleResponse encounterResponse;
  const SimpleEncounterItem({super.key, required this.encounterResponse});

  @override
  State<SimpleEncounterItem> createState() => _SimpleEncounterItemState();
}

class _SimpleEncounterItemState extends State<SimpleEncounterItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: const Color.fromARGB(43, 255, 255, 255),
        elevation: 10,
        child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 48, 49, 45),
            ),
            height: 120,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 180,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.encounterResponse.photo!),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.encounterResponse.scientificName!,
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      Text(widget.encounterResponse.description!,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.menu,
                                color: Colors.white, size: 15),
                            Text(
                              'View More',
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200),
                            )
                          ],
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
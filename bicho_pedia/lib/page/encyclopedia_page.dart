import 'package:bicho_pedia/species/widgets/specie_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class EncyClopediaPage extends StatefulWidget {
  const EncyClopediaPage({super.key});

  @override
  State<EncyClopediaPage> createState() => _EncyClopediaPageState();
}

class _EncyClopediaPageState extends State<EncyClopediaPage> {
  final serchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 20, 13),
        appBar: AppBar(
          automaticallyImplyLeading: F,
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 19, 20, 13),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search Species',
                  style: GoogleFonts.openSans(color: Colors.white)),
              Form(
                  child: Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 200,
                    child: TextFormField(
                      controller: serchText,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
        body: SpecieList(
          search: '',
        ));
  }
}

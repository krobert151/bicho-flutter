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
  late String search = '';

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
              Text(search, style: GoogleFonts.openSans(color: Colors.white)),
              Form(
                  onChanged: () {
                    Form.of(primaryFocus!.context!).save();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 170,
                        child: TextFormField(
                          onSaved: (String? value) {
                            search = value!;
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ))
                    ],
                  ))
            ],
          ),
        ),
        body: SpecieList(
          search: search,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kuis/main_screen.dart';
import 'package:kuis/pokemon_data.dart';

class PokemonDetail extends StatefulWidget {
  final int pokemonIdx;

  const PokemonDetail({Key? key, required this.pokemonIdx}) : super(key: key);

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  bool toggle = false;

  Widget build(BuildContext context) {
    final PokemonData pokemon = listPokemon[widget.pokemonIdx];
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              icon: toggle ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
              onPressed: () {
                final snackBar = SnackBar(
                  content: const Text('Berhasil Menambahkan Ke favorit'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ),
        ],
      ),
      body: ListView(children: [
        Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.network(
                      pokemon.image,
                      width: 250,
                    ),
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Center(
                      child: Column(children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      margin: EdgeInsets.all(20),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(50),
                          1: FlexColumnWidth(300),
                        },
                        children: [
                          TableRow(children: [
                            Column(
                              children: [
                                Text("Type",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text("[ " +
                                    pokemon.type.join(", ") +
                                    " ] " +
                                    "\n")
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text("Weakness",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text("[ " +
                                    pokemon.weakness.join(", ") +
                                    " ] " +
                                    "\n")
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text("Previous Evolution",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text("[ " +
                                    pokemon.prevEvolution.join(", ") +
                                    " ] " +
                                    "\n")
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text("Next Evolution",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text("[ " +
                                    pokemon.nextEvolution.join(", ") +
                                    " ] " +
                                    "\n")
                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ])),
                ],
              ),
            ),
          ],
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await canLaunch(pokemon.wikiUrl)) {
            await launch(pokemon.wikiUrl);
          } else {
            throw 'Could not launch ${pokemon.wikiUrl}';
          }
        },
        child: const Icon(Icons.travel_explore),
      ),
    );
  }
}

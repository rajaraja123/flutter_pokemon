import 'package:kuis/pokemon_detail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kuis/pokemon_data.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final PokemonData pokemon = listPokemon[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PokemonDetail(pokemonIdx: index);
              }));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                        pokemon.image,
                        width: 300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(pokemon.name),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: listPokemon.length,
      ),
    );
  }
}

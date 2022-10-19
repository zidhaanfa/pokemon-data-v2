import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../main.dart';
import '../pokemon/detailPokemon.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  SharedPreferences? prefs;
  List<dynamic> pokemonData = [];
  late String nextLink;
  late String? prevLink = null;

  Future<void> getDataPokemon() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var apiResponse = await getListPokemon();
    if (apiResponse.statusCode == 200) {
      var data = json.decode(apiResponse.body);
      var link = data['next'];
      setState(() {
        pokemonData = data['results'];
        nextLink = link.substring(18);
        // print(pokemonData);
        print(nextLink);
      });
    } else {
      setState(() {
        print('object');
      });
    }
  }

  Future<void> getDataPokemonPaginationNext() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var apiResponse = await getListPokemonPagination(nextLink);
    if (apiResponse.statusCode == 200) {
      var data = json.decode(apiResponse.body);
      var link = data['next'];
      setState(() {
        pokemonData = data['results'];
        nextLink = link.substring(18);
        // print(pokemonData);
        print(nextLink);
      });
    } else {
      setState(() {
        print('object');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          shadowColor: Colors.grey,
          elevation: 1,
          title: Text("Pokemon App"),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: pokemonData.length,
                  itemBuilder: (context, index) {
                    String idGambar =
                        '${pokemonData[index]['url'].substring(34, pokemonData[index]['url'].length - 1).length}';
                    return InkWell(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: idGambar == '2'
                                    ? Image.network(
                                        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/0${pokemonData[index]['url'].substring(34, pokemonData[index]['url'].length - 1)}.png')
                                    : Image.network(
                                        'https://assets.pokemon.com/assets/cms2/img/pokedex/full/00${pokemonData[index]['url'].substring(34, pokemonData[index]['url'].length - 1)}.png'),
                                title: Text(pokemonData[index]['name']),
                                // subtitle: Text(pokemonData[index]['url']
                                //     .substring(34,
                                //         pokemonData[index]['url'].length - 1)),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        if (pokemonData[index]['url']
                                .substring(
                                    34, pokemonData[index]['url'].length - 1)
                                .length ==
                            2) {
                          Get.to(() => DetailPokemon(
                                name: pokemonData[index]['name'],
                                idLink:
                                    '0${pokemonData[index]['url'].substring(34, pokemonData[index]['url'].length - 1)}',
                                id: pokemonData[index]['url'].substring(
                                    34, pokemonData[index]['url'].length - 1),
                              ));
                        } else {
                          Get.to(() => DetailPokemon(
                                name: pokemonData[index]['name'],
                                idLink:
                                    '00${pokemonData[index]['url'].substring(34, pokemonData[index]['url'].length - 1)}',
                                id: pokemonData[index]['url'].substring(
                                    34, pokemonData[index]['url'].length - 1),
                              ));
                        }
                      },
                    );
                  },
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      prevLink == null
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: GFButton(
                                onPressed: null,
                                text: "Previous",
                                color: Colors.grey,
                                shape: GFButtonShape.pills,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: GFButton(
                                onPressed: () {},
                                text: "Previous",
                                color: button,
                                shape: GFButtonShape.pills,
                              ),
                            ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: GFButton(
                          onPressed: () {
                            getDataPokemonPaginationNext();
                          },
                          text: "Next",
                          color: button,
                          shape: GFButtonShape.pills,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

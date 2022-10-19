import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../api/api.dart';
import '../main.dart';

class DetailPokemon extends StatefulWidget {
  final String name;
  final String idLink;
  final String id;
  const DetailPokemon(
      {Key? key, required this.name, required this.idLink, required this.id})
      : super(key: key);

  @override
  _DetailPokemonState createState() => _DetailPokemonState();
}

class _DetailPokemonState extends State<DetailPokemon> {
  Map<String, dynamic> listDetail = {};
  List<dynamic> listAbilities = [];
  List<dynamic> listForms = [];
  List<dynamic> listGameIndices = [];
  List<dynamic> listHeldItems = [];
  List<dynamic> listMoves = [];
  List<dynamic> listPastType = [];
  Map<String, dynamic> species = {};
  Map<String, dynamic> sprites = {};
  List<dynamic> listStats = [];
  List<dynamic> listTypes = [];

  bool showAbilities = false;
  bool showForms = false;
  bool showGameIndices = false;
  bool showHeldItems = false;
  bool showMoves = false;
  bool showPastType = false;
  bool showSpecies = false;
  bool showSprites = false;
  bool showStats = false;
  bool showTypes = false;
  Future<void> getDetailPokemon() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var apiResponse = await getDataPokemon(widget.id);
    if (apiResponse.statusCode == 200) {
      var data = json.decode(apiResponse.body);
      setState(() {
        listDetail = data;
        listAbilities = data['abilities'];
        listForms = data['forms'];
        listGameIndices = data['game_indices'];
        listHeldItems = data['held_items'];
        listMoves = data['moves'];
        listPastType = data['past_types'];
        species = data['species'];
        sprites = data['sprites'];
        listStats = data['stats'];
        listTypes = data['types'];
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
    getDetailPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          shadowColor: Colors.grey,
          elevation: 1,
          title: Text(widget.name),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      GFCard(
                        boxFit: BoxFit.cover,
                        titlePosition: GFPosition.start,
                        image: Image.network(
                          'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${widget.idLink}.png',
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.6,
                          fit: BoxFit.cover,
                        ),
                        showImage: true,
                        content: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                        "Base Experience : ${listDetail['base_experience']}"),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                          "Height : ${listDetail['height']}")),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                          "Weight : ${listDetail['weight']}")),
                                ],
                              ),
                            ),
                          ],
                        ),
                        buttonBar: GFButtonBar(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: GFButton(
                                onPressed: () {},
                                color: button,
                                text: "location_area_encounters",
                                textColor: Colors.white,
                                icon: Icon(
                                  Icons.map_sharp,
                                  color: Colors.white,
                                ),
                                shape: GFButtonShape.pills,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showAbilities = !showAbilities;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title: Text('Abilities',
                                style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showAbilities
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showAbilities
                          ? Card(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listAbilities.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            title: Text(
                                                '${listAbilities[index]['ability']['name']}'),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showForms = !showForms;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title:
                                Text('Forms', style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showForms
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showForms
                          ? Card(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listForms.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            title: Text(
                                                '${listForms[index]['name']}'),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showGameIndices = !showGameIndices;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title: Text('Game Indices',
                                style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showGameIndices
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showGameIndices
                          ? Card(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listGameIndices.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            title: Text(
                                                '${listGameIndices[index]['version']['name']}'),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showHeldItems = !showHeldItems;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title: Text('Held Items',
                                style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showHeldItems
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showHeldItems
                          ? Card(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listHeldItems.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            title: Text(
                                                '${listHeldItems[index]['item']['name']}'),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showMoves = !showMoves;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title:
                                Text('Moves', style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showMoves
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showMoves
                          ? Card(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listMoves.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            title: Text(
                                                '${listMoves[index]['move']['name']}'),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showPastType = !showPastType;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title: Text('Past Type',
                                style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showPastType
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showPastType
                          ? Card(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listPastType.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            title: Text(
                                                '${listPastType[index]['move']['name']}'),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showSpecies = !showSpecies;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title:
                                Text('Species', style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showSpecies
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showSpecies
                          ? Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: ListTile(
                                        title: Text('${species['name']}'),
                                        trailing:
                                            Icon(Icons.keyboard_arrow_right),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showSprites = !showSprites;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title:
                                Text('Sprites', style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showSprites
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showSprites
                          ? Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: 120,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: sprites['back_default'] == null
                                              ? SizedBox(
                                                  width: 1,
                                                )
                                              : Image.network(
                                                  sprites['back_default'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: sprites['back_female'] == null
                                              ? SizedBox(
                                                  width: 1,
                                                )
                                              : Image.network(
                                                  sprites['back_female'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: sprites['back_shiny'] == null
                                              ? SizedBox(
                                                  width: 1,
                                                )
                                              : Image.network(
                                                  sprites['back_shiny'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: sprites['back_shiny_female'] ==
                                                  null
                                              ? SizedBox(
                                                  width: 1,
                                                )
                                              : Image.network(
                                                  sprites['back_shiny_female'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child:
                                              sprites['front_default'] == null
                                                  ? SizedBox(
                                                      width: 1,
                                                    )
                                                  : Image.network(
                                                      sprites['front_default'],
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: sprites['front_female'] == null
                                              ? SizedBox(
                                                  width: 1,
                                                )
                                              : Image.network(
                                                  sprites['front_female'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: sprites['front_shiny'] == null
                                              ? SizedBox(
                                                  width: 1,
                                                )
                                              : Image.network(
                                                  sprites['front_shiny'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: sprites[
                                                      'front_shiny_female'] ==
                                                  null
                                              ? SizedBox(
                                                  width: 1,
                                                )
                                              : Image.network(
                                                  sprites['front_shiny_female'],
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: ListTile(
                                              title: Text('Other'),
                                              trailing: Icon(
                                                  Icons.keyboard_arrow_right),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showPastType = !showPastType;
                          });
                        },
                        child: Card(
                          child: ListTile(
                            title:
                                Text('Stats', style: TextStyle(fontSize: 20)),
                            trailing: Icon(
                              showPastType
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      ),
                      showPastType
                          ? Card(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: listStats.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {},
                                          child: ListTile(
                                            title: Text(
                                                '${listStats[index]['stat']['name']}'),
                                            subtitle: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: Text(
                                                          'Base Stat: ${listStats[index]['base_stat']}'),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: Text(
                                                          'Effort: ${listStats[index]['effort']}'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            trailing: Icon(
                                                Icons.keyboard_arrow_right),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
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

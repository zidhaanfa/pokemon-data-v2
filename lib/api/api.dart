import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

const url = 'pokeapi.co/api/v2/';

Future<http.Response> getListPokemon() {
  return http.get(
    Uri.https('pokeapi.co', '/api/v2/pokemon'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  );
}

Future<http.Response> getListPokemonPagination(String link) {
  return http.get(
    Uri.https('pokeapi.co', link),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  );
}

Future<http.Response> getDataPokemon(String id) {
  return http.get(
    Uri.https('pokeapi.co', '/api/v2/pokemon/$id'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  );
}

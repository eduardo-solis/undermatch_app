import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:undermatch_app/models/ctgCategorias.dart';
import 'package:undermatch_app/routes/routes.dart';

class CtgCategoriasAPI {
  final String urlBase = Routes.URL;

  Future<List<CtgCategorias>> getList() async {
    List<CtgCategorias> categorias = [];
    var url = Uri.parse("$urlBase/api/ctgCategorias");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);

        for (var element in jsonData) {
          categorias
              .add(CtgCategorias(element["IdCategoria"], element["Categoria"]));
        }
        return categorias;
      }
      return [];
    } catch (e) {
      return [];
    }

    return categorias;
  }
}

//import 'package:undermatch_app/models/equipo.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:undermatch_app/models/equipo.dart';

class EquiposAPI {
  Future<List<Equipo>> getList() async {
    Uri url = Uri.https('443f-189-203-236-12.ngrok.io', '/api/tblEquipos');

    List<Equipo> equipos = [];

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);

        for (var element in jsonData) {
          equipos.add(Equipo(
              element["IdEquipo"],
              element["Nombre"],
              element["Categoria"],
              element["AnioFundacion"],
              element["Zona"],
              element["ColorLocal"],
              element["ColorVisitante"],
              element["Estatus"]));
        }

        return equipos;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

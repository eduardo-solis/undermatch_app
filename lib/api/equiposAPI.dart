import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:undermatch_app/models/equipo.dart';

class EquiposAPI {
  final String urlBase =
      "https://35e9-2806-2f0-6000-f28d-4079-44ea-70da-56df.ngrok.io";

  Future<List<Equipo>> getList() async {
    var url = Uri.parse('$urlBase/api/tblEquipos');

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

  Future<String> agregar(Equipo e) async {
    try {
      String nombre = e.nombre;
      int categoria = e.categoria;
      String zona = e.zona;
      String anioFundacion = e.anioFundacion;
      String colorLocal = e.colorLocal;
      String colorVisitante = e.colorVisitante;

      var url = Uri.parse(
          '$urlBase/api/tblEquipos/?nombre=$nombre&categoria=$categoria&anioFundacion=$anioFundacion&zona=$zona&colorVisitante=$colorVisitante&colorLocal=$colorLocal');
      final response = await http.post(url);
      if (response.statusCode == 201) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (ex) {
      return "ERROR";
    }
  }

  Future<String> editar(Equipo e) async {
    try {
      int id = e.id;
      String nombre = e.nombre;
      int categoria = e.categoria;
      String zona = e.zona;
      String anioFundacion = e.anioFundacion;
      String colorLocal = e.colorLocal;
      String colorVisitante = e.colorVisitante;

      var url = Uri.parse(
          '$urlBase/api/tblEquipos/?idEquipo=$id&nombre=$nombre&categoria=$categoria&anioFundacion=$anioFundacion&zona=$zona&colorVisitante=$colorVisitante&colorLocal=$colorLocal');

      final response = await http.put(url);
      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (ex) {
      return "ERROR";
    }
  }

  Future<String> eliminar(int idEquipo) async {
    try {
      var url =
          Uri.parse('$urlBase/api/tblEquipos/?idEquipo=$idEquipo&operacion=0');

      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (ex) {
      return "ERROR";
    }
  }

  Future<String> activar(int idEquipo) async {
    try {
      var url =
          Uri.parse('$urlBase/api/tblEquipos/?idEquipo=$idEquipo&operacion=1');
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (ex) {
      return "ERROR";
    }
  }
}

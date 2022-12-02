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

Future<String> agregar(Equipo e) async {
  try {
    Uri url = Uri.https('443f-189-203-236-12.ngrok.io', '/api/tblEquipos', {
      "nombre": e.nombre,
      "categoria": e.categoria,
      "zona": e.zona,
      "anioFundacion": e.anioFundacion,
      "colorLocal": e.colorLocal,
      "colorVisitante": e.colorVisitante
    });
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
    Uri url = Uri.https('443f-189-203-236-12.ngrok.io', '/api/tblEquipos', {
      "idEquipo": e.id,
      "nombre": e.nombre,
      "categoria": e.categoria,
      "zona": e.zona,
      "anioFundacion": e.anioFundacion,
      "colorLocal": e.colorLocal,
      "colorVisitante": e.colorVisitante
    });
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
    Uri url = Uri.https('443f-189-203-236-12.ngrok.io', '/api/tblEquipos',
        {"idEquipo": idEquipo, "operacion": 0});
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
    Uri url = Uri.https('443f-189-203-236-12.ngrok.io', '/api/tblEquipos',
        {"idEquipo": idEquipo, "operacion": 1});
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

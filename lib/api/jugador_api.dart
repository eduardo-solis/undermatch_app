import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:undermatch_app/models/jugador.dart';
import 'package:undermatch_app/routes/routes.dart';

class JugadorAPI {
  final String urlBase = Routes.URL;

  Future<List<Jugador>> getList() async {
    List<Jugador> jugadores = [];

    var url = Uri.parse('$urlBase/api/tblJugadores');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        print(jsonData);
        for (var element in jsonData) {
          jugadores.add(Jugador(
              element["IdPersona"],
              element["IdJugador"],
              element["Nombre"],
              element["PrimerApellido"],
              element["SegundoApellido"],
              element["FechaNacimiento"],
              element["Sexo"],
              element["Telefono"],
              "1",
              element["Correo"],
              element["NumDorsal"],
              element["SobreNombre"],
              element["Posicion"],
              element["Capitan"],
              element["Estatus"]));
        }
      }
      return jugadores;
    } catch (e) {
      return jugadores;
    }
  }

  Future<String> agregar(Jugador j) async {
    var url = Uri.parse(
        '$urlBase/api/tblJugadores?nombre=${j.nombre}&primerApellido=${j.primerApellido}&segundoApellido=${j.segundoApellido}&fechaNacimiento=${j.fechaNacimiento}&sexo=${j.sexo}&telefono=${j.telefono}&telefono2=1&correo=${j.correo}&numDorsal=${j.numDorsal}&sobreNombre=${j.sobreNombre}&posicion=${j.posicion}&capitan=${j.capitan}');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }

  Future<String> editar(Jugador j) async {
    var url = Uri.parse(
        '$urlBase/api/tblJugadores?idPersona=${j.idPersona}&idJugador=${j.idJugador}&nombre=${j.nombre}&primerApellido=${j.primerApellido}&segundoApellido=${j.segundoApellido}&fechaNacimiento=${j.fechaNacimiento}&sexo=${j.sexo}&telefono=${j.telefono}&telefono2=1&correo=${j.correo}&numDorsal=${j.numDorsal}&sobreNombre=${j.sobreNombre}&posicion=${j.posicion}&capitan=${j.capitan}');

    try {
      final response = await http.put(url);

      if (response.statusCode == 204) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }

  Future<String> eliminar(int idJugador) async {
    var url =
        Uri.parse('$urlBase/api/tblJugadores?idJugador=$idJugador&operacion=0');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }

  Future<String> activar(int idJugador) async {
    var url =
        Uri.parse('$urlBase/api/tblJugadores?idJugador=$idJugador&operacion=1');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:undermatch_app/models/arbitro.dart';
import 'package:undermatch_app/routes/routes.dart';

class ArbitroAPI {
  final String urlBase = Routes.URL;

  Future<List<Arbitro>> getList() async {
    List<Arbitro> arbitros = [];

    try {
      var url = Uri.parse('$urlBase/api/tblArbitros');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);

        for (var element in jsonData) {
          arbitros.add(Arbitro(
              element["IdPersona"],
              element["IdArbitro"],
              element["Nombre"],
              element["PrimerApellido"],
              element["SegundoApellido"],
              element["FechaNacimiento"],
              element["Sexo"],
              element["Telefono"],
              element["Telefono2"],
              element["Correo"],
              element["CostoArbitraje"],
              element["IdCategoria"],
              element["IdTipoArbitro"],
              element["Estatus"]));
        }

        return arbitros;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> agregar(Arbitro a) async {
    try {
      var url = Uri.parse(
          '$urlBase/api/tblArbitros?nombre=${a.nombre}&primerApellido=${a.primerApellido}&segundoApellido=${a.segundoApellido}&fechaNacimiento=${a.fechaNacimiento}&sexo=${a.sexo}&telefono=${a.telefono}&telefono2=${a.telefono2}&correo=${a.correo}&costoArbitraje=${a.costoArbitraje}&idCategoria=${a.idCategoria}&idTipoArbitro=${a.idTipoArbotro}');

      final response = await http.post(url);

      if (response.statusCode == 201) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }

  Future<String> editar(Arbitro a) async {
    try {
      var url = Uri.parse(
          '$urlBase/api/tblArbitros?idPersona=${a.idPersona}&idArbitro=${a.idArbitro}&nombre=${a.nombre}&primerApellido=${a.primerApellido}&segundoApellido=${a.segundoApellido}&fechaNacimiento=${a.fechaNacimiento}&sexo=${a.sexo}&telefono=${a.telefono}&telefono2=${a.telefono2}&correo=${a.correo}&costoArbitraje=${a.costoArbitraje}&idCategoria=${a.idCategoria}&idTipoArbitro=${a.idTipoArbotro}');

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

  Future<String> eliminar(int idArbitro) async {
    try {
      var url = Uri.parse(
          '$urlBase/api/tblArbitros?idArbitro=$idArbitro&operacion=0');

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

  Future<String> activar(int idArbitro) async {
    try {
      var url = Uri.parse(
          '$urlBase/api/tblArbitros?idArbitro=$idArbitro&operacion=1');

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

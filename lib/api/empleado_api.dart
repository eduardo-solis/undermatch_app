import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:undermatch_app/models/empleado.dart';
import 'package:undermatch_app/routes/routes.dart';

class EmpleadoAPI {
  final String urlBase = Routes.URL;

  Future<List<Empleado>> getList() async {
    List<Empleado> empleados = [];

    var url = Uri.parse('$urlBase/api/tblEmpleados');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);

        final jsonData = jsonDecode(body);

        for (var element in jsonData) {
          empleados.add(Empleado(
              element["IdPersona"],
              element["IdEmpleado"],
              element["Nombre"],
              element["PrimerApellido"],
              element["SegundoApellido"],
              element["FechaNacimiento"],
              element["Sexo"],
              element["Telefono"],
              element["Telefono2"],
              element["Correo"],
              element["Calle"],
              element["Numero"],
              element["Colonia"],
              element["CodigoPostal"],
              element["IdMunicipio"],
              element["Curp"],
              element["TipoEmpleado"],
              element["Rfc"],
              element["Nss"],
              element["Salario"],
              element["Horario"],
              element["Estatus"]));
        }
      }

      return empleados;
    } catch (e) {
      return empleados;
    }
  }

  Future<String> agregar(Empleado e) async {
    var url = Uri.parse(
        '$urlBase/api/tblEmpleados?nombre=${e.nombre}&primerApellido=${e.primerApellido}&segundoApellido=${e.segundoApellido}&fechaNacimiento=${e.fechaNacimiento}&sexo=${e.sexo}&telefono=${e.telefono}&telefono2=${e.telefono2}&correo=${e.correo}&calleE=${e.calleE}&numeroE=${e.numeroE}&coloniaE=${e.coloniaE}&codigoPostalE=${e.codigoPostalE}&idMunicipioE=${e.idMunicipioE}&curpe=${e.curpe}&tipoEmpleado=${e.tipoEmpleado}&rfcE=${e.rfcE}&nssE=${e.nssE}&salarioE=${e.salarioE}&horarioE=${e.horarioE}');

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

  Future<String> editar(Empleado e) async {
    var url = Uri.parse(
        '$urlBase/api/tblEmpleados?idPersona=${e.idPersona}&nombre=${e.nombre}&primerApellido=${e.primerApellido}&segundoApellido=${e.segundoApellido}&fechaNacimiento=${e.fechaNacimiento}&sexo=${e.sexo}&telefono=${e.telefono}&telefono2=${e.telefono2}&correo=${e.correo}&idEmpleado=${e.idEmpleado}&calleE=${e.calleE}&numeroE=${e.numeroE}&coloniaE=${e.coloniaE}&codigoPostalE=${e.codigoPostalE}&idMunicipioE=${e.idMunicipioE}&curpe=${e.curpe}&tipoEmpleado=${e.tipoEmpleado}&rfcE=${e.rfcE}&nssE=${e.nssE}&salarioE=${e.salarioE}&horarioE=${e.horarioE}');

    try {
      final response = await http.post(url);

      if (response.statusCode == 204) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }

  Future<String> eliminar(int idEmpleado) async {
    var url = Uri.parse(
        '$urlBase/api/tblEmpleados?idEmpleado=$idEmpleado&operacion=0');
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

  Future<String> activar(int idEmpleado) async {
    var url = Uri.parse(
        '$urlBase/api/tblEmpleados?idEmpleado=$idEmpleado&operacion=1');
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

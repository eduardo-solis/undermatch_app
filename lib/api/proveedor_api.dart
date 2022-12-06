import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:undermatch_app/models/proveedor.dart';
import 'package:undermatch_app/routes/routes.dart';

class ProveedorAPI {
  final String urlBase = Routes.URL;

  Future<List<Proveedor>> getList() async {
    var url = Uri.parse('$urlBase/api/tblProveedores');

    List<Proveedor> proveedores = [];

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);

        for (var element in jsonData) {
          //print(element);
          proveedores.add(Proveedor(
              element["IdProveedor"],
              element["Rfc"],
              element["Nombre"],
              element["RazonSocial"],
              element["Calle"],
              element["Numero"],
              element["Colonia"],
              element["CodigoPostal"],
              element["IdMunicipio"],
              element["TipoProveedor"],
              element["Correo"],
              element["Telefono"],
              element["IdPlantel"],
              element["Estatus"]));
        }

        return proveedores;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> agregar(Proveedor p) async {
    try {
      int id = p.idProveedor;
      String rfc = p.rfc;
      String nombre = p.nombre;
      String razonSocial = p.razonSocial;
      String calle = p.calle;
      String numero = p.numero;
      String colonia = p.colonia;
      String cp = p.codigoPostal;
      String correo = p.correo;
      String telefono = p.telefono;
      int estatus = p.Estatus;
      int idMunicipio = p.idMunicipio;
      int idTipoProveedor = p.idTipoProveedor;
      int idPlantel = p.idPanel;

      var url = Uri.parse(
          '$urlBase/api/tblProveedores?rfc=${p.rfc}&nombre=${p.nombre}&razonSocial=${p.razonSocial}&calle=${p.calle}&numero=${p.numero}&colonia=${p.colonia}&codigoPostal=${p.codigoPostal}&idMunicipio=${p.idMunicipio}&idTipoProveedor=${p.idTipoProveedor}&correo=${p.correo}&telefono=${p.telefono}&idPlantel=${p.idPanel}');
      print(url);
      final response = await http.post(url);
      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "ERROR";
      }
    } catch (ex) {
      return "ERROR";
    }
  }

  Future<String> editar(Proveedor p) async {
    try {
      int id = p.idProveedor;
      String rfc = p.rfc;
      String nombre = p.nombre;
      String razonSocial = p.razonSocial;
      String calle = p.calle;
      String numero = p.numero;
      String colonia = p.colonia;
      String cp = p.codigoPostal;
      String correo = p.correo;
      String telefono = p.telefono;
      int estatus = p.Estatus;
      int idMunicipio = p.idMunicipio;
      int idTipoProveedor = p.idTipoProveedor;
      int idPlantel = p.idPanel;

      var url = Uri.parse(
          '$urlBase/api/tblProveedores?idProveedor=${p.idProveedor}&rfc=${p.rfc}&nombre=${p.nombre}&razonSocial=${p.razonSocial}&calle=${p.calle}&numero=${p.numero}&colonia=${p.colonia}&codigoPostal=${p.codigoPostal}&idMunicipio=${p.idMunicipio}&idTipoProveedor=${p.idTipoProveedor}&correo=${p.correo}&telefono=${p.telefono}&idPlantel=${p.idPanel}');

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

  Future<String> eliminar(int idProveedor) async {
    try {
      var url = Uri.parse(
          '$urlBase/api/tblProveedores/?idProveedor=$idProveedor&operacion=0');

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

  Future<String> activar(int idProveedor) async {
    try {
      var url = Uri.parse(
          '$urlBase/api/tblProveedores/?idProveedor=$idProveedor&operacion=1');
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

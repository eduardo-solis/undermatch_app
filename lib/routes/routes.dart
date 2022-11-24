import 'package:flutter/material.dart';

abstract class Routes {
  static const INICIO = "/";

  // Rutas de los equipos
  static const EQUIPOS = "/equipos";
  static const EQUIPOS_CONSULTAR = "/equipos/consultar";
  static const EQUIPOS_CONSULTAR_ID = "/equipos/consultar_id";
  static const EQUIPOS_AGREGAR = "/equipos/agregar";
  static const EQUIPOS_MODIFICAR = "/equipos/modificar";
  static const EQUIPOS_ELIMINAR = "/equipos/eliminar";
  static const EQUIPOS_ACTIVAR = "/equipos/activar";
}

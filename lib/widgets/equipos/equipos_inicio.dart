import 'package:flutter/material.dart';

import '../../routes/routes.dart';

class EquiposInicio extends StatelessWidget {
  const EquiposInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Equipos")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Servicios:"),
            ElevatedButton(
                onPressed: () {
                  //print("Consultar equipo");
                  Navigator.pushReplacementNamed(
                      context, Routes.EQUIPOS_CONSULTAR);
                },
                child: const Text("Consultar")),
            ElevatedButton(
                onPressed: () => print("Consultar equipo por Id"),
                child: const Text("Consultar por ID")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.EQUIPOS_AGREGAR);
                },
                child: const Text("Agregar")),
            ElevatedButton(
                onPressed: () => print("Editar equipo"),
                child: const Text("Editar")),
            ElevatedButton(
                onPressed: () => print("Eliminar equipo"),
                child: const Text("Eliminar")),
            ElevatedButton(
                onPressed: () => print("Activar equipo"),
                child: const Text("Activar"))
          ],
        ),
      ),
    );
  }
}

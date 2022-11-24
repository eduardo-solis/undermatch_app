import 'package:flutter/material.dart';

class EquiposInicio extends StatelessWidget {
  const EquiposInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Equipos")),
      body: Center(
        child: Column(
          children: [
            const Text("Servicios:"),
            ElevatedButton(
                onPressed: () => print("Consultar equipo"),
                child: const Text("Consultar")),
            ElevatedButton(
                onPressed: () => print("Consultar equipo por Id"),
                child: const Text("Consultar por ID")),
            ElevatedButton(
                onPressed: () => print("Agregar equipo"),
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

import 'package:flutter/material.dart';

class MyDialogEquipo extends StatelessWidget {
  const MyDialogEquipo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Guardar equipo"),
      contentPadding: const EdgeInsets.all(15),
      children: [
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Nombre"),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Categoría"),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Año de fundación"),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Zona"),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Color Local"),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Color Visitante"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {},
                child: const Text("Cancelar")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Text("Guardar"))
          ],
        )
      ],
    );
  }
}

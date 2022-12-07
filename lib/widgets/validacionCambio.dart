import 'package:flutter/material.dart';

class ValidacionCambio extends StatelessWidget {
  final String titulo;
  final String modulo;
  final Function accion;

  const ValidacionCambio(
      {Key? key,
      required this.titulo,
      required this.accion,
      required this.modulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(titulo),
      contentPadding: const EdgeInsets.all(15),
      children: [
        Text("Estas seguro de hacer cambios en un $modulo"),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  accion();
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ItemListEquipos extends StatelessWidget {
  final String nombre;
  final int numMiembros;
  const ItemListEquipos(
      {Key? key, required this.nombre, required this.numMiembros})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    editar() {
      print("Editar");
    }

    eliminar() {
      print("Eliminar");
    }

    return Container(
      margin: const EdgeInsets.all(10),
      height: 70,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nombre: $nombre"),
              Text("Núm. Miembros: $numMiembros"),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => eliminar(),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () => editar(),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

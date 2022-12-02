import 'package:flutter/material.dart';
import 'package:undermatch_app/widgets/equipos/myDialog.dart';

class ItemListEquipos extends StatelessWidget {
  final int Id;
  final String Nombre;
  final int Categoria;
  final String AnioFundacion;
  final String Zona;
  final String ColorLocal;
  final String ColorVisitante;
  final int Estatus;
  const ItemListEquipos(
      {Key? key,
      required this.Nombre,
      required this.Id,
      required this.Categoria,
      required this.AnioFundacion,
      required this.Zona,
      required this.ColorLocal,
      required this.ColorVisitante,
      required this.Estatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _dialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogEquipo(
              id: Id,
              nombre: Nombre,
              anioFundacion: AnioFundacion,
              categoria: Categoria,
              colorLocal: ColorLocal,
              colorVisitante: ColorVisitante,
              zona: Zona,
            );
          });
    }

    editar() {
      print("Editar");
      _dialog();
    }

    eliminar() {
      print("Eliminar");
    }

    activar() {
      print("Activar");
    }

    return Container(
      margin: const EdgeInsets.all(10),
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
              Text("Nombre: $Nombre"),
              Text("Núm. Miembros: $AnioFundacion"),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: Estatus == 0 ? () => activar() : () => eliminar(),
                  icon: Estatus == 0
                      ? const Icon(
                          Icons.toggle_off,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.toggle_on,
                          color: Colors.green,
                        )),
              IconButton(
                  onPressed: () => editar(),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

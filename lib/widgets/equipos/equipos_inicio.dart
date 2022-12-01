import 'package:flutter/material.dart';
import 'package:undermatch_app/widgets/equipos/itemList.dart';
import 'package:undermatch_app/widgets/equipos/myDialog.dart';

class EquiposInicio extends StatelessWidget {
  const EquiposInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buscar() {
      print("Buscar");
    }

    limpiar() {
      print("Limpiar");
    }

    Future<void> _dialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const MyDialogEquipo();
          });
    }

    agregar() {
      print("Agregar");
      _dialog();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Equipos")),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Buscar"),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.amber,
                          ),
                          onPressed: () => buscar(),
                        ))
                  ],
                ),
                ElevatedButton(
                    onPressed: () => limpiar(),
                    child: const Text("Limpiar busqueda")),
                // Agregar listas
                const SizedBox(
                  height: 20,
                ),

                ItemListEquipos(nombre: "Pumas", numMiembros: 11),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Agregar"),
        splashColor: Colors.amber,
        onPressed: () => agregar(),
      ),
    );
  }
}

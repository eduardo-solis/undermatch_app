import 'package:flutter/material.dart';
import 'package:undermatch_app/api/equiposAPI.dart';
import 'package:undermatch_app/models/equipo.dart';
import 'package:undermatch_app/widgets/equipos/itemList.dart';
import 'package:undermatch_app/widgets/equipos/myDialog.dart';

class EquiposInicio extends StatefulWidget {
  const EquiposInicio({Key? key}) : super(key: key);

  @override
  State<EquiposInicio> createState() => _EquiposInicioState();
}

class _EquiposInicioState extends State<EquiposInicio> {
  late Future<List<Equipo>> equipos;
  late Future<List<Equipo>> equiposFiltrados;
  bool buscando = false;

  @override
  void initState() {
    super.initState();
    equipos = EquiposAPI().getList();
  }

  List<Widget> _listaEquipos(List<Equipo> data) {
    List<Widget> equipos = [];

    for (var equipo in data) {
      equipos.add(ItemListEquipos(
          Nombre: equipo.nombre,
          Id: equipo.id,
          Categoria: equipo.categoria,
          AnioFundacion: equipo.anioFundacion,
          Zona: equipo.zona,
          ColorLocal: equipo.colorLocal,
          ColorVisitante: equipo.colorVisitante,
          Estatus: equipo.estatus));
    }

    return equipos;
  }

  @override
  Widget build(BuildContext context) {
    buscar() {
      print("Buscar");
      setState(() {
        buscando = true;
      });
    }

    limpiar() {
      print("Limpiar");
      setState(() {
        buscando = false;
      });
    }

    Future<void> _dialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const MyDialogEquipo(
              id: 0,
              nombre: "",
              anioFundacion: "",
              categoria: 0,
              colorLocal: "",
              colorVisitante: "",
              zona: "",
            );
          });
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
                Visibility(
                  visible: buscando,
                  child: ElevatedButton(
                      onPressed: () => limpiar(),
                      child: const Text("Limpiar busqueda")),
                ),
                // Agregar listas
                const SizedBox(
                  height: 20,
                ),

                FutureBuilder(
                  future: equipos,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        shrinkWrap: true,
                        children: _listaEquipos(snapshot.data as List<Equipo>),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("NO Hay info");
                    }
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Agregar"),
        splashColor: Colors.amber,
        onPressed: () => _dialog(),
      ),
    );
  }
}

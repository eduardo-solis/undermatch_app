import 'package:flutter/material.dart';
import 'package:undermatch_app/api/equiposAPI.dart';
import 'package:undermatch_app/models/equipo.dart';
import 'package:undermatch_app/widgets/equipos/elementoEquipo.dart';
import 'package:undermatch_app/widgets/equipos/formularioEquipos.dart';

class EquiposInicio extends StatefulWidget {
  const EquiposInicio({Key? key}) : super(key: key);

  @override
  State<EquiposInicio> createState() => _EquiposInicioState();
}

class _EquiposInicioState extends State<EquiposInicio> {
  late Future<List<Equipo>> equipos;
  late Future<List<Equipo>> equiposFiltrados;
  bool buscando = false;
  final TextEditingController _textoABuscar = TextEditingController();

  @override
  void initState() {
    super.initState();
    equipos = EquiposAPI().getList();
    equiposFiltrados = equipos.then((value) => value);
  }

  List<Widget> _listaEquipos(List<Equipo> data) {
    List<Widget> equipos = [];

    for (var equipo in data) {
      equipos.add(ElementoEquipo(
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

  buscar() {
    if (_textoABuscar.text.length != 0) {
      equiposFiltrados = equipos.then((value) {
        String aux = _textoABuscar.text.toLowerCase();
        List<Equipo> auxEquipos = [];
        for (var element in value) {
          if (element.nombre.toLowerCase() == aux) {
            auxEquipos.add(element);
          }
        }
        return auxEquipos;
      });

      buscando = true;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Ingrese el nombre del equipo a buscar",
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.amber,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))));
    }
  }

  limpiar() {
    equiposFiltrados = equipos;
    _textoABuscar.text = "";
    buscando = false;
    setState(() {});
  }

  Future<void> _formularioEquipos() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const FormularioEquipos(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equipos"),
        centerTitle: true,
        elevation: 0,
      ),
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
                          controller: _textoABuscar,
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
                  future: equiposFiltrados,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Text(
                          "No se encontro nada",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return ListView(
                          shrinkWrap: true,
                          children:
                              _listaEquipos(snapshot.data as List<Equipo>),
                        );
                      }
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
        onPressed: () => _formularioEquipos(),
      ),
    );
  }
}

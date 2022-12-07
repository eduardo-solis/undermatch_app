import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/arbitro_api.dart';
import 'package:undermatch_app/models/arbitro.dart';
import 'package:undermatch_app/widgets/arbitros/elemento_arbitro.dart';

import '../widgets/arbitros/formulario_arbitro.dart';

class ArbitrosInicio extends StatefulWidget {
  const ArbitrosInicio({Key? key}) : super(key: key);

  @override
  State<ArbitrosInicio> createState() => _ArbitrosInicioState();
}

class _ArbitrosInicioState extends State<ArbitrosInicio> {
  late Future<List<Arbitro>> arbitros;
  late Future<List<Arbitro>> arbitrosFiltrados;
  bool buscando = false;
  final TextEditingController _textoABuscar = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerArbitros();
  }

  obtenerArbitros() {
    arbitros = ArbitroAPI().getList();
    arbitrosFiltrados = arbitros.then((value) => value);
  }

  List<Widget> _listaArbitros(List<Arbitro> data) {
    List<Widget> arbitros = [];

    for (var arbitro in data) {
      arbitros.add(ElementoArbitro(
          idPersona: arbitro.idPersona,
          idArbitro: arbitro.idArbitro,
          nombre: arbitro.nombre,
          primerApellido: arbitro.primerApellido,
          segundoApellido: arbitro.segundoApellido,
          fechaNacimiento: arbitro.fechaNacimiento,
          sexo: arbitro.sexo,
          telefono: arbitro.telefono,
          correo: arbitro.correo,
          costoArbitraje: arbitro.costoArbitraje,
          idCategoria: arbitro.idCategoria,
          idTipoArbotro: arbitro.idTipoArbotro,
          estatus: arbitro.estatus,
          formulario: _formularioArbitro));
    }

    return arbitros;
  }

  buscar() {
    if (_textoABuscar.text.length != 0) {
      arbitrosFiltrados = arbitros.then((value) {
        String aux = _textoABuscar.text.toLowerCase();
        List<Arbitro> auxArbitro = [];
        for (var element in value) {
          if (element.nombre.toLowerCase().contains(aux)) {
            auxArbitro.add(element);
          }
        }
        return auxArbitro;
      });

      buscando = true;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Ingrese el nombre del arbitro a buscar",
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.amber,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))));
    }
  }

  limpiar() {
    arbitrosFiltrados = arbitros;
    _textoABuscar.text = "";
    buscando = false;
    setState(() {});
  }

  Future<void> _formularioArbitro(
    int idPersona,
    int idArbitro,
    String nombre,
    String primerApellido,
    String segundoApellido,
    String fechaNacimiento,
    String sexo,
    String telefono,
    String correo,
    double costoArbitraje,
    int idCategoria,
    int idTipoArbotro,
  ) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormularioArbitro(
              idPersona: idPersona,
              idArbitro: idArbitro,
              nombre: nombre,
              primerApellido: primerApellido,
              segundoApellido: segundoApellido,
              fechaNacimiento: fechaNacimiento,
              sexo: sexo,
              telefono: telefono,
              correo: correo,
              costoArbitraje: costoArbitraje,
              idCategoria: idCategoria,
              idTipoArbotro: idTipoArbotro);
        }).then((value) {
      setState(() {
        obtenerArbitros();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arbitros"),
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
                  future: arbitrosFiltrados,
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
                              _listaArbitros(snapshot.data as List<Arbitro>),
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
        onPressed: () => _formularioArbitro(
            0, 0, "", "", "", "01-01-2000", "Hombre", "", "", 0, 1, 1),
      ),
    );
  }
}

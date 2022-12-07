import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/jugador_api.dart';
import 'package:undermatch_app/models/jugador.dart';
import 'package:undermatch_app/widgets/jugadores/elemento_jugador.dart';

import '../widgets/jugadores/formulario_jugadores.dart';

class JugadoresInicio extends StatefulWidget {
  const JugadoresInicio({Key? key}) : super(key: key);

  @override
  State<JugadoresInicio> createState() => _JugadoresInicioState();
}

class _JugadoresInicioState extends State<JugadoresInicio> {
  late Future<List<Jugador>> jugadores;
  late Future<List<Jugador>> jugadoresFiltrados;
  bool buscando = false;
  final TextEditingController _textoABuscar = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerJugadores();
  }

  obtenerJugadores() {
    jugadores = JugadorAPI().getList();
    jugadoresFiltrados = jugadores.then((value) => value);
  }

  List<Widget> _listaJugadores(List<Jugador> data) {
    List<Widget> jugadores = [];

    for (var jugador in data) {
      jugadores.add(ElementoJugador(
          formulario: _formularioJugador,
          idPersona: jugador.idPersona,
          idJugador: jugador.idJugador,
          nombre: jugador.nombre,
          primerApellido: jugador.primerApellido,
          segundoApellido: jugador.segundoApellido,
          fechaNacimiento: jugador.fechaNacimiento,
          sexo: jugador.sexo,
          telefono: jugador.telefono,
          telefono2: jugador.telefono2,
          correo: jugador.correo,
          numDorsal: jugador.numDorsal,
          sobreNombre: jugador.sobreNombre,
          posicion: jugador.posicion,
          estatus: jugador.estatus));
    }

    return jugadores;
  }

  buscar() {
    if (_textoABuscar.text.length != 0) {
      jugadoresFiltrados = jugadores.then((value) {
        String aux = _textoABuscar.text.toLowerCase();
        List<Jugador> auxJugador = [];
        for (var element in value) {
          if (element.nombre.toLowerCase().contains(aux)) {
            auxJugador.add(element);
          }
        }
        return auxJugador;
      });

      buscando = true;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Ingrese el nombre del jugador a buscar",
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.amber,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))));
    }
  }

  limpiar() {
    jugadoresFiltrados = jugadores;
    _textoABuscar.text = "";
    buscando = false;
    setState(() {});
  }

  Future<void> _formularioJugador(
    int idPersona,
    int idJugador,
    String nombre,
    String correo,
    String fechaNacimiento,
    String numDorsal,
    String posicion,
    String primerApellido,
    String segundoApellido,
    String sexo,
    String sobreNombre,
    String telefono2,
    String telefono,
  ) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormularioJugador(
            idPersona: idPersona,
            idJugador: idJugador,
            nombre: nombre,
            correo: correo,
            fechaNacimiento: fechaNacimiento,
            numDorsal: numDorsal,
            posicion: posicion,
            primerApellido: primerApellido,
            segundoApellido: segundoApellido,
            sexo: sexo,
            sobreNombre: sobreNombre,
            telefono2: telefono2,
            telefono: telefono,
          );
        }).then((value) {
      setState(() {
        obtenerJugadores();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jugadores"),
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
                  future: jugadoresFiltrados,
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
                              _listaJugadores(snapshot.data as List<Jugador>),
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
        onPressed: () => _formularioJugador(0, 0, "", "", "01-01-2000", "",
            "Delantero", "", "", "Hombre", "", "", ""),
      ),
    );
  }
}

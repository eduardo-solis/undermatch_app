import 'package:flutter/material.dart';
import 'package:undermatch_app/api/jugador_api.dart';
import 'package:undermatch_app/widgets/validacionCambio.dart';

class ElementoEmpleado extends StatefulWidget {
  final int idPersona;
  final int idJugador;
  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final String fechaNacimiento;
  final String sexo;
  final String telefono;
  final String telefono2;
  final String correo;
  final String numDorsal;
  final String sobreNombre;
  final String posicion;
  final int estatus;
  final Function formulario;

  const ElementoEmpleado(
      {Key? key,
      required this.formulario,
      required this.idPersona,
      required this.idJugador,
      required this.nombre,
      required this.primerApellido,
      required this.segundoApellido,
      required this.fechaNacimiento,
      required this.sexo,
      required this.telefono,
      required this.telefono2,
      required this.correo,
      required this.numDorsal,
      required this.sobreNombre,
      required this.posicion,
      required this.estatus})
      : super(key: key);

  @override
  State<ElementoEmpleado> createState() => _ElementoEmpleadoState();
}

class _ElementoEmpleadoState extends State<ElementoEmpleado> {
  late int estatusJugador;

  Future<void> _validarCambio(Function accion) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ValidacionCambio(
            titulo: "Guardar cambios", accion: accion, modulo: "Jugador");
      },
    );
  }

  eliminar() {
    JugadorAPI().eliminar(widget.idJugador).then((res) {
      if (res == "OK") {
        setState(() {
          estatusJugador = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha desactivado un jugador",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al desactivar un jugador",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  activar() {
    JugadorAPI().activar(widget.idJugador).then((res) {
      if (res == "OK") {
        setState(() {
          estatusJugador = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha activado un jugador",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al activar un jugador",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  hacerCambio() {
    if (estatusJugador == 0) {
      _validarCambio(activar);
    } else if (estatusJugador == 1) {
      _validarCambio(eliminar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estatusJugador = widget.estatus;
  }

  @override
  Widget build(BuildContext context) {
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
              Text("Nombre: ${widget.nombre}"),
              Text("SobreNombre: ${widget.sobreNombre}"),
              Text("Núm. Dorsal: ${widget.numDorsal}"),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => hacerCambio(),
                  icon: estatusJugador == 0
                      ? const Icon(
                          Icons.toggle_off,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.toggle_on,
                          color: Colors.green,
                        )),
              IconButton(
                  onPressed: () => widget.formulario(
                        widget.idPersona,
                        widget.idJugador,
                        widget.nombre,
                        widget.correo,
                        widget.fechaNacimiento,
                        widget.numDorsal,
                        widget.posicion,
                        widget.primerApellido,
                        widget.segundoApellido,
                        widget.sexo,
                        widget.sobreNombre,
                        widget.telefono2,
                        widget.telefono,
                      ),
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

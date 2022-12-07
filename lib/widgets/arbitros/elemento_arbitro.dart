import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/arbitro_api.dart';
import 'package:undermatch_app/widgets/validacionCambio.dart';

class ElementoArbitro extends StatefulWidget {
  final int idPersona;
  final int idArbitro;
  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final String fechaNacimiento;
  final String sexo;
  final String telefono;
  final String correo;
  final double costoArbitraje;
  final int idCategoria;
  final int idTipoArbotro;
  final int estatus;
  final Function formulario;

  const ElementoArbitro({
    Key? key,
    required this.idPersona,
    required this.idArbitro,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.fechaNacimiento,
    required this.sexo,
    required this.telefono,
    required this.correo,
    required this.costoArbitraje,
    required this.idCategoria,
    required this.idTipoArbotro,
    required this.estatus,
    required this.formulario,
  }) : super(key: key);

  @override
  State<ElementoArbitro> createState() => _ElementoArbitroState();
}

class _ElementoArbitroState extends State<ElementoArbitro> {
  late int estatusArbitro;

  Future<void> _validarCambio(Function accion) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ValidacionCambio(
            titulo: "Guardar cambios", accion: accion, modulo: "Arbitro");
      },
    );
  }

  eliminar() {
    ArbitroAPI().eliminar(widget.idArbitro).then((res) {
      if (res == "OK") {
        setState(() {
          estatusArbitro = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha desactivado un arbitro",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al desactivar un arbitro",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  activar() {
    ArbitroAPI().activar(widget.idArbitro).then((res) {
      if (res == "OK") {
        setState(() {
          estatusArbitro = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha activado un arbitro",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al activar un arbitro",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  hacerCambio() {
    if (estatusArbitro == 0) {
      _validarCambio(activar);
    } else if (estatusArbitro == 1) {
      _validarCambio(eliminar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estatusArbitro = widget.estatus;
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
              Text("Apellido: ${widget.primerApellido}"),
              Text("Costo Arbitraje: ${widget.costoArbitraje}"),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => hacerCambio(),
                  icon: estatusArbitro == 0
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
                      widget.idArbitro,
                      widget.nombre,
                      widget.primerApellido,
                      widget.segundoApellido,
                      widget.fechaNacimiento,
                      widget.sexo,
                      widget.telefono,
                      widget.correo,
                      widget.costoArbitraje,
                      widget.idCategoria,
                      widget.idTipoArbotro),
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

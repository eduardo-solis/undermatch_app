import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/empleado_api.dart';
import 'package:undermatch_app/widgets/validacionCambio.dart';

class ElementoEmpleado extends StatefulWidget {
  final int idPersona;
  final int idEmpleado;
  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final String fechaNacimiento;
  final String sexo;
  final String telefono;
  final String correo;
  final String calleE;
  final String numeroE;
  final String coloniaE;
  final String codigoPostalE;
  final int idMunicipioE;
  final String curpe;
  final int tipoEmpleado;
  final String rfcE;
  final String nssE;
  final double salarioE;
  final String horarioE;
  final int estatus;
  final Function formulario;

  const ElementoEmpleado({
    Key? key,
    required this.idPersona,
    required this.idEmpleado,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.fechaNacimiento,
    required this.sexo,
    required this.telefono,
    required this.correo,
    required this.calleE,
    required this.numeroE,
    required this.coloniaE,
    required this.codigoPostalE,
    required this.idMunicipioE,
    required this.curpe,
    required this.tipoEmpleado,
    required this.rfcE,
    required this.nssE,
    required this.salarioE,
    required this.horarioE,
    required this.estatus,
    required this.formulario,
  }) : super(key: key);

  @override
  State<ElementoEmpleado> createState() => _ElementoEmpleadoState();
}

class _ElementoEmpleadoState extends State<ElementoEmpleado> {
  late int estatusEmpleado;

  Future<void> _validarCambio(Function accion) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ValidacionCambio(
            titulo: "Guardar cambios", accion: accion, modulo: "Empleado");
      },
    );
  }

  eliminar() {
    EmpleadoAPI().eliminar(widget.idEmpleado).then((res) {
      if (res == "OK") {
        setState(() {
          estatusEmpleado = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha desactivado un empleado",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
                "Ha ocurrido un error al desactivar un empleado",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  activar() {
    EmpleadoAPI().activar(widget.idEmpleado).then((res) {
      if (res == "OK") {
        setState(() {
          estatusEmpleado = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha activado un empleado",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al activar un empleado",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  hacerCambio() {
    if (estatusEmpleado == 0) {
      _validarCambio(activar);
    } else if (estatusEmpleado == 1) {
      _validarCambio(eliminar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estatusEmpleado = widget.estatus;
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
              Text("Correo: ${widget.correo}"),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => hacerCambio(),
                  icon: estatusEmpleado == 0
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
                      widget.idEmpleado,
                      widget.nombre,
                      widget.primerApellido,
                      widget.segundoApellido,
                      widget.fechaNacimiento,
                      widget.sexo,
                      widget.telefono,
                      "1",
                      widget.correo,
                      widget.calleE,
                      widget.numeroE,
                      widget.coloniaE,
                      widget.codigoPostalE,
                      widget.idMunicipioE,
                      widget.curpe,
                      widget.tipoEmpleado,
                      widget.rfcE,
                      widget.nssE,
                      widget.salarioE,
                      widget.horarioE),
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

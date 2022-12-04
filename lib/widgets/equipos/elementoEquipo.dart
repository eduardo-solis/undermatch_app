import 'package:flutter/material.dart';
import 'package:undermatch_app/api/equiposAPI.dart';
import 'package:undermatch_app/widgets/equipos/formularioEquipos.dart';
import 'package:undermatch_app/widgets/validacionCambio.dart';

class ElementoEquipo extends StatefulWidget {
  final int Id;
  final String Nombre;
  final int Categoria;
  final String AnioFundacion;
  final String Zona;
  final String ColorLocal;
  final String ColorVisitante;
  final int Estatus;
  final Function formulario;
  const ElementoEquipo(
      {Key? key,
      required this.Nombre,
      required this.Id,
      required this.Categoria,
      required this.AnioFundacion,
      required this.Zona,
      required this.ColorLocal,
      required this.ColorVisitante,
      required this.Estatus,
      required this.formulario})
      : super(key: key);

  @override
  State<ElementoEquipo> createState() => _ElementoEquipoState();
}

class _ElementoEquipoState extends State<ElementoEquipo> {
  late int estatusEquipo;

  Future<void> _formularioEquipo() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormularioEquipos(
            id: widget.Id,
            nombre: widget.Nombre,
            anioFundacion: widget.AnioFundacion,
            categoria: widget.Categoria,
            colorLocal: widget.ColorLocal,
            colorVisitante: widget.ColorVisitante,
            zona: widget.Zona,
          );
        });
  }

  Future<void> _validarCambio(Function accion) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ValidacionCambio(
            titulo: "Guardar cambios", accion: accion, modulo: "Equipo");
      },
    );
  }

  eliminar() {
    EquiposAPI().eliminar(widget.Id).then((res) {
      if (res == "OK") {
        setState(() {
          estatusEquipo = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha desactivado un equipo",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al desactivar un equipo",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  activar() {
    EquiposAPI().activar(widget.Id).then((res) {
      if (res == "OK") {
        setState(() {
          estatusEquipo = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha activado un equipo",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al activar un equipo",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  hacerCambio() {
    if (estatusEquipo == 0) {
      _validarCambio(activar);
    } else if (estatusEquipo == 1) {
      _validarCambio(eliminar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estatusEquipo = widget.Estatus;
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
              Text("Nombre: ${widget.Nombre}"),
              Text("Zona: ${widget.Zona}"),
              Text("Año de Fundación: ${widget.AnioFundacion}"),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => hacerCambio(),
                  icon: estatusEquipo == 0
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
                      widget.Id,
                      widget.Nombre,
                      widget.AnioFundacion,
                      widget.Categoria,
                      widget.ColorLocal,
                      widget.ColorVisitante,
                      widget.Zona),
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

import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/proveedor_api.dart';
import 'package:undermatch_app/widgets/proveedores/formularioProveedores.dart';
import 'package:undermatch_app/widgets/validacionCambio.dart';

class ElementoProveedor extends StatefulWidget {
  final int idProveedor;
  final String rfc;
  final String nombre;
  final String razonSocial;
  final String calle;
  final String numero;
  final String colonia;
  final String codigoPostal;
  final int idMunicipio;
  final int idTipoProveedor;
  final String correo;
  final String telefono;
  final int idPanel;
  final int Estatus;
  final Function formulario;

  const ElementoProveedor(
      {Key? key,
      required this.Estatus,
      required this.formulario,
      required this.idProveedor,
      required this.rfc,
      required this.nombre,
      required this.razonSocial,
      required this.calle,
      required this.numero,
      required this.colonia,
      required this.codigoPostal,
      required this.idMunicipio,
      required this.idTipoProveedor,
      required this.correo,
      required this.telefono,
      required this.idPanel})
      : super(key: key);

  @override
  State<ElementoProveedor> createState() => _ElementoProveedorState();
}

class _ElementoProveedorState extends State<ElementoProveedor> {
  late int estatusProveedor;

  Future<void> _formularioProveedor() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormularioProveedor(
            idProveedor: widget.idProveedor,
            idMunicipio: widget.idMunicipio,
            idPanel: widget.idPanel,
            idTipoProveedor: widget.idTipoProveedor,
            nombre: widget.nombre,
            numero: widget.numero,
            calle: widget.calle,
            codigoPostal: widget.codigoPostal,
            colonia: widget.colonia,
            correo: widget.correo,
            razonSocial: widget.razonSocial,
            rfc: widget.rfc,
            telefono: widget.telefono,
          );
        });
  }

  Future<void> _validarCambio(Function accion) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ValidacionCambio(
            titulo: "Guardar cambios", accion: accion, modulo: "Proveedor");
      },
    );
  }

  eliminar() {
    ProveedorAPI().eliminar(widget.idProveedor).then((res) {
      if (res == "OK") {
        setState(() {
          estatusProveedor = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha desactivado un proveedor",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
                "Ha ocurrido un error al desactivar un proveedor",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  activar() {
    ProveedorAPI().activar(widget.idProveedor).then((res) {
      if (res == "OK") {
        setState(() {
          estatusProveedor = 1;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Se ha activado un proveedor",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      } else if (res == "ERROR") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Ha ocurrido un error al activar un proveedor",
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
      }
    });
  }

  hacerCambio() {
    if (estatusProveedor == 0) {
      _validarCambio(activar);
    } else if (estatusProveedor == 1) {
      _validarCambio(eliminar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estatusProveedor = widget.Estatus;
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
              Text("Razón Social: ${widget.razonSocial}"),
              Text("Telefono: ${widget.telefono}"),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => hacerCambio(),
                  icon: estatusProveedor == 0
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
                        widget.idProveedor,
                        widget.idMunicipio,
                        widget.idPanel,
                        widget.idTipoProveedor,
                        widget.nombre,
                        widget.numero,
                        widget.calle,
                        widget.codigoPostal,
                        widget.colonia,
                        widget.correo,
                        widget.razonSocial,
                        widget.rfc,
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

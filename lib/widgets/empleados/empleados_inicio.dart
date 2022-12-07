import 'package:flutter/material.dart';
import 'package:undermatch_app/api/empleado_api.dart';
import 'package:undermatch_app/models/empleado.dart';
import 'package:undermatch_app/widgets/empleados/elemento_empleado.dart';

import 'formulario_empleado.dart';

class EmpledosInicio extends StatefulWidget {
  const EmpledosInicio({Key? key}) : super(key: key);

  @override
  State<EmpledosInicio> createState() => _EmpledosInicioState();
}

class _EmpledosInicioState extends State<EmpledosInicio> {
  late Future<List<Empleado>> empleados;
  late Future<List<Empleado>> empleadosFiltrados;
  bool buscando = false;
  final TextEditingController _textoABuscar = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerEmpleados();
  }

  obtenerEmpleados() {
    empleados = EmpleadoAPI().getList();
    empleadosFiltrados = empleados.then((value) => value);
  }

  List<Widget> _listaEmpleados(List<Empleado> data) {
    List<Widget> empleados = [];

    for (var empleado in data) {
      empleados.add(ElementoEmpleado(
          idPersona: empleado.idPersona,
          idEmpleado: empleado.idEmpleado,
          nombre: empleado.nombre,
          primerApellido: empleado.primerApellido,
          segundoApellido: empleado.segundoApellido,
          fechaNacimiento: empleado.fechaNacimiento,
          sexo: empleado.sexo,
          telefono: empleado.telefono,
          correo: empleado.correo,
          calleE: empleado.calleE,
          numeroE: empleado.numeroE,
          coloniaE: empleado.coloniaE,
          codigoPostalE: empleado.codigoPostalE,
          idMunicipioE: empleado.idMunicipioE,
          curpe: empleado.curpe,
          tipoEmpleado: empleado.tipoEmpleado,
          rfcE: empleado.rfcE,
          nssE: empleado.nssE,
          salarioE: empleado.salarioE,
          horarioE: empleado.horarioE,
          estatus: empleado.estatus,
          formulario: _formularioEmpleado));
    }

    return empleados;
  }

  buscar() {
    if (_textoABuscar.text.length != 0) {
      empleadosFiltrados = empleados.then((value) {
        String aux = _textoABuscar.text.toLowerCase();
        List<Empleado> auxEmpleado = [];
        for (var element in value) {
          if (element.nombre.toLowerCase().contains(aux)) {
            auxEmpleado.add(element);
          }
        }
        return auxEmpleado;
      });

      buscando = true;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Ingrese el nombre del empleado a buscar",
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.amber,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))));
    }
  }

  limpiar() {
    empleadosFiltrados = empleados;
    _textoABuscar.text = "";
    buscando = false;
    setState(() {});
  }

  Future<void> _formularioEmpleado(
      int idPersona,
      int idEmpleado,
      String nombre,
      String primerApellido,
      String segundoApellido,
      String fechaNacimiento,
      String sexo,
      String telefono,
      String telefono2,
      String correo,
      String calleE,
      String numeroE,
      String coloniaE,
      String codigoPostalE,
      int idMunicipioE,
      String curpe,
      int tipoEmpleado,
      String rfcE,
      String nssE,
      double salarioE,
      String horarioE) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormularioEmpleado(
              idPersona: idPersona,
              nombre: nombre,
              primerApellido: primerApellido,
              segundoApellido: segundoApellido,
              fechaNacimiento: fechaNacimiento,
              sexo: sexo,
              telefono: telefono,
              correo: correo,
              idEmpleado: idEmpleado,
              calleE: calleE,
              numeroE: numeroE,
              coloniaE: coloniaE,
              codigoPostalE: codigoPostalE,
              idMunicipioE: idMunicipioE,
              curpe: curpe,
              tipoEmpleado: tipoEmpleado,
              rfcE: rfcE,
              nssE: nssE,
              salarioE: salarioE,
              horarioE: horarioE);
        }).then((value) {
      setState(() {
        obtenerEmpleados();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empleados"),
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
                  future: empleadosFiltrados,
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
                              _listaEmpleados(snapshot.data as List<Empleado>),
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
        onPressed: () => _formularioEmpleado(0, 0, "", "", "", "01-01-2000",
            "Hombre", "", "", "", "", "", "", "", 334, "", 1, "", "", 0, ""),
      ),
    );
  }
}

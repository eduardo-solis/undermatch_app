import 'package:flutter/material.dart';
import 'package:undermatch_app/api/proveedor_api.dart';
import 'package:undermatch_app/models/proveedor.dart';
import 'package:undermatch_app/widgets/proveedores/elementoProveedor.dart';
import 'package:undermatch_app/widgets/proveedores/formularioProveedores.dart';

class ProveedoresInicio extends StatefulWidget {
  const ProveedoresInicio({Key? key}) : super(key: key);

  @override
  State<ProveedoresInicio> createState() => _ProveedoresInicioState();
}

class _ProveedoresInicioState extends State<ProveedoresInicio> {
  late Future<List<Proveedor>> proveedores;
  late Future<List<Proveedor>> proveedoresFiltrados;
  bool buscando = false;
  final TextEditingController _textoABuscar = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerProveedores();
  }

  obtenerProveedores() {
    proveedores = ProveedorAPI().getList();
    proveedoresFiltrados = proveedores.then((value) => value);
  }

  List<Widget> _listaProveedores(List<Proveedor> data) {
    List<Widget> proveedores = [];

    for (var proveedor in data) {
      proveedores.add(ElementoProveedor(
          Estatus: proveedor.Estatus,
          formulario: _formularioProveedor,
          idProveedor: proveedor.idProveedor,
          rfc: proveedor.rfc,
          nombre: proveedor.nombre,
          razonSocial: proveedor.razonSocial,
          calle: proveedor.calle,
          numero: proveedor.numero,
          colonia: proveedor.colonia,
          codigoPostal: proveedor.codigoPostal,
          idMunicipio: proveedor.idMunicipio,
          idTipoProveedor: proveedor.idTipoProveedor,
          correo: proveedor.correo,
          telefono: proveedor.telefono,
          idPanel: proveedor.idPanel));
    }

    return proveedores;
  }

  buscar() {
    if (_textoABuscar.text.length != 0) {
      proveedoresFiltrados = proveedores.then((value) {
        String aux = _textoABuscar.text.toLowerCase();
        List<Proveedor> auxProveedor = [];
        for (var element in value) {
          if (element.nombre.toLowerCase().contains(aux)) {
            auxProveedor.add(element);
          }
        }
        return auxProveedor;
      });

      buscando = true;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Ingrese el nombre del proveedor a buscar",
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.amber,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))));
    }
  }

  limpiar() {
    proveedoresFiltrados = proveedores;
    _textoABuscar.text = "";
    buscando = false;
    setState(() {});
  }

  Future<void> _formularioProveedor(
      int idProveedor,
      int idMunicipio,
      int idPanel,
      int idTipoProveedor,
      String nombre,
      String numero,
      String calle,
      String codigoPostal,
      String colonia,
      String correo,
      String razonSocial,
      String rfc,
      String telefono) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormularioProveedor(
            idProveedor: idProveedor,
            idMunicipio: idMunicipio,
            idPanel: idPanel,
            idTipoProveedor: idTipoProveedor,
            nombre: nombre,
            numero: numero,
            calle: calle,
            codigoPostal: codigoPostal,
            colonia: colonia,
            correo: correo,
            razonSocial: razonSocial,
            rfc: rfc,
            telefono: telefono,
          );
        }).then((value) {
      setState(() {
        obtenerProveedores();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proveedores"),
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
                  future: proveedoresFiltrados,
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
                          children: _listaProveedores(
                              snapshot.data as List<Proveedor>),
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
        onPressed: () => _formularioProveedor(
            0, 0, 0, 0, "", "", "", "", "", "", "", "", ""),
      ),
    );
  }
}

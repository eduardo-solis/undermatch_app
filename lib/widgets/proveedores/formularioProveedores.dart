import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/proveedor_api.dart';
import 'package:undermatch_app/models/proveedor.dart';

class FormularioProveedor extends StatefulWidget {
  final int idProveedor;
  final String rfc;
  final String nombre;
  final String razonSocial;
  final String calle;
  final String numero;
  final String colonia;
  final String codigoPostal;
  final int idMunicipio; //
  final int idTipoProveedor; //
  final String correo;
  final String telefono;
  final int idPanel; //

  const FormularioProveedor({
    Key? key,
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
    required this.idPanel,
  }) : super(key: key);

  @override
  State<FormularioProveedor> createState() => _FormularioProveedorState();
}

class _FormularioProveedorState extends State<FormularioProveedor> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _rfc = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _razonSocial = TextEditingController();
  final TextEditingController _calle = TextEditingController();
  final TextEditingController _numero = TextEditingController();
  final TextEditingController _colonia = TextEditingController();
  final TextEditingController _cp = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _telefono = TextEditingController();

  String valorMunicipio = "334";
  List<DropdownMenuItem<String>> comboMunicipios = [
    const DropdownMenuItem<String>(value: "334", child: Text("León")),
    const DropdownMenuItem<String>(value: "321", child: Text("Guanajuato")),
    const DropdownMenuItem<String>(value: "348", child: Text("Celaya")),
    const DropdownMenuItem<String>(value: "327", child: Text("Irapuato")),
  ];

  String valorTProveedor = "1";
  List<DropdownMenuItem<String>> comboTProveedor = [
    const DropdownMenuItem<String>(value: "1", child: Text("Calzado")),
    const DropdownMenuItem<String>(value: "2", child: Text("Vestimenta")),
    const DropdownMenuItem<String>(value: "3", child: Text("Balones")),
  ];

  String valorPlantel = "1";
  List<DropdownMenuItem<String>> comboPlantel = [
    const DropdownMenuItem<String>(value: "1", child: Text("Deportiva León")),
    const DropdownMenuItem<String>(value: "2", child: Text("Estadio León")),
  ];

  guardar() {
    if (_form.currentState!.validate()) {
      Proveedor proveedor = Proveedor(
          widget.idProveedor,
          _rfc.text,
          _nombre.text,
          _razonSocial.text,
          _calle.text,
          _numero.text,
          _colonia.text,
          _cp.text,
          int.parse(valorMunicipio),
          int.parse(valorTProveedor),
          _correo.text,
          _telefono.text,
          int.parse(valorPlantel),
          1);
      if (widget.idProveedor != 0) {
        ProveedorAPI().editar(proveedor).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha actualizado un proveedor",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al actualizar un proveedor",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          }
        });
      } else {
        ProveedorAPI().agregar(proveedor).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha registrado un proveedor",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al registrar un proveedor",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          }
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _rfc.text = widget.rfc;
    _nombre.text = widget.nombre;
    _razonSocial.text = widget.razonSocial;
    _calle.text = widget.calle;
    _numero.text = widget.numero;
    _colonia.text = widget.colonia;
    _cp.text = widget.codigoPostal;
    valorMunicipio = widget.idMunicipio.toString();
    valorTProveedor = widget.idTipoProveedor.toString();
    _correo.text = widget.correo;
    _telefono.text = widget.telefono;
    valorPlantel = widget.idPanel.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: SimpleDialog(
        title: const Text("Guardar proveedor"),
        contentPadding: const EdgeInsets.all(15),
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Nombre"),
            ),
            controller: _nombre,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("RFC"),
            ),
            controller: _rfc,
            maxLength: 13,
            validator: (value) {
              String dato = value.toString();

              if (dato.length != 13) {
                return "Este campo debe tener 13 caracteristicas";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Razón Social"),
            ),
            controller: _razonSocial,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Calle"),
            ),
            controller: _calle,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Número"),
            ),
            controller: _numero,
            keyboardType: TextInputType.number,
            validator: (value) {
              String dato = value.toString();

              if (dato.startsWith("0")) {
                return "Este campo no puede contener un 0 al inicio";
              }
              if (dato.contains(",") ||
                  dato.contains(".") ||
                  dato.contains(" ") ||
                  dato.contains("-")) {
                return "No es permitido ingresar , . - o espacios en blanco";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Colonia"),
            ),
            controller: _colonia,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Codigo Postal"),
            ),
            controller: _cp,
            maxLength: 5,
            keyboardType: TextInputType.number,
            validator: (value) {
              String dato = value.toString();

              if (dato.startsWith("0")) {
                return "Este campo no puede contener un 0 al inicio";
              }
              if (dato.contains(",") ||
                  dato.contains(".") ||
                  dato.contains(" ") ||
                  dato.contains("-")) {
                return "No es permitido ingresar , . - o espacios en blanco";
              }
            },
          ),
          const Text("Municipio"),
          DropdownButton(
            value: valorMunicipio,
            items: comboMunicipios,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              valorMunicipio = item!;
              setState(() {});
            },
          ),
          const Text("Tipo de proveedor"),
          DropdownButton(
            value: valorTProveedor,
            items: comboTProveedor,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              valorTProveedor = item!;
              setState(() {});
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Correo"),
            ),
            controller: _correo,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Telefono"),
            ),
            controller: _telefono,
            keyboardType: TextInputType.phone,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          const Text("Plantel"),
          DropdownButton(
            value: valorPlantel,
            items: comboPlantel,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              valorPlantel = item!;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    guardar();
                  },
                  child: const Text("Guardar"))
            ],
          )
        ],
      ),
    );
  }
}

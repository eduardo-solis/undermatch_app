import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/ctgCategorias_api.dart';
import 'package:undermatch_app/controller/equipos_api.dart';
import 'package:undermatch_app/models/equipo.dart';

class FormularioEquipos extends StatefulWidget {
  final int id;
  final String nombre;
  final int categoria;
  final String anioFundacion;
  final String zona;
  final String colorLocal;
  final String colorVisitante;

  const FormularioEquipos({
    Key? key,
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.anioFundacion,
    required this.zona,
    required this.colorLocal,
    required this.colorVisitante,
  }) : super(key: key);

  @override
  State<FormularioEquipos> createState() => _FormularioEquiposState();
}

class _FormularioEquiposState extends State<FormularioEquipos> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _categoria = TextEditingController();
  final TextEditingController _anioFundacion = TextEditingController();
  final TextEditingController _zona = TextEditingController();
  final TextEditingController _colorLocal = TextEditingController();
  final TextEditingController _colorVisitante = TextEditingController();

  String _idCategoria = "1";
  List<DropdownMenuItem<String>> listaCategorias = [
    const DropdownMenuItem<String>(value: "1", child: Text("Juvenil")),
    const DropdownMenuItem<String>(value: "2", child: Text("Infantil")),
    const DropdownMenuItem<String>(value: "3", child: Text("Libre")),
  ];

  guardar() {
    if (_form.currentState!.validate()) {
      if (widget.id != 0) {
        Equipo equipo = Equipo(
            widget.id,
            _nombre.text,
            int.parse(_idCategoria),
            _anioFundacion.text,
            _zona.text,
            _colorLocal.text,
            _colorVisitante.text,
            1);

        EquiposAPI().editar(equipo).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha actualizado un equipo",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al actualizar un equipo",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          }
        });
      } else {
        Equipo equipo = Equipo(
            widget.id,
            _nombre.text,
            int.parse(_idCategoria),
            _anioFundacion.text,
            _zona.text,
            _colorLocal.text,
            _colorVisitante.text,
            1);

        EquiposAPI().agregar(equipo).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha registrado un equipo",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al registrar un equipo",
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

    _nombre.text = widget.nombre;
    _anioFundacion.text = widget.anioFundacion;
    _categoria.text = widget.categoria.toString();
    _zona.text = widget.zona;
    _colorLocal.text = widget.colorLocal;
    _colorVisitante.text = widget.colorVisitante;
    _idCategoria = widget.categoria.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: SimpleDialog(
        title: const Text("Guardar equipo"),
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
          const Text("Categorias"),
          DropdownButton(
            value: _idCategoria,
            items: listaCategorias,
            onChanged: (String? value) {
              _idCategoria = value!;
              setState(() {});
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Año de fundación"),
            ),
            controller: _anioFundacion,
            maxLength: 4,
            keyboardType: TextInputType.number,
            validator: (value) {
              String dato = value.toString();

              if (dato.isEmpty) {
                return "Este campo es obligatorio";
              }
              if (dato.length != 4) {
                return "El año debe ser de 4 digitos";
              }
              if (dato.contains(".") ||
                  dato.contains(",") ||
                  dato.contains("-") ||
                  dato.contains(" ") ||
                  dato.startsWith("0")) {
                return "El año debe ser de 4 digitos";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Zona"),
            ),
            controller: _zona,
            validator: (value) {
              String dato = value.toString();
              if (dato.isEmpty) {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Color Local"),
            ),
            controller: _colorLocal,
            validator: (value) {
              String dato = value.toString();
              if (dato.isEmpty) {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Color Visitante"),
            ),
            controller: _colorVisitante,
            validator: (value) {
              String dato = value.toString();
              if (dato.isEmpty) {
                return "Este campo es obligatorio";
              }
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

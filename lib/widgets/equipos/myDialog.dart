import 'package:flutter/material.dart';
import 'package:undermatch_app/api/equiposAPI.dart';
import 'package:undermatch_app/models/equipo.dart';

class MyDialogEquipo extends StatefulWidget {
  final int id;
  final String nombre;
  final int categoria;
  final String anioFundacion;
  final String zona;
  final String colorLocal;
  final String colorVisitante;

  const MyDialogEquipo({
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
  State<MyDialogEquipo> createState() => _MyDialogEquipoState();
}

class _MyDialogEquipoState extends State<MyDialogEquipo> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _form = GlobalKey<FormState>();
    TextEditingController _nombre = TextEditingController(text: widget.nombre);
    TextEditingController _categoria =
        TextEditingController(text: widget.categoria.toString());
    TextEditingController _anioFundacion =
        TextEditingController(text: widget.anioFundacion);
    TextEditingController _zona = TextEditingController(text: widget.zona);
    TextEditingController _colorLocal =
        TextEditingController(text: widget.colorLocal);
    TextEditingController _colorVisitante =
        TextEditingController(text: widget.colorVisitante);

    void guardar() {
      if (_form.currentState!.validate()) {
        if (widget.id != 0) {
          print("Se ha actualizado un registro");

          Equipo equipo = Equipo(
              widget.id,
              widget.nombre,
              widget.categoria,
              widget.anioFundacion,
              widget.zona,
              widget.colorLocal,
              widget.colorVisitante,
              1);

          String res = EquiposAPI().editar(equipo).toString();

          if (res == "OK") {
            //Añadir snackbar de exito
          } else if (res == "ERROR") {
            // Añadir snackbar de error
          }
        } else {
          print("Se ha guardado un nuevo registro");
          Equipo equipo = Equipo(
              widget.id,
              widget.nombre,
              widget.categoria,
              widget.anioFundacion,
              widget.zona,
              widget.colorLocal,
              widget.colorVisitante,
              1);

          String res = EquiposAPI().agregar(equipo).toString();

          if (res == "OK") {
            //Añadir snackbar de exito
          } else if (res == "ERROR") {
            // Añadir snackbar de error
          }
        }
      }
    }

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
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Categoría"),
            ),
            controller: _categoria,
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
                  onPressed: () => guardar(),
                  child: const Text("Guardar"))
            ],
          )
        ],
      ),
    );
  }
}

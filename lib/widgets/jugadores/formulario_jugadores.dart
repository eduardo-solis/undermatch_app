import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/jugador_api.dart';
import 'package:undermatch_app/models/jugador.dart';

class FormularioJugador extends StatefulWidget {
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

  const FormularioJugador({
    Key? key,
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
  }) : super(key: key);

  @override
  State<FormularioJugador> createState() => _FormularioJugadorState();
}

class _FormularioJugadorState extends State<FormularioJugador> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _primerApellido = TextEditingController();
  final TextEditingController _segundoApellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _telefono2 = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _numDorsal = TextEditingController();
  final TextEditingController _sobreNombre = TextEditingController();

  String _sexo = "Hombre";
  List<DropdownMenuItem<String>> comboSexo = [
    const DropdownMenuItem<String>(value: "Hombre", child: Text("Hombre")),
    const DropdownMenuItem<String>(value: "Mujer", child: Text("Mujer")),
    const DropdownMenuItem<String>(value: "Otro", child: Text("Otro")),
  ];

  String _dia = "01";
  List<DropdownMenuItem<String>> comboDia = [];

  String _mes = "01";
  List<DropdownMenuItem<String>> comboMes = [];

  String _anio = "2000";
  List<DropdownMenuItem<String>> comboAnio = [];

  String _posicion = "Delantero";
  List<DropdownMenuItem<String>> comboPosicion = [
    const DropdownMenuItem<String>(
        value: "Delantero", child: Text("Delantero")),
    const DropdownMenuItem<String>(value: "Defensa", child: Text("Defensa")),
    const DropdownMenuItem<String>(value: "Medio", child: Text("Medio")),
    const DropdownMenuItem<String>(value: "Portero", child: Text("Portero")),
  ];

  guardar() {
    if (_form.currentState!.validate()) {
      String fecha = '$_dia-$_mes-$_anio';

      Jugador jugador = Jugador(
          widget.idPersona,
          widget.idJugador,
          _nombre.text,
          _primerApellido.text,
          _segundoApellido.text,
          fecha,
          _sexo,
          _telefono.text,
          _telefono2.text,
          _correo.text,
          _numDorsal.text,
          _sobreNombre.text,
          _posicion,
          0,
          1);

      if (widget.idJugador != 0) {
        JugadorAPI().editar(jugador).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha actualizado un jugador",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al actualizar un jugador",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          }
        });
      } else {
        JugadorAPI().agregar(jugador).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha registrado un jugador",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al registrar un jugador",
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
    _primerApellido.text = widget.primerApellido;
    _segundoApellido.text = widget.segundoApellido;
    _telefono.text = widget.telefono;
    _telefono2.text = widget.telefono2;
    _correo.text = widget.correo;
    _numDorsal.text = widget.numDorsal;
    _sobreNombre.text = widget.sobreNombre;
    _posicion = widget.posicion;
    _sexo = widget.sexo;
    asignarFecha();
    comboDia = List.generate(31, (index) {
      int num = index + 1;
      String dia = num < 10 ? '0$num' : '$num';

      return DropdownMenuItem<String>(value: dia, child: Text(dia));
    });

    comboMes = List.generate(12, (index) {
      int num = index + 1;
      String mes = num < 10 ? '0$num' : '$num';

      return DropdownMenuItem<String>(value: mes, child: Text(mes));
    });

    comboAnio = List.generate(123, (index) {
      int num = index + 1900;
      String anio = '$num';

      return DropdownMenuItem<String>(value: anio, child: Text(anio));
    });
  }

  asignarFecha() {
    String fecha = widget.fechaNacimiento;
    final fechaSplit = fecha.split("-");
    _dia = fechaSplit[0];
    _mes = fechaSplit[1];
    _anio = fechaSplit[2];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: SimpleDialog(
        title: const Text("Guardar jugador"),
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
              label: Text("Primer Apellido"),
            ),
            controller: _primerApellido,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Segundo Apellido"),
            ),
            controller: _segundoApellido,
          ),
          const Text("Fecha de nacimiento"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: DropdownButton(
                  value: _dia,
                  items: comboDia,
                  isExpanded: true,
                  elevation: 16,
                  onChanged: (String? item) {
                    _dia = item!;
                    setState(() {});
                  },
                ),
              ),
              const Expanded(flex: 1, child: Text("|")),
              Expanded(
                flex: 2,
                child: DropdownButton(
                  value: _mes,
                  items: comboMes,
                  isExpanded: true,
                  elevation: 16,
                  onChanged: (String? item) {
                    _mes = item!;
                    setState(() {});
                  },
                ),
              ),
              const Expanded(flex: 1, child: Text("|")),
              Expanded(
                flex: 2,
                child: DropdownButton(
                  value: _anio,
                  items: comboAnio,
                  isExpanded: true,
                  elevation: 16,
                  onChanged: (String? item) {
                    _anio = item!;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const Text("Sexo"),
          DropdownButton(
            value: _sexo,
            items: comboSexo,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              _sexo = item!;
              setState(() {});
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
              label: Text("Número de dorsal"),
            ),
            controller: _numDorsal,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("SobreNombre"),
            ),
            controller: _sobreNombre,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          const Text("Posición"),
          DropdownButton(
            value: _posicion,
            items: comboPosicion,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              _posicion = item!;
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

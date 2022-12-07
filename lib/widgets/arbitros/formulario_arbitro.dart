import 'package:flutter/material.dart';
import 'package:undermatch_app/api/arbitro_api.dart';
import 'package:undermatch_app/models/arbitro.dart';

class FormularioArbitro extends StatefulWidget {
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

  const FormularioArbitro({
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
  }) : super(key: key);

  @override
  State<FormularioArbitro> createState() => _FormularioArbitroState();
}

class _FormularioArbitroState extends State<FormularioArbitro> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _primerApellido = TextEditingController();
  final TextEditingController _segundoApellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();

  final TextEditingController _costoArbitraje = TextEditingController();

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

  String _tipoArbitro = "1";
  List<DropdownMenuItem<String>> comboTArbitro = [
    const DropdownMenuItem<String>(value: "1", child: Text("Central")),
    const DropdownMenuItem<String>(value: "2", child: Text("Abanderado")),
    const DropdownMenuItem<String>(value: "3", child: Text("Cuarto arbitro")),
  ];

  String _tipoCategoria = "1";
  List<DropdownMenuItem<String>> listaCategorias = [
    const DropdownMenuItem<String>(value: "1", child: Text("Juvenil")),
    const DropdownMenuItem<String>(value: "2", child: Text("Infantil")),
    const DropdownMenuItem<String>(value: "3", child: Text("Libre")),
  ];

  guardar() {
    if (_form.currentState!.validate()) {
      String fecha = '$_dia-$_mes-$_anio';

      Arbitro arbitro = Arbitro(
          widget.idPersona,
          widget.idArbitro,
          _nombre.text,
          _primerApellido.text,
          _segundoApellido.text,
          fecha,
          _sexo,
          _telefono.text,
          "1",
          _correo.text,
          double.parse(_costoArbitraje.text),
          int.parse(_tipoCategoria),
          int.parse(_tipoArbitro),
          1);

      if (widget.idArbitro != 0) {
        ArbitroAPI().editar(arbitro).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha actualizado un arbitro",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al actualizar un arbitro",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          }
        });
      } else {
        ArbitroAPI().agregar(arbitro).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha registrado un arbitro",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al registrar un arbitro",
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
    _correo.text = widget.correo;
    _sexo = widget.sexo;

    _tipoArbitro = widget.idTipoArbotro.toString();
    _tipoCategoria = widget.idTipoArbotro.toString();
    _costoArbitraje.text = widget.costoArbitraje.toString();

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
        title: const Text("Guardar Arbitro"),
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
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
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
              label: Text("Costo de arbitraje"),
            ),
            controller: _costoArbitraje,
            keyboardType: TextInputType.number,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          const Text("Tipo de arbitro"),
          DropdownButton(
            value: _tipoArbitro,
            items: comboTArbitro,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              _tipoArbitro = item!;
              setState(() {});
            },
          ),
          const Text("Categoria"),
          DropdownButton(
            value: _tipoCategoria,
            items: listaCategorias,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              _tipoCategoria = item!;
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

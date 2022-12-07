import 'package:flutter/material.dart';
import 'package:undermatch_app/controller/empleado_api.dart';
import 'package:undermatch_app/models/empleado.dart';

class FormularioEmpleado extends StatefulWidget {
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

  const FormularioEmpleado({
    Key? key,
    required this.idPersona,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.fechaNacimiento,
    required this.sexo,
    required this.telefono,
    required this.correo,
    required this.idEmpleado,
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
  }) : super(key: key);

  @override
  State<FormularioEmpleado> createState() => _FormularioEmpleadoState();
}

class _FormularioEmpleadoState extends State<FormularioEmpleado> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _primerApellido = TextEditingController();
  final TextEditingController _segundoApellido = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _correo = TextEditingController();

  final TextEditingController _calleE = TextEditingController();
  final TextEditingController _numeroE = TextEditingController();
  final TextEditingController _coloniaE = TextEditingController();
  final TextEditingController _codigoPostalE = TextEditingController();
  final TextEditingController _curpe = TextEditingController();
  final TextEditingController _rfcE = TextEditingController();
  final TextEditingController _nssE = TextEditingController();
  final TextEditingController _salarioE = TextEditingController();
  final TextEditingController _horarioE = TextEditingController();

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

  String _tipoEmpleado = "1";
  List<DropdownMenuItem<String>> comboTEmpleado = [
    const DropdownMenuItem<String>(value: "1", child: Text("Administrador")),
    const DropdownMenuItem<String>(value: "2", child: Text("Mantenimiento")),
    const DropdownMenuItem<String>(
        value: "3", child: Text("Auxiliar administrativo")),
  ];

  String _municipio = "334";
  List<DropdownMenuItem<String>> comboMunicipios = [
    const DropdownMenuItem<String>(value: "334", child: Text("León")),
    const DropdownMenuItem<String>(value: "321", child: Text("Guanajuato")),
    const DropdownMenuItem<String>(value: "348", child: Text("Celaya")),
    const DropdownMenuItem<String>(value: "327", child: Text("Irapuato")),
  ];

  guardar() {
    if (_form.currentState!.validate()) {
      String fecha = '$_dia-$_mes-$_anio';

      Empleado empleado = Empleado(
          widget.idPersona,
          widget.idEmpleado,
          _nombre.text,
          _primerApellido.text,
          _segundoApellido.text,
          fecha,
          _sexo,
          _telefono.text,
          "1",
          _correo.text,
          _calleE.text,
          _numeroE.text,
          _coloniaE.text,
          _codigoPostalE.text,
          int.parse(_municipio),
          _curpe.text,
          int.parse(_tipoEmpleado),
          _rfcE.text,
          _nssE.text,
          double.parse(_salarioE.text),
          _horarioE.text,
          1);

      if (widget.idEmpleado != 0) {
        EmpleadoAPI().editar(empleado).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha actualizado un empleado",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al actualizar un empleado",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          }
        });
      } else {
        EmpleadoAPI().agregar(empleado).then((res) {
          if (res == "OK") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Se ha registrado un empleado",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))));
            Navigator.pop(context);
          } else if (res == "ERROR") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    "Ha ocurrido un error al registrar un empleado",
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

    _calleE.text = widget.calleE;
    _numeroE.text = widget.numeroE;
    _coloniaE.text = widget.coloniaE;
    _codigoPostalE.text = widget.codigoPostalE;
    _curpe.text = widget.curpe;
    _rfcE.text = widget.rfcE;
    _nssE.text = widget.nssE;
    _salarioE.text = widget.salarioE.toString();
    _horarioE.text = widget.horarioE;
    _municipio = widget.idMunicipioE.toString();

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
        title: const Text("Guardar Empleado"),
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
              label: Text("Calle"),
            ),
            controller: _calleE,
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
            controller: _numeroE,
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
            controller: _coloniaE,
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
            controller: _codigoPostalE,
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
            value: _municipio,
            items: comboMunicipios,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? item) {
              _municipio = item!;
              setState(() {});
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("RFC"),
            ),
            controller: _rfcE,
            maxLength: 13,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("CURP"),
            ),
            controller: _curpe,
            maxLength: 18,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Número de Seguro Social"),
            ),
            controller: _nssE,
            maxLength: 11,
            keyboardType: TextInputType.number,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          DropdownButton(
            value: _tipoEmpleado,
            items: comboTEmpleado,
            onChanged: (String? value) {
              _tipoEmpleado = value!;
              setState(() {});
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Salario"),
            ),
            controller: _salarioE,
            keyboardType: TextInputType.number,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
                return "Este campo es obligatorio";
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Horario"),
            ),
            controller: _horarioE,
            keyboardType: TextInputType.number,
            validator: (value) {
              String dato = value.toString();

              if (dato == "") {
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

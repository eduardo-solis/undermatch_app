import 'package:flutter/material.dart';
import 'package:undermatch_app/routes/routes.dart';
import 'package:undermatch_app/views/arbitros_inicio.dart';
import 'package:undermatch_app/widgets/drawerMenu/drawe_menu.dart';
import 'package:undermatch_app/views/empleados_inicio.dart';
import 'package:undermatch_app/views/equipos_inicio.dart';
import 'package:undermatch_app/views/jugadores_inicio.dart';
import 'package:undermatch_app/views/proveedores_inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Routes.INICIO: (context) => const MyHomePage(title: 'UnderMatch API'),
        Routes.EQUIPOS: (context) => const EquiposInicio(),
        Routes.PROVEEDORES: (context) => const ProveedoresInicio(),
        Routes.JUGADORES: (context) => const JugadoresInicio(),
        Routes.EMPLEADOS: (context) => const EmpledosInicio(),
        Routes.ARBITROS: (context) => const ArbitrosInicio()
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'UnderMatch API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Servicios de la API:",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Equipos"),
            Text("Jugadores"),
            Text("Proveedores"),
            Text("Empleados"),
            Text("Arbitros"),
          ],
        ),
      ),
    );
  }
}

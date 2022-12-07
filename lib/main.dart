import 'package:flutter/material.dart';
import 'package:undermatch_app/routes/routes.dart';
import 'package:undermatch_app/widgets/empleados/empleados_inicio.dart';
import 'package:undermatch_app/widgets/equipos/equipos_inicio.dart';
import 'package:undermatch_app/widgets/jugadores/jugadores_inicio.dart';
import 'package:undermatch_app/widgets/proveedores/proveedores_inicio.dart';

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
        Routes.EMPLEADOS: (context) => const EmpledosInicio()
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Servicios de la API"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.EQUIPOS);
                },
                child: const Text("Equipos")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.PROVEEDORES);
                },
                child: const Text("Proveedores")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.JUGADORES);
                },
                child: const Text("Jugadores")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.EMPLEADOS);
                },
                child: const Text("Empleados")),
          ],
        ),
      ),
    );
  }
}

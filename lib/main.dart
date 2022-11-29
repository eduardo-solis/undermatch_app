import 'package:flutter/material.dart';
import 'package:undermatch_app/routes/routes.dart';
import 'package:undermatch_app/widgets/equipos/equipos_agregar.dart';
import 'package:undermatch_app/widgets/equipos/equipos_consultar.dart';
import 'package:undermatch_app/widgets/equipos/equipos_inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.INICIO,
      routes: {
        Routes.INICIO: (context) => const MyHomePage(title: 'UnderMatch API'),
        Routes.EQUIPOS: (context) => const EquiposInicio(),
        Routes.EQUIPOS_CONSULTAR: (context) => const EquiposConsultar(),
        Routes.EQUIPOS_AGREGAR: (context) => const EquiposAgregar()
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
                  Navigator.pushReplacementNamed(context, Routes.EQUIPOS);
                  print("Entro a los servicios de los Equipos");
                },
                child: const Text("Equipos"))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EquiposAgregar extends StatelessWidget {
  const EquiposAgregar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar equipo"),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Nombre"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Categoria"),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Año de fundación"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Zona"),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Color Local"),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Color Visitante"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Guardar"))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pro0030/ModalGradiente.dart'; // Asegúrate de que esta ruta es correcta para el archivo de Interés Simple
import 'package:pro0030/ModalAmortizacion.dart'; // Asegúrate de que esta ruta es correcta para el archivo de Anualidades
import 'package:pro0030/ModalInteres.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ingeniería Económica"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de Interés Simple
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalcularInteres()),
                  );
                },
                child: const Text('Interés Simple'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalculadoraGradientes()),
                  );
                },
                child: const Text('Gradientes'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de Anualidades
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Amortizacion()),
                  );
                },
                child: const Text('Amortización'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

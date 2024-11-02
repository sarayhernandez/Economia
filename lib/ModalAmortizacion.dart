import 'dart:math';
import 'package:flutter/material.dart';

class Amortizacion extends StatefulWidget {
  const Amortizacion({super.key});

  @override
  _AmortizacionState createState() => _AmortizacionState();
}

class _AmortizacionState extends State<Amortizacion> {
  double capital = 0.0;
  double tasainteres = 0.0;
  int tiempoMeses = 0;
  double valorAnualidad = 0.0;

  TextEditingController capitalController = TextEditingController();
  TextEditingController tasaInteresController = TextEditingController();
  TextEditingController tiempoMesesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amortizacion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'La amortización es el proceso de pagar una deuda a través de pagos periódicos. '
              'Los métodos más comunes de amortización incluyen el método alemán, el método francés y el método americano.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Método Alemán:\n'
              'Valor de la Amortización = Capital / Tiempo en Periodos\n\n'
              'Método Francés:\n'
              'Cuota = (Capital * i) / (1 - (1 + i)^-n)\n\n'
              'Método Americano:\n'
              'Cuota = Capital + Intereses al Final del Periodo\n',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: capitalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Capital',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tasaInteresController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tasa de Interés Anual (%)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tiempoMesesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tiempo (Meses)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _calcularAmortizacion();
              },
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }

  void _calcularAmortizacion() {
    setState(() {
      capital = double.tryParse(capitalController.text) ?? 0.0;
      tasainteres = (double.tryParse(tasaInteresController.text) ?? 0.0) / 100;
      tiempoMeses = int.tryParse(tiempoMesesController.text) ?? 0;
    });

    // Ajustar la tasa de interés a mensual
    double tasaMensual = tasainteres / 12;

    // Cálculo del Método Alemán
    double amortizacionAlemania = capital / tiempoMeses;

    // Cálculo del Método Francés
    double cuotaFrancesa =
        capital * tasaMensual / (1 - pow(1 + tasaMensual, -tiempoMeses));

    // Cálculo del Método Americano
    double interesesAmericanos = capital * tasaMensual;
    double cuotaAmericana = capital + interesesAmericanos;

    _showResult('Método Alemán: ${amortizacionAlemania.toStringAsFixed(2)}\n'
        'Método Francés: ${cuotaFrancesa.toStringAsFixed(2)}\n'
        'Método Americano: ${cuotaAmericana.toStringAsFixed(2)}');
  }

  void _showResult(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text(result),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

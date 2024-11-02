import 'dart:math';

import 'package:flutter/material.dart';

class CalcularInteres extends StatefulWidget {
  const CalcularInteres({super.key});

  @override
  _CalcularInteresState createState() => _CalcularInteresState();
}

class _CalcularInteresState extends State<CalcularInteres> {
  int anos = 0;
  int meses = 0;
  int dias = 0;
  double capital = 0.0;
  double tasainteres = 0.0;
  double interes = 0.0;
  String _selectedCalculation = 'Interés Simple'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cálculo de Interés"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Seleccione el tipo de interés a calcular:',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton<String>(
                    value: _selectedCalculation,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCalculation = newValue!;
                      });
                    },
                    items: <String>['Interés Simple', 'Interés Compuesto']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  if (_selectedCalculation == 'Interés Simple')
                    const Text(
                      'El interés simple es una fórmula financiera que se utiliza para calcular los intereses generados por un capital durante un tiempo determinado, sin que los intereses generados se sumen al capital inicial. Se utiliza principalmente en préstamos y ahorros de corto plazo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  if (_selectedCalculation == 'Interés Compuesto')
                    const Text(
                      'El interés compuesto es una fórmula financiera que calcula los intereses generados por un capital en el cual los intereses generados se suman al capital inicial, de manera que el interés en cada período se calcula sobre el nuevo saldo. Es común en ahorros y préstamos a largo plazo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 10),
                  if (_selectedCalculation == 'Interés Simple')
                    const Text(
                      'Fórmulas utilizadas:\n\n'
                      '1. Interés Simple (I) = Capital (C) × Tasa de Interés (T) × Tiempo (n)\n\n'
                      '2. Tiempo Total (n) = Años + (Meses / 12) + (Días / 360)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  if (_selectedCalculation == 'Interés Compuesto')
                    const Text(
                      'Fórmulas utilizadas:\n\n'
                      '1. Monto (M) = Capital (C) × (1 + Tasa de Interés (T))^Tiempo (n)\n\n'
                      '2. Interés Compuesto (I) = Monto (M) - Capital (C)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese el capital',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          capital = double.parse(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese la cantidad de años',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          anos = int.parse(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese la cantidad de meses',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          meses = int.parse(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese la cantidad de días',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          dias = int.parse(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese la tasa de interés (%)',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          tasainteres = double.parse(value);
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double tiempoTotal = anos + meses / 12 + dias / 360;
                      if (_selectedCalculation == 'Interés Simple') {
                        setState(() {
                          interes = capital * (tasainteres / 100) * tiempoTotal;
                          interes = double.parse((interes).toStringAsFixed(2));
                        });
                      } else if (_selectedCalculation == 'Interés Compuesto') {
                        double tasaDecimal = tasainteres / 100;
                        setState(() {
                          double monto =
                              capital * pow(1 + tasaDecimal, tiempoTotal);
                          interes = monto - capital;
                          interes = double.parse((interes).toStringAsFixed(2));
                        });
                      }

                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Interés Calculado: $interes',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Calcular'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

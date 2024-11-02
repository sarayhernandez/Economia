import 'package:flutter/material.dart';
import 'dart:math';

class CalculadoraGradientes extends StatefulWidget {
  const CalculadoraGradientes({super.key});

  @override
  _CalculadoraGradientesState createState() => _CalculadoraGradientesState();
}

class _CalculadoraGradientesState extends State<CalculadoraGradientes> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para los campos de entrada
  final TextEditingController _txtA = TextEditingController();
  final TextEditingController _txtG = TextEditingController();
  final TextEditingController _txtI = TextEditingController();
  final TextEditingController _txtN = TextEditingController();

  // Variable para seleccionar el tipo de cálculo
  String _selectedCalculation = 'Valor Presente';

  // Variable para seleccionar el tipo de gradiente
  bool _isArithmetic = true;

  // Funciones para calcular los valores
  double _calcularVPGradienteAritmetico(double A, double g, double i, int n) {
    // Fórmula para el valor presente de un gradiente aritmético
    double factor1 = (1 - pow(1 + i, -n)) / i;
    double factor2 = (n - factor1) / (i * pow(1 + i, n));
    return A * factor1 + g * factor2;
  }

  double _calcularVPGradienteGeometrico(double A, double g, double i, int n) {
    // Fórmula para el valor presente de un gradiente geométrico
    return A * (1 - pow((1 + g) / (1 + i), n)) / (i - g);
  }

  double _calcularVFGradienteAritmetico(double A, double g, double i, int n) {
    // Fórmula para el valor futuro de un gradiente aritmético
    return A * pow(1 + i, n) +
        g * ((pow(1 + i, n) * (n * i - 1) + 1) / pow(i, 2));
  }

  double _calcularVFGradienteGeometrico(double A, double g, double i, int n) {
    // Fórmula para el valor futuro de un gradiente geométrico
    return A * pow(1 + i, n) +
        g * (pow(1 + i, n) * (pow(1 + g, n) - 1)) / ((i - g) * (1 + i));
  }

  void _calcular() {
    if (_formKey.currentState!.validate()) {
      // Obtener los valores de los campos de texto y convertir la tasa de interés a decimal
      double A = double.parse(_txtA.text);
      double g = double.parse(_txtG.text);
      double i = double.parse(_txtI.text) / 100;
      int n = int.parse(_txtN.text);

      // Realizar el cálculo según el valor seleccionado y tipo de gradiente
      double resultado = 0;
      if (_selectedCalculation == 'Valor Presente') {
        if (_isArithmetic) {
          resultado = _calcularVPGradienteAritmetico(A, g, i, n);
        } else {
          resultado = _calcularVPGradienteGeometrico(A, g, i, n);
        }
      } else {
        if (_isArithmetic) {
          resultado = _calcularVFGradienteAritmetico(A, g, i, n);
        } else {
          resultado = _calcularVFGradienteGeometrico(A, g, i, n);
        }
      }

      // Mostrar el resultado en un diálogo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resultado'),
            content: Text('El resultado es: $resultado'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Gradientes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Descripción y fórmulas
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text(
                    'Esta calculadora permite calcular el valor presente o futuro de una serie de pagos o recepciones bajo un gradiente aritmético o geométrico. Aquí están las fórmulas utilizadas:\n\n'
                    '1. Gradiente Aritmético:\n'
                    '   - Valor Presente: VP = A * [(1 - (1 + i)^(-n)) / i] + g * [(n - (1 - (1 + i)^(-n)) / i) / ((1 + i)^n)]\n'
                    '   - Valor Futuro: VF = A * (1 + i)^n + g * [( (1 + i)^n * (n * i - 1) + 1 ) / i^2 ]\n\n'
                    '2. Gradiente Geométrico:\n'
                    '   - Valor Presente: VP = A * [(1 - ((1 + g) / (1 + i))^n) / (i - g)]\n'
                    '   - Valor Futuro: VF = A * (1 + i)^n + g * [( (1 + i)^n * ((1 + g)^n - 1)) / ((i - g) * (1 + i))]\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                // Campos de entrada
                TextFormField(
                  controller: _txtA,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Valor inicial (A)'),
                ),
                TextFormField(
                  controller: _txtG,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Gradiente (g)'),
                ),
                TextFormField(
                  controller: _txtI,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Tasa de interés anual (i%)'),
                ),
                TextFormField(
                  controller: _txtN,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Número de periodos (n)'),
                ),
                SwitchListTile(
                  title: const Text('Gradiente Aritmético'),
                  value: _isArithmetic,
                  onChanged: (value) {
                    setState(() {
                      _isArithmetic = value;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCalculation,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCalculation = newValue!;
                    });
                  },
                  items: <String>['Valor Presente', 'Valor Futuro']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration:
                      const InputDecoration(labelText: 'Tipo de cálculo'),
                ),
                ElevatedButton(
                  onPressed: _calcular,
                  child: const Text('Calcular'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

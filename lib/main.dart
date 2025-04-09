import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo Trabajo N°1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculadoraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();

  String resultado = '';
  String error = '';

  void _calcular(String tipo) {
    final texto1 = numero1Controller.text.trim();
    final texto2 = numero2Controller.text.trim();

    setState(() {
      resultado = '';
      error = '';

      if (texto1.isEmpty || texto2.isEmpty) {
        error = 'Por favor, completa ambos campos.';
        return;
      }

      final num1 = double.tryParse(texto1);
      final num2 = double.tryParse(texto2);

      if (num1 == null || num2 == null) {
        error = 'Por favor, ingresa números válidos.';
        return;
      }

      if (tipo == 'suma') {
        resultado = 'Resultado: ${num1 + num2}';
      } else if (tipo == 'multiplicacion') {
        resultado = 'Resultado: ${num1 * num2}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Icon(Icons.cloud, size: 60, color: Colors.grey),
                const SizedBox(height: 10),
                const Text(
                  'Ejemplo Trabajo N°1',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Calcular el Resultado',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: numero1Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número N°1',
                    labelStyle: TextStyle(color: Colors.red),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: numero2Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Número N°2',
                    labelStyle: TextStyle(color: Colors.red),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Resultado:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                if (resultado.isNotEmpty)
                  Text(
                    resultado,
                    style: const TextStyle(fontSize: 18),
                  ),
                if (error.isNotEmpty)
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _calcular('suma'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Sumar'),
                    ),
                    ElevatedButton(
                      onPressed: () => _calcular('multiplicacion'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Multiplicar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

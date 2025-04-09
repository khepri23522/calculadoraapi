import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo Trabajo N°1',
      theme: ThemeData(
        colorScheme: isDarkMode
            ? const ColorScheme.dark()
            : ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: CalculadoraPage(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const CalculadoraPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

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

      final num1 = double.tryParse(texto1);
      final num2 = double.tryParse(texto2);

      if (texto1.isEmpty || texto2.isEmpty) {
        error = 'Por favor, completa ambos campos.';
        return;
      }

      if (num1 == null || num2 == null) {
        error = 'Por favor, ingresa números válidos.';
        return;
      }

      if (tipo == 'suma') {
        resultado = 'Resultado: ${num1 + num2}';
      } else if (tipo == 'resta') {
        resultado = 'Resultado: ${num1 - num2}';
      } else if (tipo == 'multiplicacion') {
        resultado = 'Resultado: ${num1 * num2}';
      }
    });
  }

  void _validarInputs() {
    final texto1 = numero1Controller.text.trim();
    final texto2 = numero2Controller.text.trim();

    setState(() {
      error = '';
      resultado = '';
      if (texto1.isEmpty || texto2.isEmpty) {
        error = 'Por favor, completa ambos campos.';
      } else if (double.tryParse(texto1) == null ||
          double.tryParse(texto2) == null) {
        error = 'Por favor, ingresa números válidos.';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    numero1Controller.addListener(_validarInputs);
    numero2Controller.addListener(_validarInputs);
  }

  @override
  void dispose() {
    numero1Controller.dispose();
    numero2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: widget.toggleTheme,
                      icon: Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                AnimatedOpacity(
                  opacity: resultado.isNotEmpty ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    resultado,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                if (error.isNotEmpty)
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.center,
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
                      onPressed: () => _calcular('resta'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Restar'),
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

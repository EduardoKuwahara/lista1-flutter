import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercícios Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculadoraArea(title: 'Calculadora de Área'),
    );
  }
}

class CalculadoraArea extends StatefulWidget {
  const CalculadoraArea({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraArea> createState() => _CalculadoraAreaState();
}

class _CalculadoraAreaState extends State<CalculadoraArea> {
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  String _resultado = '';

  void _calcularArea() {
    double? largura = double.tryParse(_larguraController.text.replaceAll(',', '.'));
    double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));

    if (largura != null && altura != null) {
      double area = largura * altura;

      setState(() {
        _resultado = 'Área do retângulo: ${area.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _resultado = 'Por favor, insira valores válidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding( // Usando Padding para dar margem nas bordas
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // <-- Sintaxe corrigida aqui
          children: [
            // Campo de texto para a Largura
            TextField(
              controller: _larguraController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Largura',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Campo de texto para a Altura
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            // Resultado do cálculo
            Text(
              _resultado,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calcularArea,
        tooltip: 'Calcular Área', // Tooltip corrigido
        child: const Icon(Icons.calculate), // Ícone alterado
      ),
    );
  }
}
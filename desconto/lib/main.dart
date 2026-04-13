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
      home: const CalculadoraDesconto(title: 'Calculadora de Desconto'),
    );
  }
}

class CalculadoraDesconto extends StatefulWidget {
  const CalculadoraDesconto({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraDesconto> createState() => _CalculadoraDescontoState();
}

class _CalculadoraDescontoState extends State<CalculadoraDesconto> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descontoController = TextEditingController();

  String _resultado = '';
  List<Map<String, dynamic>> _lista = [];

  void _calcularDesconto() {
    double? preco = double.tryParse(_precoController.text.replaceAll(',', '.'));
    double? desconto = double.tryParse(_descontoController.text.replaceAll(',', '.'));

    if (preco != null && desconto != null) {
      double precoComDesconto = preco - (preco * desconto / 100);

      setState(() {
        _resultado = 'Preço com desconto: R\$ ${precoComDesconto.toStringAsFixed(2)}';
      });

      _lista.add({
        'nome': _nomeController.text,
        'precoOriginal': preco,
        'desconto': desconto,
        'precoComDesconto': precoComDesconto,
      });

      _precoController.clear();
      _descontoController.clear();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Produto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _precoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preço Original (R\$)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descontoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Desconto (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Expanded(child: ListView.builder(
              itemCount: _lista.length,
              itemBuilder: (context, index) {
                final item = _lista[index];
                return ListTile(
                  title: Text(item['nome']),
                  subtitle: Text(
                    'Original: R\$ ${item['precoOriginal'].toStringAsFixed(2)} | '
                    'Desconto: ${item['desconto']}% | '
                    'Com Desconto: R\$ ${item['precoComDesconto'].toStringAsFixed(2)}'
                  ),
                );
              },
            ),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calcularDesconto,
        tooltip: 'Calcular Desconto',
        child: const Icon(Icons.calculate),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ItemCompra {
  String nome;
  bool concluido;

  ItemCompra({required this.nome, this.concluido = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ListaCompras(),
    );
  }
}

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  final TextEditingController _itemController = TextEditingController();
  
  final List<ItemCompra> _listaDeCompras = [];


  void _adicionarItem() {
    String nome = _itemController.text;

    if (nome.isNotEmpty) {
      setState(() {
        _listaDeCompras.add(ItemCompra(nome: nome));
      });
      _itemController.clear();
    }
  }

  void _removerItem(int index) {
    setState(() {
      _listaDeCompras.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista de Compras'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      labelText: 'O que você precisa comprar?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _adicionarItem,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: ListView.builder(
                itemCount: _listaDeCompras.length,
                itemBuilder: (context, index) {
                  final item = _listaDeCompras[index];

                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: item.concluido,
                        onChanged: (bool? valor) {
                          setState(() {
                            item.concluido = valor ?? false;
                          });
                        },
                      ),
                      title: Text(
                        item.nome,
                        style: TextStyle(
                          decoration: item.concluido 
                            ? TextDecoration.lineThrough 
                            : TextDecoration.none,
                          color: item.concluido ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removerItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Tarefa {
  String nome;
  String descricao;
  bool concluida;
  String prioridade;

  Tarefa({
    required this.nome,
    required this.descricao,
    this.concluida = false,
    required this.prioridade,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ListaTarefas(title: 'Cadastro de Tarefas Diárias'),
    );
  }
}

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({super.key, required this.title});

  final String title;

  @override
  State<ListaTarefas> createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  final TextEditingController _tarefaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  
  final List<Tarefa> _tarefas = [];
  String _prioridadeSelecionada = 'Baixa'; 

  int _pesoPrioridade(String prioridade) {
    if (prioridade == 'Alta') return 1;
    if (prioridade == 'Média') return 2;
    return 3; // Baixa
  }

  void _ordenarPorPrioridade() {
    setState(() {
      _tarefas.sort((a, b) {
        int pesoA = _pesoPrioridade(a.prioridade);
        int pesoB = _pesoPrioridade(b.prioridade);
        return pesoA.compareTo(pesoB);
      });
    });
  }

  void _adicionarTarefa() {
    String nome = _tarefaController.text;
    String descricao = _descricaoController.text;

    if (nome.isNotEmpty) {
      setState(() {
        _tarefas.add(Tarefa(
          nome: nome,
          descricao: descricao,
          prioridade: _prioridadeSelecionada,
        ));
      });
      
      _tarefaController.clear();
      _descricaoController.clear();
      setState(() {
        _prioridadeSelecionada = 'Baixa'; 
      });
    }
  }

  void removeTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Ordenar por Prioridade',
            onPressed: _ordenarPorPrioridade,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: const InputDecoration(
                labelText: 'Nome da Tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Breve Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            
            const Text('Prioridade:', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Baixa',
                  groupValue: _prioridadeSelecionada,
                  onChanged: (String? value) {
                    setState(() { _prioridadeSelecionada = value!; });
                  },
                ),
                const Text('Baixa'),
                Radio<String>(
                  value: 'Média',
                  groupValue: _prioridadeSelecionada,
                  onChanged: (String? value) {
                    setState(() { _prioridadeSelecionada = value!; });
                  },
                ),
                const Text('Média'),
                Radio<String>(
                  value: 'Alta',
                  groupValue: _prioridadeSelecionada,
                  onChanged: (String? value) {
                    setState(() { _prioridadeSelecionada = value!; });
                  },
                ),
                const Text('Alta'),
              ],
            ),
            
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: const Text('Adicionar Tarefa'),
            ),
            const Divider(height: 30, thickness: 2),
            
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = _tarefas[index];
                  
                  Color corPrioridade = Colors.grey;
                  if (tarefa.prioridade == 'Alta') corPrioridade = Colors.red;
                  if (tarefa.prioridade == 'Média') corPrioridade = Colors.orange;
                  if (tarefa.prioridade == 'Baixa') corPrioridade = Colors.green;

                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: tarefa.concluida,
                        onChanged: (bool? valor) {
                          setState(() {
                            tarefa.concluida = valor ?? false;
                          });
                        },
                      ),
                      title: Text(
                        tarefa.nome,
                        style: TextStyle(
                          decoration: tarefa.concluida 
                            ? TextDecoration.lineThrough 
                            : TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tarefa.descricao),
                          Text(
                            'Prioridade: ${tarefa.prioridade}',
                            style: TextStyle(color: corPrioridade, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeTarefa(index),
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
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Logger',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
      ),
      home: const DataLoggerHomePage(),
    );
  }
}

class DataLoggerHomePage extends StatefulWidget {
  const DataLoggerHomePage({super.key});

  @override
  _DataLoggerHomePageState createState() => _DataLoggerHomePageState();
}

class _DataLoggerHomePageState extends State<DataLoggerHomePage> {
  final List<String> _data = [];
  final TextEditingController _inputController = TextEditingController();

  void _addLog(String log) {
    if (log.isNotEmpty) {
      setState(() {
        _data.insert(0, log); // Add new items to the top
      });
      _inputController.clear();
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  void _showAddLogDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registrar Nuevo Punto'),
          content: TextField(
            controller: _inputController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nombre del Punto'),
            onSubmitted: _addLog,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                _inputController.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Registrar'),
              onPressed: () => _addLog(_inputController.text),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DevOps PoC: Data Logger'),
      ),
      body: _data.isEmpty
          ? const Center(
              child: Text(
                'Aún no hay registros.\nPresiona el botón + para agregar uno.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final log = _data[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text((_data.length - index).toString()),
                    ),
                    title: Text(log),
                    trailing: const Icon(Icons.check_circle_outline, color: Colors.green),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLogDialog,
        tooltip: 'Registrar Punto',
        child: const Icon(Icons.add),
      ),
    );
  }
}

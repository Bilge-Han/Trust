import 'dart:developer';
import 'package:flutter/material.dart';
import 'SQLHelperIsAlan.dart';

class AdminPersonServicePage extends StatefulWidget {
  const AdminPersonServicePage({Key? key}) : super(key: key);

  @override
  _AdminPersonServicePagePageState createState() =>
      _AdminPersonServicePagePageState();
}

class _AdminPersonServicePagePageState extends State<AdminPersonServicePage> {
  Future<bool> registerControl(String name, String surName, String gmail,
      String password, String ilgiAlan, _isAlanlars, context, int? id) async {
    bool logcon = false;
    if (name != '' &&
        surName != '' &&
        gmail != '' &&
        password != '' &&
        ilgiAlan != '') {
      for (var i = 0; i < _isAlanlars.length; i++) {
        if (_isAlanlars[i]['gmail'] == gmail) {
          logcon = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('this gmail is already in using'),
            backgroundColor: Colors.transparent,
          ));
          break;
        } else {
          logcon = true;
        }
      }
      if (logcon == true && id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Logging'),
          backgroundColor: Colors.lightGreenAccent,
        ));
        await _addItem();
      } else if (logcon == true && id != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Updating'),
          backgroundColor: Colors.lightGreenAccent,
        ));
        await _updateItem(id);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('not empty'),
        backgroundColor: Colors.deepOrangeAccent,
      ));
    }
    Navigator.of(context).pop();
    return logcon;
  }

  List<Map<String, dynamic>> _persons = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIsAlan.getItems();
    setState(() {
      _persons = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _AlanController = TextEditingController();
  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _persons.firstWhere((element) => element['id'] == id);
      _nameController.text = existingJournal['name'];
      _surNameController.text = existingJournal['surName'];
      _gmailController.text = existingJournal['gmail'];
      _passwordController.text = existingJournal['password'];
      _AlanController.text = existingJournal['ilgiAlan'];
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(hintText: 'name')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _surNameController,
                      decoration: const InputDecoration(hintText: 'surName')),
                  const SizedBox(height: 20),

                  TextField(
                      controller: _gmailController,
                      decoration: const InputDecoration(hintText: 'gmail')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: 'password')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _AlanController,
                      decoration: const InputDecoration(hintText: 'Alan')),
                  const SizedBox(height: 20),
                  // DropdownButton<String>(
                  //   items: yetkiler.map((String value) {
                  //     return DropdownMenuItem<String>(
                  //         value: value, child: Text(value));
                  //   }).toList(),
                  //   value: selectedYetki,
                  //   onChanged: (var value) {
                  //     setState(() {
                  //       selectedYetki = value.toString();
                  //     });
                  //   },
                  // ),
                  //const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await registerControl(
                            _nameController.text,
                            _surNameController.text,
                            _gmailController.text,
                            _passwordController.text,
                            _AlanController.text,
                            _persons,
                            context,
                            id);
                      }
                      if (id != null) {
                        await registerControl(
                            _nameController.text,
                            _surNameController.text,
                            _gmailController.text,
                            _passwordController.text,
                            _AlanController.text,
                            _persons,
                            context,
                            id);
                      }
                      _nameController.text = '';
                      _surNameController.text = '';
                      _gmailController.text = '';
                      _passwordController.text = '';
                      _AlanController.text = '';
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addItem() async {
    await SQLHelperIsAlan.createItem(
        _nameController.text,
        _surNameController.text,
        _gmailController.text,
        _passwordController.text,
        _AlanController.text);
    _refreshPersons();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelperIsAlan.updateItem(
        id,
        _nameController.text,
        _surNameController.text,
        _gmailController.text,
        _passwordController.text,
        _AlanController.text);
    _refreshPersons();
  }

  void _deleteItem(int id) async {
    await SQLHelperIsAlan.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a product!'),
    ));
    _refreshPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lycan'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _persons.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_persons[index]['name']),
                  subtitle: Text(_persons[index]['gmail']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(_persons[index]['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_persons[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _nameController.text = '';
          _surNameController.text = '';
          _gmailController.text = '';
          _passwordController.text = '';
          _AlanController.text = '';
          _showForm(null);
        },
      ),
    );
  }
}

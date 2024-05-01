import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperHaber.dart';

class AdminHaberService extends StatefulWidget {
  const AdminHaberService({Key? key}) : super(key: key);

  @override
  State<AdminHaberService> createState() => _AdminHaberServiceState();
}

class _AdminHaberServiceState extends State<AdminHaberService> {
  List<Map<String, dynamic>> _haberler = [];
  bool _isLoading = true;
  void _refreshHaberler() async {
    final data = await SQLHelperHaber.getItems();
    setState(() {
      _haberler = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshHaberler();
  }

  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _icerikController = TextEditingController();
  final TextEditingController _detayController = TextEditingController();
  final TextEditingController _imageUrl1Controller = TextEditingController();
  final TextEditingController _imageUrl2Controller = TextEditingController();
  void _showForm(int? id) async {
    if (id != null) {
      _baslikController.text = _haberler[id]['baslik'];
      _icerikController.text = _haberler[id]['icerik'];
      _detayController.text = _haberler[id]['detay'];
      _imageUrl1Controller.text = _haberler[id]['imageUrl1'];
      _imageUrl2Controller.text = _haberler[id]['imageUrl2'];
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
                      controller: _baslikController,
                      decoration: const InputDecoration(hintText: 'Başlık')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _icerikController,
                      decoration: const InputDecoration(hintText: 'İçerik')),
                  const SizedBox(height: 20),

                  TextField(
                      controller: _detayController,
                      decoration: const InputDecoration(hintText: 'Detay')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _imageUrl1Controller,
                      decoration: const InputDecoration(hintText: 'image 1')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _imageUrl2Controller,
                      decoration: const InputDecoration(hintText: 'image 2')),
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
                        _addItem();
                      }
                      if (id != null) {
                        _updateItem(id);
                      }
                      _baslikController.text = '';
                      _icerikController.text = '';
                      _detayController.text = '';
                      _imageUrl1Controller.text = '';
                      _imageUrl2Controller.text = '';
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addItem() async {
    await SQLHelperHaber.createItem(
      _baslikController.text,
      _icerikController.text,
      _detayController.text,
      _imageUrl1Controller.text,
      _imageUrl2Controller.text,
    );
    _refreshHaberler();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelperHaber.updateItem(
      id,
      _baslikController.text,
      _icerikController.text,
      _detayController.text,
      _imageUrl1Controller.text,
      _imageUrl2Controller.text,
    );
    _refreshHaberler();
  }

  void _deleteItem(int id) async {
    await SQLHelperHaber.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a product!'),
    ));
    _refreshHaberler();
  }

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
              itemCount: _haberler.length,
              itemBuilder: (context, index) => Card(
                color: Colors.transparent.withOpacity(0.25),
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_haberler[index]['baslik']),
                  subtitle: Text(_haberler[index]['baslik']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_haberler[index]['id']),
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
          _baslikController.text = '';
          _icerikController.text = '';
          _detayController.text = '';
          _imageUrl1Controller.text = '';
          _imageUrl2Controller.text = '';
          _showForm(null);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperBasvuru.dart';

class AdminBasvuruService extends StatefulWidget {
  const AdminBasvuruService({Key? key}) : super(key: key);

  @override
  State<AdminBasvuruService> createState() => _AdminBasvuruServiceState();
}

class _AdminBasvuruServiceState extends State<AdminBasvuruService> {
  List<Map<String, dynamic>> _basvurular = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperBasvuru.getItems();
    setState(() {
      _basvurular = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons();
  }

  void _deleteItem(int id) async {
    await SQLHelperBasvuru.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Başvurunuz başarıyla silindi.!'),
    ));
    _refreshPersons();
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
              itemCount: _basvurular.length,
              itemBuilder: (context, index) => Card(
                color: Colors.transparent.withOpacity(0.25),
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_basvurular[index]['companyName']),
                  subtitle: Text(_basvurular[index]['personid'].toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _deleteItem(_basvurular[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

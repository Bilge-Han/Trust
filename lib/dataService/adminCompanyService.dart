import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperIsVeren.dart';

class AdminCompanyService extends StatefulWidget {
  const AdminCompanyService({Key? key}) : super(key: key);

  @override
  State<AdminCompanyService> createState() => _AdminCompanyServiceState();
}

class _AdminCompanyServiceState extends State<AdminCompanyService> {
  Future<bool> registerControl(
      String companyName,
      String sector,
      String gmail,
      String password,
      String lokasyon,
      String vergi,
      _isVerenlers,
      context,
      int? id) async {
    bool logcon = false;
    if (companyName != '' &&
        sector != '' &&
        gmail != '' &&
        password != '' &&
        lokasyon != '' &&
        vergi != '') {
      // _isVerenlers[i]['gmail'] == gmail &&
      //       _isVerenlers[id]['gmail'] != gmail) ||
      //   (_isVerenlers[i]['vergi'] == vergi &&
      //       _isVerenlers[id]['vergi'] != vergi)
      for (var i = 0; i < _isVerenlers.length; i++) {
        if (_isVerenlers[i]['gmail'] == gmail &&
            _isVerenlers[i]['vergi'] == vergi) {
          logcon = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('this gmail is already in using'),
            backgroundColor: Colors.amberAccent,
          ));
          break;
        } else {
          logcon = true;
        }
      }
      if (logcon == true && id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Logging'),
          backgroundColor: Colors.greenAccent,
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
        backgroundColor: Colors.redAccent,
      ));
    }
    Navigator.of(context).pop();
    return logcon;
  }

  List<Map<String, dynamic>> _companies = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIsVeren.getItems();
    setState(() {
      _companies = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons();
  }

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lokasyonController = TextEditingController();
  final TextEditingController _vergiController = TextEditingController();
  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _companies.firstWhere((element) => element['id'] == id);
      _companyNameController.text = existingJournal['companyName'];
      _sectorController.text = existingJournal['sector'];
      _gmailController.text = existingJournal['gmail'];
      _passwordController.text = existingJournal['password'];
      _lokasyonController.text = existingJournal['lokasyon'];
      _vergiController.text = existingJournal['vergi'];
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
                      controller: _companyNameController,
                      decoration:
                          const InputDecoration(hintText: 'companyName')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _sectorController,
                      decoration: const InputDecoration(hintText: 'sector')),
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
                      controller: _lokasyonController,
                      decoration: const InputDecoration(hintText: 'lokasyon')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _vergiController,
                      decoration: const InputDecoration(hintText: 'vergi')),
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
                            _companyNameController.text,
                            _sectorController.text,
                            _gmailController.text,
                            _passwordController.text,
                            _lokasyonController.text,
                            _vergiController.text,
                            _companies,
                            context,
                            id);
                      }
                      if (id != null) {
                        await registerControl(
                            _companyNameController.text,
                            _sectorController.text,
                            _gmailController.text,
                            _passwordController.text,
                            _lokasyonController.text,
                            _vergiController.text,
                            _companies,
                            context,
                            id);
                      }
                      _companyNameController.text = '';
                      _sectorController.text = '';
                      _gmailController.text = '';
                      _passwordController.text = '';
                      _lokasyonController.text = '';
                      _vergiController.text = '';
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addItem() async {
    await SQLHelperIsVeren.createItem(
        _companyNameController.text,
        _sectorController.text,
        _gmailController.text,
        _passwordController.text,
        _lokasyonController.text,
        _vergiController.text);
    _refreshPersons();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelperIsVeren.updateItem(
        id,
        _companyNameController.text,
        _sectorController.text,
        _gmailController.text,
        _passwordController.text,
        _lokasyonController.text,
        _vergiController.text);
    _refreshPersons();
  }

  void _deleteItem(int id) async {
    await SQLHelperIsVeren.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a product!'),
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
              itemCount: _companies.length,
              itemBuilder: (context, index) => Card(
                color: Colors.transparent.withOpacity(0.25),
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_companies[index]['companyName']),
                  subtitle: Text(_companies[index]['sector']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(_companies[index]['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_companies[index]['id']),
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
          _companyNameController.text = '';
          _sectorController.text = '';
          _gmailController.text = '';
          _passwordController.text = '';
          _lokasyonController.text = '';
          _vergiController.text = '';
          _showForm(null);
        },
      ),
    );
  }
}

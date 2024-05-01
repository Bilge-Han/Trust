import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperIlan.dart';
import 'package:trust/utilities/constants.dart';

class AdminIlanServicePage extends StatefulWidget {
  int id;
  AdminIlanServicePage(this.id);
  @override
  State<AdminIlanServicePage> createState() => _AdminIlanServicePageState(id);
}

class _AdminIlanServicePageState extends State<AdminIlanServicePage> {
  int _id;
  _AdminIlanServicePageState(this._id);
  Future<void> ilanControl(String companyName, String sector, String alan,
      String lokasyon, String kriter, String tarih, int? id) async {
    if (companyName != '' &&
        sector != '' &&
        alan != '' &&
        lokasyon != '' &&
        kriter != '' &&
        tarih != '') {
      if (id == null) {
        await _addItem();
      } else {
        await _updateItem(id);
      }
      Navigator.of(context)
          .pushNamed(Constants.ROUTE_ADMIN_COMPANY_SERVICE_PAGE);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Lütfen Eksik Bilgileri Doldurunuz.'),
        backgroundColor: Colors.deepOrangeAccent,
      ));
    }
  }

  List<Map<String, dynamic>> _ilanlar = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIlan.getItems();
    setState(() {
      _ilanlar = data;
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
  final TextEditingController _alanController = TextEditingController();
  final TextEditingController _lokasyonController = TextEditingController();
  final TextEditingController _kriterController = TextEditingController();
  final TextEditingController _tarihController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _ilanlar.firstWhere((element) => element['id'] == id);
      _companyNameController.text = existingJournal['companyName'];
      _sectorController.text = existingJournal['sector'];
      _alanController.text = existingJournal['alan'];
      _lokasyonController.text = existingJournal['lokasyon'];
      _kriterController.text = existingJournal['kriter'];
      _tarihController.text = existingJournal['tarih'];
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
                          const InputDecoration(hintText: 'Şirket Adı')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _sectorController,
                      decoration: const InputDecoration(hintText: 'Sektör')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _alanController,
                      decoration: const InputDecoration(
                          hintText: 'Aranan İş Pozisyonu')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _lokasyonController,
                      decoration: const InputDecoration(hintText: 'Lokasyon')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _kriterController,
                      decoration: const InputDecoration(hintText: 'Kriter')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _tarihController,
                      decoration: const InputDecoration(
                          hintText: 'Son Başvuru Tarihi')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        ilanControl(
                            _companyNameController.text,
                            _sectorController.text,
                            _alanController.text,
                            _lokasyonController.text,
                            _kriterController.text,
                            _tarihController.text,
                            id);
                      }
                      if (id != null) {
                        ilanControl(
                            _companyNameController.text,
                            _sectorController.text,
                            _alanController.text,
                            _lokasyonController.text,
                            _kriterController.text,
                            _tarihController.text,
                            id);
                      }
                      _companyNameController.text = '';
                      _sectorController.text = '';
                      _alanController.text = '';
                      _lokasyonController.text = '';
                      _kriterController.text = '';
                      _tarihController.text = '';
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addItem() async {
    await SQLHelperIlan.createItem(
        _id,
        _companyNameController.text,
        _sectorController.text,
        _alanController.text,
        _lokasyonController.text,
        _kriterController.text,
        _tarihController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('İlan başarıyla oluşturuldu.!'),
    ));
    _refreshPersons();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelperIlan.updateItem(
        id,
        _id,
        _companyNameController.text,
        _sectorController.text,
        _alanController.text,
        _lokasyonController.text,
        _kriterController.text,
        _tarihController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('İlan başarıyla güncellendi.!'),
    ));
    _refreshPersons();
  }

  Future<void> _deleteItem(int id) async {
    await SQLHelperIlan.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('İlan başarıyla silindi.!'),
    ));
    _refreshPersons();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lycan'),
        backgroundColor: Colors.transparent.withOpacity(0.25),
        shadowColor: Colors.transparent.withOpacity(0.75),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _ilanlar.length,
              itemBuilder: (context, index) => Card(
                color: Colors.transparent.withOpacity(0.25),
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_ilanlar[index]['companyName']),
                  subtitle: Text(_ilanlar[index]['sector']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(_ilanlar[index]['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_ilanlar[index]['id']),
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
          _alanController.text = '';
          _lokasyonController.text = '';
          _kriterController.text = '';
          _tarihController.text = '';
          _showForm(null);
        },
      ),
    );
  }
}

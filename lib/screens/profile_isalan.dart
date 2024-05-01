import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_person.dart';
import 'package:trust/dataService/SQLHelperIsAlan.dart';
import 'package:trust/screens/list_basvurularim.dart';
import 'package:trust/screens/login_home.dart';

class ProfileIsAlanPage extends StatefulWidget {
  int id;
  List<Map<String, dynamic>> persons = [];
  ProfileIsAlanPage(this.id, this.persons);
  @override
  State<StatefulWidget> createState() => _ProfileIsAlanPageState(id, persons);
}

class _ProfileIsAlanPageState extends State<ProfileIsAlanPage> {
  int _id;
  List<Map<String, dynamic>> _persons = [];
  _ProfileIsAlanPageState(this._id, this._persons);
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
      if (logcon == true && id != null) {
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
  void _showForm(
    int? id,
  ) async {
    if (id != null) {
      // final existingJournal =
      //     _persons.firstWhere((element) => element['id'] == id);
      _nameController.text = _persons[id]['name'];
      _surNameController.text = _persons[id]['surName'];
      _gmailController.text = _persons[id]['gmail'];
      _passwordController.text = _persons[id]['password'];
      _AlanController.text = _persons[id]['ilgiAlan'];
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
                    style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent.withOpacity(0.25)),
                    onPressed: () async {
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
        centerTitle: true,
        title: const Text('Profilim'),
        backgroundColor: Colors.black38.withOpacity(0.25),
        shadowColor: Colors.greenAccent.withAlpha(150),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Başlık
                  //header("Profilim", context),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return buildProfileCard(
                                context,
                                _persons[_id]['name'],
                                _persons[_id]['surName'],
                                _persons[_id]['gmail'],
                                _persons[_id]['ilgiAlan'],
                                _persons,
                                _id);
                          }
                          //else if (index == 1) {
                          //   return buildCategory("Çıkış Yap", context,
                          //       LoginHomePage(), Colors.red);
                          // }
                          else {
                            return const SizedBox(height: 0.0);
                          }
                        }),
                  ),
                ],
              ),
            ),
            bottomNavigationBar(
                page: "profile", context: context, id: _id, persons: _persons),
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard(BuildContext context, String name, String surName,
      String gmail, String alan, List<Map<String, dynamic>> _persons, int _id) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: SizedBox(
        height: 520.0,
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: Text(alan),
              ),
              const Divider(
                color: Colors.greenAccent,
                indent: 16.0,
              ),
              ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: Text(
                  gmail,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: Text(
                  "İletişim Numarası",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return buildProfileEdit(_id);
                      } else if (index == 1) {
                        return buildCategory(
                            "Başvurularım",
                            context,
                            BasvuruListPage(_id),
                            Colors.black38.withOpacity(0.25));
                      } else if (index == 2) {
                        return buildCategory(
                            "Çıkış Yap", context, LoginHomePage(), Colors.red);
                      } else {
                        return const SizedBox(height: 0.0);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(
      String title, BuildContext context, Widget widget, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget;
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withAlpha(150),
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
            ]),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A1034)),
        ),
      ),
    );
  }

  Widget buildProfileEdit(int _id) {
    return GestureDetector(
      onTap: () {
        _showForm(_id);
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black38.withOpacity(0.25),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withAlpha(150),
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
            ]),
        child: const Text(
          ("Profili Düzenle"),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A1034)),
        ),
      ),
    );
  }
}

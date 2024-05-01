import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_company.dart';
import 'package:trust/dataService/SQLHelperIsVeren.dart';
import 'package:collection/collection.dart';

class ProfileEditIsVeren extends StatefulWidget {
  int id;
  ProfileEditIsVeren(this.id);
  @override
  State<ProfileEditIsVeren> createState() => _ProfileEditIsVerenState(id);
}

class _ProfileEditIsVerenState extends State<ProfileEditIsVeren> {
  int _id;
  _ProfileEditIsVerenState(this._id);
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
      for (var i = 0; i < _isVerenlers.length; i++) {
        if (_isVerenlers[i]['gmail'] == gmail &&
                _isVerenlers[_id]['gmail'] != gmail ||
            (_isVerenlers[i]['vergi'] == vergi &&
                _isVerenlers[_id]['vergi'] != vergi)) {
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

  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        _showForm(
          _id,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
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
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Stack(
  //         children: [
  //           Scaffold(
  //             appBar: AppBar(
  //               title: const Text('Lycan'),
  //             ),
  //             body: _isLoading
  //                 ? const Center(
  //                     child: CircularProgressIndicator(),
  //                   )
  //                 : Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       TextField(
  //                           controller: _companyNameController,
  //                           decoration:
  //                               const InputDecoration(hintText: 'Şirket Adı')),
  //                       const SizedBox(height: 10),
  //                       TextField(
  //                           controller: _sectorController,
  //                           decoration:
  //                               const InputDecoration(hintText: 'Sektör')),
  //                       const SizedBox(height: 10),
  //                       TextField(
  //                           controller: _gmailController,
  //                           decoration:
  //                               const InputDecoration(hintText: 'Gmail')),
  //                       const SizedBox(height: 10),
  //                       TextField(
  //                           controller: _passwordController,
  //                           decoration:
  //                               const InputDecoration(hintText: 'Şifre')),
  //                       const SizedBox(height: 10),
  //                       TextField(
  //                           controller: _lokasyonController,
  //                           decoration:
  //                               const InputDecoration(hintText: 'Lokasyon')),
  //                       const SizedBox(height: 10),
  //                       TextField(
  //                           controller: _vergiController,
  //                           decoration: const InputDecoration(
  //                               hintText: 'Vergi Numarası')),
  //                       const SizedBox(height: 10),
  //                       ElevatedButton(
  //                         onPressed: () async {
  //                           if (_id != null) {
  //                             registerControl(
  //                                 _companyNameController.text,
  //                                 _sectorController.text,
  //                                 _gmailController.text,
  //                                 _passwordController.text,
  //                                 _lokasyonController.text,
  //                                 _vergiController.text,
  //                                 _companies,
  //                                 context,
  //                                 _id);
  //                           }
  //                           _companyNameController.text = '';
  //                           _sectorController.text = '';
  //                           _gmailController.text = '';
  //                           _passwordController.text = '';
  //                           _lokasyonController.text = '';
  //                           _vergiController.text = '';
  //                         },
  //                         child: const Text('Update'),
  //                       )
  //                     ],
  //                   ),
  //           ),
  //           bottomNavigationBarCompany(
  //               page: "profile",
  //               context: context,
  //               id: _id,
  //               companies: _companies),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}

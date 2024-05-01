import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_person.dart';

class HaberDetailPage extends StatefulWidget {
  int? id;
  List<Map<String, dynamic>> haberler = [];
  HaberDetailPage(this.id, this.haberler);
  @override
  State<HaberDetailPage> createState() => _HaberDetailPageState(id!, haberler);
}

class _HaberDetailPageState extends State<HaberDetailPage> {
  int _id;
  List<Map<String, dynamic>> _haberler = [];
  _HaberDetailPageState(this._id, this._haberler);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(' Haberler '),
              backgroundColor: Colors.black38.withOpacity(0.25),
              shadowColor: Colors.greenAccent.withAlpha(150),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: SizedBox(
                height: 450,
                child: Card(
                  color: Colors.black38.withOpacity(0.15),
                  shadowColor: Colors.greenAccent.withAlpha(150),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Image.asset(_haberler[_id]['imageUrl1']),
                          // height: 250.0,
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(_haberler[_id]['baslik'],
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                            const SizedBox(height: 2.0),
                            ListTile(
                              title: Text(
                                _haberler[_id]['icerik'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withAlpha(255),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            ListTile(
                              title: Text(
                                _haberler[_id]['detay'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withAlpha(255),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar(
              page: "home", context: context, id: _id, persons: []),
        ],
      )),
    );
  }
}

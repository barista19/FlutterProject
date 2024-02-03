import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContactPage.dart';
import 'HomePage.dart';

class ProfilePage extends StatefulWidget {
  final String kullaniciAdi;

  ProfilePage({
    required this.kullaniciAdi,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String adSoyad = "";
  String eMail = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    adSoyad = prefs.getString('fullName_${widget.kullaniciAdi}') ?? '';
    eMail = prefs.getString('eMail_${widget.kullaniciAdi}') ?? '';
    phone = prefs.getString('phone_${widget.kullaniciAdi}') ?? '';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4e1fd),
      appBar: AppBar(
        title: Text('Profilim',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          )
        ),
        centerTitle: true,
        backgroundColor: Color(0xffecc1f5),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('images/foto1.png'),
          ),
          SizedBox(height: 40),
          Divider(),
          ListTile(
            leading: Icon(Icons.drive_file_rename_outline_sharp, size: 30),
            title: Text(
              'Ad Soyad:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              adSoyad,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email, size: 30),
            title: Text(
              'E mail:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              eMail,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person, size: 30),
            title: Text(
              'Kullanıcı Adı:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.kullaniciAdi,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone, size: 30),
            title: Text(
              'Telefon:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              phone,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Divider(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/foto1.png'),
              ),
              accountName: Text(widget.kullaniciAdi,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              accountEmail: null,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.article),
                  SizedBox(width: 8.0),
                  Text('Ana Sayfa'),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(kullaniciAdi: widget.kullaniciAdi)
                ));
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
              indent: 16.0,
              endIndent: 16.0,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.call),
                  SizedBox(width: 8.0),
                  Text('İletişim'),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContactPage(kullaniciAdi: widget.kullaniciAdi,)
                ));
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
              indent: 16.0,
              endIndent: 16.0,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8.0),
                  Text('Profilim'),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilePage(kullaniciAdi: widget.kullaniciAdi,)
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

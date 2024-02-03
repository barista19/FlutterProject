import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'ProfilePage.dart';

class ContactPage extends StatefulWidget {
  final String kullaniciAdi;

  ContactPage({
    required this.kullaniciAdi,
  });

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xfff4e1fd),
      appBar: AppBar(
        title: Text("İletişim",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffecc1f5),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
                child: Image.asset(
                  "images/foto1.png",
                  height: 200,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              "Yardıma ihtiyacınız varsa \n Bize Ulaşın.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.purple,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                          )
                        ]
                    ),
                    height: 100,
                    width: 150,

                    //color: Colors.white,
                    child: Column(
                      children: [
                        Icon(
                          Icons.alternate_email, color: Colors.purple, size: 50,),
                        Text("E Mail Adresi"),
                        Text("iletisim@mail.com",
                          textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                          )
                        ]
                    ),
                    height: 100,
                    width: 150,
                    // color: Colors.white,
                    child: Column(
                      children: [
                        Icon(Icons.help, color: Colors.purple, size: 50,),
                        Text("       Faks\n 123456789"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                          )
                        ]
                    ),
                    height: 100,
                    width: 150,
                    // color: Colors.white,
                    child: Column(
                      children: [
                        Icon(Icons.phone, color: Colors.purple, size: 50,),
                        Text("Telefon \n+90 555 111 1111 "),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                          )
                        ]
                    ),
                    //color: Colors.white,
                    child: Column(
                      children: [
                        Icon(Icons.home, color: Colors.purple, size: 50,),
                        Text("Adres\nİstanbul Türkiye "),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("Haberler hesabıdır.",
              style: TextStyle(color: Colors.purple),),
          ],
        ),
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
                    builder: (context) => ContactPage(kullaniciAdi: widget.kullaniciAdi)
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
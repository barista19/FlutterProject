import 'package:flutter/material.dart';
import 'package:flutterproje1/ContactPage.dart';
import 'package:flutterproje1/ProfilePage.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {

  final String kullaniciAdi;

  HomePage({
    required this.kullaniciAdi,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> newsList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://www.ensonhaber.com/teknoloji'));

    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);
      final items = document.querySelectorAll('.item');

      for (var item in items) {
        final title = item.querySelector('.text span')?.text;
        final imageUrl = item.querySelector('img')?.attributes['data-src'];
        final link = item.querySelector('a')?.attributes['href'];

        if (title != null && imageUrl != null && link != null) {
          newsList.add({'title': title, 'imageUrl': imageUrl, 'link': link});
        }
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refresh() async {
    // Yenileme işlemi
    newsList.clear();
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4e1fd),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffecc1f5),
        title: Text(
          'Teknoloji Haberleri',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: newsList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image.asset(
                  'images/foto1.png',
                  height: 150.0,
                ),
              );
            }

            final news = newsList[index - 1];
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  title: Text(
                    news['title'] ?? '',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Image.network(
                    news['imageUrl'] ?? '',
                    width: 100.0,
                    height: 100.0,
                  ),
                  onTap: () {
                    launch('https://www.ensonhaber.com${news['link']}');
                  },
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                  indent: 16.0,
                  endIndent: 16.0,
                ),
              ],
            );
          },
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

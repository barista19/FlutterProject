import 'package:flutter/material.dart';
import 'package:flutterproje1/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> _login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Girilen kullanıcı adı ve şifreyi al
    final String enteredUsername = _usernameController.text;
    final String enteredPassword = _passwordController.text;

    // Kayıtlı kullanıcı adları listesini al
    final List<String> registeredUsernames = prefs.getKeys().where((key) => key.startsWith('username_')).toList();

    // Kullanıcı adı ve şifre kontrolü
    for (String usernameKey in registeredUsernames) {
      final String storedUsername = prefs.getString(usernameKey) ?? "";
      final String storedPasswordKey = 'password_$storedUsername';
      final String storedPassword = await _secureStorage.read(key: storedPasswordKey) ?? "";

      if (enteredUsername == storedUsername && enteredPassword == storedPassword) {
        // Giriş başarılı mesajı
        debugPrint('Giriş Başarılı');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(kullaniciAdi: _usernameController.text)
        ));

        return;
      }
    }

    // Hata mesajı
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text('Bilgileri yanlış girdiniz. Lütfen Kontrol Edin.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4e1fd),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90,),
              Text("HABERLER",
                style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),
              ),
              SizedBox(height: 25),
              Image.asset("images/foto1.png"),
              SizedBox(height: 25),
              Text("Giriş Yap",
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelStyle: TextStyle(color: Colors.purple),
                  prefixIcon: Icon(Icons.person, color: Colors.purple),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelStyle: TextStyle(color: Colors.purple),
                  prefixIcon: Icon(Icons.lock, color: Colors.purple),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bir Hesabınız Yok Mu? ",
                  style: TextStyle(
                    fontSize: 15
                  ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage()
                        ));
                      },
                      child: Text("Şimdi Kaydolun!",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

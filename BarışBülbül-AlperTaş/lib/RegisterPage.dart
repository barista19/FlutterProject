import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _eMailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> _saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Verileri al
    final String fullName = _fullNameController.text;
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String eMail = _eMailController.text;
    final String phone = _phoneController.text;


    // Boş alan kontrolü
    if (fullName.isEmpty || username.isEmpty || password.isEmpty || eMail.isEmpty || phone.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Tüm bilgileri doldurunuz.'),
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
      return;
    }

    // Verileri depola
    await prefs.setString('fullName_$username', fullName);
    await prefs.setString('username_$username', username);
    await prefs.setString('eMail_$username', eMail);
    await prefs.setString('phone_$username', phone);


    // Şifreyi güvenli bir şekilde depola
    await _secureStorage.write(key: 'password_$username', value: password);

    // Kayıt başarılı mesajı
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Başarılı'),
          content: Text('Kaydınız Başarıyla Oluşturuldu.'),
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
              SizedBox(height: 60),
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
              Text("Kayıt Ol",
                style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Ad Soyad',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelStyle: TextStyle(color: Colors.purple),
                  prefixIcon: Icon(Icons.drive_file_rename_outline, color: Colors.purple),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _eMailController,
                decoration: InputDecoration(
                  labelText: 'E Mail',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelStyle: TextStyle(color: Colors.purple),
                  prefixIcon: Icon(Icons.mail, color: Colors.purple),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Telefon',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelStyle: TextStyle(color: Colors.purple),
                  prefixIcon: Icon(Icons.phone, color: Colors.purple),
                ),
              ),
              SizedBox(height: 10),
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
                onPressed: _saveUserData,
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Kayıt Ol',
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
                  Text("Zaten Bir Hesabınız Var Mı? ",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()
                        ));
                      },
                      child: Text("Giriş Yapın!",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple
                        ),
                      )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

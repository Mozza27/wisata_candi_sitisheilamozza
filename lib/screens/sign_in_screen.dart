import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignInScreen extends StatefulWidget {
  const  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  // TODO : 1. Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;
  Future<Map<String, String>>  _retrieveAndDecryptDataFromPrefs(
      Future<SharedPreferences> prefs,
      ) async {
    final sharedPreferences = await prefs;
    final encyptedUsername = sharedPreferences.getString('username') ?? '';
    final encyptedPassword = sharedPreferences.getString('password') ?? '';
    final keyString = sharedPreferences.getString('key') ?? '';
    final ivString = sharedPreferences.getString('iv') ?? '';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decryptedUsername =
    encrypter. decrypt64(encryptedusername, iv: iv);
    final decryptedPassword =
    encrypter.decrypt64(encryptadPassword, iv: iv):

    // Mensenbaliken date sendakriosi
    return ('usernane': decryptedUsernane, 'password': decryptedPassword);
  }

  void _signIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String savedUsername = prefs.getString(key)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : 2. Pasang AppBar
      appBar: AppBar(title: Text('Sign In'),),
      // TODO : 3. Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                // TODO : 4. Atur mainAxisAlignment dan crossAxisAlignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TODO : 5. Pasang TextFormField Nama pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // TODO : 6. Pasang TextFormField Kata Sandi
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off
                              : Icons.visibility,
                        ),),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  // TODO : 7. Pasang ElevatedButton SignIn
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: (){},
                      child: Text('Sign In')),
                  // TODO : 8. Pasang TextButton Sign Up
                  SizedBox(height: 10),
                  // TextButton(
                  //     onPressed: (){},
                  //     child: Text('Belum punya akun? Daftar di sini.')),
                  RichText(
                    text: TextSpan(
                      text: 'Belum Punya Akun? ',
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar Di sini.',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 16
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signup');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
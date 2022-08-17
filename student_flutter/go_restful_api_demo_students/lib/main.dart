import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_restful_api_demo_students/new_user.dart';
import 'package:go_restful_api_demo_students/user_login.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Web',
      theme: ThemeData(
        textTheme: TextTheme(bodyText1: GoogleFonts.lato()),
      ),
      home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Size size;

  bool obscureText = true, obscureText2 = true, isLoginPressed = false;
  Color backgroundColor = Colors.grey;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  Future<UserLogin> makeLogin(String email, String password) async {
    http.Response url;
    try {
      url = await http.post(
          body: jsonEncode({'email': email, 'password': password}),
          Uri.parse("https://go-postgres-demo2.herokuapp.com/api/user/login"));
    } catch (e) {
      rethrow;
    }

    if (url.statusCode == 200) {
      return UserLogin.fromJson(jsonDecode(url.body));
    } else {
      return UserLogin();
    }
  }

  Future<NewUser> makeNewUser(String email, String password) async {
    late http.Response url;
    try {
      url = await http.post(
          body: jsonEncode({'email': email, 'password': password}),
          Uri.parse("https://go-postgres-demo2.herokuapp.com/api/user/new"));
    } catch (e) {
      rethrow;
    }

    if (url.statusCode == 200) {
      return NewUser.fromJson(jsonDecode(url.body));
    } else {
      return NewUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: !isLoginPressed ? userLogin() : userData(),
    );
  }

  Widget userLogin() {
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFF8A2387),
              Color(0xFFE94057),
              Color(0XFFF27121),
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.network(
              "https://imgyukle.com/f/2022/08/17/nn13Qb.png",
              height: 200,
              width: 200,
            ),
            Container(
              height: size.height * 0.6,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey)),
                        label: const Text("E-mail"),
                        hintText: "abcdefgh@gmail.com"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controllerPassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey)),
                        label: const Text("Password"),
                        hintText: "123456abcdef"),
                    obscureText: obscureText,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onSurface: Colors.black, elevation: 3),
                      onPressed: () {
                        makeLogin(controllerEmail.text.toString(),
                            controllerPassword.text.toString());
                        setState(() {
                          isLoginPressed = true;
                        });
                      },
                      child: const Text(
                        "Giriş Yap",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            onSurface: Colors.black, elevation: 3),
                        onPressed: () {
                          makeNewUser(controllerEmail.text.toString(),
                              controllerPassword.text.toString());
                          setState(() {
                            isLoginPressed = true;
                          });
                        },
                        child: const Text(
                          "Kayıt Ol",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userData() {
    return FutureBuilder<UserLogin>(
      future: makeLogin(controllerEmail.text, controllerPassword.text),
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          return SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xFF8A2387),
                    Color(0xFFE94057),
                    Color(0XFFF27121),
                  ])),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    const Text("GİRİŞ BAŞARILI !",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      "GİRİŞ YAPILAN EMAİL : ${snapshot.data!.account!.email}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "GİRİŞ SAATİ : ${DateTime.parse(snapshot.data!.account!.createdAt.toString())}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "GİRİŞ YAPILAN HESABIN İD'Sİ : ${snapshot.data!.account!.iD}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data!.account!.password.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

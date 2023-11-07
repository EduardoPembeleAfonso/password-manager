import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dismissible_page/dismissible_page.dart';

// pages
import 'package:password_manager/pages/Drawer/drawer.dart';

// repos
import 'package:password_manager/database/repositories/account_repository.dart';

class GeneratePassword extends StatefulWidget {
  const GeneratePassword(
      {super.key,
      required this.itemId,
      required this.itemEmail,
      required this.itemWebsite,
      required this.itemCategory,
      required this.itemIcon,
      required this.itemPassword,
      required this.itemSecurity});
  final int itemId;
  final String itemEmail;
  final String itemWebsite;
  final int itemCategory;
  final String itemIcon;
  final String itemPassword;
  final int itemSecurity;

  @override
  State<GeneratePassword> createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  final _accountRepository = AccountRepository();
  String _websiteController = '';
  String _emailOrPhoneController = '';
  String _passwordController = '';
  double _currentLengthPasswordSlider = 8;
  bool valueCheckBoxNumber = false;
  bool valueCheckBoxSymbols = false;
  bool valueCheckBoxLowercase = false;
  bool valueCheckBoxUpercase = false;
  bool _levelSecurity = false;
  bool _loading = false;

  @override
  void initState() {
    _loading = false;
    _levelSecurity = false;
    _websiteController = widget.itemWebsite;
    _emailOrPhoneController = widget.itemEmail;
    super.initState();
  }

  void _goAnalyse() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const MenuDrawer(
          pageId: 2,
        ),
      ),
    );
  }

  static const List<String> _numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  static const List<String> _symbols = [
    '*',
    '^',
    '?',
    '.',
    ';',
    ':',
    '%',
    '#',
    '@',
    '!'
  ];
  static const List<String> _upercase = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];
  static const List<String> _lowercase = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];

  // function that generate password
  void _passwordGenerator() {
    var char = [];
    if (valueCheckBoxLowercase) {
      char.addAll(
        _lowercase,
      );
    }
    if (valueCheckBoxUpercase) {
      char.addAll(
        _upercase,
      );
    }
    if (valueCheckBoxNumber) {
      char.addAll(
        _numbers,
      );
    }
    if (valueCheckBoxSymbols) {
      char.addAll(
        _symbols,
      );
    }

    if (!valueCheckBoxLowercase &&
        !valueCheckBoxUpercase &&
        !valueCheckBoxNumber &&
        !valueCheckBoxSymbols) {
      char.addAll(_lowercase);
      _levelSecurity = false;
    }

    if (valueCheckBoxLowercase &&
        valueCheckBoxUpercase &&
        valueCheckBoxNumber &&
        valueCheckBoxSymbols) {
      _levelSecurity = true;
    } else {
      _levelSecurity = false;
    }

    var password = '';

    for (int i = 0; i < _currentLengthPasswordSlider; i++) {
      password += char[Random().nextInt(char.length)];
    }
    setState(() {
      _passwordController = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
        onDismissed: () {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MenuDrawer(
                pageId: 2,
              ),
            ),
          );
        },
        direction: DismissiblePageDismissDirection.multi,
        isFullScreen: false,
        child: Scaffold(
          body: Hero(
            tag: 'generate_password',
            child: SingleChildScrollView(
              child: Container(
                color: const Color(0xFF00a093),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: _goAnalyse,
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  right:
                                      45), //MediaQuery.of(context).size.width / 6),
                              child: Text(
                                'Gerador de palavra-passe',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 0.0),
                      padding: const EdgeInsets.only(bottom: 20),
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          border: Border.all(
                              width: 1,
                              color: Colors.transparent,
                              style: BorderStyle.solid)),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Website ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    initialValue: widget.itemWebsite,
                                    onChanged: (value) {
                                      setState(() {
                                        _websiteController = value;
                                      });
                                    },
                                    validator: (value) {
                                      return value == ''
                                          ? "Link do website não pode estar vazio."
                                          : null;
                                    },
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 180, 179, 178)),
                                    decoration: InputDecoration(
                                      hintText: "Link do website",
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 179, 178)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.check_circle_outline_sharp,
                                            color: _websiteController.isNotEmpty
                                                ? const Color.fromARGB(
                                                    255, 121, 246, 159)
                                                : const Color.fromARGB(
                                                    255, 180, 179, 178),
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Color(0xFFe5e1de))),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Color(0xFFe5e1de))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Contacto ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    initialValue: widget.itemEmail,
                                    onChanged: (value) {
                                      setState(() {
                                        _emailOrPhoneController = value;
                                      });
                                    },
                                    validator: (value) {
                                      return value == ''
                                          ? "O Contacto não pode estar vazio."
                                          : null;
                                    },
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 180, 179, 178)),
                                    decoration: InputDecoration(
                                      hintText: "Email ou número de telefone",
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 179, 178)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.check_circle_outline_sharp,
                                            color: _emailOrPhoneController
                                                    .isNotEmpty
                                                ? const Color.fromARGB(
                                                    255, 121, 246, 159)
                                                : const Color.fromARGB(
                                                    255, 180, 179, 178),
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Color(0xFFe5e1de))),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Color(0xFFe5e1de))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 30, left: 20, right: 20),
                            child: const Divider(
                              height: 2,
                              color: Color.fromARGB(255, 180, 179, 178),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Palavra-passe ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xFFe5e1de),
                                      )),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    initialValue: _passwordController,
                                    enabled: false,
                                    onChanged: (value) {
                                      setState(() {
                                        _passwordController = value;
                                      });
                                    },
                                    validator: (value) {
                                      return value == ''
                                          ? "A Palavra-passe não pode estar vazio."
                                          : null;
                                    },
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 180, 179, 178)),
                                    decoration: InputDecoration(
                                      hintText:
                                          " ${_passwordController.isNotEmpty ? _passwordController : 'Palavra - passe'}",
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 180, 179, 178)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.check_circle_outline_sharp,
                                            color: _levelSecurity
                                                ? const Color.fromARGB(
                                                    255, 121, 246, 159)
                                                : widget.itemSecurity == 1
                                                    ? const Color.fromARGB(
                                                        255, 121, 246, 159)
                                                    : const Color.fromARGB(
                                                        255, 180, 179, 178),
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFe5e1de))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFe5e1de))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tamanho',
                                            style: GoogleFonts.poppins(
                                                fontSize: 15.0,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    width: 1,
                                                    color: const Color.fromARGB(
                                                        255, 180, 179, 178))),
                                            child: Text(
                                              '$_currentLengthPasswordSlider',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Slider(
                                        value: _currentLengthPasswordSlider,
                                        max: 16,
                                        divisions: 6,
                                        label: _currentLengthPasswordSlider
                                            .round()
                                            .toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _currentLengthPasswordSlider =
                                                value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Numeros',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Transform.scale(
                                                scale: 1.5,
                                                child: Checkbox(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 64, 127, 254),
                                                  checkColor: Colors.white,
                                                  side: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 180, 179, 178)),
                                                  value: valueCheckBoxNumber,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      valueCheckBoxNumber =
                                                          newValue ?? false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 165.0,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Simbolos',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Transform.scale(
                                                scale: 1.5,
                                                child: Checkbox(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 64, 127, 254),
                                                  checkColor: Colors.white,
                                                  side: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 180, 179, 178)),
                                                  value: valueCheckBoxSymbols,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      valueCheckBoxSymbols =
                                                          newValue ?? false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Minusculas',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Transform.scale(
                                                scale: 1.5,
                                                child: Checkbox(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 64, 127, 254),
                                                  checkColor: Colors.white,
                                                  side: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 180, 179, 178)),
                                                  value: valueCheckBoxLowercase,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      valueCheckBoxLowercase =
                                                          newValue ?? false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 165.0,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Maisculas',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Transform.scale(
                                                scale: 1.5,
                                                child: Checkbox(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 64, 127, 254),
                                                  checkColor: Colors.white,
                                                  side: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 180, 179, 178)),
                                                  value: valueCheckBoxUpercase,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      valueCheckBoxUpercase =
                                                          newValue ?? false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 45),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _passwordGenerator();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.white),
                                            foregroundColor:
                                                const MaterialStatePropertyAll(
                                                    Color(0xFF272f32)),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    side: const BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            180,
                                                            179,
                                                            178)))),
                                          ),
                                          child: Text("Gerar",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18.0,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 175,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _loading = true;
                                            });
                                            _editPassword(context);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.white),
                                              foregroundColor:
                                                  const MaterialStatePropertyAll(
                                                      Color(0xFF272f32)),
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      side: const BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              180,
                                                              179,
                                                              178))))),
                                          child: _loading
                                              ? Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  height: 20,
                                                  width: 20,
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    64,
                                                                    127,
                                                                    254)),
                                                  ),
                                                )
                                              : Text(
                                                  "Salvar",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

// my functions
  void _editPassword(context) {
    final id = widget.itemId;
    int idCategory = widget.itemCategory;
    String file = widget.itemIcon.toString();
    String website = widget.itemWebsite;
    String email = widget.itemEmail;
    String password = widget.itemPassword;
    _accountRepository
        .updateAccount(
            id,
            idCategory,
            file,
            _websiteController == '' ? website : _websiteController,
            _emailOrPhoneController == '' ? email : _emailOrPhoneController,
            _passwordController == '' ? password : _passwordController)
        .then((_) {
      setState(() {
        _loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuDrawer(
            pageId: 2,
          ),
        ),
      );
    }).catchError((_) {
      setState(() {
        _loading = false;
      });
    });
  }
}

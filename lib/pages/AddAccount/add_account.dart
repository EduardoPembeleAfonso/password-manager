import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dismissible_page/dismissible_page.dart';

class AddAccount extends KFDrawerContent {
  // const SignIn({Key? key}) : super(key: key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _categoryController = TextEditingController();
  final _iconAccountController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _fileName;
  late File _myFile;
  Uint8List? _fileBytes;
  late bool _showPassword;
  late bool _hasFileName;

  @override
  void initState() {
    _showPassword = true;
    _hasFileName = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _websiteController.dispose();
    _categoryController.dispose();
    _iconAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      // Note that scrollable widget inside DismissiblePage might limit the functionality
      // If scroll direction matches DismissiblePage direction
      direction: DismissiblePageDismissDirection.multi,
      isFullScreen: false,
      child: Scaffold(
        body: Hero(
            tag: 'Unique tag',
            child: SingleChildScrollView(
              reverse: false,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: const Color(0xFF00a093),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 12, left: 10, bottom: 10),
                          child: Text(
                            'Adicionar nova conta',
                            style: GoogleFonts.poppins(
                              textStyle:
                                  Theme.of(context).textTheme.displayMedium,
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                            // height: 260,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0.0),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Column(children: [
                                      GestureDetector(
                                        onTap: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles();

                                          if (result != null) {
                                            _fileBytes =
                                                result.files.single.bytes;
                                            _fileName =
                                                result.files.single.name;
                                            File file = File(result
                                                .files.single.path
                                                .toString());
                                            _myFile = file;

                                            // _myFile = result.files.single.path.toString();
                                            setState(() {
                                              _hasFileName = true;
                                            });
                                          } else {
                                            setState(() {
                                              _hasFileName = false;
                                            });

                                            // User canceled the picker
                                          }
                                        },
                                        child: Container(
                                            width: 70,
                                            height: 70,
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              color: const Color(0xFF00a093),
                                              radius: const Radius.circular(50),
                                              padding: _hasFileName
                                                  ? const EdgeInsets.all(0)
                                                  : const EdgeInsets.all(20),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50)),
                                                child: _hasFileName
                                                    ? Image.file(
                                                        _myFile,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : const Icon(
                                                        Icons.image_outlined,
                                                        size: 30.0,
                                                        color:
                                                            Color(0xFF00a093),
                                                      ),
                                              ),
                                            )),
                                      ),
                                      _hasFileName
                                          ? Text(
                                              '$_fileName',
                                              style: GoogleFonts.poppins(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                                fontSize: 15.0,
                                                color: const Color(0xFF00a093),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Text(
                                              'Adicionar imagem',
                                              style: GoogleFonts.poppins(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                                fontSize: 15.0,
                                                color: const Color(0xFF00a093),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                    ]),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 25.0),
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  'Website',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _websiteController,
                                                style: const TextStyle(
                                                    color: Color(0xFFe5e1de)),
                                                decoration: InputDecoration(
                                                    hintText: "Link do website",
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFc7c7ca)),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xFFf8f7fe),
                                                    focusColor: Colors.white,
                                                    prefixIcon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .wb_auto_outlined,
                                                          color: Colors.black38,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFFe5e1de))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFF00a093)))),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  'Contacto',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                controller:
                                                    _emailOrPhoneController,
                                                style: const TextStyle(
                                                    color: Color(0xFFe5e1de)),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Email ou número de telefone",
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFc7c7ca)),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xFFf8f7fe),
                                                    focusColor: Colors.white,
                                                    prefixIcon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .phone_android_outlined,
                                                          color: Colors.black38,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFFe5e1de))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFF00a093)))),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  return value == null
                                                      ? "Contacto não pode estar vazio."
                                                      : null;
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  'Palavra-passe',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                obscureText: _showPassword,
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _passwordController,
                                                style: const TextStyle(
                                                    color: Color(0xFFe5e1de)),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "  Palavra-passe ou pin",
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xFFc7c7ca)),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xFFf8f7fe),
                                                    focusColor: Colors.white,
                                                    prefixIcon: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.lock_outline,
                                                          color: Colors.black38,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                    ),
                                                    suffixIcon: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      width: 70,
                                                      height: 20,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _showPassword =
                                                                !_showPassword;
                                                          });
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              const MaterialStatePropertyAll(
                                                                  Color(
                                                                      0xFFf8e2de)),
                                                          foregroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Colors.red
                                                                      .shade800),
                                                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: const BorderSide(
                                                                  color: Color(
                                                                      0xFF00a093)))),
                                                        ),
                                                        child: Text(
                                                          _showPassword
                                                              ? "Ver"
                                                              : "Ocultar",
                                                          style: GoogleFonts
                                                              .oswald(
                                                                  color: Colors
                                                                      .red
                                                                      .shade800,
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                        ),
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFFe5e1de))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFF00a093)))),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  return value == ''
                                                      ? "A palavra-passe não pode estar vazio."
                                                      : null;
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 30),
                                      child: Text('Escolhe uma categoria',
                                          style: GoogleFonts.poppins(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 100,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            buildCategory('Streaming', 'hbo'),
                                            buildCategory('Wallet', 'netflix'),
                                            buildCategory('Medsos', 'hbo'),
                                            buildCategory('Edtech', 'netflix'),
                                            buildCategory('Brandon', 'hbo'),
                                            buildCategory('Alie', 'netflix'),
                                            buildCategory('Mia', 'hbo'),
                                            buildCategory('Jess', 'netflix'),
                                            buildCategory('Adam', 'hbo'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 25.0),
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Color(0xFF3c4950)),
                                            foregroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.white),
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    side: const BorderSide(
                                                        color: Color(
                                                            0xFF3c4950)))),
                                            textStyle:
                                                const MaterialStatePropertyAll(
                                                    TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ))),
                                        child: const Text("Salvar"),
                                      ),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget buildCategory(String name, String filename) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 30,
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Colors.transparent,
                style: BorderStyle.solid,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: Image.asset('assets/$filename.jpg').image,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(name,
              style: GoogleFonts.poppins(
                  fontSize: 15.0, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}

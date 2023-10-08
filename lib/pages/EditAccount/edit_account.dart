import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dismissible_page/dismissible_page.dart';

// pages
import 'package:password_manager/pages/Dashboard/dashboard.dart';
import 'package:password_manager/pages/Drawer/drawer.dart';

// repos
import 'package:password_manager/database/repositories/category_repository.dart';
import 'package:password_manager/database/repositories/account_repository.dart';

class EditAccount extends StatefulWidget {
  const EditAccount(
      {super.key,
      required this.itemId,
      required this.itemEmail,
      required this.itemWebsite,
      required this.itemCategory,
      required this.itemIcon,
      required this.itemPassword});
  final int itemId;
  final String itemEmail;
  final String itemWebsite;
  final int itemCategory;
  final String itemIcon;
  final String itemPassword;

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _categoryRepository = CategoryRepository();
  final _accountRepository = AccountRepository();
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _iconAccountController = TextEditingController();
  String _websiteController = '';
  String _emailOrPhoneController = '';
  String _passwordController = '';
  String? _fileName;
  late File _myFilePreview;
  String _myFile = '';
  Uint8List? _fileBytes;
  late bool _showPassword;
  bool _loading = false;
  bool _isSelected = false;
  late bool _hasFileName;
  int _idSelected = 0;

  @override
  void initState() {
    _showPassword = true;
    _loading = false;
    _hasFileName = false;
    _isSelected = false;
    _idSelected = 0;
    _categoryRepository.getCategorys();
    super.initState();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _iconAccountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File file = File(widget.itemIcon.toString());
    return DismissiblePage(
      onDismissed: () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const MenuDrawer(),
          ),
        );
      },
      direction: DismissiblePageDismissDirection.multi,
      isFullScreen: false,
      child: Scaffold(
        body: Hero(
            tag: 'Edit account',
            child: SingleChildScrollView(
              reverse: false,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: const Color(0xFF00a093),
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
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
                              top: 10.0, left: 10, bottom: 10),
                          child: Text(
                            'Editar conta',
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
                                            String file = result
                                                .files.single.path
                                                .toString();
                                            _myFile = file;
                                            File filePreview = File(result
                                                .files.single.path
                                                .toString());
                                            _myFilePreview = filePreview;

                                            setState(() {
                                              _hasFileName = true;
                                            });
                                          } else {
                                            setState(() {
                                              _hasFileName = false;
                                            });
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
                                                        _myFilePreview,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.file(
                                                        file,
                                                        fit: BoxFit.cover,
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
                                              widget.itemIcon,
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
                                                initialValue:
                                                    widget.itemWebsite,
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
                                                    color: Color(0xFF3c4950)),
                                                decoration: InputDecoration(
                                                    hintText: "Link do website",
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xFF3c4950)),
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
                                                initialValue: widget.itemEmail,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _emailOrPhoneController =
                                                        value;
                                                  });
                                                },
                                                style: const TextStyle(
                                                    color: Color(0xFF3c4950)),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Email ou número de telefone",
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xFF3c4950)),
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
                                                  return value == ''
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
                                              SizedBox(
                                                  height: _loading ? 5 : 0),
                                              TextFormField(
                                                obscureText: _showPassword,
                                                initialValue:
                                                    widget.itemPassword,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _passwordController = value;
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                style: const TextStyle(
                                                    color: Color(0xFF3c4950)),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "  Palavra-passe ou pin",
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xFF3c4950)),
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
                                                              5),
                                                      width: 82.0,
                                                      height: 15.0,
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
                                                              const MaterialStatePropertyAll(
                                                                  Color(
                                                                      0xFFe19785)),
                                                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                              side: const BorderSide(
                                                                  color: Color(
                                                                      0xFFe19785)))),
                                                        ),
                                                        child: Text(
                                                          _showPassword
                                                              ? "Ver"
                                                              : "Ocultar",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  color: Colors
                                                                      .red
                                                                      .shade800,
                                                                  fontSize:
                                                                      12.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
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
                                              ),
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
                                          child: FutureBuilder(
                                              future: _categoryRepository
                                                  .getCategorys(),
                                              builder: (context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData &&
                                                    snapshot.data != null) {
                                                  return ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          snapshot.data?.length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return SizedBox(
                                                          child: //Text('ola')
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _isSelected =
                                                                    true;
                                                                _idSelected =
                                                                    snapshot.data[
                                                                            index]
                                                                        ['id'];
                                                              });
                                                            },
                                                            child: buildCategory(
                                                                snapshot
                                                                    .data[index]
                                                                        ['name']
                                                                    .toString(),
                                                                snapshot.data[
                                                                        index]
                                                                    ['image'],
                                                                _isSelected,
                                                                _idSelected,
                                                                snapshot.data[
                                                                        index]
                                                                    ['id']),
                                                          ),
                                                        );
                                                      }));
                                                } else {
                                                  return const Center(
                                                    child: SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child:
                                                            CircularProgressIndicator()),
                                                  );
                                                }
                                              })),
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
                                          setState(() {
                                            _loading = true;
                                          });
                                          _editAccount(context);
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
                                        child: _loading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.white),
                                              )
                                            : const Text("Editar"),
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

  Widget buildCategory(
      String name, String filename, isSelected, idSelected, id) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 30,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: Colors.transparent,
                    style: BorderStyle.solid,
                  ),
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: Image.file(File(filename)).image,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (isSelected == true && id == idSelected)
                Positioned(
                    right: -1,
                    top: 2,
                    child: Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.only(top: 0, right: 10),
                        width: 20,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFFe19785),
                        )))
            ],
          ),
          Text(name,
              style: GoogleFonts.poppins(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: isSelected == false && id == widget.itemCategory
                      ? const Color(0xFFe19785)
                      : isSelected == true && id == idSelected
                          ? const Color(0xFFe19785)
                          : Colors.black)),
        ],
      ),
    );
  }

  // my functions
  void _editAccount(context) {
    if (_formKey.currentState!.validate()) {
      final id = widget.itemId;
      int idCategory = widget.itemCategory;
      String file = widget.itemIcon.toString();
      String website = widget.itemWebsite;
      String email = widget.itemEmail;
      String password = widget.itemPassword;
      _accountRepository
          .updateAccount(
              id,
              _idSelected == 0 ? idCategory : _idSelected,
              _myFile.toString() == '' ? file : _myFile.toString(),
              _websiteController == '' ? website : _websiteController,
              _emailOrPhoneController == '' ? email : _emailOrPhoneController,
              _passwordController == '' ? password : _passwordController)
          .then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
      }).catchError((_) {
        setState(() {
          _loading = false;
        });
      });
    }
  }
}

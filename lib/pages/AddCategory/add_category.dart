import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:password_manager/data/repositories/category_repository.dart';
// import 'package:password_manager/bloc/bloc_category/category_bloc.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  late final CategoryRepository categoryRepository;
  final _formKey = GlobalKey<FormState>();
  final _nameCategoryController = TextEditingController();
  String? _fileName;
  late File _myFile;
  Uint8List? _fileBytes;
  late bool _showPassword;
  late bool _hasFileName;

  @override
  void initState() {
    _hasFileName = false;
    super.initState();
  }

  @override
  void dispose() {
    _nameCategoryController.dispose();
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
            tag: 'tag_category',
            child: SingleChildScrollView(
              reverse: false,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: const Color(0xFF00a093),
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
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
                              top: 20, left: 10, bottom: 20),
                          child: Text(
                            'Adicionar nova categoria',
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
                                            width: 100,
                                            height: 100,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              color: const Color(0xFF00a093),
                                              radius: const Radius.circular(50),
                                              padding: _hasFileName
                                                  ? const EdgeInsets.all(0)
                                                  : const EdgeInsets.all(35),
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
                                    const SizedBox(
                                      height: 30,
                                    ),
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
                                                  'Nome',
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
                                                    _nameCategoryController,
                                                style: const TextStyle(
                                                    color: Color(0xFFe5e1de)),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Nome da categoria",
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
                                                              .text_fields_outlined,
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
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 25.0),
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _createCategory();
                                          // Navigator.of(context).pop();
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

  // my functions
  void _createCategory() {
    if (_formKey.currentState!.validate()) {
      categoryRepository.createCategory(
          name: _nameCategoryController.text, image: _myFile);
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/bloc/bloc_auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dismissible_page/dismissible_page.dart';

// repos
import 'package:password_manager/database/repositories/category_repository.dart';
import 'package:password_manager/database/repositories/account_repository.dart';

// models
import 'package:password_manager/database/models/model_category.dart';

// pages
import 'package:password_manager/pages/AddAccount/add_account.dart';
import 'package:password_manager/pages/EditAccount/edit_account.dart';
import 'package:password_manager/pages/SearchAccount/search_account.dart';
import 'package:password_manager/pages/SignIn/sign_in.dart';
import 'package:password_manager/pages/AddCategory/add_category.dart';
import 'package:password_manager/pages/ViewCategory/view_category.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _categoryRepository = CategoryRepository();
  final _accountRepository = AccountRepository();
  final _searchController = TextEditingController();
  late bool _passwordIsObscure;
  String _selectedMenu = '1';
  List list = [];
  int _idAccountSelected = 0;

  CategoryModel? model;
  List<CategoryModel>? modelList;

  @override
  void initState() {
    _passwordIsObscure = true;
    _selectedMenu = '1';
    _idAccountSelected = 0;
    super.initState();
    _categoryRepository.getCategorys();
    _accountRepository.getAccounts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goSearch() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              SearchAccount(itemSearch: _searchController.text)),
    );
  }

  void _goEditAccount(id, email, website, category, icon, password) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => EditAccount(
          itemId: id,
          itemEmail: email,
          itemWebsite: website,
          itemCategory: category,
          itemIcon: icon,
          itemPassword: password,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              context.pushTransparentRoute(const AddAccount());
            },
            backgroundColor: const Color(0xFF3c4950),
            foregroundColor: Colors.white,
            label: const Text('+ Adicionar conta')),
        body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                // Navega para a tela de login(sign in)
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              }
            },
            child: SingleChildScrollView(
              reverse: false,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xFF00a093),
                      height: 180,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Seja bem-vindo!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 290,
                                        padding: const EdgeInsets.all(0.0),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: _searchController,
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  hintText: 'Pesquisar',
                                                  hintStyle: const TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.search_outlined,
                                                        color: Colors.black38,
                                                      ),
                                                      onPressed: _goSearch,
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0))),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                return value == null
                                                    ? 'O campo não pode estar vazio.'
                                                    : '';
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 0.0),
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xFFe19785),
                                              border: Border.all(
                                                  width: 0,
                                                  color: Colors.transparent,
                                                  style: BorderStyle.solid)),
                                          child: IconButton(
                                            alignment: Alignment.center,
                                            icon: const Icon(
                                              Icons.search_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            onPressed: _goSearch,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          color: const Color(0xFF00a093),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 238, 238),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, top: 5),
                                        child: Text(
                                          'Minhas categorias',
                                          style: GoogleFonts.poppins(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        // color: Colors.black,
                                        margin: const EdgeInsets.only(
                                            right: 20, top: 5),
                                        child: IconButton(
                                            onPressed: () {
                                              context.pushTransparentRoute(
                                                  const AddCategory());
                                            },
                                            icon: const Icon(
                                              Icons.add_box_outlined,
                                              size: 30,
                                              color: Color(0xFF3c4950),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                                      return Container(
                                                        child: buildCategory(
                                                            snapshot.data[index]
                                                                ['id'],
                                                            snapshot.data[index]
                                                                    ['name']
                                                                .toString(),
                                                            snapshot.data[index]
                                                                ['image']),
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
                                  )
                                ],
                              )),
                        ),
                        Container(
                          color: const Color.fromARGB(255, 239, 238, 238),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                            reverse: false,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              margin: const EdgeInsets.only(bottom: 20),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, bottom: 10.0),
                                    child: Text(
                                      'Ultimas contas',
                                      style: GoogleFonts.poppins(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FutureBuilder(
                                        future: _accountRepository.getAccounts(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: snapshot.data?.length,
                                                itemBuilder: ((context, index) {
                                                  return buildAccounts(
                                                      snapshot, index);
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
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Container buildAccounts(AsyncSnapshot<dynamic> snapshot, int index) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFf8f7fe),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                ),
              ),
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      Image.file(File(snapshot.data[index]['image'])).image),
            ),
            Container(
              width: 220,
              height: 100,
              margin: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snapshot.data[index]['link'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 18.0, fontWeight: FontWeight.w500)),
                  Text(snapshot.data[index]['contact'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFc7c7ca))),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 0, top: 5, bottom: 5, right: 0),
                    child: Row(
                      children: [
                        Text(
                            _passwordIsObscure == true &&
                                    _idAccountSelected ==
                                        snapshot.data[index]['id']
                                ? snapshot.data[index]['password'].toString()
                                : snapshot.data[index]['password']
                                    .toString()
                                    .replaceAll(RegExp(r"."), "*"),
                            style: GoogleFonts.poppins(
                                fontSize: 15.0, fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 20,
                          child: IconButton(
                            padding: const EdgeInsets.only(bottom: 20),
                            onPressed: () {
                              setState(() {
                                _idAccountSelected = snapshot.data[index]['id'];
                                _passwordIsObscure = !_passwordIsObscure;
                              });
                            },
                            icon: Icon(
                              _passwordIsObscure == true &&
                                      _idAccountSelected ==
                                          snapshot.data[index]['id']
                                  ? Icons.disabled_visible_outlined
                                  : Icons.remove_red_eye_outlined,
                              size: 20.0,
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
                height: 80,
                width: 50,
                margin: const EdgeInsets.only(bottom: 0.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedMenu,
                  enableFeedback: true,
                  onSelected: (item) async {
                    setState(() {
                      _selectedMenu = item;
                    });
                    if (item == '1') {
                      await Clipboard.setData(ClipboardData(
                          text: '${snapshot.data[index]['password']}'));
                    }
                    if (item == '2') {
                      _goEditAccount(
                          snapshot.data[index]['id'],
                          snapshot.data[index]['contact'],
                          snapshot.data[index]['link'],
                          snapshot.data[index]['categoryId'],
                          snapshot.data[index]['image'],
                          snapshot.data[index]['password']);
                    }
                    if (item == '3') {
                      _accountRepository
                          .deleteAccount(snapshot.data[index]['id']);
                      setState(() {});
                    }
                  },
                  itemBuilder: ((contexto) {
                    return [
                      PopupMenuItem(
                        value: "1",
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.copy_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 0.0),
                                child: Text('Copiar',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                    )),
                              )
                            ]),
                      ),
                      PopupMenuItem(
                        value: "2",
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.edit_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 0.0),
                                child: Text('Editar',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                    )),
                              )
                            ]),
                      ),
                      PopupMenuItem(
                        value: "3",
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.delete_outline_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 0.0),
                                child: Text('Apagar',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                    )),
                              )
                            ]),
                      )
                    ];
                  }),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildCategory(id, String name, String filename) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  ViewCategory(itemId: id, itemName: name, itemImage: filename),
            ),
          );
        },
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
                backgroundImage: Image.file(File(filename)).image,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(name,
                style: GoogleFonts.poppins(
                    fontSize: 18.0, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}

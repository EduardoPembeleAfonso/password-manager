import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dismissible_page/dismissible_page.dart';

//pages
import 'package:password_manager/pages/Dashboard/dashboard.dart';
import 'package:password_manager/pages/Drawer/drawer.dart';
import 'package:password_manager/pages/EditAccount/edit_account.dart';
import 'package:password_manager/pages/EditCategory/edit_category.dart';

// repos
import 'package:password_manager/database/repositories/category_repository.dart';
import 'package:password_manager/database/repositories/account_repository.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory(
      {super.key,
      required this.itemId,
      required this.itemName,
      required this.itemImage});
  final int itemId;
  final String itemName;
  final String itemImage;

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  final _categoryRepository = CategoryRepository();
  final _accountRepository = AccountRepository();
  late bool _passwordIsObscure;
  String _selectedMenu = '1';
  List list = [];
  int _idAccountSelected = 0;

  @override
  void initState() {
    _passwordIsObscure = true;
    _selectedMenu = '1';
    _idAccountSelected = 0;
    super.initState();
  }

  void _goEditCategory() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => EditCategory(
          itemId: widget.itemId,
          itemName: widget.itemName,
          itemImage: widget.itemImage,
        ),
      ),
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
            tag: 'tag_view_category',
            child: SingleChildScrollView(
              reverse: false,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: const Color(0xFF00a093),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
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
                            height: 50,
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.itemName,
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _goEditCategory();
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            _categoryRepository
                                                .deleteCategory(widget.itemId);
                                            Navigator.pushReplacement<void,
                                                void>(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const Dashboard(),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 15.0),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ultimas contas da categoria',
                                  style: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    fontSize: 18.0,
                                    color: const Color(0xFFc7c7ca),
                                    fontWeight: FontWeight.w400,
                                  )),
                              Expanded(
                                child: FutureBuilder(
                                    future: _categoryRepository
                                        .getAllAccountOfCategory(widget.itemId),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data?.length > 0) {
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: ((context, index) {
                                              return buildAccounts(
                                                  snapshot, index);
                                            }));
                                      } else {
                                        return Container(
                                          alignment: Alignment.topCenter,
                                          margin:
                                              const EdgeInsets.only(top: 30.0),
                                          child: Text('Categoria sem contas',
                                              style: GoogleFonts.poppins(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                                fontSize: 20.0,
                                                color: const Color(0xFFc7c7ca),
                                                fontWeight: FontWeight.w400,
                                              )),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Container buildAccounts(AsyncSnapshot<dynamic> snapshot, int index) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(bottom: 20),
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
}

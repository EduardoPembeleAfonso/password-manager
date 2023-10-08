import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dismissible_page/dismissible_page.dart';

//pages
import 'package:password_manager/pages/Drawer/drawer.dart';
import 'package:password_manager/pages/EditAccount/edit_account.dart';

// repos
import 'package:password_manager/database/repositories/account_repository.dart';

class SearchAccount extends StatefulWidget {
  const SearchAccount({
    super.key,
    required this.itemSearch,
  });
  final String itemSearch;
  @override
  State<SearchAccount> createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount> {
  final _accountRepository = AccountRepository();
  String _searchController = '';
  late bool _passwordIsObscure;
  List list = [];
  int _idAccountSelected = 0;

  @override
  void initState() {
    _passwordIsObscure = true;
    _idAccountSelected = 0;
    super.initState();
    _accountRepository.search(widget.itemSearch);
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
            tag: 'tag_search_account',
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
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, bottom: 20),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 290,
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          initialValue: widget.itemSearch,
                                          onChanged: (value) {
                                            setState(() {
                                              _searchController = value;
                                            });
                                          },
                                          style: const TextStyle(
                                              color: Colors.black54),
                                          decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFFf8f7fe),
                                              hintText: 'Pesquisar',
                                              hintStyle: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                              prefixIcon: const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.search_outlined,
                                                    color: Colors.black38,
                                                  ),
                                                  onPressed: null,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
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
                                      margin: const EdgeInsets.only(right: 5),
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
                                        onPressed: () {
                                          _accountRepository
                                              .search(_searchController);
                                        },
                                      )),
                                ],
                              ),
                            )),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 15.0),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                    future: _searchController != ''
                                        ? _accountRepository
                                            .search(_searchController)
                                        : _accountRepository
                                            .search(widget.itemSearch),
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
                                          child: Text('Pesquisa sem correspondencia!',
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
              child: GestureDetector(
                onTap: () {
                  _goEditAccount(
                      snapshot.data[index]['id'],
                      snapshot.data[index]['contact'],
                      snapshot.data[index]['link'],
                      snapshot.data[index]['categoryId'],
                      snapshot.data[index]['image'],
                      snapshot.data[index]['password']);
                },
                child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        Image.file(File(snapshot.data[index]['image'])).image),
              ),
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
                child: IconButton(
                  icon: const Icon(Icons.copy_outlined),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                        text: '${snapshot.data[index]['password']}'));
                  },
                )),
          ],
        ),
      ),
    );
  }
}

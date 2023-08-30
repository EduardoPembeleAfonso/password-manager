import 'package:flutter/material.dart';
import 'package:password_manager/bloc/bloc_auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foldable_list/foldable_list.dart';
import 'package:foldable_list/resources/arrays.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

// pages
import 'package:password_manager/pages/AddAccount/add_account.dart';
import 'package:password_manager/pages/SignIn/sign_in.dart';
import 'package:password_manager/pages/AddCategory/add_category.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _searchController = TextEditingController();
  final _password = 'minha senha';
  late bool _passwordIsObscure;
  late List<Widget> widgetListItem;
  late List<Widget> expandedWidgetListItem;

  @override
  void initState() {
    _passwordIsObscure = true;
    super.initState();
    initList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        //bottomNavigationBar: bottomFABBottonAppBar(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              context.pushTransparentRoute(AddAccount());
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
                            // height: 150,
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
                                        // height: 50,
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
                                                  prefixIcon: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.search_outlined,
                                                        color: Colors.black38,
                                                      ),
                                                      onPressed: null,
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
                                          child: const IconButton(
                                            alignment: Alignment.center,
                                            icon: Icon(
                                              Icons.search_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            onPressed: null,
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
                              // height: 100,
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
                                            fontSize: 22.0,
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
                                                  AddCategory());
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
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('category')
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    streamSnapshot) {
                                              return streamSnapshot.hasData
                                                  ? ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: streamSnapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          ((context, index) {
                                                        return Container(
                                                          child: buildCategory(streamSnapshot.data!.docs[index]['name'], streamSnapshot.data!.docs[index]['image']),
                                                        );
                                                      }))
                                                  : const Center(
                                                      child: SizedBox(
                                                          height: 100,
                                                          width: 100,
                                                          child:
                                                              CircularProgressIndicator()),
                                                    );
                                            })
                                        // ListView(
                                        //   scrollDirection: Axis.horizontal,
                                        //   children: [
                                        //     buildCategory('Streaming', 'hbo'),
                                        //     buildCategory('Wallet', 'netflix'),
                                        //     buildCategory('Medsos', 'hbo'),
                                        //     buildCategory('Edtech', 'netflix'),
                                        //     buildCategory('Brandon', 'hbo'),
                                        //     buildCategory('Alie', 'netflix'),
                                        //     buildCategory('Mia', 'hbo'),
                                        //     buildCategory('Jess', 'netflix'),
                                        //     buildCategory('Adam', 'hbo'),
                                        //   ],
                                        // ),
                                        ),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          color: const Color.fromARGB(255, 239, 238, 238),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          height: 600,
                          child: Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
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
                            child: FoldableList(
                                animationType: AnimationType.none,
                                foldableItems: expandedWidgetListItem,
                                items: widgetListItem),
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

  initList() {
    widgetListItem = [];
    expandedWidgetListItem = [];
    for (var i = 0; i < 9; i++) {
      widgetListItem.add(renderSimpleWidget());
      expandedWidgetListItem.add(renderExpandedWidget());
    }
  }

  Widget renderSimpleWidget() {
    return Container(
      height: 100,
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
                backgroundImage: Image.asset('assets/hbo.jpg').image,
              ),
            ),
            // const SizedBox(
            //   width: 20,
            // ),
            Container(
              width: 220,
              height: 50,
              margin: const EdgeInsets.only(top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John Doe",
                      style: GoogleFonts.poppins(
                          fontSize: 18.0, fontWeight: FontWeight.w500)),
                  Text("john_doe@gmail.com",
                      style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFc7c7ca))),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFFc7c7ca),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 1,
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                ),
              ),
              child: const IconButton(
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: null,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderExpandedWidget() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: const Color(0xFFf8f7fe),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(bottom: 45, left: 10),
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
                backgroundImage: Image.asset('assets/hbo.jpg').image,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(
                        left: 0, top: 5, bottom: 5, right: 0),
                    child: Text("John Doe",
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(
                        left: 0, top: 5, bottom: 5, right: 0),
                    child: Row(
                      children: [
                        Text(
                            _passwordIsObscure
                                ? _password.replaceAll(RegExp(r"."), "*")
                                : _password,
                            style: GoogleFonts.poppins(
                                fontSize: 15.0, fontWeight: FontWeight.w400)),
                        SizedBox(
                          height: 20,
                          child: IconButton(
                            padding: const EdgeInsets.only(bottom: 20),
                            onPressed: () {
                              setState(() {
                                _passwordIsObscure = !_passwordIsObscure;
                              });
                            },
                            icon: Icon(
                              _passwordIsObscure == true
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.disabled_visible_outlined,
                              size: 20.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    padding: const EdgeInsets.only(
                        left: 0, top: 5, bottom: 5, right: 0),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text("Data de expiração : 22/12/2023",
                        style: GoogleFonts.poppins(
                            fontSize: 13.0, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: 35,
                    width: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 38,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFc7c7ca),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: Colors.transparent,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: const IconButton(
                            padding: EdgeInsets.all(5),
                            onPressed: null,
                            icon: Icon(
                              Icons.colorize_outlined,
                              size: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 38,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFc7c7ca),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: Colors.transparent,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: const IconButton(
                            padding: EdgeInsets.all(5),
                            onPressed: null,
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              size: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 38,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFc7c7ca),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1,
                              color: Colors.transparent,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: const IconButton(
                            padding: EdgeInsets.all(5),
                            onPressed: null,
                            icon: Icon(
                              Icons.share_outlined,
                              size: 18.0,
                              color: Colors.white,
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
    );
  }

  Widget buildCategory(String name, String filename) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 5),
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
              backgroundImage: Image.asset('assets/$filename').image,
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
    );
  }

  
}

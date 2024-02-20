import 'dart:ui';

import 'package:bicho_pedia/auth/bloc/login/login_bloc.dart';
import 'package:bicho_pedia/auth/repositories/auth_repository.dart';
import 'package:bicho_pedia/auth/repositories/auth_repository_impl.dart';
import 'package:bicho_pedia/auth/wigets/register_widget.dart';
import 'package:bicho_pedia/screen/home_screen.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formLogin = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  late AuthRepository authRepository;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _loginBloc = LoginBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          buildWhen: (context, state) {
            return state is LoginInitial ||
                state is DoLoginSuccess ||
                state is DoLoginError;
          },
          builder: (context, state) {
            if (state is DoLoginSuccess) {
              return const HomeScreenExample();
            } else if (state is DoLoginError) {
              return const Text('Login error');
            }
            return Center(child: _buildLoginForm());
          },
          listener: (BuildContext context, LoginState state) {},
        ));
  }

  _buildLoginForm() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Form(
        key: _formLogin,
        child: Container(
          height: 590,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
          ),
          child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(50.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Text(
                      "Welcome back we miss you!",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                        color: Color.fromARGB(255, 171, 171, 171),
                        fontSize: 12,
                      )),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      child: Text("Username",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 164, 164, 164)))),
                    ),
                    const Gap(5),
                    TextFormField(
                      controller: userTextController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 164, 164, 164),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 164, 164),
                                  width: 1)),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 164, 164, 164),
                              fontWeight: FontWeight.w200),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 164, 164))),
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text("Password",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 164, 164, 164)))),
                    ),
                    const Gap(5),
                    TextFormField(
                      controller: passTextController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: Color.fromARGB(255, 164, 164, 164),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 164, 164, 164),
                                  width: 1)),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 164, 164, 164),
                              fontWeight: FontWeight.w200),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 113, 113, 113))),
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text('Register',
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 164, 164, 164)))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterWidget()),
                            );
                          },
                        ),
                        TextButton(
                          child: Text('Forgot Password',
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 164, 164, 164)),
                              )),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 190, 222, 97),
                            Color.fromARGB(255, 110, 128, 57)
                          ])),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        child: Text('Sign In',
                            style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600))),
                        onPressed: () {
                          if (_formLogin.currentState!.validate()) {
                            _loginBloc.add(
                              DoLoginEvent(
                                userTextController.text,
                                passTextController.text,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

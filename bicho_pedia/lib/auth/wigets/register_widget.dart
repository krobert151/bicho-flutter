import 'package:bicho_pedia/auth/bloc/register/register_bloc.dart';
import 'package:bicho_pedia/auth/repositories/auth_repository.dart';
import 'package:bicho_pedia/auth/repositories/auth_repository_impl.dart';
import 'package:bicho_pedia/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _fromRegister = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();

  late AuthRepository authRepository;
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _registerBloc = RegisterBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    userTextController.dispose();
    emailTextController.dispose();
    passTextController.dispose();
    _registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerBloc,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          buildWhen: (previous, state) {
            return state is RegisterInitial ||
                state is DoRegisterSuccess ||
                state is DoRegisterErrror;
          },
          builder: (context, state) {
            if (state is DoRegisterSuccess) {
              return const HomeScreenExample();
            } else if (state is DoRegisterErrror) {
              return const Text('Resgiter Error');
            }
            return Center(child: _buildRegisterForm());
          },
          listener: (BuildContext context, RegisterState state) {},
        ),
      ),
    );
  }

  _buildRegisterForm() {
    return Form(
        key: _fromRegister,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: userTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Username'),
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
            TextFormField(
              controller: emailTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
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
            TextFormField(
              controller: passTextController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
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
              child: ElevatedButton(
                child: Text('Register'.toUpperCase()),
                onPressed: () {
                  if (_fromRegister.currentState!.validate()) {
                    _registerBloc.add(DoRegisterEvent(userTextController.text,
                        emailTextController.text, passTextController.text));
                  }
                },
              ),
            ),
          ],
        ));
  }
}

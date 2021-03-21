import 'package:flutter/material.dart';
import 'package:test1/services/auth.dart';
import 'package:test1/services/store.dart';
import 'package:test1/views/search.dart';
import 'package:test1/widgets/app_bar.dart';

class SignUpScreen extends StatefulWidget {
  final toggle;

  SignUpScreen({this.toggle});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  signUp() async {
    if (formKey.currentState.validate()) {
      String username = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      setState(() {
        isLoading = true;
      });

      String signUpError = await signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (signUpError == null) {
        await addUser(
          id: auth.currentUser.uid,
          username: username,
          email: email,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });

        final snackBar = SnackBar(
          content: Text(signUpError),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          validator: (val) {
                            return val.isEmpty
                                ? 'Vui lòng nhập tên tài khoản!'
                                : null;
                          },
                          decoration:
                              InputDecoration(hintText: 'Tên tài khoản'),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (val) {
                            return val.isEmpty ? 'Vui lòng nhập email!' : null;
                          },
                          decoration: InputDecoration(hintText: 'Email'),
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (val) {
                            return val.isEmpty
                                ? 'Vui lòng nhập mật khẩu!'
                                : null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'Mật khẩu'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: signUp,
                    child: Text('Đăng ký'),
                  ),
                  ElevatedButton(
                    onPressed: widget.toggle,
                    child: Text('Đăng nhập'),
                  ),
                ],
              ),
            ),
    );
  }
}

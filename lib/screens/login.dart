import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/recuperar_senha.dart';
import 'package:flutter_application_1/screens/register.dart';
import 'package:flutter_application_1/widgets/input_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  final _userController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSuccess(){
     Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>Home())
      );
    //Get.to(Home());
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuario/senha incorreto!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: SafeArea (
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),  
                    child: Text(
                      'X-BANK', 
                      style: Theme.of(context).textTheme.headline1
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(maxWidth: 300),
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 7.0,
                            offset: Offset(0, 0)
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children:<Widget> [
                        InputField(
                          icon: Icons.person_outline,
                          hint: "Usuário",
                          obscure: false,
                          controller: _userController,
                          error: "Usuario invalido!",
                        ),
                        InputField(
                          icon: Icons.lock_outline,
                          hint: "Senha",
                          obscure: true,
                          controller: _passController,
                          error: "Senha invaloda!",
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Esqueceu a Senha?',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>RecuperarSenha())
                              );
                              //Get.to(RecuperarSenha());
                            } 
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child:  SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              child: Text("Entrar"),
                              onPressed:  (){ 
                                UserModel().signIn(
                                  username: _userController.text, 
                                  pass: _passController.text, 
                                  onSuccess: _onSuccess, 
                                  onFail: _onFail);
                              }
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: InkWell(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Cadastrar-se',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onTap: (){ 
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>Register())
                              );
                              //Get.to(Register());
                            }
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}

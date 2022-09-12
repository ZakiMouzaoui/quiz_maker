import 'package:flutter/material.dart';
import 'package:quiz_maker/pages/sign_in_page.dart';

import '../controllers/auth_controller.dart';
import '../widgets/app_name_widget.dart';
import 'package:get/get.dart';

import 'home_page.dart';


class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _signInController = Get.put(SignInController());

  final _emailCtr = TextEditingController();
  final _passwordCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const AppNameWidget(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: orientation == Orientation.portrait
                          ? 250 : 30,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Name",
                        ),
                        validator: (_val) => _val!.trim().isEmpty ? "Name field is required" : null,
                      ),
                      TextFormField(
                        controller: _emailCtr,
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (_val) => _val!.trim().isEmpty ? "Email field is required" : null,
                      ),
                      TextFormField(
                        controller: _passwordCtr,
                        decoration: InputDecoration(
                            hintText: "Password"
                        ),
                        obscureText: true,
                        validator: (_val) => _val!.trim().isEmpty ? "Password field is required" : null,
                      ),
                      SizedBox(height: 20,),
                      GetBuilder<SignInController>(
                        builder: (_) => InkWell(
                          onTap: ()async{
                            if(_formKey.currentState!.validate()){
                              final _response = await _signInController.signUp(_emailCtr.text, _passwordCtr.text);
                              if(_response.data != null){
                                Get.offAll(()=>HomePage());
                              }
                              else{
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                          _response.error,

                                        ),
                                        backgroundColor: Colors.black45
                                    )
                                );
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: _signInController.isLoading
                                  ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          SizedBox(width: 3,),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>SignInPage());
                            },
                            child: Text("Sign In",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                            ),),
                          )
                        ],
                      )
                    ],
                  ),
                ))

        ),
      ),
    );
  }
}

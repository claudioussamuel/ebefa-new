import 'package:ebefa/helpers/custom_button.dart';
import 'package:ebefa/helpers/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../constant/constants.dart';

enum Auth{
  signin,
  signup
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
   bool _obscureText = true; 




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(child: 
      SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(8, ),
        child: Column(children: [
          const Text("3B3FA", style:  TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),),
          // ========== Sign Up ============
          ListTile(
            title: const Text("Create Account",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            leading: Radio(activeColor: kPrimaryColor,
            value: Auth.signup,
            groupValue: _auth,
            onChanged: (Auth? val) {
              setState(() {
                _auth = val!;
              });
              
            },
            ),
          ),
      
          if(_auth==Auth.signup)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(key: _signUpFormKey,child: Column(
              children: [
                CustomTextField(controller: authController.name,hintText: "Name",),
               const SizedBox(height: 10,),
                CustomTextField(controller: authController.email,hintText: "Email",),
               const SizedBox(height: 10,),
                 TextFormField(
    
      controller: authController.password,
      
      decoration: InputDecoration(
     hintText:"Password" ,
     suffixIcon: GestureDetector(onTap: () {
      setState(() {
        _obscureText =!_obscureText;
      });
       
     },
     child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
     ),
     
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
         
      ),
      enabledBorder: const OutlineInputBorder(
        
        borderSide: BorderSide(
          color: Colors.black38,
          
        )
        
      )
      ),
      validator: (value) {
        
      },
      obscureText: _obscureText,
    
    ),
                 const SizedBox(height: 10,),
                CustomButton(text: "Sign Up", onTap: () { 
                  authController.signUp();            
                })
                
              ],
            )),
          ),
          // ============ Sign In =============
          ListTile(
            title: const Text("SignIn",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            leading: Radio(activeColor: kPrimaryColor,
            value: Auth.signin,
            groupValue: _auth,
            onChanged: (Auth? val) {
               setState(() {
                _auth = val!;
              });
            },
            ),
          ),
          if(_auth==Auth.signin)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(key: _signInFormKey,child: Column(
              children: [
                CustomTextField(controller:authController.email,hintText: "Email",),
               const SizedBox(height: 10,),
               // CustomTextField(controller: authController.password,hintText: "Password",),
                TextFormField(
    
      controller: authController.password,
      
      decoration: InputDecoration(
     hintText:"Password" ,
     suffixIcon: GestureDetector(onTap: () {
      setState(() {    
       _obscureText =!_obscureText;
      });
     },
     child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
     ),
     
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
         
      ),
      enabledBorder: const OutlineInputBorder(
        
        borderSide: BorderSide(
          color: Colors.black38,
          
        )
        
      )
      ),
      validator: (value) {
        
      },
      obscureText: _obscureText,
    
    ),
                const SizedBox(height: 10,),
                CustomButton(text: "Sign In", onTap: () { 
                  authController.signIn();            
                })
                
              ],
            )),
          ),
        ]),
        ),
      ),
      ),
    );
  }
}
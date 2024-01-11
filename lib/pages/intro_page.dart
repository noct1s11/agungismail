import "package:easyshop/components/my_button.dart";
import "package:easyshop/components/my_textfield.dart";
import "package:easyshop/components/square_tile.dart";
import "package:easyshop/service/Auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";


class intropage extends StatefulWidget {
 const intropage({super.key});

  @override
  State<intropage> createState() => _intropageState();
}

class _intropageState extends State<intropage> {
  // text Editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void singnUserIn() async {

// show loading cirle 
showDialog(context: context, builder:(context) {
  return const Center(
    child: CircularProgressIndicator(),
    );
},
);

// try sign in
try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
      );
      // pop the loading cirle
     Navigator.pop(context);
}on FirebaseAuthException catch (e) {
    // pop the loading cirle
     Navigator.pop(context);
  //Wrong EMAIL
  if (e.code == 'user-not-found'){// pop the loading cirle

    //show Error to user
    WrongEmailMessage();
  } 
  //Wrong PASSWORD
  else if (e.code == 'wrong-password') {// pop the loading cirle

    //show Error to user
    WrongPasswordMessage();

  }
}
      
  }
  // Wrong email message popup
  void WrongEmailMessage(){
    showDialog(context: context, builder:(context) {
     return const AlertDialog(title: Text('Incorrect Email'),
      );
    },
    );
  }
    // Wrong passwor message popup
  void WrongPasswordMessage(){
    showDialog(context: context, builder:(context) {
    return const  AlertDialog(title: Text('Incorrect Password'),
      );
    },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Padding(
                padding: const EdgeInsets.all(43.0),
                
                child: Image.asset(
                  'lib/images/airjordanlogo.png',
                height: 160,
                
                ),
              ),
        
              const Text(
                'Just Do It',
                  style: TextStyle(
                    fontSize: 20,
                ),
              ),
              
              
              // title
              const SizedBox(height: 5),

        
              // sub title
               const Text(
                'List of NBA Teams by also selling new sneakers and jerseys made with premium quality',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),


              const SizedBox(height: 10),

              // username
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obsureText: false,
              ),
              
              const SizedBox(height: 10,),
              //pasword
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obsureText: true,
              ),
               const SizedBox(height: 25),   
                // start now botton
                MyButton(
                  onTap: singnUserIn,
                ),
                const SizedBox(height: 20),
                
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Row(
                    children: [
                     
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Text('Or Continue With',
                      style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    
                     Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 15),
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().SignInWithGoogle(),
                      ImagePath: 'lib/images/google.png',
                      ),

                    const SizedBox(width: 20),

                    // apple button
                    SquareTile(
                      onTap: () {},
                      ImagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),
                 const SizedBox(height: 50),
                     // not a member ? Register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        const Text('Register now',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

            ],
          ),  
        ),
      ),
    );
  }
}
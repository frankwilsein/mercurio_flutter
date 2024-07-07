import 'package:flutter/material.dart';
import 'package:mercurio/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _Logo(),
            
               _Form(),
            
               _Labels(),
               //const Text('terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
            
              ],
              
            ),
          ),
        ),
      ),
      
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/logo_app2.png')),
            //SizedBox(height :20),
            Text('MERCURIO', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
          ],
        ),
      
      ),
    );
  }
}

class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl =TextEditingController();
  final passCtrl= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 50),
      
      child: Column(
        children: <Widget>[
          CustomInput
          (icon: Icons.mail_outline, 
          placeholder: 'Correo', 
          keyboardType: TextInputType.emailAddress,
          textController: emailCtrl,),

           CustomInput
          (icon: Icons.lock_outline, 
          placeholder: 'Contraseña', 
          isPassword: true,
          textController: passCtrl,),
         // CustomInput(),

        BtnPeticion(icon2: Icons.person_pin, 
        text: 'INGRESAR', 
        onPressed2: (){    
          print(emailCtrl.text);
        print(passCtrl.text);

        })

          
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Tienes Problemas?', style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w200),),
         // SizedBox(height: 10,),
          Text('Podemos ayudarte', style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

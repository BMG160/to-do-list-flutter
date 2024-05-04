import 'package:flutter/material.dart';

import 'package:to_do_list/widgets/easy_elevated_button_widget.dart';
import 'package:to_do_list/widgets/easy_text_form_field_widget.dart';
import 'package:to_do_list/widgets/easy_text_widget.dart';
import 'package:to_do_list/widgets/horizontal_spacing_widget.dart';
import 'package:to_do_list/widgets/vertical_spacing_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/background.jpg'))
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
                top: 220,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 10),
                  width: 350,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(49, 54, 63, 100),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: EasyTextWidget(text: 'LOGIN', textColor: Colors.white, textSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const VerticalSpacingWidget(height: 20),
                      const EasyTextWidget(text: 'Email:', textColor: Colors.white, textSize: 15, fontWeight: FontWeight.bold),
                      const VerticalSpacingWidget(height: 10),
                      EasyTextFormFieldWidget(controller: emailController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your email address here.', prefixIcon: const Icon(Icons.email, color: Colors.white,),),
                      const VerticalSpacingWidget(height: 20),
                      const EasyTextWidget(text: 'Password:', textColor: Colors.white, textSize: 15, fontWeight: FontWeight.bold),
                      const VerticalSpacingWidget(height: 10),
                      EasyTextFormFieldWidget(controller: emailController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your password here.', prefixIcon: const Icon(Icons.lock, color: Colors.white,),),
                      const VerticalSpacingWidget(height: 20),
                      const EasyElevatedButtonWidget(buttonText: 'LOGIN', textColor: Colors.white, buttonColor: Color.fromRGBO(118, 171, 174, 100)),
                      const VerticalSpacingWidget(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EasyTextWidget(text: 'Register new account?', textColor: Colors.white, textSize: 15, fontWeight: FontWeight.normal),
                          HorizontalSpacingWidget(width: 10),
                          EasyTextWidget(text: 'CLICK HERE', textColor: Colors.white, textSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,)
                        ],
                      )
                    ],
                  ),
                )
            ),
            Positioned(
              top: 125,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Image.asset('assets/doggy.png')
              ),
            ),
          ],
        )
      ),
    );
  }
}

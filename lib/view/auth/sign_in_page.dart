import 'package:blog_app/core/extensions/context_extensions.dart';
import 'package:blog_app/core/utils/ui/textfield_decoration.dart';
import 'package:blog_app/core/widgets/buttons/button_widget.dart';
import 'package:blog_app/view/auth/sign_up_page.dart';
import 'package:blog_app/view_model/auth/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInViewModel = ref.watch(signInViewModelProvider);
    return ScaffoldMessenger(
      key: signInViewModel.scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: SingleChildScrollView(
          padding: context.paddingSymmetric(0, 25),
          child: Column(
            children: [
              const SizedBox(height: 200),
              TextFormField(
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                controller: signInViewModel.emailController,
                autofocus: false,
                decoration: textFormFieldDecoration(
                  context: context,
                  hintText: "email",
                  focusedBorderSide: const BorderSide(
                    color: Color.fromARGB(193, 144, 169, 193),
                    width: 1.5,
                  ),
                  contentPadding: context.paddingSymmetric(15, 20),
                  fillColor: const Color(0xC1D6EBFF),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                controller: signInViewModel.passwordController,

                autofocus: false,
                
                decoration: textFormFieldDecoration(
                  context: context,
                  hintText: "password",
                  focusedBorderSide: const BorderSide(
                    color: Color.fromARGB(193, 144, 169, 193),
                    width: 1.5,
                  ),
                  contentPadding: context.paddingSymmetric(15, 20),
                  fillColor: const Color(0xC1D6EBFF),
                ),
              ),
              const SizedBox(height: 100),
              ButtonWidget(
                height: 45,
                padding: context.paddingSymmetric(0, 20),
                onClicked: () async {
                  await signInViewModel.fetchSignInService();
                },
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                buttonColor: Colors.blue,
                child: Text(
                  "Sign In",
                  style: context.textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                },
                child: Text(
                  'No account yet? Sign Up',
                  style: context.textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

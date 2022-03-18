import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/constants/colors.dart';
import '/constants/const_variables.dart';
import '/cubit/register/register_cubit.dart';
import '/cubit/register/register_states.dart';
import '/screens/home_scrn.dart';
import '/screens/login_scrn.dart';
import '/utils/cache_helper.dart';
import '/widgets/components.dart';

class RegisterScrn extends StatelessWidget {
  RegisterScrn({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.RegisterModel.status) {
            print(state.RegisterModel.message);
            print(state.RegisterModel.data!.token);

            CacheHelper.saveData(
              key: 'token',
              value: state.RegisterModel.data!.token,
            ).then((value) {
              token = state.RegisterModel.data!.token.toString();
              navigateAndFinish(
                context,
                const HomeScrn(),
              );
            });
          } else {
            print(state.RegisterModel.message);

            showToast(
              text: state.RegisterModel.message,
              state: ToastStates.ERROR,
            );
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        "Register now to browse our hot offers",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: RegisterCubit.get(context).isPassword,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: RegisterCubit.get(context).suffix != null
                              ? IconButton(
                                  onPressed: () {
                                    RegisterCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    RegisterCubit.get(context).suffix,
                                  ),
                                )
                              : null,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 50.0,
                          child: MaterialButton(
                            onPressed: () {
                              print("formKey");
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              } else
                                print("Erorr");
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: defaultColor,
                          ),
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Do have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              emailController.text = "";
                              passwordController.text = "";
                              navigateTo(
                                context,
                                LoginScrn(),
                              );
                            },
                            child: Text(
                              'login'.toUpperCase(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

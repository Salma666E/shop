import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/app/cubit.dart';
import '/constants/colors.dart';
import '/cubit/shop_home/home_cubit.dart';
import '/cubit/shop_home/home_states.dart';
import '/utils/func_helper.dart';

class SettingsScrn extends StatefulWidget {
  SettingsScrn({Key? key}) : super(key: key);

  @override
  State<SettingsScrn> createState() => _SettingsScrnState();
}

class _SettingsScrnState extends State<SettingsScrn> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _switch = AppCubit.get(context).isDark;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context).userModel;
        nameController.text = cubit!.data!.name!;
        phoneController.text = cubit.data!.phone!;
        emailController.text = cubit.data!.email!;
        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: state is! UserLoadingState,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              AppCubit.get(context).isDark == true
                                  ? "Select light mode"
                                  : "Select dark mode",
                              style: TextStyle(fontWeight: FontWeight.w900)),
                          Spacer(),
                          Switch(
                            onChanged: (value) {
                              print("value: " + value.toString());
                              AppCubit.get(context)
                                  .changeAppMode(fromShared: value);
                              setState(() {
                                _switch = value;
                              });
                            },
                            value: _switch,
                            inactiveThumbColor: defaultColor,
                            activeColor: defaultColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Select language app?',
                              style: TextStyle(fontWeight: FontWeight.w900)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: TextButton(
                                child: const Text('English'),
                                onPressed: () {},
                              )),
                              Expanded(
                                  child: TextButton(
                                child: const Text('عربي'),
                                onPressed: () {},
                              )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Personal Information:',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      if (state is UpdateUserDataLoadingState)
                        const LinearProgressIndicator(),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your name updated';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Your Name",
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email updated';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Your Email",
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone updated';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Your Phone",
                          prefixIcon: Icon(
                            Icons.phone_android,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! UpdateUserDataLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 50.0,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                HomeCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            child: const Text(
                              "Save Updated",
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
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! LogOutLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 50.0,
                          child: MaterialButton(
                            onPressed: () {
                              signOut(context);
                            },
                            child: const Text(
                              "LOGOUT",
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
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

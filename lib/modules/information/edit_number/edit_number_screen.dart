import 'package:emas/modules/employee/employee.dart';
import 'package:emas/modules/information/edit_number/cubit/edit_number_cubit.dart';
import 'package:emas/modules/information/edit_number/cubit/edit_number_state.dart';
import 'package:emas/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

var numberController = TextEditingController();
var formkey = GlobalKey<FormState>();

class EditNumberScreen extends StatelessWidget {
  final dynamic phoneNumber;
  const EditNumberScreen({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditNmberCubit(),
      child: BlocConsumer<EditNmberCubit, EditNumberStates>(
        listener: (context, state) {
          if (state is EditNumberSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => EmployeeScreen()),
              (route) => false,
            );
          } else if (state is EditNumberErrorState) {
            showToast(
              txt: 'an error occurred',
              state: toaststate.WARNING,
            );
          }
        },
        builder: (context, state) {
          var cubit = EditNmberCubit.get(context);
          numberController.text = phoneNumber;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Mobile No',
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
            body: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    child: defultFormField(
                      ontap: () {},
                      controller: numberController,
                      labeltext: 'Mobile No',
                      prefixicon: Icons.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'You must enter the number';
                        }
                        if (value.length < 12) {
                          return 'You must enter 12 numbers';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  state is EditNumberLoadingState
                      ? CircularProgressIndicator(
                          color: HexColor('3232A0'),
                        )
                      : MaterialButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              if (numberController.text == phoneNumber) {
                                showToast(
                                  txt: 'must change number',
                                  state: toaststate.WARNING,
                                );
                              } else {
                                cubit.update(
                                  phone: numberController.text,
                                );
                              }
                            }
                          },
                          height: 53,
                          minWidth: 224,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: HexColor('3232A0'),
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

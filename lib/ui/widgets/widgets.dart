import 'package:flutter/material.dart';

Widget InputFields(TextEditingController controller, Widget icon, String hint) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextFormField(
      controller: controller,
      validator: (validaitor){
        if(validaitor!.isEmpty){
          return "enter this field";
        }else{
          return null;
        }
      },
      decoration: InputDecoration(hintText: hint,
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.black,
                  width: 0
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.black,
                width: 0
            ),
            borderRadius: BorderRadius.circular(10),
          )
      ),
    ),
  );
}

Widget Buttons(String name, Function() onTap) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: onTap,
      child: Center(
        child: Text("$name"),
      ),

    ),
  );
}


import 'package:flutter/material.dart';

class DialogUtils {
  static showLoading({required BuildContext context,bool isDismissible= true}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          content:
              Row(children: [Text('Loading'),SizedBox(width: 12,), CircularProgressIndicator()]),
        );
      },
    );

  }
  static hideLoading(BuildContext context){
    Navigator.of(context).pop();
  }
  static showMessage({required BuildContext context,required String message,String? title,required String actionName,Function? posActionFun}){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          title: Text(title ?? ''),
          actions: [TextButton(onPressed: (){
              if(posActionFun !=null){
                posActionFun.call();
              }
           // Navigator.of(context).pop();
          }, child: Text(actionName))],
        );
      },
    );
  }
}

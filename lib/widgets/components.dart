import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
// enum
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   Function? onSubmit,
//   Function? onChange,
//   Function? onTap,
//   bool isPassword = false,
//   required Function validate,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   Function? suffixPressed,
//   bool isClickable = true,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       enabled: isClickable,
//       onFieldSubmitted: onSubmit,
//       onChanged: onChange,
//       onTap: onTap,
//       validator: validate,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(
//           prefix,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//                 onPressed: ()=>suffixPressed,
//                 icon: Icon(
//                   suffix,
//                 ),
//               )
//             : null,
//         border: OutlineInputBorder(),
//       ),
//     );

// Widget myDivider() => Padding(
//       padding: const EdgeInsetsDirectional.only(
//         start: 20.0,
//       ),
//       child: Container(
//         width: double.infinity,
//         height: 1.0,
//         color: Colors.grey[300],
//       ),
//     );

// // Widget buildArticleItem(article, context) => InkWell(
// //       onTap: () {
// //         navigateTo(
// //           context,
// //           WebViewScreen(article['url']),
// //         );
// //       },
// //       child: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Row(
// //           children: [
// //             Container(
// //               width: 120.0,
// //               height: 120.0,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(
// //                   10.0,
// //                 ),
// //                 image: DecorationImage(
// //                   image: NetworkImage('${article['urlToImage']}'),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               width: 20.0,
// //             ),
// //             Expanded(
// //               child: Container(
// //                 height: 120.0,
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   children: [
// //                     Expanded(
// //                       child: Text(
// //                         '${article['title']}',
// //                         style: Theme.of(context).textTheme.bodyText1,
// //                         maxLines: 3,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                     ),
// //                     Text(
// //                       '${article['publishedAt']}',
// //                       style: TextStyle(
// //                         color: Colors.grey,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               width: 15.0,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );

// // Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
// //       condition: list.length > 0,
// //       builder: (context) => ListView.separated(
// //         physics: BouncingScrollPhysics(),
// //         itemBuilder: (context, index) => buildArticleItem(list[index], context),
// //         separatorBuilder: (context, index) => myDivider(),
// //         itemCount: 10,
// //       ),
// //       fallback: (context) =>
// //           isSearch ? Container() : Center(child: CircularProgressIndicator()),
// //     );



// // void navigateAndFinish(
// //   context,
// //   widget,
// // ) =>
// //     Navigator.pushAndRemoveUntil(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => widget,
// //       ),
// //       (route) {
// //         return false;
// //       },
// //     );




// // Widget defaultButton({
// //   double width = double.infinity,
// //   Color background = Colors.blue,
// //   bool isUpperCase = true,
// //   double radius = 3.0,
// //   required Function function,
// //   required String text,
// // }) =>
// //     Container(
// //       width: width,
// //       height: 50.0,
// //       child: MaterialButton(
// //         onPressed: function,
// //         child: Text(
// //           isUpperCase ? text.toUpperCase() : text,
// //           style: TextStyle(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(
// //           radius,
// //         ),
// //         color: background,
// //       ),
// //     );

// // Widget defaultTextButton({
// //   required Function function,
// //   required String text,
// // }) =>
// //     TextButton(
// //       onPressed: function,
// //       child: Text(
// //         text.toUpperCase(),
// //       ),
// //     );

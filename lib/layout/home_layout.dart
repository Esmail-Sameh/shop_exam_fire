import 'package:flutter/material.dart';
import 'package:shop_exam/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  static String routName = 'homeLayout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            color: Colors.amber.withOpacity(0.6),
            child: Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Please verify your email',
                ),
                Spacer(),
                defaultTextButton(
                  onPressed: (){},
                  text: 'Send',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

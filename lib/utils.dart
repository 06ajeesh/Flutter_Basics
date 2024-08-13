import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;


TextStyle tStyle=const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 22,);


DateTime time=DateTime.now();
DateFormat formater= DateFormat('d MMM');
String formatedTime=formater.format(time);

Widget titleWidget(Size size){
  return SizedBox(
    width: size.width*0.7,
  child: Row(
    children: [
      CircleAvatar(
        radius: 25,
        child: Image.asset("assets/avatar.png",fit: BoxFit.fill,
        ),
      ),
      const SizedBox(width: 10,),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
          children: [
            Text("Hello, ", style: tStyle.copyWith(fontSize: 20),),
            const Text("User"),
          ],
        ),

          Text("Today, $formatedTime",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),),
        ],
      )),
      badges.Badge(position: badges.BadgePosition.topEnd(top: -10,end: -6),badgeContent: Text('1'),child: Icon(Icons.notifications),)
    ],
  ),
);}
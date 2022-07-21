import 'package:facebook_lily/utils/colors.dart';
import 'package:flutter/material.dart';

class TabBarClass {
  List<Tab> tabBarFunc([int? page]) {
    return <Tab>[
      Tab(
        icon: Icon(
          page == 0 ? Icons.home : Icons.home_outlined,
          color: kPrimaryColor,
        ),
      ),
      Tab(
        icon: Icon(
          page == 1 ? Icons.people : Icons.people_outlined,
          color: kPrimaryColor,
        ),
      ),
      Tab(
        icon: Icon(
          page == 2 ? Icons.tv : Icons.tv_off_rounded,
          color: kPrimaryColor,
        ),
      ),
      Tab(
        icon: Icon(
          page == 3 ? Icons.shop_2 : Icons.shop_2_outlined,
          color: kPrimaryColor,
        ),
      ),
      Tab(
        icon: Icon(
          page == 4 ? Icons.upload : Icons.upload_outlined,
          color: kPrimaryColor,
        ),
      ),
      Tab(
        child: CircleAvatar(
          radius: 14,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1656098996938-10e80c66d668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
        ),
      ),
      //  Tab(
      //   icon: Icon(
      //     Icons.,
      //     color: Colors.grey[300],
      //   ),
      // ),
    ];
  }
}

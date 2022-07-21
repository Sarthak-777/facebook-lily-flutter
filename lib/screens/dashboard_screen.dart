import 'package:facebook_lily/providers/userProvider.dart';
import 'package:facebook_lily/utils/colors.dart';
import 'package:facebook_lily/utils/icons_tab_bar.dart';
import 'package:facebook_lily/utils/screenItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(
        length: TabBarClass().tabBarFunc().length,
        initialIndex: 0,
        vsync: this);
    super.initState();
    providerData();
    pageController = PageController();
  }

  Future providerData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTap(page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: kBgMainColor,
          title: Image.asset(
            'assets/Lily-logo-appbar.png',
            height: 60,
          ),
          titleSpacing: -5.0,
          elevation: 0.0,
          // bottomOpacity: 0.0,
          actions: [
            InkWell(
              onTap: () {},
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 230, 215, 220),
                radius: 20,
                child: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                  size: 25.0,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            InkWell(
              onTap: () {},
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 230, 215, 220),
                radius: 20,
                child: Icon(
                  Icons.message,
                  color: kPrimaryColor,
                  size: 25.0,
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: kPrimaryColor,
            tabs: TabBarClass().tabBarFunc(_page),
            onTap: navigationTap,
          ),
        ),
        body: PageView(
          children: homeScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged,
        ));
  }
}

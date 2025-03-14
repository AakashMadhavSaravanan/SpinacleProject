import 'package:flutter/material.dart';
import 'package:flutter_application_1/Main%20Pages/assistance.dart';
import 'package:flutter_application_1/widgets/upcoming_appointments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'search.dart';
import 'upload.dart';
import '../widgets/quick_access_item.dart';
import 'profile.dart';
import 'AI_engagement.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _userName = "User"; // Default name

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  // Load the stored user name
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? "User";
    });
  }

  final List<Widget> _pages = [
    Center(child: Text('Home Page Content', style: TextStyle(fontSize: 18))),
    MedicalSearchPage(),
    HealthcareSupportScreen(),
    UploadScreen(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onNavItemTapped,
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                      NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
                      NavigationRailDestination(icon: Icon(Icons.analytics), label: Text('Analytics')),
                      NavigationRailDestination(icon: Icon(Icons.upload_file), label: Text('Upload')),
                    ],
                  ),
                  Expanded(
                    child: _selectedIndex == 0
                        ? SingleChildScrollView(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                buildHeader(),
                                SizedBox(height: 20),
                                CreditCard(),
                                SizedBox(height: 20),
                                UpcomingAppointments(),
                              ],
                            ),
                          )
                        : _pages[_selectedIndex],
                  ),
                  if (_selectedIndex == 0) buildQuickAccessSidebar(),
                ],
              );
            } else {
              return _selectedIndex == 0
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          buildHeader(),
                          SizedBox(height: 20),
                          CreditCard(),
                          SizedBox(height: 20),
                          UpcomingAppointments(),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Quick Access', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                          SizedBox(height: 15),
                          buildQuickAccessRow(),
                        ],
                      ),
                    )
                  : _pages[_selectedIndex];
            }
          },
        ),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width <= 900
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.purple,
              selectedItemColor: Colors.grey,
              unselectedItemColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: _onNavItemTapped,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
                BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Upload'),
              ],
            )
          : null,
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileSettingsScreen()),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: Text('Xe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello $_userName', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Good afternoon', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.purple),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AIHealthEngagementPage()),
                );
              },
            ),
            SizedBox(width: 15),
            Icon(Icons.phone_outlined, color: Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget buildQuickAccessSidebar() {
    return Container(
      width: 200,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Access', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 15),
          QuickAccessItem(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTicCq9dR_WXsM2hDkRBiod-EtfshwtvlMG_w&s', label: 'Pay Bills'),
          SizedBox(height: 15),
          QuickAccessItem(imageUrl: 'https://cdn-icons-png.flaticon.com/512/2278/2278951.png', label: 'Policies'),
          SizedBox(height: 15),
          QuickAccessItem(imageUrl: 'https://thumbs.dreamstime.com/b/financial-reporting-d-icon-perfectly-isolated-white-background-business-accounting-analysis-358983115.jpg', label: 'Reports'),
          SizedBox(height: 15),
          QuickAccessItem(imageUrl: 'https://cdn-icons-png.flaticon.com/512/1041/1041916.png', label: 'Q & A'),
        ],
      ),
    );
  }

  Widget buildQuickAccessRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QuickAccessItem(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTicCq9dR_WXsM2hDkRBiod-EtfshwtvlMG_w&s', label: 'Pay Bills'),
        QuickAccessItem(imageUrl: 'https://cdn-icons-png.flaticon.com/512/2278/2278951.png', label: 'Policies'),
        QuickAccessItem(imageUrl: 'https://thumbs.dreamstime.com/b/financial-reporting-d-icon-perfectly-isolated-white-background-business-accounting-analysis-358983115.jpg', label: 'Reports'),
        QuickAccessItem(imageUrl: 'https://cdn-icons-png.flaticon.com/512/1041/1041916.png', label: 'Q & A'),
      ],
    );
  }
}

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(Icons.credit_card, color: Colors.white, size: 30),
            Text('Cancer Care', style: TextStyle(color: Colors.white, fontSize: 20)),
          ]),
          SizedBox(height: 30),
          Text('4567 **** **** 2834', style: TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 2)),
          SizedBox(height: 30),
          Text('07/25', style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}

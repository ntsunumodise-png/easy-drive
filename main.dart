
import 'package:flutter/material.dart';

void main() => runApp(const EasyDriveApp());

const navy = Color(0xFF101B35);
const navyLight = Color(0xFF1C2D50);
const gold = Color(0xFFF5C542);
const pale = Color(0xFFF4F6FA);
const muted = Color(0xFF6B7280);

class EasyDriveApp extends StatelessWidget {
  const EasyDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Drive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pale,
        colorScheme: ColorScheme.fromSeed(seedColor: navy, primary: navy,
          secondary: gold, surface: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy, foregroundColor: Colors.white,
          centerTitle: false, elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: pale,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          backgroundColor: gold, foregroundColor: navy, elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        )),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class Brand extends StatelessWidget {
  final double size;
  const Brand({super.key, this.size = 30});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: size + 13, height: size + 13,
      decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(13)),
      child: Icon(Icons.directions_car_filled_rounded, color: navy, size: size)),
    const SizedBox(width: 9),
    RichText(text: TextSpan(
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w900, letterSpacing: -1.1),
      children: const [
        TextSpan(text: 'Easy', style: TextStyle(color: Colors.white)),
        TextSpan(text: 'Drive', style: TextStyle(color: gold)),
      ])),
  ]);
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: navy,
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(26),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Spacer(),
        const Center(child: Brand(size: 42)),
        const SizedBox(height: 22),
        const Center(child: Text('Your Ride. Your Price. Your Choice.',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))),
        const SizedBox(height: 34),
        Container(height: 210, width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [navyLight, Color(0xFF304D7C)]),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: gold.withOpacity(.45))),
          child: const Stack(alignment: Alignment.center, children: [
            Icon(Icons.location_on_rounded, size: 145, color: Color(0x335B9BFF)),
            Icon(Icons.directions_car_filled_rounded, size: 94, color: gold),
          ])),
        const Spacer(),
        const Text('Move around Botswana with confidence.',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 9),
        const Text('Book a ride, agree on your fare and travel your way.',
          style: TextStyle(color: Colors.white70, height: 1.5)),
        const SizedBox(height: 25),
        ElevatedButton(onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const RegisterScreen())),
          child: const Text('Create account')),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52),
            foregroundColor: Colors.white, side: const BorderSide(color: gold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const LoginScreen())),
          child: const Text('Log in')),
        const SizedBox(height: 18),
        const Center(child: Text('BOTSWANA  •  BWP (P)',
          style: TextStyle(color: Colors.white54, letterSpacing: 1.4, fontSize: 11))),
      ]),
    )),
  );
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) => AuthScaffold(
    title: 'Create your account', subtitle: 'Join Easy Drive in a few simple steps.',
    button: 'Continue to verification', fields: const [
      ('Full name', Icons.person_outline), ('Mobile number (+267)', Icons.phone_outlined),
      ('Email address (optional)', Icons.email_outlined), ('Create password', Icons.lock_outline),
    ]);
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => AuthScaffold(
    title: 'Welcome back', subtitle: 'Log in to continue your journey.',
    button: 'Log in', fields: const [
      ('Mobile number or email', Icons.person_outline), ('Password', Icons.lock_outline),
    ]);
}

class AuthScaffold extends StatelessWidget {
  final String title, subtitle, button;
  final List<(String, IconData)> fields;
  const AuthScaffold({super.key, required this.title, required this.subtitle,
    required this.button, required this.fields});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Brand(size: 22)),
    body: ListView(padding: const EdgeInsets.all(22), children: [
      const SizedBox(height: 24),
      Text(title, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: navy)),
      const SizedBox(height: 8),
      Text(subtitle, style: const TextStyle(color: muted)),
      const SizedBox(height: 28),
      for (final f in fields) ...[
        Text(f.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextField(obscureText: f.$1.toLowerCase().contains('password'),
          keyboardType: f.$1.contains('number') ? TextInputType.phone : TextInputType.text,
          decoration: InputDecoration(prefixIcon: Icon(f.$2), hintText: f.$1)),
        const SizedBox(height: 18),
      ],
      const SizedBox(height: 10),
      ElevatedButton(onPressed: () => Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const MainShell()), (_) => false),
        child: Text(button)),
      const SizedBox(height: 14),
      const Text('Demo UI only: connect OTP and identity verification services before launch.',
        textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12)),
    ]),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;
  String role = 'Passenger';
  @override
  Widget build(BuildContext context) {
    final pages = role == 'Passenger'
      ? [const PassengerHome(), const TripsPage(), const WalletPage(), const ProfilePage()]
      : role == 'Driver'
        ? [const DriverDashboard(), const TripsPage(), const WalletPage(), const ProfilePage()]
        : role == 'Fleet'
          ? [const FleetDashboard(), const TripsPage(), const WalletPage(), const ProfilePage()]
          : [const AdminDashboard(), const TripsPage(), const WalletPage(), const ProfilePage()];
    return Scaffold(
      appBar: AppBar(
        title: const Brand(size: 22),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Preview app role',
            icon: const Icon(Icons.swap_horiz_rounded),
            onSelected: (v) => setState(() { role = v; tab = 0; }),
            itemBuilder: (_) => ['Passenger', 'Driver', 'Fleet', 'Admin']
              .map((v) => PopupMenuItem(value: v, child: Text('Preview $v'))).toList(),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.route_outlined), selectedIcon: Icon(Icons.route), label: 'Trips'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class PassengerHome extends StatefulWidget {
  const PassengerHome({super.key});
  @override
  State<PassengerHome> createState() => _PassengerHomeState();
}
class _PassengerHomeState extends State<PassengerHome> {
  final pickup = TextEditingController(text: 'My current location');
  final destination = TextEditingController();
  @override
  void dispose() { pickup.dispose(); destination.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    Row(children: [
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Good day 👋', style: TextStyle(color: muted)),
        Text('Where are we going?', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: navy)),
      ])),
      CircleAvatar(backgroundColor: gold, child: const Icon(Icons.person, color: navy)),
    ]),
    const SizedBox(height: 18),
    const MapPreview(),
    const SizedBox(height: 18),
    const Text('Plan your ride', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
    const SizedBox(height: 12),
    TextField(controller: pickup, decoration: const InputDecoration(prefixIcon: Icon(Icons.my_location, color: navy), hintText: 'Pickup location')),
    const SizedBox(height: 10),
    TextField(controller: destination, decoration: const InputDecoration(prefixIcon: Icon(Icons.location_on, color: Colors.red), hintText: 'Enter destination')),
    const SizedBox(height: 14),
    ElevatedButton.icon(onPressed: () {
      if (destination.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a destination first.')));
        return;
      }
      Navigator.push(context, MaterialPageRoute(builder: (_) =>
        FareProposalScreen(destination: destination.text.trim())));
    }, icon: const Icon(Icons.local_taxi), label: const Text('Find a ride')),
    const SizedBox(height: 22),
    const Text('Recent destinations', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
    const SizedBox(height: 10),
    const QuickPlace(icon: Icons.work_outline, title: 'Work', subtitle: 'Saved location'),
    const QuickPlace(icon: Icons.home_outlined, title: 'Home', subtitle: 'Saved location'),
    const QuickPlace(icon: Icons.shopping_bag_outlined, title: 'Shopping centre', subtitle: 'Recent destination'),
  ]);
}

class MapPreview extends StatelessWidget {
  const MapPreview({super.key});
  @override
  Widget build(BuildContext context) => Container(
    height: 185, clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color(0xFFDCE8F7), Color(0xFFB8D0E9)])),
    child: Stack(children: [
      Positioned(left: 24, top: 42, child: Transform.rotate(angle: .35,
        child: Container(width: 330, height: 13, color: Colors.white.withOpacity(.85)))),
      Positioned(left: 75, top: 105, child: Transform.rotate(angle: -.5,
        child: Container(width: 300, height: 11, color: Colors.white.withOpacity(.9)))),
      Positioned(right: 52, top: 18, child: Container(width: 62, height: 50,
        decoration: BoxDecoration(color: const Color(0xFFB3D7B1), borderRadius: BorderRadius.circular(12)))),
      const Center(child: Icon(Icons.location_on, color: navy, size: 43)),
      const Positioned(left: 14, bottom: 12, child: Chip(
        avatar: Icon(Icons.my_location, size: 16), label: Text('Gaborone area'))),
    ]),
  );
}

class QuickPlace extends StatelessWidget {
  final IconData icon; final String title, subtitle;
  const QuickPlace({super.key, required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: Colors.white,
      child: Icon(icon, color: navy)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_right));
}

class FareProposalScreen extends StatefulWidget {
  final String destination;
  const FareProposalScreen({super.key, required this.destination});
  @override
  State<FareProposalScreen> createState() => _FareProposalScreenState();
}
class _FareProposalScreenState extends State<FareProposalScreen> {
  int offer = 120;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Propose your fare')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const MapPreview(),
      const SizedBox(height: 18),
      infoCard('Destination', widget.destination, Icons.flag_outlined),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          const Text('Your proposed fare', style: TextStyle(color: muted)),
          const SizedBox(height: 8),
          Text('P$offer', style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: navy)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton.filledTonal(onPressed: () => setState(() => offer = (offer - 5).clamp(20, 1000).toInt()),
              icon: const Icon(Icons.remove)),
            const SizedBox(width: 22),
            IconButton.filled(onPressed: () => setState(() => offer = (offer + 5).clamp(20, 1000).toInt()),
              style: IconButton.styleFrom(backgroundColor: gold, foregroundColor: navy),
              icon: const Icon(Icons.add)),
          ]),
          const Text('Drivers may accept or send a counteroffer.',
            style: TextStyle(color: muted, fontSize: 12)),
        ])),
      const SizedBox(height: 18),
      ElevatedButton(onPressed: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => DriverOffersScreen(offer: offer))),
        child: const Text('Send fare request')),
      const SizedBox(height: 12),
      const Text('Fare shown is a demo value. Live fare guidance will be connected to the backend.',
        style: TextStyle(color: muted, fontSize: 12)),
    ]),
  );
}

class DriverOffersScreen extends StatelessWidget {
  final int offer;
  const DriverOffersScreen({super.key, required this.offer});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Driver offers')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Text('Your offer: P$offer', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: navy)),
      const SizedBox(height: 8),
      const Text('These sample offers demonstrate the selection flow.', style: TextStyle(color: muted)),
      const SizedBox(height: 16),
      for (final d in [('Thabo M.', 'Toyota Corolla • ABC 123 B', 130, '4.9'), ('Kabelo K.', 'Honda Fit • B 456 DEF', 125, '4.8'), ('Lesego P.', 'Toyota Vitz • B 789 GHI', 140, '4.7')])
        Card(color: Colors.white, child: ListTile(
          leading: const CircleAvatar(backgroundColor: navy, child: Icon(Icons.person, color: gold)),
          title: Text(d.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text('${d.$2}\n★ ${d.$4} rating'),
          isThreeLine: true,
          trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('P${d.$3}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: navy)),
            const Text('Offer', style: TextStyle(fontSize: 11, color: muted)),
          ]),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TripScreen())),
        )),
    ]),
  );
}

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Your driver')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const MapPreview(),
      const SizedBox(height: 18),
      const ListTile(
        leading: CircleAvatar(backgroundColor: navy, child: Icon(Icons.person, color: gold)),
        title: Text('Driver assigned', style: TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text('Demo driver • Vehicle details to be verified'),
        trailing: Chip(label: Text('4 min')),
      ),
      const SizedBox(height: 10),
      const Text('Contact your driver', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(child: OutlinedButton.icon(onPressed: () => _message(context),
          icon: const Icon(Icons.chat_bubble_outline), label: const Text('Chat'))),
        const SizedBox(width: 8),
        Expanded(child: OutlinedButton.icon(onPressed: () => _message(context),
          icon: const Icon(Icons.call_outlined), label: const Text('Call'))),
        const SizedBox(width: 8),
        Expanded(child: OutlinedButton.icon(onPressed: () => _message(context),
          icon: const Icon(Icons.chat), label: const Text('WhatsApp'))),
      ]),
      const SizedBox(height: 18),
      const Text('Calling and WhatsApp require passenger consent. Protected calling depends on provider availability.',
        style: TextStyle(color: muted, fontSize: 12)),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Demo: trip completion flow will be connected.'))),
        child: const Text('Complete demo trip')),
    ]),
  );
}
void _message(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Communication provider integration is not connected yet.')));

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Your trips', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: navy)),
    const SizedBox(height: 8),
    const Text('Your completed and upcoming rides will appear here.', style: TextStyle(color: muted)),
    const SizedBox(height: 18),
    const EmptyPanel(icon: Icons.route, title: 'No trips yet', detail: 'Your ride history will appear here once you start travelling.'),
  ]);
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Wallet', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: navy)),
    const SizedBox(height: 16),
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(
      color: navy, borderRadius: BorderRadius.circular(22)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Demo wallet balance', style: TextStyle(color: Colors.white70)),
        SizedBox(height: 8),
        Text('P0.00', style: TextStyle(color: gold, fontSize: 34, fontWeight: FontWeight.w900)),
        SizedBox(height: 8),
        Text('Botswana Pula (BWP)', style: TextStyle(color: Colors.white70)),
      ])),
    const SizedBox(height: 18),
    const EmptyPanel(icon: Icons.receipt_long, title: 'No transactions', detail: 'Payment records will be displayed here.'),
  ]);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Profile & settings', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: navy)),
    const SizedBox(height: 18),
    const CircleAvatar(radius: 37, backgroundColor: gold, child: Icon(Icons.person, size: 40, color: navy)),
    const SizedBox(height: 10),
    const Center(child: Text('Easy Drive User', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900))),
    const Center(child: Text('Phone verification pending', style: TextStyle(color: muted))),
    const SizedBox(height: 18),
    for (final item in [
      (Icons.person_outline, 'Personal information'), (Icons.verified_user_outlined, 'Verification'),
      (Icons.notifications_outlined, 'Notifications'), (Icons.privacy_tip_outlined, 'Privacy & security'),
      (Icons.help_outline, 'Help & support'), (Icons.info_outline, 'About Easy Drive')])
      Card(color: Colors.white, child: ListTile(leading: Icon(item.$1, color: navy),
        title: Text(item.$2), trailing: const Icon(Icons.chevron_right),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.$2} screen is part of the next build phase.'))))),
  ]);
}

class DriverDashboard extends StatelessWidget {
  const DriverDashboard({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Driver dashboard', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: navy)),
    const SizedBox(height: 14),
    const MapPreview(),
    const SizedBox(height: 14),
    const MetricCard(title: 'Available ride credits', value: '12', icon: Icons.confirmation_number_outlined),
    const MetricCard(title: 'Today’s earnings', value: 'P0.00', icon: Icons.payments_outlined),
    const SizedBox(height: 12),
    ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Driver availability will connect to the live trip service.'))),
      child: const Text('Go online')),
    const SizedBox(height: 10),
    const Text('Driver onboarding, licence checks, vehicle verification and subscriptions will be added in the next implementation phase.',
      style: TextStyle(color: muted)),
  ]);
}

class FleetDashboard extends StatelessWidget {
  const FleetDashboard({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Fleet management', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: navy)),
    const SizedBox(height: 16),
    const MetricCard(title: 'Registered vehicles', value: '0', icon: Icons.directions_car),
    const MetricCard(title: 'Assigned drivers', value: '0', icon: Icons.groups),
    ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fleet registration form will be implemented next.'))),
      child: const Text('Register a vehicle')),
  ]);
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Operations dashboard', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: navy)),
    const SizedBox(height: 8),
    const Text('Restricted operational preview — no withdrawal controls.', style: TextStyle(color: muted)),
    const SizedBox(height: 14),
    const MetricCard(title: 'Pending driver reviews', value: '0', icon: Icons.fact_check_outlined),
    const MetricCard(title: 'Active trips', value: '0', icon: Icons.route),
    const MetricCard(title: 'Open complaints', value: '0', icon: Icons.support_agent),
    for (final label in ['Verify drivers', 'Verify vehicles', 'Manage passengers', 'Review complaints', 'Trip monitoring'])
      Card(color: Colors.white, child: ListTile(title: Text(label), trailing: const Icon(Icons.chevron_right))),
  ]);
}

class MetricCard extends StatelessWidget {
  final String title, value; final IconData icon;
  const MetricCard({super.key, required this.title, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) => Card(color: Colors.white, child: ListTile(
    leading: CircleAvatar(backgroundColor: gold.withOpacity(.25), child: Icon(icon, color: navy)),
    title: Text(title, style: const TextStyle(color: muted, fontSize: 13)),
    trailing: Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: navy)),
  ));
}

class EmptyPanel extends StatelessWidget {
  final IconData icon; final String title, detail;
  const EmptyPanel({super.key, required this.icon, required this.title, required this.detail});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Column(children: [
      Icon(icon, size: 48, color: navy.withOpacity(.5)),
      const SizedBox(height: 10),
      Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
      const SizedBox(height: 6),
      Text(detail, textAlign: TextAlign.center, style: const TextStyle(color: muted)),
    ]),
  );
}

Widget infoCard(String title, String value, IconData icon) => Card(
  color: Colors.white, child: ListTile(leading: Icon(icon, color: navy),
    title: Text(title, style: const TextStyle(color: muted, fontSize: 12)),
    subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.w800, color: navy))));

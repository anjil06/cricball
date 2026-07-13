import 'package:flutter/material.dart';
import '../models/match.dart';
import '../services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class CreateMatchScreen extends StatefulWidget {
  const CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  String _selectedMode = '20 overs';
  final _team1NameController = TextEditingController();
  final _team2NameController = TextEditingController();
  final List<TextEditingController> _team1PlayersControllers = [];
  final List<TextEditingController> _team2PlayersControllers = [];

  final modes = ['10 overs', '20 overs', '50 overs', 'custom'];

  @override
  void initState() {
    super.initState();
    _initializePlayers();
  }

  void _initializePlayers() {
    _team1PlayersControllers.clear();
    _team2PlayersControllers.clear();
    for (int i = 0; i < 11; i++) {
      _team1PlayersControllers.add(TextEditingController());
      _team2PlayersControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _team1NameController.dispose();
    _team2NameController.dispose();
    for (var controller in _team1PlayersControllers) {
      controller.dispose();
    }
    for (var controller in _team2PlayersControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.user?.uid;

      if (userId == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not authenticated')),
        );
        return;
      }

      List<String> team1Players = _team1PlayersControllers
          .where((controller) => controller.text.isNotEmpty)
          .map((controller) => controller.text)
          .toList();

      List<String> team2Players = _team2PlayersControllers
          .where((controller) => controller.text.isNotEmpty)
          .map((controller) => controller.text)
          .toList();

      if (team1Players.length < 11 || team2Players.length < 11) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add all 11 players for each team')),
        );
        return;
      }

      final match = Match(
        id: '',
        team1Name: _team1NameController.text,
        team2Name: _team2NameController.text,
        mode: _selectedMode,
        team1Playing11: team1Players,
        team2Playing11: team2Players,
        createdBy: userId,
        createdAt: DateTime.now(),
      );

      try {
        await _firestoreService.createMatch(match);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Match created successfully!')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Match'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.sports_cricket,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Match Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  initialValue: _selectedMode,
                  decoration: InputDecoration(
                    labelText: 'Match Mode',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  items: modes.map((mode) {
                    return DropdownMenuItem(value: mode, child: Text(mode));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedMode = value!);
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _team1NameController,
                  decoration: InputDecoration(
                    labelText: 'Team 1 Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Enter team name' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _team2NameController,
                  decoration: InputDecoration(
                    labelText: 'Team 2 Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Enter team name' : null,
                ),
                const SizedBox(height: 25),
                const Text(
                  'Team 1 Playing 11',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildPlayersList(_team1PlayersControllers),
                const SizedBox(height: 25),
                const Text(
                  'Team 2 Playing 11',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildPlayersList(_team2PlayersControllers),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Create Match'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayersList(List<TextEditingController> controllers) {
    return Column(
      children: List.generate(11, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextFormField(
            controller: controllers[index],
            decoration: InputDecoration(
              labelText: 'Player ${index + 1}',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Enter player name' : null,
          ),
        );
      }),
    );
  }
}

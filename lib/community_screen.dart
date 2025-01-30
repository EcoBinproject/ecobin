import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  TextEditingController messageController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController pollQuestionController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> messages = [];
  List<String> onlineMembers = []; // Dynamic online members
  int communityPoints = 0;
  String userName = 'Tu';
  String userStatus = 'In attesa di aggiornamento';
  bool isDarkMode = false;
  List<Map<String, dynamic>> polls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor:
            isDarkMode ? Colors.grey[850] : Colors.greenAccent[700],
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeMessage(),
            Divider(color: Colors.grey[300]),
            _buildStatusSection(),
            Divider(color: Colors.grey[300]),
            _buildChatSection(),
            Divider(color: Colors.grey[300]),
            _buildOnlineMembersSection(),
            Divider(color: Colors.grey[300]),
            _buildMessageInput(),
            Divider(color: Colors.grey[300]),
            _buildPollSection(),
            Divider(color: Colors.grey[300]),
            _buildResourcesSection(),
          ],
        ),
      ),
    );
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  Widget _buildWelcomeMessage() {
    return Text(
      'Benvenuto nella Community, $userName!',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.white : Colors.green[700],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.account_circle,
              size: 30, color: isDarkMode ? Colors.white : Colors.green[700]),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: statusController,
              decoration: InputDecoration(
                hintText: 'Aggiorna stato...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                setState(() {
                  userStatus =
                      text.isEmpty ? 'In attesa di aggiornamento' : text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSection() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return _buildChatBubble(
            messages[index]['userName']!,
            messages[index]['message']!,
            messages[index]['image'],
            messages[index]['likes'],
            messages[index]['userName'] == userName,
            index,
          );
        },
      ),
    );
  }

  Widget _buildChatBubble(String userName, String message, File? image,
      int likes, bool isSender, int index) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSender ? Colors.green[300] : Colors.green[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(message),
            if (image != null)
              Image.file(image, width: 200, height: 200, fit: BoxFit.cover),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up,
                      color: likes > 0 ? Colors.blue : Colors.grey),
                  onPressed: () => _toggleLike(index),
                ),
                Text('$likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Membri Online:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        onlineMembers.isEmpty
            ? Text('Nessun membro online')
            : Column(
                children: onlineMembers.map((member) => Text(member)).toList()),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _pickImage),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(hintText: 'Scrivi un messaggio...'),
              onSubmitted: (text) => _sendMessage(text),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.isNotEmpty || _image != null) {
      setState(() {
        messages.add({
          'userName': userName,
          'message': text,
          'image': _image,
          'likes': 0
        });
        messageController.clear();
        _image = null;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget _buildPollSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sondaggi:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...polls.map((poll) {
          return Card(
            child: ListTile(
              title: Text(poll['question']),
              trailing: IconButton(
                icon: Icon(Icons.poll),
                onPressed: () => _votePoll(poll),
              ),
            ),
          );
        }).toList(),
        ElevatedButton(
          onPressed: _createPoll,
          child: Text('Crea un sondaggio'),
        ),
      ],
    );
  }

  void _votePoll(Map<String, dynamic> poll) {
    // Logica per votare il sondaggio
    setState(() {
      poll['votes']++;
    });
  }

  void _createPoll() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Crea un sondaggio'),
          content: TextField(
            controller: pollQuestionController,
            decoration: InputDecoration(hintText: 'Domanda del sondaggio'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (pollQuestionController.text.isNotEmpty) {
                  setState(() {
                    polls.add(
                        {'question': pollQuestionController.text, 'votes': 0});
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Crea'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annulla'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResourcesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Risorse Utili:', style: TextStyle(fontWeight: FontWeight.bold)),
        ListTile(
          title: Text('Link al sito di riciclo'),
          onTap: () => _launchURL('https://www.riciclo.com'),
        ),
        ListTile(
          title: Text('Guida al compostaggio'),
          onTap: () => _launchURL('https://www.compostaggio.com'),
        ),
        ListTile(
          title: Text('Informazioni sulla sostenibilità'),
          onTap: () => _launchURL('https://www.sostenibilita.com'),
        ),
      ],
    );
  }

  void _launchURL(String url) {
    // Logica per aprire il link nel browser
    // Puoi usare il pacchetto url_launcher per implementare questa funzionalità
  }

  void _toggleLike(int index) {
    setState(() {
      messages[index]['likes']++;
    });
  }
}

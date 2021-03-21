import 'package:flutter/material.dart';
import 'package:test1/services/auth.dart' as auth;
import 'package:test1/services/store.dart';
import 'package:test1/views/authentication.dart';
import 'package:test1/views/chat.dart';
import 'package:test1/widgets/search_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> listSearchResult = <Map<String, dynamic>>[];

  signOut() {
    auth.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationScreen(),
      ),
    );
  }

  search() async {
    String searchText = searchController.text;

    if (searchText.isEmpty) {
      final snackBar = SnackBar(
        content: Text('Vui lòng nhập tên người dùng!'),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      FocusScope.of(context).unfocus();

      final tmp = await getUsersByName(name: searchText);

      if (tmp.length == 0) {
        setState(() {
          listSearchResult = [];
        });

        final snackBar = SnackBar(
          content: Text('Không tìm thấy tài khoản nào như vậy!'),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          listSearchResult = tmp;
        });
      }
    }
  }

  listSearchTile() {
    if (listSearchResult.length == 0) {
      return Container();
    } else {
      return ListView.builder(
        itemCount: listSearchResult.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchTile(
            name: listSearchResult[index]['name'],
            email: listSearchResult[index]['email'],
            message: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    friendId: listSearchResult[index]['id'],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ứng dụng chat nho nhỏ'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Nhập tên người dùng',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ],
            ),
            listSearchTile(),
          ],
        ),
      ),
    );
  }
}

part of 'home.dart';

class HomeLogic with ChangeNotifier {
  BuildContext context;
  HomeLogic(this.context);
  final chatController = TextEditingController();
  final focusNode = FocusNode();
  List<Map<String, dynamic>> chatMessages = [];
  final gemini = Gemini.instance;
  final scrollController = ScrollController();

  void onChatSend() async {
    String text = chatController.text;
    chatController.clear();
    chatMessages.add({'message': text, 'isGemini': false});
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    showLoading();
    final response = await gemini.text(text);
    chatMessages.add({
      'message': response?.content?.parts?[0].text ?? 'No response',
      'isGemini': true
    });
    hideLoading();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }

  void clearChat() {
    chatMessages.clear();
    notifyListeners();
  }

  void showLoading() {
    showDialog(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white.withOpacity(0.1),
        child: const Center(
          child: SpinKitCircle(
            color: Colors.green,
            size: 50,
          ),
        ),
      ),
    );
  }

  void hideLoading() {
    Navigator.of(context).pop();
  }
}

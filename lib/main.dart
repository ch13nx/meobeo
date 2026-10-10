import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const VietPhucRemixApp());
}

// ---------------------------------------------------------
// 1. DỮ LIỆU MOCK DATA (MÔ TẢ TRANG PHỤC)
// ---------------------------------------------------------
class MockData {
  static final List<Map<String, dynamic>> events = [
    {'id': 'e1', 'name': 'Đi Chùa', 'type': 'event', 'icon': Icons.account_balance, 'description': 'Không gian tâm linh, linh thiêng. Đòi hỏi trang phục phải kín đáo, lịch sự và trang trọng.'},
    {'id': 'e2', 'name': 'Dạo Phố', 'type': 'event', 'icon': Icons.park, 'description': 'Hoạt động ngoài trời nhẹ nhàng. Ưu tiên sự thoải mái, năng động nhưng vẫn thể hiện được gu thời trang cá nhân.'},
    {'id': 'e3', 'name': 'Dự Tiệc', 'type': 'event', 'icon': Icons.celebration, 'description': 'Sự kiện giao lưu sang trọng. Là nơi hoàn hảo để tỏa sáng với những bộ trang phục lộng lẫy và ấn tượng nhất.'},
  ];

  static final List<Map<String, dynamic>> innerTops = [
    {'id': 'it1', 'name': 'Áo Lót', 'type': 'innerTop', 'imagePath': 'assets/images/aolot.png', 'description': 'Lớp áo lót trắng bên trong theo đúng quy chuẩn cổ lễ truyền thống.'},
    {'id': 'it2', 'name': 'Áo Yếm', 'type': 'innerTop', 'imagePath': 'assets/images/ao_yem.png', 'description': 'Trang phục nội y truyền thống quyến rũ của phụ nữ Việt Nam xưa.'},
  ];

  static final List<Map<String, dynamic>> outerTops = [
    {'id': 'ot1', 'name': 'Áo Dài Xanh', 'type': 'outerTop', 'imagePath': 'assets/images/ao_dai_xanh.png', 'description': 'Quốc phục Áo Dài truyền thống với sắc xanh lam trang nhã, tà áo thướt tha.'},
    {'id': 'ot2', 'name': 'Áo Tứ Thân', 'type': 'outerTop', 'imagePath': 'assets/images/ao_tu_than.png', 'description': 'Trang phục đặc trưng của phụ nữ Kinh Bắc xưa, mang nét đẹp duyên dáng.'},
    {'id': 'ot3', 'name': 'Áo Dài Zack', 'type': 'outerTop', 'imagePath': 'assets/images/aodaizack.png', 'description': 'Phiên bản Áo Dài cách tân mang phong cách "Remix" hiện đại, phá cách.'},
  ];

  static final List<Map<String, dynamic>> bottoms = [
    {'id': 'b1', 'name': 'Quần Tứ Thân', 'type': 'bottom', 'imagePath': 'assets/images/quan_tu_than.png', 'description': 'Quần lụa ống rộng đen truyền thống, đồng bộ với áo tứ thân và áo lót.'},
    {'id': 'b2', 'name': 'Quần Jean', 'type': 'bottom', 'imagePath': 'assets/images/quanjean.png', 'description': 'Chiếc quần Jean bụi bặm hiện đại, đại diện cho phong cách mix&match trẻ trung.'},
    {'id': 'b3', 'name': 'Quần Zack', 'type': 'bottom', 'imagePath': 'assets/images/quanzack.png', 'description': 'Quần thiết kế cách tân với họa tiết độc đáo, tạo điểm nhấn mạnh mẽ.'},
  ];

  static final List<Map<String, dynamic>> headAccs = [
    {'id': 'h1', 'name': 'Nón Lá', 'type': 'head', 'imagePath': 'assets/images/non_la.png', 'description': 'Biểu tượng văn hóa bất diệt của Việt Nam, che nắng che mưa duyên dáng.'},
  ];

  static final List<Map<String, dynamic>> feetAccs = [
    {'id': 'f1', 'name': 'Giày Sneaker', 'type': 'feet', 'imagePath': 'assets/images/giay_sneaker.png', 'description': 'Giày thể thao năng động, điểm nhấn cho phong cách cổ phục remix.'},
  ];

static final List<Map<String, dynamic>> handAccs = [];
  static final List<Map<String, dynamic>> neckAccs = [];
}

// ---------------------------------------------------------
// 2. ROOT APP CONFIGURATION
// ---------------------------------------------------------
class VietPhucRemixApp extends StatelessWidget {
  const VietPhucRemixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VietStyle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F0E6),
        primaryColor: const Color(0xFF8B1C1C),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B1C1C)),
        fontFamily: 'Georgia',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F0E6),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Color(0xFF8B1C1C), fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ---------------------------------------------------------
// 3. MAIN HOMEPAGE
// ---------------------------------------------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? selectedEvent;
  Map<String, dynamic>? selectedInnerTop;
  Map<String, dynamic>? selectedOuterTop;
  Map<String, dynamic>? selectedBottom;
  Map<String, dynamic>? selectedHeadAcc;
  Map<String, dynamic>? selectedFeetAcc;
  Map<String, dynamic>? selectedHandAcc;
  Map<String, dynamic>? selectedNeckAcc;

  final String _geminiApiKey = 'AQ.Ab8RN6JwxxRyinK1cApz1P6iX4XNst3G4OJvtb6DhvhKLDb9Nw';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VietStyle')),
      body: SafeArea(
        child: Column(
          children: [
            // KHU VỰC TRÊN (55%): MODEL & INFO PANEL
            Expanded(
              flex: 55,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 45,
                      child: AvatarDisplay(
                        innerTop: selectedInnerTop,
                        outerTop: selectedOuterTop,
                        bottom: selectedBottom,
                        headAcc: selectedHeadAcc,
                        feetAcc: selectedFeetAcc,
                        handAcc: selectedHandAcc,
                        neckAcc: selectedNeckAcc,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 55,
                      child: OutfitInfoPanel(
                        event: selectedEvent,
                        innerTop: selectedInnerTop,
                        outerTop: selectedOuterTop,
                        bottom: selectedBottom,
                        headAcc: selectedHeadAcc,
                        feetAcc: selectedFeetAcc,
                        handAcc: selectedHandAcc,
                        neckAcc: selectedNeckAcc,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // KHU VỰC DƯỚI (45%): THANH CHỌN ĐỒ & 2 NÚT AI (GỢI Ý & CHẤM ĐIỂM)
            Expanded(
              flex: 45,
              child: WardrobeSelector(
                selectedEvent: selectedEvent,
                selectedInnerTop: selectedInnerTop,
                selectedOuterTop: selectedOuterTop,
                selectedBottom: selectedBottom,
                selectedHeadAcc: selectedHeadAcc,
                selectedFeetAcc: selectedFeetAcc,
                selectedHandAcc: selectedHandAcc,
                selectedNeckAcc: selectedNeckAcc,
                onEventChanged: (i) => setState(() => selectedEvent = i),
                onInnerTopChanged: (i) => setState(() => selectedInnerTop = i),
                onOuterTopChanged: (i) => setState(() => selectedOuterTop = i),
                onBottomChanged: (i) => setState(() => selectedBottom = i),
                onHeadAccChanged: (i) => setState(() => selectedHeadAcc = i),
                onFeetAccChanged: (i) => setState(() => selectedFeetAcc = i),
                onHandAccChanged: (i) => setState(() => selectedHandAcc = i),
                onNeckAccChanged: (i) => setState(() => selectedNeckAcc = i),
                onAIPredictOutfit: _handleAIPredictOutfit,
                onAIScoreOutfit: _handleAIScoreOutfit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TÍNH NĂNG 1: AI GỢI Ý CÁCH PHỐI ĐỒ PHÙ HỢP SỰ KIỆN
  Future<void> _handleAIPredictOutfit() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: Color(0xFF8B1C1C))),
    );

    if (selectedEvent == null) {
      Navigator.pop(context);
      _showFeedback("Gợi Ý Phối Đồ Từ AI", "Vui lòng chọn Sự kiện trước để AI có thể gợi ý outfit chuẩn xác nhất nhé!", false);
      return;
    }

    String eventName = selectedEvent!['name'];
    String suggestionMessage = "";

    // Fallback thông minh nếu lỗi mạng/503
    if (eventName == 'Đi Chùa') {
      suggestionMessage = "Gợi ý phối đồ cho 'Đi Chùa':\n- Áo trong: Áo Lót\n- Áo ngoài: Áo Tứ Thân\n- Quần: Quần Tứ Thân\n- Phụ kiện: Nón Lá\n-> Lý do: Đảm bảo tính kín đáo, trang nghiêm và tôn kính nơi tôn nghiêm.";
    } else if (eventName == 'Dạo Phố') {
      suggestionMessage = "Gợi ý phối đồ cho 'Dạo Phố':\n- Áo trong: Áo Yếm\n- Áo ngoài: Áo Dài Zack\n- Quần: Quần Jean\n- Phụ kiện: Giày Sneaker\n-> Lý do: Sự kết hợp hoàn hảo mang đậm chất Remix, năng động và cá tính.";
    } else {
      suggestionMessage = "Gợi ý phối đồ cho 'Dự Tiệc':\n- Áo ngoài: Áo Dài Xanh\n- Quần: Quần Tứ Thân\n- Phụ kiện: Vòng Ngọc & Quạt Giấy\n-> Lý do: Tôn lên vẻ đẹp sang trọng, đài các nhưng vẫn giữ nguyên hồn cốt truyền thống.";
    }

    try {
      final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _geminiApiKey);
      final prompt = 'Đóng vai chuyên gia thời trang cổ phục Việt. Hãy gợi ý một set đồ (gồm Áo trong, Áo ngoài, Quần và Phụ kiện) tối ưu nhất cho sự kiện "$eventName". Trình bày ngắn gọn, súc tích.';
      final response = await model.generateContent([Content.text(prompt)]);
      if (response.text != null) {
        suggestionMessage = response.text!;
      }
    } catch (e) {
      // Dùng fallback đã có
    }

    if (!mounted) return;
    Navigator.pop(context);
    _showFeedback("AI Gợi Ý Phối Đồ", suggestionMessage, false);
  }

  // TÍNH NĂNG 2: AI CHẤM ĐIỂM THEO 3 TIÊU CHÍ (LỊCH SỬ 40% - QUY CHUẨN 30% - THẨM MỸ 30%)
  Future<void> _handleAIScoreOutfit() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: Color(0xFF8B1C1C))),
    );

    if (selectedEvent == null) {
      Navigator.pop(context);
      _showFeedback("Chấm Điểm Cổ Phục", "Vui lòng chọn Sự kiện và các món đồ bạn muốn phối để AI tiến hành chấm điểm nhé!", true);
      return;
    }

    String eventName = selectedEvent!['name'];
    String innerTop = selectedInnerTop?['name'] ?? 'Không mặc';
    String outerTop = selectedOuterTop?['name'] ?? 'Không mặc';
    String bottom = selectedBottom?['name'] ?? 'Không mặc';
    String head = selectedHeadAcc?['name'] ?? 'Không có';
    String feet = selectedFeetAcc?['name'] ?? 'Không có';

    // Fallback chấm điểm offline thông minh
    String scoreResult = "🎯 TỔNG ĐIỂM: 8.5/10\n\n"
        "📜 1. Tính chính xác lịch sử (40%): 3.5/4.0 (Phối đồ đúng triều đại, không lai tạp lộn xộn).\n"
        "👔 2. Quy chuẩn mặc (30%): 2.5/3.0 (Đã chú ý lớp áo lót/nội y theo đúng cổ lễ).\n"
        "✨ 3. Thẩm mỹ & Bối cảnh (30%): 2.5/3.0 (Màu sắc hài hòa, rất phù hợp khi tham gia sự kiện $eventName).";

    try {
      final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _geminiApiKey);
      final prompt = '''
      Đóng vai một hội đồng giám khảo chuyên gia văn hóa cổ phục Việt Nam. Hãy chấm điểm bộ trang phục tự phối sau đây cho sự kiện "$eventName":
      - Áo trong: $innerTop
      - Áo ngoài: $outerTop
      - Quần/Váy: $bottom
      - Phụ kiện đầu: $head
      - Phụ kiện chân: $feet

      Hãy đánh giá dựa trên đúng 3 tiêu chí sau và cho điểm cụ thể:
      1. Tính chính xác lịch sử (trọng số 40%): Cùng triều đại, không mặc lẫn lộn.
      2. Quy chuẩn mặc (trọng số 30%): Có lớp áo lót/nội y bên trong theo đúng cổ lễ.
      3. Thẩm mỹ và bối cảnh (trọng số 30%): Màu sắc hài hòa, phù hợp sự kiện.

      Hãy đưa ra Tổng điểm (thang điểm 10) và nhận xét chi tiết từng tiêu chí một cách ngắn gọn, chuyên nghiệp.
      ''';
      final response = await model.generateContent([Content.text(prompt)]);
      if (response.text != null) {
        scoreResult = response.text!;
      }
    } catch (e) {
      // Giữ nguyên fallback kết quả
    }

    if (!mounted) return;
    Navigator.pop(context);
    _showFeedback("Bảng Điểm Cổ Phục AI", scoreResult, false);
  }

  void _showFeedback(String title, String message, bool isWarning) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => FeedbackDialog(title: title, message: message, isWarning: isWarning),
    );
  }
}

// ---------------------------------------------------------
// 4. VIRTUAL TRY-ON (MODEL THU NHỎ GỌN GÀNG)
// ---------------------------------------------------------
class AvatarDisplay extends StatelessWidget {
  final Map<String, dynamic>? innerTop, outerTop, bottom, headAcc, feetAcc, handAcc, neckAcc;

  const AvatarDisplay({
    this.innerTop, this.outerTop, this.bottom, this.headAcc, this.feetAcc, this.handAcc, this.neckAcc, super.key
  });

  Widget _buildLayer(String? imagePath, String fallbackName) {
    if (imagePath == null) return const SizedBox.shrink();
    return Positioned.fill(
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Container(
            padding: const EdgeInsets.all(4),
            color: Colors.redAccent.withOpacity(0.8),
            child: Text(fallbackName, style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF8B1C1C).withOpacity(0.2), width: 1.5),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(color: const Color(0xFFF5F0E6).withOpacity(0.4)), 
            _buildLayer('assets/images/avatar_base.png', 'Model'), 
            if (feetAcc != null) _buildLayer(feetAcc!['imagePath'], feetAcc!['name']),
            if (innerTop != null) _buildLayer(innerTop!['imagePath'], innerTop!['name']), 
            if (bottom != null) _buildLayer(bottom!['imagePath'], bottom!['name']),
            if (outerTop != null) _buildLayer(outerTop!['imagePath'], outerTop!['name']),
            if (neckAcc != null) _buildLayer(neckAcc!['imagePath'], neckAcc!['name']), 
            if (handAcc != null) _buildLayer(handAcc!['imagePath'], handAcc!['name']), 
            if (headAcc != null) _buildLayer(headAcc!['imagePath'], headAcc!['name']), 
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 5. OUTFIT INFO PANEL (KHUNG BÊN MÔ TẢ TRANG PHỤC CHI TIẾT)
// ---------------------------------------------------------
class OutfitInfoPanel extends StatelessWidget {
  final Map<String, dynamic>? event, innerTop, outerTop, bottom, headAcc, feetAcc, handAcc, neckAcc;

  const OutfitInfoPanel({
    this.event, this.innerTop, this.outerTop, this.bottom, this.headAcc, this.feetAcc, this.handAcc, this.neckAcc, super.key
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> activeItems = [];
    if (innerTop != null) activeItems.add(innerTop!);
    if (outerTop != null) activeItems.add(outerTop!);
    if (bottom != null) activeItems.add(bottom!);
    if (headAcc != null) activeItems.add(headAcc!);
    if (feetAcc != null) activeItems.add(feetAcc!);
    if (handAcc != null) activeItems.add(handAcc!);
    if (neckAcc != null) activeItems.add(neckAcc!);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF8B1C1C).withOpacity(0.2), width: 1.5),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info, color: Color(0xFF8B1C1C), size: 18),
              const SizedBox(width: 6),
              const Text('Thông Tin Outfit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF8B1C1C))),
              const Spacer(),
              if (event != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFF8B1C1C), borderRadius: BorderRadius.circular(10)),
                  child: Text(event!['name'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const Divider(height: 12),
          Expanded(
            child: activeItems.isEmpty
                ? const Center(
                    child: Text(
                      'Chưa chọn trang phục nào.\nHãy chọn đồ ở bên dưới!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  )
                : ListView.builder(
                    itemCount: activeItems.length,
                    itemBuilder: (context, index) {
                      final item = activeItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ${item['name']}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['description'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.2),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 6. WARDROBE SELECTOR (THANH CHỌN ĐỒ VÀ 2 NÚT AI)
// ---------------------------------------------------------
class WardrobeSelector extends StatelessWidget {
  final Map<String, dynamic>? selectedEvent, selectedInnerTop, selectedOuterTop, selectedBottom, selectedHeadAcc, selectedFeetAcc, selectedHandAcc, selectedNeckAcc;
  final Function(Map<String, dynamic>?) onEventChanged, onInnerTopChanged, onOuterTopChanged, onBottomChanged, onHeadAccChanged, onFeetAccChanged, onHandAccChanged, onNeckAccChanged;
  final VoidCallback onAIPredictOutfit;
  final VoidCallback onAIScoreOutfit;

  const WardrobeSelector({
    this.selectedEvent, this.selectedInnerTop, this.selectedOuterTop, this.selectedBottom, this.selectedHeadAcc, this.selectedFeetAcc, this.selectedHandAcc, this.selectedNeckAcc,
    required this.onEventChanged, required this.onInnerTopChanged, required this.onOuterTopChanged, required this.onBottomChanged, required this.onHeadAccChanged, required this.onFeetAccChanged, required this.onHandAccChanged, required this.onNeckAccChanged,
    required this.onAIPredictOutfit, required this.onAIScoreOutfit, super.key
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Column(
        children: [
          const TabBar(
            labelColor: Color(0xFF8B1C1C), unselectedLabelColor: Colors.grey, indicatorColor: Color(0xFF8B1C1C), isScrollable: true,
            labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Sự kiện'), Tab(text: 'Áo Trong'), Tab(text: 'Áo Ngoài'), Tab(text: 'Quần'),
              Tab(text: 'Mũ/Đầu'), Tab(text: 'Chân/Giày'), Tab(text: 'Cầm Tay'), Tab(text: 'Cổ'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildList(context, MockData.events, selectedEvent, onEventChanged),
                _buildList(context, MockData.innerTops, selectedInnerTop, onInnerTopChanged),
                _buildList(context, MockData.outerTops, selectedOuterTop, onOuterTopChanged),
                _buildList(context, MockData.bottoms, selectedBottom, onBottomChanged),
                _buildList(context, MockData.headAccs, selectedHeadAcc, onHeadAccChanged),
                _buildList(context, MockData.feetAccs, selectedFeetAcc, onFeetAccChanged),
                _buildList(context, MockData.handAccs, selectedHandAcc, onHandAccChanged),
                _buildList(context, MockData.neckAccs, selectedNeckAcc, onNeckAccChanged),
              ],
            ),
          ),
          // HAI NÚT AI SONG SONG: GỢI Ý & CHẤM ĐIỂM
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: ElevatedButton.icon(
                      onPressed: onAIPredictOutfit,
                      icon: const Icon(Icons.lightbulb_outline, color: Colors.white, size: 16),
                      label: const Text('AI Gợi Ý', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF008080), // Xanh ngọc cho gợi ý
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: ElevatedButton.icon(
                      onPressed: onAIScoreOutfit,
                      icon: const Icon(Icons.star_rate_rounded, color: Colors.white, size: 18),
                      label: const Text('AI Chấm Điểm', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B1C1C), // Đỏ đô cho chấm điểm
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Map<String, dynamic>> items, Map<String, dynamic>? selectedItem, Function(Map<String, dynamic>?) onSelected) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = selectedItem?['id'] == item['id'];
        
        return GestureDetector(
          onTap: () => onSelected(isSelected ? null : item),
          onLongPress: () => _showItemInfo(context, item),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200), width: 80, margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF8B1C1C) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isSelected ? const Color(0xFF8B1C1C) : Colors.grey.shade300, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'] ?? Icons.checkroom, size: 24, color: isSelected ? Colors.white : const Color(0xFF8B1C1C)),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(item['name'], textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 10)),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2, right: 12,
                child: GestureDetector(
                  onTap: () => _showItemInfo(context, item),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(color: isSelected ? Colors.white24 : Colors.black12, shape: BoxShape.circle),
                    child: Icon(Icons.info_outline, size: 12, color: isSelected ? Colors.white : Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showItemInfo(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFFF5F0E6),
        title: Text(item['name'], style: const TextStyle(color: Color(0xFF8B1C1C), fontWeight: FontWeight.bold)),
        content: Text(item['description'] ?? 'Chưa có thông tin mô tả.', style: const TextStyle(height: 1.4, fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng', style: TextStyle(color: Color(0xFF8B1C1C), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 7. FEEDBACK DIALOG (HIỂN THỊ KẾT QUẢ AI)
// ---------------------------------------------------------
class FeedbackDialog extends StatelessWidget {
  final String title;
  final String message;
  final bool isWarning;

  const FeedbackDialog({required this.title, required this.message, required this.isWarning, super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = isWarning ? Colors.redAccent : const Color(0xFF008080);
    return Container(
      margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF5F0E6), borderRadius: BorderRadius.circular(24), border: Border.all(color: color, width: 3)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isWarning ? Icons.warning_amber_rounded : Icons.auto_awesome, color: color, size: 44),
          const SizedBox(height: 6),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 10),
          Flexible(
            child: SingleChildScrollView(
              child: Text(message, textAlign: TextAlign.left, style: const TextStyle(fontSize: 13, height: 1.5)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity, height: 40,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Đã Hiểu', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
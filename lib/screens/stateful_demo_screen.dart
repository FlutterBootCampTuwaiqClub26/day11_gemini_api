import 'package:flutter/material.dart';



// هذه الصفحة تعليمية بحتة، هدفها توضيح مفهوم StatefulWidget للطلاب:
// - StatelessWidget: ما عنده "ذاكرة"، كل مرة يتبنى (build) من جديد بدون أي حالة داخلية.
// - StatefulWidget: عنده كائن State منفصل يعيش معه، وتقدر تغيّر قيم داخله
//   عن طريق setState() فيعيد الفريموورك رسم الواجهة (build) بس القيم تفضل محفوظة.
class StatefulDemoScreen extends StatefulWidget {
  const StatefulDemoScreen({super.key});

  @override
  State<StatefulDemoScreen> createState() => _StatefulDemoScreenState();
}

class _StatefulDemoScreenState extends State<StatefulDemoScreen> {
  // هذي القيم تعيش داخل الـ State، مو داخل الـ Widget نفسه.
  // عشان كذا تفضل محفوظة بين كل عملية setState (rebuild).
  int _counter = 0;
  int _buildCount = 0;

  // هذا الوقت يتسجل مرة وحدة بس، لحظة إنشاء الـ State لأول مرة.
  // نستخدمه عشان نوضح للطلاب إن setState تعيد بناء الواجهة (build)
  // لكن ما تعيد إنشاء الـ State من جديد ولا تصفّر initState.
  final DateTime _stateCreatedAt = DateTime.now();

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // كل مرة تصير setState، دالة build تنفذ من جديد، فنزيد هذا العداد
    // بس بدون setState إضافية (نعتمد إنه نفس build call اللي صار بسبب setState).
    _buildCount++;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مثال StatefulWidget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'العداد (State متغيّرة)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              '$_counter',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrement,
                  child: const Text('-'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _increment,
                  child: const Text('+'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: _reset,
                  child: const Text('تصفير'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 16),
            // هذي البطاقة تعرض معلومات توضح إن build() تتكرر مع كل setState،
            // بينما State نفسه (وبالتالي _stateCreatedAt) ما يتغيّر.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('عدد مرات تنفيذ build(): $_buildCount'),
                    const SizedBox(height: 8),
                    Text(
                      'وقت إنشاء الـ State (ثابت): '
                      '${_stateCreatedAt.hour.toString().padLeft(2, '0')}:'
                      '${_stateCreatedAt.minute.toString().padLeft(2, '0')}:'
                      '${_stateCreatedAt.second.toString().padLeft(2, '0')}',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'لاحظ: مهما ضغطت + أو -، الوقت أعلاه ما يتغيّر لأن '
                      'setState تعيد بناء الواجهة فقط، ولا تعيد إنشاء '
                      'الـ State من جديد.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // مقارنة بسيطة: هذا العنصر StatelessWidget، يستقبل القيمة من
            // الأب (Parent) عن طريق constructor، وما عنده أي حالة داخلية خاصة فيه.
            const StatelessInfoBox(
              label: 'مثال StatelessWidget داخل نفس الصفحة',
              description:
                  'هذا العنصر نفسه ما يقدر يغيّر بياناته لحاله؛ '
                  'أي تغيير لازم يجيه من الأب اللي يستخدم StatefulWidget.',
            ),
          ],
        ),
      ),
    );
  }
}

// StatelessWidget بسيط للمقارنة: بيانات ثابتة تجيه من برا (immutable)،
// وما عنده setState ولا كائن State منفصل.
class StatelessInfoBox extends StatelessWidget {
  final String label;
  final String description;

  const StatelessInfoBox({
    super.key,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(description),
        ],
      ),
    );
  }
}

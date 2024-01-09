import 'package:flutter/material.dart';

class HowBuyData extends StatelessWidget {
  const HowBuyData({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("   Nyein Chan A.V.A Technologies သည် (၂၀၀၁)ခုနှစ်တွင် စတင်တည်ထောင်ခဲ့ပြီး Audio Language Lab. နှင့် ရူပဗေဒ သိပ္ပံလက်တွေ့ သင်ထောက်ကူပစ္စည်းများကိုစတင် ထုတ်လုပ်ဖြန့်ချီခဲ့သည်။ ၂၀၀၁ မှ ၂၀၁၀အတွင်း အထက်မြန်မာပြည်ရှိ တက္ကသိုလ်ကောလိပ်များနှင့် အခြေခံပညာကျောင်းပေါင်းများစွာကို Audio Language Lab. များတပ်ဆင်ပေးနိုင်ခဲ့ပါသည်။ NCAVA မှ တပ်ဆင်ပေးသော Language Lab. များသည် အသံပိုင်းဆိုင်ရာ Quality ကောင်းမွန်ခြင်း ၊ အသုံပြုရတာလွယ်ကူရှင်းလင်းခြင်း၊ After Sale Service ကောင်းခြင်းတို့ကြောင့် အသုံးပြုသော ဆရာ ဆရာမများ၏ ကျေနပ်နှစ်သက်မှုများစွာရရှိခဲ့ပါသည်။",textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("  ပို့ဆောင်ခ နှုန်းထားများ ",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(" မန္တလေး မြို့တွင်း ပုံမှန် delivery - 1,500ကျပ် ",textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0,0 ),
              child: Text("  မန္တလေး မြို့တွင်း Urgent Delivery -2,000 ကျပ် မှ 4,000ကျပ် ",textAlign: TextAlign.center,style: TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0,0 ),
              child: Text(" ကျန်မြို့များ အတွက် ကားဂိတ် တင်ခ (2,000ကျပ်) ကောက်ခံပါမည်။ ",textAlign: TextAlign.center,style: TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0,0 ),
              child: Text(" *** ပစ္စည်းဖိုး ငွေကြိုလွဲရပါမည်။ ပစ္စည်းဖိုးငွေလွဲဝင်ပြီး (၂၄)နာရီအတွင်း စတင်ပို့ဆောင်ပေးပါသည်။ တန်ဆာခကို ပစ္စည်းရောက်မှပေးချေပေးရပါမည်။***",textAlign: TextAlign.center,style: TextStyle(color: Colors.red)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Image.network("https://nyeinchanava.com/wp-content/uploads/2023/10/0-02-06-d5a641b0dee9753f26b4318700a24bbe7147229763a28e9de873f685ea287263_2078c79579590f.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0,0 ),
              child: Text(" ယုံကြည်စွာဝယ်ယူအားပေးမှုအတွက် အထူးကျေးဇူးတင်ရှိပါသည်။",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}

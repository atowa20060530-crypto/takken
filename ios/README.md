# 宅建 出る順（iPhoneアプリ）

とわさん専用の宅建学習アプリです。App Storeには出さず、Xcodeから自分のiPhoneに直接入れます。

## できること

- **出る順**：論点を「類題を含めた過去10年の出題数」で並べ、S/A/B/Cのランクを付けます。問題もこの順で出ます。
- **インプット**：論点ごとの要点と、YouTube解説動画へのボタン。
- **アウトプット**：一問一答（○×）と四肢択一。解説・論点の要点・動画ボタンが答えのすぐ下に出ます。
- **出典表示**：過去問には「令和5年度 問3（肢2）」のような出典と、類題の出題年度（R5・R3…）を表示。年度別にも解けます。
- **復習**：間違えた問題と、復習のタイミングが来た問題（1日→2.5日→6日…と間隔が伸びる）を自動で集めます。
- **記録**：今日の問題数、正答率、連続学習日数、直近14日のグラフ、科目別の正答率。

## iPhoneに入れる手順（無料のApple IDの場合）

1. Macで `TakkenApp.xcodeproj` をダブルクリックしてXcodeで開く。
2. Xcodeのメニュー「Xcode → Settings → Accounts」で、左下の「＋」からApple IDを追加する。
3. 左の一覧で一番上の「TakkenApp」→ TARGETSの「TakkenApp」→「Signing & Capabilities」タブを開き、Teamで「（自分の名前）(Personal Team)」を選ぶ。
   - 「Bundle Identifier が使えない」と出たら、`com.towa.takkenderujun` の末尾に数字を足す（例：`com.towa.takkenderujun2`）。
4. iPhoneをUSBケーブルでMacにつなぎ、iPhoneに出る「このコンピュータを信頼しますか？」で「信頼」。
5. iPhoneの「設定 → プライバシーとセキュリティ → デベロッパモード」をオンにして再起動する（初回だけ）。
6. Xcode上部の実行先で自分のiPhoneを選び、▶（Run）を押す。
7. 初回は「信頼されていないデベロッパ」と出るので、iPhoneの「設定 → 一般 → VPNとデバイス管理」で自分のApple IDを「信頼」してからアプリを開く。

### 7日ごとの入れ直し

無料のApple IDだと、入れたアプリは7日で起動できなくなります。iPhoneをつないでもう一度 ▶ を押せば直ります（アプリを削除しなければ学習記録は残ります）。
Apple Developer Program（年12,800円）に登録すると、1年間入れ直し不要になり、TestFlightでケーブルなしの更新もできます。

## 問題・論点の追加

`TakkenApp/Data/` の2つのJSONを編集します。

- `topics.json`：論点。`estimatedCount` が出る順の元になる「類題を含めた過去10年の出題数」。`videoURL` に特定の動画URL（`&t=120` で開始位置指定も可）を入れると、検索ではなくその動画が開きます。
- `questions.json`：問題。過去問なら出典と類題を入れます。

```json
{
  "id": "r5-03-2",
  "topicId": "gyo-35",
  "kind": "tf",
  "text": "（問題文）",
  "answer": false,
  "explanation": "（解説）",
  "source": { "year": 2023, "number": 3, "choice": 2 },
  "similar": [ { "year": 2021, "number": 35, "choice": 1 }, { "year": 2019, "number": 41, "choice": 3 } ]
}
```

`year` は西暦（2023＝令和5年度）。四肢択一は `"kind": "mc"` にして `choices`（4つ）と `answerIndex`（0始まり）を入れます。

## 今のデータについて

- 収録しているのは主要27論点・49問のオリジナル問題です。過去問本文はまだ入っていません。
- 出る順の出題数（`estimatedCount`）は過去10年の傾向から置いた目安です。過去問データを取り込んだら実数に置き換えます。
- 動画ボタンは今はYouTube検索を開きます。おすすめ動画が決まったら `videoURL` に入れてください。

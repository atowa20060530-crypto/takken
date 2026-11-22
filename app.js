"use strict";

/* ================= Icons (SF Symbols風) ================= */
const S = (body, fill = false) =>
  `<svg viewBox="0 0 24 24" fill="${fill ? "currentColor" : "none"}" stroke="${fill ? "none" : "currentColor"}" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round">${body}</svg>`;
const I = {
  house: S('<path d="M3.5 11 12 4l8.5 7"/><path d="M5.5 9.5V20h4.5v-5.5h4V20h4.5V9.5"/>'),
  houseFill: S('<path d="M12 3.2 2.6 11a1 1 0 0 0 1.3 1.5l.9-.8V20a1 1 0 0 0 1 1h4.2v-6h4v6h4.2a1 1 0 0 0 1-1v-8.3l.9.8a1 1 0 0 0 1.3-1.5Z"/>', true),
  listNumber: S('<path d="M10 6h10M10 12h10M10 18h10"/><path d="M4 4.5 5.2 4v4M3.8 10.6c.3-.6 2-.9 2 .3 0 .9-2 1.6-2 3h2.2M3.9 16.3c.6-.6 2-.4 2 .5s-1.1.7-1.1.7.9 0 1.1.8c.1 1-1.6 1.2-2.1.5"/>'),
  pencilSquare: S('<path d="M11 4H6a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-5"/><path d="M18.4 3.6a2 2 0 0 1 2.9 2.9L12.5 15.3 9 16l.7-3.5Z"/>'),
  chartBar: S('<path d="M3 20h18"/><path d="M6 16v-4M10.5 16V8M15 16v-6M19.5 16V5"/>'),
  building: S('<path d="M4 21V6l7-3v18M11 21V9l9 3v9M3 21h18M7 8v.01M7 12v.01M7 16v.01M14.5 14v.01M17 14v.01M14.5 17.5v.01M17 17.5v.01"/>'),
  scale: S('<path d="M12 3v18M7 21h10M4 7h16M6.5 7 3.5 14a3 3 0 0 0 6 0Zm11 0-3 7a3 3 0 0 0 6 0Z"/>'),
  map: S('<path d="m3 6 6-2.5 6 2.5 6-2.5v14.5L15 20.5 9 18l-6 2.5Z"/><path d="M9 3.5V18M15 6v14.5"/>'),
  yen: S('<circle cx="12" cy="12" r="9"/><path d="m8.5 7 3.5 5 3.5-5M12 12v5.5M9 12.5h6M9 15h6"/>'),
  calendar: S('<rect x="3.5" y="5" width="17" height="15.5" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/>'),
  sparkles: S('<path d="M10 3.5 11.6 8.4 16.5 10 11.6 11.6 10 16.5 8.4 11.6 3.5 10 8.4 8.4Z"/><path d="M18 14.5l.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8Z"/>'),
  checkFill: S('<path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20Zm4.7 7.2-5.5 6.2a1 1 0 0 1-1.5 0l-2.6-2.8a1 1 0 1 1 1.5-1.4l1.9 2 4.7-5.3a1 1 0 0 1 1.5 1.3Z"/>', true),
  xFill: S('<path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20Zm3.5 12.1a1 1 0 0 1-1.4 1.4L12 13.4l-2.1 2.1a1 1 0 0 1-1.4-1.4l2.1-2.1-2.1-2.1a1 1 0 0 1 1.4-1.4l2.1 2.1 2.1-2.1a1 1 0 0 1 1.4 1.4L13.4 12Z"/>', true),
  circle: S('<circle cx="12" cy="12" r="9.2"/>'),
  playCircleFill: S('<path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20Zm-2 6.3 6 3.7-6 3.7Z"/>', true),
  counterFill: S('<path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20Zm0 15a5 5 0 0 1-4.6-3 1 1 0 1 1 1.8-.8A3 3 0 1 0 12 9h-.6l.9.9a1 1 0 0 1-1.4 1.4L8.3 8.7a1 1 0 0 1 0-1.4l2.6-2.6a1 1 0 0 1 1.4 1.4L11.4 7H12a5 5 0 0 1 0 10Z"/>', true),
  chevR: S('<path d="m9 5 7 7-7 7"/>'),
  chevL: S('<path d="m15 4.5-7.5 7.5 7.5 7.5"/>'),
  playRectFill: S('<path d="M5 4.5h14A3 3 0 0 1 22 7.5v9a3 3 0 0 1-3 3H5a3 3 0 0 1-3-3v-9a3 3 0 0 1 3-3Zm5 4v7l6-3.5Z"/>', true),
  pencil: S('<path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L8 18l-4 1 1-4Z"/>'),
  flame: S('<path d="M12 2.5c1 3.5 5.5 5.5 5.5 11a5.5 5.5 0 0 1-11 0c0-2.6 1.3-4.3 2.4-5.4.3 1.4.9 2.5 1.9 3.1C10.5 8 11 5 12 2.5Z"/>', true),
  counter: S('<path d="M4.5 12a7.5 7.5 0 1 0 2.3-5.4"/><path d="M4 4v4.5h4.5"/>'),
  shuffle: S('<path d="M3 7h3.5c4.5 0 6.5 10 11 10H21M3 17h3.5c1.8 0 3.1-1.5 4.2-3.3M13.3 10.3C14.4 8.5 15.7 7 17.5 7H21M18.5 4.5 21 7l-2.5 2.5M18.5 14.5 21 17l-2.5 2.5"/>'),
  circleCircle: S('<circle cx="12" cy="12" r="9.2"/><circle cx="12" cy="12" r="4.5"/>'),
  listRect: S('<rect x="2.5" y="4" width="19" height="16" rx="3"/><path d="M10 9h8M10 15h8M6.5 9v.01M6.5 15v.01"/>'),
  xmark: S('<path d="M6 6l12 12M18 6 6 18" stroke-width="2.4"/>'),
  sealFill: S('<path d="M12 1.8l2.4 1.8 3-.1.9 2.8 2.5 1.7-1 2.9 1 2.9-2.5 1.7-.9 2.8-3-.1L12 20.2l-2.4-1.8-3 .1-.9-2.8-2.5-1.7 1-2.9-1-2.9 2.5-1.7.9-2.8 3 .1Zm3.6 7.4a1 1 0 0 0-1.4.1l-3.1 3.7-1.5-1.4A1 1 0 1 0 8.2 13l2.3 2.2a1 1 0 0 0 1.5-.1l3.8-4.5a1 1 0 0 0-.2-1.4Z"/>', true),
};

/* ================= Data ================= */
const SUBJECTS = [
  { key: "宅建業法", short: "業法", exam: 20, order: 0, color: "var(--c-gyoho)", icon: I.building },
  { key: "権利関係", short: "権利", exam: 14, order: 1, color: "var(--c-kenri)", icon: I.scale },
  { key: "法令上の制限", short: "法令", exam: 8, order: 2, color: "var(--c-horei)", icon: I.map },
  { key: "税・その他", short: "税他", exam: 8, order: 3, color: "var(--c-zei)", icon: I.yen },
];
const SUBJ = Object.fromEntries(SUBJECTS.map((s) => [s.key, s]));

const grade = (count) => (count >= 20 ? "S" : count >= 10 ? "A" : count >= 6 ? "B" : "C");
const GRADE_CAPTION = { S: "毎年複数問", A: "ほぼ毎年", B: "よく出る", C: "ときどき" };
const GRADE_COLOR = { S: "var(--g-s)", A: "var(--g-a)", B: "var(--g-b)", C: "var(--g-c)" };

const wareki = (y) => (y >= 2019 ? (y - 2018 === 1 ? "令和元年度" : `令和${y - 2018}年度`) : `平成${y - 1988}年度`);
const shortEra = (p) => (p.year >= 2019 ? `R${p.year - 2018}` : `H${p.year - 1988}`);
const srcLabel = (p) => `${wareki(p.year)} 問${p.number}` + (p.choice != null ? `（肢${p.choice}）` : "");

function youtubeURL(t) {
  if (t.videoURL) return t.videoURL;
  return "https://www.youtube.com/results?search_query=" + encodeURIComponent(t.videoQuery);
}
const options = (q) => (q.kind === "tf" ? ["○", "×"] : q.choices || []);
const correctIndex = (q) => (q.kind === "tf" ? (q.answer !== false ? 0 : 1) : q.answerIndex || 0);
const askedYears = (q) => {
  const s = new Set((q.similar || []).map((p) => p.year));
  if (q.source) s.add(q.source.year);
  return s;
};

/* ================= Store ================= */
const store = {
  topics: [],
  questions: [],
  rankedTopics: [],
  rankedQuestions: [],
  topicByID: {},
  rankByTopic: {},
  records: {},
  daily: {},

  init(topics, questions) {
    this.topics = topics;
    this.questions = questions;
    this.rankedTopics = [...topics].sort((a, b) => {
      if (a.estimatedCount !== b.estimatedCount) return b.estimatedCount - a.estimatedCount;
      if (SUBJ[a.subject].order !== SUBJ[b.subject].order) return SUBJ[a.subject].order - SUBJ[b.subject].order;
      return a.id < b.id ? -1 : a.id > b.id ? 1 : 0;
    });
    this.rankedTopics.forEach((t, i) => (this.rankByTopic[t.id] = i + 1));
    topics.forEach((t) => (this.topicByID[t.id] ??= t));
    const rank = this.rankByTopic;
    this.rankedQuestions = [...questions].sort((a, b) => {
      const ra = rank[a.topicId] ?? Infinity, rb = rank[b.topicId] ?? Infinity;
      if (ra !== rb) return ra - rb;
      const ya = askedYears(a).size, yb = askedYears(b).size;
      if (ya !== yb) return yb - ya;
      return a.id < b.id ? -1 : a.id > b.id ? 1 : 0;
    });
    this.load();
  },

  topicFor(q) { return this.topicByID[q.topicId]; },
  rank(t) { return this.rankByTopic[t.id] || 0; },
  questionsFor(t) { return this.rankedQuestions.filter((q) => q.topicId === t.id); },
  questionsSubject(s) { return this.rankedQuestions.filter((q) => this.topicByID[q.topicId]?.subject === s); },
  questionsYear(y) {
    return this.rankedQuestions
      .filter((q) => q.source?.year === y)
      .sort((a, b) => (a.source.number - b.source.number) || ((a.source.choice || 0) - (b.source.choice || 0)));
  },
  questionsKind(k) { return this.rankedQuestions.filter((q) => q.kind === k); },
  get pastYears() {
    return [...new Set(this.questions.filter((q) => q.source).map((q) => q.source.year))].sort((a, b) => b - a);
  },

  isPending(q, now) {
    const r = this.records[q.id];
    if (!r) return null;
    if (!r.lastCorrect) return true;
    if (r.due) return new Date(r.due) <= now;
    return false;
  },
  get reviewQueue() {
    const now = new Date();
    return this.rankedQuestions.filter((q) => this.isPending(q, now) === true);
  },
  nextSet(count) {
    const now = new Date();
    const pending = this.rankedQuestions.filter((q) => this.isPending(q, now) !== false);
    return (pending.length ? pending : this.rankedQuestions).slice(0, count);
  },
  status(q) {
    const r = this.records[q.id];
    return r ? r.lastCorrect : null;
  },
  mastery(t) {
    const qs = this.questionsFor(t);
    if (!qs.length) return 0;
    return qs.filter((q) => this.records[q.id]?.lastCorrect === true).length / qs.length;
  },

  record(q, correct) {
    const r = this.records[q.id] || { attempts: 0, correct: 0, lastCorrect: false, interval: 0 };
    r.attempts += 1;
    if (correct) {
      r.correct += 1;
      r.interval = r.interval < 1 ? 1 : Math.min(r.interval * 2.5, 60);
    } else {
      r.interval = 0;
    }
    r.lastCorrect = correct;
    r.lastAt = new Date().toISOString();
    r.due = new Date(Date.now() + Math.floor(r.interval * 24 * 60) * 60000).toISOString();
    this.records[q.id] = r;
    const key = dayKey(new Date());
    const d = this.daily[key] || { answered: 0, correct: 0 };
    d.answered += 1;
    if (correct) d.correct += 1;
    this.daily[key] = d;
    this.save();
  },
  reset() { this.records = {}; this.daily = {}; this.save(); },

  get totalAnswered() { return Object.values(this.daily).reduce((a, d) => a + d.answered, 0); },
  get totalCorrect() { return Object.values(this.daily).reduce((a, d) => a + d.correct, 0); },
  get todayAnswered() { return this.daily[dayKey(new Date())]?.answered || 0; },
  get accuracyText() {
    if (!this.totalAnswered) return "–";
    return Math.round((this.totalCorrect / this.totalAnswered) * 100) + "%";
  },
  get streak() {
    const day = new Date();
    if (!(this.daily[dayKey(day)]?.answered > 0)) day.setDate(day.getDate() - 1);
    let n = 0;
    while (this.daily[dayKey(day)]?.answered > 0) { n++; day.setDate(day.getDate() - 1); }
    return n;
  },
  get last14Days() {
    const out = [];
    const today = new Date(); today.setHours(0, 0, 0, 0);
    for (let off = 13; off >= 0; off--) {
      const d = new Date(today); d.setDate(d.getDate() - off);
      out.push({ date: d, count: this.daily[dayKey(d)]?.answered || 0 });
    }
    return out;
  },
  subjectStats(s) {
    let a = 0, c = 0;
    for (const q of this.questionsSubject(s)) {
      const r = this.records[q.id];
      if (r) { a += r.attempts; c += r.correct; }
    }
    return { answered: a, correct: c };
  },
  get masteredTopics() { return this.topics.filter((t) => this.mastery(t) >= 0.999).length; },

  save() {
    try { localStorage.setItem("takken-progress", JSON.stringify({ records: this.records, daily: this.daily })); } catch (e) {}
  },
  load() {
    try {
      const s = JSON.parse(localStorage.getItem("takken-progress") || "null");
      if (s) { this.records = s.records || {}; this.daily = s.daily || {}; }
    } catch (e) {}
  },
};

function dayKey(d) {
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
}
const esc = (s) => String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

/* ================= Components ================= */
const gradeBadge = (g) => `<span class="grade rounded" style="background:${GRADE_COLOR[g]}">${g}</span>`;
const subjectTag = (s) => `<span class="subj" style="color:${SUBJ[s].color}">${SUBJ[s].icon}${esc(s)}</span>`;
const progressBar = (v, color = "var(--accent)") =>
  `<div class="progress"><i style="width:${Math.max(0, Math.min(1, v)) * 100}%;background:${color}"></i></div>`;
const stat = (v, l) => `<div class="stat"><div class="v rounded">${esc(v)}</div><div class="l">${esc(l)}</div></div>`;

function sourceBadge(q) {
  let h = `<div class="src">`;
  h += q.source
    ? `<span class="lbl">${I.calendar}${esc(srcLabel(q.source))}</span>`
    : `<span class="lbl">${I.sparkles}オリジナル問題</span>`;
  if (q.similar && q.similar.length) h += `<span>類題 ${q.similar.map(shortEra).join("・")}</span>`;
  return h + `</div>`;
}

function topicRow(t) {
  const g = grade(t.estimatedCount);
  return `<div class="topic-row">
    <div class="rank rounded">${store.rank(t)}</div>
    <div class="body">
      <div class="t">${esc(t.title)}</div>
      <div class="meta">${subjectTag(t.subject)}<span class="caption2 secondary">約${t.estimatedCount}問/10年</span></div>
      ${progressBar(store.mastery(t), SUBJ[t.subject].color)}
    </div>
    ${gradeBadge(g)}
  </div>`;
}

function questionRow(q) {
  const st = store.status(q);
  const icon = st === true ? `<span style="color:var(--good)">${I.checkFill}</span>`
    : st === false ? `<span style="color:var(--bad)">${I.xFill}</span>`
    : `<span class="tertiary">${I.circle}</span>`;
  return `<div class="card qrow"><div class="st">${icon}</div>
    <div class="stack" style="gap:4px;min-width:0"><div class="qt">${esc(q.text)}</div>${sourceBadge(q)}</div></div>`;
}

function launcher(title, icon, detail, action, tint = "var(--accent)") {
  return `<button class="row" style="--inset:56px" data-act="launch" data-launch="${esc(action)}" data-title="${esc(title)}">
    <span class="ic" style="color:${tint}">${icon}</span>
    <span class="txt"><span>${esc(title)}</span><span class="caption secondary">${esc(detail)}</span></span>
    <span class="chev">${I.chevR}</span>
  </button>`;
}

function largeNav(title) {
  return `<div class="navbar"><div class="bar"><div class="title inline-title-small">${esc(title)}</div></div></div>`;
}
function inlineNav(title, backTitle) {
  return `<div class="navbar inline"><div class="bar">
    <div class="left"><button class="back" data-act="back">${I.chevL}<span>${esc(backTitle)}</span></button></div>
    <div class="title">${esc(title)}</div></div></div>`;
}

/* ================= Navigation state ================= */
const TABS = [
  { key: "home", label: "ホーム", icon: I.house, iconOn: I.houseFill, title: "宅建 出る順" },
  { key: "ranking", label: "出る順", icon: I.listNumber, title: "出る順" },
  { key: "practice", label: "問題", icon: I.pencilSquare, title: "問題" },
  { key: "stats", label: "記録", icon: I.chartBar, title: "記録" },
];
const ui = {
  tab: "home",
  stacks: { home: [], ranking: [], practice: [], stats: [] }, // pushed topic ids
  filter: null,
  quiz: null,
  confirmReset: false,
  pushedAnim: false,
};

/* ================= Screens ================= */
function homeScreen() {
  const rq = store.reviewQueue;
  const top = store.rankedTopics.slice(0, 5);
  return `${largeNav("宅建 出る順")}<div class="scroll"><div class="large-title">宅建 出る順</div>
  <div class="home">
    <div class="card stat-row">${stat(String(store.todayAnswered), "今日の問題")}<div class="vdiv"></div>${stat(store.accuracyText, "正答率")}<div class="vdiv"></div>${stat(store.streak + "日", "連続学習")}</div>
    <button class="start" data-act="launch" data-launch="next10" data-title="出る順で10問">
      <div style="flex:1"><div class="t">出る順で10問</div><div class="s">よく出る論点の、まだ解いていない・間違えた問題から</div></div>
      ${I.playCircleFill}
    </button>
    ${rq.length ? `<button class="card review" data-act="launch" data-launch="review" data-title="復習">
      <span class="big">${I.counterFill}</span>
      <span class="stack" style="flex:1;gap:2px"><span class="headline">復習 ${rq.length}問</span><span class="caption secondary">間違えた問題・復習のタイミングが来た問題</span></span>
      <span class="chev">${I.chevR}</span></button>` : ""}
    <div class="stack" style="gap:10px">
      <div class="headline">出る順トップ5</div>
      <div class="toplist">${top.map((t) => `<button class="item" data-act="topic" data-id="${t.id}">${topicRow(t)}<span class="chev">${I.chevR}</span></button>`).join("")}</div>
    </div>
  </div></div>`;
}

function rankingScreen() {
  const topics = store.rankedTopics.filter((t) => ui.filter == null || t.subject === ui.filter);
  const seg = [`<button class="${ui.filter == null ? "on" : ""}" data-act="filter" data-v="">すべて</button>`]
    .concat(SUBJECTS.map((s) => `<button class="${ui.filter === s.key ? "on" : ""}" data-act="filter" data-v="${s.key}">${s.short}</button>`))
    .join("");
  return `${largeNav("出る順")}<div class="scroll"><div class="large-title">出る順</div><div class="list">
    <div class="section"><div class="seg">${seg}</div></div>
    <div class="section"><div class="rows">${topics.map((t) => `<button class="row" style="--inset:60px" data-act="topic" data-id="${t.id}">${topicRow(t)}<span class="chev">${I.chevR}</span></button>`).join("")}</div>
    <div class="section-footer">類題を含めた過去10年の出題数（目安）が多い順。S＝毎年複数問、A＝ほぼ毎年、B＝よく出る、C＝ときどき。</div></div>
  </div></div>`;
}

function topicScreen(t, backTitle) {
  const qs = store.questionsFor(t);
  const g = grade(t.estimatedCount);
  return `${inlineNav(t.title, backTitle)}<div class="scroll"><div class="detail">
    <div class="stack" style="gap:8px">
      <div style="display:flex;align-items:center;gap:8px">${gradeBadge(g)}<span class="subheadline semibold" style="flex:1">出る順 ${store.rank(t)}位 · ${GRADE_CAPTION[g]}</span>${subjectTag(t.subject)}</div>
      <div>${esc(t.summary)}</div>
      <div class="caption secondary">類題を含む過去10年の出題：約${t.estimatedCount}問（目安）</div>
    </div>
    <div class="card stack" style="gap:10px"><div class="headline">要点</div>
      ${t.points.map((p) => `<div class="point">${I.checkFill}<span>${esc(p)}</span></div>`).join("")}</div>
    <div class="btn2">
      <button class="yt" data-act="yt" data-id="${t.id}">${I.playRectFill}解説動画</button>
      <button class="go" data-act="launch" data-launch="topic:${t.id}" data-title="${esc(t.title)}" ${qs.length ? "" : "disabled"}>${I.pencil}${qs.length}問解く</button>
    </div>
    <div class="headline" style="padding-top:4px">問題</div>
    ${qs.map(questionRow).join("")}
  </div></div>`;
}

function practiceScreen() {
  const years = store.pastYears;
  return `${largeNav("問題")}<div class="scroll"><div class="large-title">問題</div><div class="list">
    <div class="section"><div class="section-header">おすすめ</div><div class="rows">
      ${launcher("出る順で10問", I.flame, "未回答・間違えた問題を出る順に", "next10")}
      ${launcher("復習", I.counter, `${store.reviewQueue.length}問`, "review")}
      ${launcher("ランダム10問", I.shuffle, `全${store.questions.length}問から`, "random10")}
    </div></div>
    <div class="section"><div class="section-header">科目別（出る順）</div><div class="rows">
      ${SUBJECTS.map((s) => launcher(s.key, s.icon, `${store.questionsSubject(s.key).length}問 · 本試験${s.exam}問`, "subject:" + s.key, s.color)).join("")}
    </div></div>
    <div class="section"><div class="section-header">年度別（過去問）</div><div class="rows">
      ${years.length
        ? years.map((y) => launcher(wareki(y), I.calendar, `${store.questionsYear(y).length}問`, "year:" + y)).join("")
        : `<div class="row footnote secondary">過去問データを取り込むと、年度ごとに解けるようになります。</div>`}
    </div></div>
    <div class="section"><div class="section-header">形式</div><div class="rows">
      ${launcher("一問一答（○×）", I.circleCircle, `${store.questionsKind("tf").length}問`, "kind:tf")}
      ${launcher("四肢択一", I.listRect, `${store.questionsKind("mc").length}問`, "kind:mc")}
    </div></div>
  </div></div>`;
}

function chartSVG(days) {
  const W = 320, H = 160, padR = 28, padB = 18;
  const max = Math.max(1, ...days.map((d) => d.count));
  const nice = max <= 4 ? 4 : Math.ceil(max / 5) * 5;
  const step = (W - padR) / days.length;
  const bw = step * 0.62;
  let g = "";
  for (let i = 0; i <= 4; i++) {
    const v = (nice / 4) * i;
    const y = H - padB - ((H - padB - 6) * i) / 4;
    g += `<line x1="0" x2="${W - padR}" y1="${y}" y2="${y}" stroke="var(--separator)" stroke-width="0.5" ${i ? 'stroke-dasharray="2 2"' : ""}/>`;
    g += `<text x="${W - padR + 6}" y="${y + 3}">${Number.isInteger(v) ? v : v.toFixed(1)}</text>`;
  }
  days.forEach((d, i) => {
    const h = ((H - padB - 6) * d.count) / nice;
    const x = i * step + (step - bw) / 2;
    if (d.count > 0) g += `<rect x="${x}" y="${H - padB - h}" width="${bw}" height="${h}" rx="4" fill="var(--accent)"/>`;
    if (i % 3 === 1) g += `<text x="${x + bw / 2}" y="${H - 4}" text-anchor="middle">${d.date.getMonth() + 1}/${d.date.getDate()}</text>`;
  });
  return `<svg viewBox="0 0 ${W} ${H}" preserveAspectRatio="none">${g}</svg>`;
}

function statsScreen() {
  return `${largeNav("記録")}<div class="scroll"><div class="large-title">記録</div><div class="list">
    <div class="section"><div class="rows"><div class="row stat-row" style="padding:17px 16px">
      ${stat(String(store.totalAnswered), "解いた数")}${stat(store.accuracyText, "正答率")}${stat(store.streak + "日", "連続学習")}
    </div></div></div>
    <div class="section"><div class="section-header">直近14日</div><div class="rows"><div class="row"><div class="chart" style="width:100%">${chartSVG(store.last14Days)}</div></div></div></div>
    <div class="section"><div class="section-header">科目別の正答率</div><div class="rows">
      ${SUBJECTS.map((s) => {
        const st = store.subjectStats(s.key);
        const txt = st.answered === 0 ? "未着手" : `${Math.round((st.correct / st.answered) * 100)}%（${st.correct}/${st.answered}）`;
        return `<div class="row"><div class="subrow"><div class="top">${subjectTag(s.key)}<span class="caption secondary mono">${txt}</span></div>
          ${progressBar(st.answered ? st.correct / st.answered : 0, s.color)}</div></div>`;
      }).join("")}
    </div></div>
    <div class="section"><div class="section-header">論点の習得</div><div class="rows"><div class="row">
      <span style="flex:1">全問正解した論点</span><span class="secondary mono">${store.masteredTopics} / ${store.topics.length}</span></div></div></div>
    <div class="section"><div class="rows"><button class="row danger" data-act="askreset">学習記録をリセット</button></div></div>
  </div></div>`;
}

/* ================= Quiz ================= */
function startQuiz(title, questions) {
  if (!questions.length && title !== "出る順で10問") return;
  ui.quiz = { title, items: questions.slice(), index: 0, picked: null, results: {}, finished: false, showPoints: false, fresh: true };
  render();
}

function quizScreen() {
  const z = ui.quiz;
  const done = z.finished || !z.items.length;
  const center = done ? esc(z.title) : `<span class="mono">${z.index + 1} / ${z.items.length}</span>`;
  const nav = `<div class="navbar inline"><div class="bar">
    <div class="left"><button class="xbtn" data-act="closequiz" aria-label="閉じる">${I.xmark}</button></div>
    <div class="title" style="font-size:15px">${center}</div></div></div>`;
  return `<div class="cover${z.fresh ? "" : " no-anim"}">${nav}${done ? resultView() : questionView(z.items[z.index])}</div>`;
}

function fillColor(q, i) {
  const z = ui.quiz;
  if (z.picked == null) return "var(--card)";
  if (i === correctIndex(q)) return "rgba(33,158,97,.15)";
  if (i === z.picked) return "rgba(219,69,69,.12)";
  return "var(--card)";
}
function fgColor(q, i) {
  const z = ui.quiz;
  if (z.picked == null) return "var(--label)";
  if (i === correctIndex(q)) return "var(--good)";
  if (i === z.picked) return "var(--bad)";
  return "var(--secondary)";
}
function borderColor(q, i) {
  const z = ui.quiz;
  if (z.picked == null) return "rgba(142,142,147,.2)";
  if (i === correctIndex(q)) return "var(--good)";
  if (i === z.picked) return "var(--bad)";
  return "rgba(142,142,147,.2)";
}

function questionView(q) {
  const z = ui.quiz;
  const t = store.topicFor(q);
  let opts;
  if (q.kind === "tf") {
    opts = `<div class="tf">${[0, 1].map((i) => `<button data-act="answer" data-i="${i}" style="background:${fillColor(q, i)};color:${fgColor(q, i)};border-color:${borderColor(q, i)}">
      <span class="mark rounded">${i === 0 ? "○" : "×"}</span><span class="cap">${i === 0 ? "正しい" : "誤り"}</span></button>`).join("")}</div>`;
  } else {
    opts = `<div class="mc">${options(q).map((o, i) => {
      const bc = borderColor(q, i);
      return `<button data-act="answer" data-i="${i}" style="background:${fillColor(q, i)};color:${fgColor(q, i)};border-color:${bc}">
        <span class="num rounded" style="background:color-mix(in srgb, ${bc} 25%, transparent)">${i + 1}</span>
        <span class="opt">${esc(o)}</span>
        ${z.picked != null && i === correctIndex(q) ? `<span class="ok">${I.checkFill}</span>` : ""}</button>`;
    }).join("")}</div>`;
  }
  let expl = "";
  if (z.picked != null) {
    const ok = z.picked === correctIndex(q);
    expl = `<div class="card expl">
      <div class="res" style="color:${ok ? "var(--good)" : "var(--bad)"}">${ok ? I.checkFill : I.xFill}${ok ? "正解" : "不正解"}</div>
      <div class="subheadline semibold">${q.kind === "tf" ? "答え：" + (q.answer === true ? "○ 正しい" : "× 誤り") : "答え：" + (correctIndex(q) + 1)}</div>
      <div class="callout">${esc(q.explanation)}</div>
      ${t ? `<hr>
        <button class="disc${z.showPoints ? " open" : ""}" data-act="togglepoints"><span>論点の要点：${esc(t.title)}</span>${I.chevR}</button>
        ${z.showPoints ? `<div class="disc-body">${t.points.map((p) => `<div>・${esc(p)}</div>`).join("")}</div>` : ""}
        <button class="ytlink" data-act="yt" data-id="${t.id}">${I.playRectFill}YouTubeで解説を見る</button>` : ""}
    </div>`;
  }
  const g = t ? grade(t.estimatedCount) : null;
  return `<div class="scroll" id="quizscroll"><div class="quiz">
    ${progressBar(z.index / Math.max(z.items.length, 1))}
    ${t ? `<div class="crumb">${gradeBadge(g)}<span>出る順 ${store.rank(t)}位 · ${esc(t.title)}</span></div>` : ""}
    ${sourceBadge(q)}
    <div class="qtext">${esc(q.text)}</div>
    ${opts}
    ${expl}
  </div></div>
  ${z.picked != null ? `<div class="bottom-bar"><button class="primary" data-act="next">${z.index + 1 < z.items.length ? "次へ" : "結果を見る"}</button></div>` : ""}`;
}

function resultView() {
  const z = ui.quiz;
  const correct = z.items.filter((q) => z.results[q.id] === true).length;
  const wrong = z.items.filter((q) => z.results[q.id] === false);
  const total = z.items.length;
  let mid;
  if (!total) {
    mid = `<div style="width:64px;height:64px;color:var(--accent)">${I.sealFill}</div><div class="headline">いま解く問題はありません</div>`;
  } else {
    const r = 83, C = 2 * Math.PI * r, frac = correct / total;
    mid = `<div class="ring"><svg viewBox="0 0 180 180">
      <circle cx="90" cy="90" r="${r}" fill="none" stroke="rgba(15,120,107,.15)" stroke-width="14"/>
      <circle cx="90" cy="90" r="${r}" fill="none" stroke="var(--accent)" stroke-width="14" stroke-linecap="round" stroke-dasharray="${C * frac} ${C}" ${frac === 0 ? 'stroke-opacity="0"' : ""}/></svg>
      <div class="c"><div class="n rounded">${correct}/${total}</div><div class="subheadline secondary">正解</div></div></div>
      <div class="headline" style="text-align:center">${message(correct, total)}</div>`;
  }
  return `<div class="result"><div class="sp"></div>${mid}<div class="sp"></div>
    <div class="acts">
      ${wrong.length ? `<button class="primary" data-act="retry">間違えた${wrong.length}問を解き直す</button>` : ""}
      <button class="secondary-btn" data-act="closequiz">終わる</button>
    </div></div>`;
}

function message(c, t) {
  const r = c / Math.max(t, 1);
  if (r === 1) return "全問正解！この調子";
  if (r >= 0.7) return "合格ライン。間違いだけ見直そう";
  if (r >= 0.4) return "あと一歩。要点と動画で確認しよう";
  return "まずは要点を読んでから再挑戦";
}

/* ================= Render ================= */
const app = document.getElementById("app");
const scrollMemo = {};

function screenFor(tab) {
  const st = ui.stacks[tab];
  if (st.length) {
    const t = store.topicByID[st[st.length - 1]];
    const prevTitle = st.length > 1 ? store.topicByID[st[st.length - 2]].title : TABS.find((x) => x.key === tab).title;
    return topicScreen(t, prevTitle);
  }
  return { home: homeScreen, ranking: rankingScreen, practice: practiceScreen, stats: statsScreen }[tab]();
}

function render() {
  // remember scroll positions
  app.querySelectorAll(".tabpane").forEach((p) => {
    const sc = p.querySelector(".scroll");
    if (sc) scrollMemo[p.dataset.tab + ":" + ui.stacks[p.dataset.tab].length] = sc.scrollTop;
  });
  const qs = document.getElementById("quizscroll");
  const quizScroll = qs ? qs.scrollTop : 0;

  let h = "";
  for (const t of TABS) {
    const pushed = ui.pushedAnim === t.key;
    h += `<div class="tabpane${ui.tab === t.key ? " active" : ""}" data-tab="${t.key}"><div class="screen${pushed ? " push-in" : ""}">${screenFor(t.key)}</div></div>`;
  }
  h += `<nav class="tabbar">${TABS.map((t) => `<button class="${ui.tab === t.key ? "on" : ""}" data-act="tab" data-tab="${t.key}">${ui.tab === t.key && t.iconOn ? t.iconOn : t.icon}<span>${t.label}</span></button>`).join("")}</nav>`;
  if (ui.quiz) h += quizScreen();
  if (ui.confirmReset) {
    h += `<div class="sheet-wrap" data-act="cancelreset"><div class="sheet">
      <div class="grp"><div class="ttl">学習記録をすべて消去しますか？</div><button class="danger" data-act="doreset">消去する</button></div>
      <button class="cancel" data-act="cancelreset">キャンセル</button></div></div>`;
  }
  app.innerHTML = h;

  app.querySelectorAll(".tabpane").forEach((p) => {
    const sc = p.querySelector(".scroll");
    const key = p.dataset.tab + ":" + ui.stacks[p.dataset.tab].length;
    if (sc && scrollMemo[key] && ui.pushedAnim !== p.dataset.tab) sc.scrollTop = scrollMemo[key];
    if (sc) bindLargeTitle(sc);
  });
  const nq = document.getElementById("quizscroll");
  if (nq && ui.quiz && !ui.quiz.resetScroll) nq.scrollTop = quizScroll;
  if (ui.quiz) { ui.quiz.fresh = false; ui.quiz.resetScroll = false; }
  ui.pushedAnim = false;
}

function bindLargeTitle(sc) {
  const lt = sc.querySelector(".large-title");
  const small = sc.parentElement.querySelector(".inline-title-small");
  const nav = sc.parentElement.querySelector(".navbar");
  if (!lt || !small) return;
  const upd = () => {
    const on = sc.scrollTop > 40;
    small.style.opacity = on ? 1 : 0;
    nav.classList.toggle("inline", on);
  };
  sc.addEventListener("scroll", upd, { passive: true });
  upd();
}

/* ================= Events ================= */
function launchList(key) {
  if (key === "next10") return store.nextSet(10);
  if (key === "review") return store.reviewQueue;
  if (key === "random10") return [...store.questions].sort(() => Math.random() - 0.5).slice(0, 10);
  const [k, v] = key.split(":");
  if (k === "topic") return store.questionsFor(store.topicByID[v]);
  if (k === "subject") return store.questionsSubject(v);
  if (k === "year") return store.questionsYear(Number(v));
  if (k === "kind") return store.questionsKind(v);
  return [];
}

app.addEventListener("click", (e) => {
  const el = e.target.closest("[data-act]");
  if (!el || el.disabled) return;
  const act = el.dataset.act;
  const z = ui.quiz;
  switch (act) {
    case "tab":
      if (ui.tab === el.dataset.tab) ui.stacks[ui.tab] = [];
      ui.tab = el.dataset.tab;
      render();
      break;
    case "topic":
      ui.stacks[ui.tab].push(el.dataset.id);
      ui.pushedAnim = ui.tab;
      render();
      break;
    case "back":
      ui.stacks[ui.tab].pop();
      render();
      break;
    case "filter":
      ui.filter = el.dataset.v || null;
      render();
      break;
    case "launch": {
      const qs = launchList(el.dataset.launch);
      const title = el.dataset.title;
      // ホームの大ボタンは空でも開く（SwiftUI版と同じ）。一覧の起動は空なら何もしない
      if (el.classList.contains("start")) {
        ui.quiz = { title, items: qs, index: 0, picked: null, results: {}, finished: false, showPoints: false, fresh: true };
        render();
      } else if (qs.length) {
        ui.quiz = { title, items: qs, index: 0, picked: null, results: {}, finished: false, showPoints: false, fresh: true };
        render();
      }
      break;
    }
    case "yt":
      window.open(youtubeURL(store.topicByID[el.dataset.id]), "_blank", "noopener");
      break;
    case "answer": {
      if (!z || z.picked != null) return;
      const q = z.items[z.index];
      const i = Number(el.dataset.i);
      z.picked = i;
      const ok = i === correctIndex(q);
      z.results[q.id] = ok;
      store.record(q, ok);
      if (navigator.vibrate) navigator.vibrate(ok ? 15 : [20, 40, 20]);
      render();
      break;
    }
    case "togglepoints":
      z.showPoints = !z.showPoints;
      render();
      break;
    case "next":
      if (z.index + 1 < z.items.length) {
        z.index += 1; z.picked = null; z.showPoints = false; z.resetScroll = true;
      } else {
        z.finished = true;
      }
      render();
      break;
    case "retry": {
      const wrong = z.items.filter((q) => z.results[q.id] === false);
      Object.assign(z, { items: wrong, index: 0, picked: null, results: {}, finished: false, showPoints: false, resetScroll: true });
      render();
      break;
    }
    case "closequiz": {
      const cover = app.querySelector(".cover");
      if (cover) {
        cover.classList.add("closing");
        let closed = false;
        const finish = () => { if (closed) return; closed = true; ui.quiz = null; render(); };
        cover.addEventListener("animationend", finish, { once: true });
        setTimeout(finish, 400);
      } else { ui.quiz = null; render(); }
      break;
    }
    case "askreset":
      ui.confirmReset = true;
      render();
      break;
    case "cancelreset":
      if (e.target.closest(".grp") && el.classList.contains("sheet-wrap")) return;
      ui.confirmReset = false;
      render();
      break;
    case "doreset":
      e.stopPropagation();
      store.reset();
      ui.confirmReset = false;
      render();
      break;
  }
});

/* ================= Boot ================= */
Promise.all([fetch("data/topics.json").then((r) => r.json()), fetch("data/questions.json").then((r) => r.json())])
  .then(([t, q]) => { store.init(t, q); render(); })
  .catch((err) => { app.innerHTML = `<div style="padding:40px 16px" class="secondary">データの読み込みに失敗しました：${esc(err.message)}</div>`; });

if ("serviceWorker" in navigator && location.protocol === "https:") {
  navigator.serviceWorker.register("sw.js").catch(() => {});
}

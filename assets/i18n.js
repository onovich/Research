/*! Research Locale Links v1.1.0 */

(function () {
  'use strict';

  var root = document.documentElement;
  var storageKey = 'research-language';
  var supported = ['en', 'zh-CN'];

  var messages = {
    en: {
      'reading.full': 'Full mode: supporting evidence, case details, and sources are visible.',
      'reading.brief': 'Brief mode: decisions and actions stay visible while supporting evidence is condensed.',
      'theme.toLight': 'Switch to light mode',
      'theme.toDim': 'Switch to dim mode',
      'theme.light': '☀',
      'theme.dim': '☾',
      'menu.open': 'Open contents',
      'menu.close': 'Close contents',
      'calculator.healthy': 'Room to adjust',
      'calculator.thin': 'Very little buffer',
      'calculator.loss': 'Projected loss',
      'filter.all': 'Showing all {count} types.',
      'filter.filtered': 'Showing {count} matching gameplay types.',
      'decision.remaining': '{count} choices remaining',
      'decision.partial': 'The score currently includes answered items only.',
      'decision.readyTitle': 'Ready for pre-launch and unit-economics validation',
      'decision.readyCopy': 'Do not launch yet. First validate day-one willingness to pay, acquisition cost, and contribution margin at every reward tier.',
      'decision.repairTitle': 'Fill the evidence gaps before deciding',
      'decision.repairCopy': 'Prioritize the weakest areas among the demo, reachable audience, positioning, and budget.',
      'decision.stopTitle': 'Not ready for crowdfunding',
      'decision.stopCopy': 'Build a Steam demo, creator playtests, festival presence, and a reachable community before making demand public.'
    },
    'zh-CN': {
      'reading.full': '当前为完整模式：显示补充证据、案例细节与全部来源。',
      'reading.brief': '当前为速读模式：保留判断与行动，隐藏补充证据。可在页首切换完整报告。',
      'theme.toLight': '切换到日间模式',
      'theme.toDim': '切换到夜读模式',
      'theme.light': '☀',
      'theme.dim': '☾',
      'menu.open': '打开目录',
      'menu.close': '关闭目录',
      'calculator.healthy': '尚有调整空间',
      'calculator.thin': '缓冲很薄',
      'calculator.loss': '预计出现亏损',
      'filter.all': '当前显示全部 {count} 类。',
      'filter.filtered': '筛选后显示 {count} 类玩法。',
      'decision.remaining': '还需完成 {count} 项选择',
      'decision.partial': '当前得分只统计已经选择的项目。',
      'decision.readyTitle': '可以进入预热与经济验证',
      'decision.readyCopy': '下一步不是立即上线，而是验证首日付费意愿、获客成本和每个档位的贡献毛利。',
      'decision.repairTitle': '先补关键证据，再决定',
      'decision.repairCopy': '优先补 Demo、受众名单、定位或预算中得分较低的项目。',
      'decision.stopTitle': '现在不适合直接众筹',
      'decision.stopCopy': '先做 Steam Demo、创作者试玩、节展与社区建设，避免公开验证“受众还没准备好”。'
    }
  };

  function safeGet(key) {
    try {
      return localStorage.getItem(key);
    } catch (error) {
      return null;
    }
  }

  function safeSet(key, value) {
    try {
      localStorage.setItem(key, value);
    } catch (error) {
      return;
    }
  }

  function normalize(value) {
    if (!value) return null;
    var normalized = String(value).replace('_', '-').toLowerCase();
    if (normalized === 'zh' || normalized.indexOf('zh-') === 0) return 'zh-CN';
    if (normalized === 'en' || normalized.indexOf('en-') === 0) return 'en';
    return null;
  }

  function interpolate(template, values) {
    return String(template).replace(/\{([^}]+)\}/g, function (match, key) {
      return values && Object.prototype.hasOwnProperty.call(values, key) ? values[key] : match;
    });
  }

  var current = normalize(root.getAttribute('lang')) || 'en';
  var preferred = normalize(safeGet(storageKey)) || current;
  root.lang = current;
  root.dataset.language = current;
  root.dataset.languagePreference = preferred;

  root.classList.remove('no-js');

  function t(key, values) {
    var dictionary = messages[current] || messages.en;
    var fallback = messages.en[key] || key;
    return interpolate(dictionary[key] || fallback, values);
  }

  function setLanguage(language) {
    var normalized = normalize(language);
    if (!normalized || supported.indexOf(normalized) === -1) return;
    preferred = normalized;
    root.dataset.languagePreference = normalized;
    safeSet(storageKey, normalized);
  }

  function bindLanguageLinks() {
    document.querySelectorAll('[data-language-option]').forEach(function (link) {
      var language = normalize(link.dataset.languageOption);
      link.setAttribute('aria-current', language === current ? 'page' : 'false');
      link.addEventListener('click', function () {
        setLanguage(language);
      });
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindLanguageLinks, { once: true });
  } else {
    bindLanguageLinks();
  }

  window.ResearchLocale = {
    get: function () { return current; },
    preferred: function () { return preferred; },
    set: setLanguage,
    t: t,
    normalize: normalize
  };
}());

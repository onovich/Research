/*! Research Reading Shell v1.1.0 */

(function () {
      'use strict';

      var root = document.documentElement;
      var body = document.body;
      var progressBar = document.getElementById('progress-bar');
      var readingState = document.getElementById('reading-state');
      var menuButton = document.getElementById('menu-button');
      var sideNav = document.getElementById('side-nav');
      var navClose = document.getElementById('nav-close');
      var navBackdrop = document.getElementById('nav-backdrop');
      var themeButton = document.getElementById('theme-button');
      var locale = window.ResearchLocale || {
        get: function () { return 'en'; },
        t: function (key) { return key; }
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

      function setPressed(selector, dataName, value) {
        document.querySelectorAll(selector).forEach(function (button) {
          button.setAttribute('aria-pressed', String(button.dataset[dataName] === value));
        });
      }

      function setReadingMode(mode, shouldStore) {
        root.dataset.reading = mode;
        setPressed('.reading-button', 'readingMode', mode);
        if (readingState) {
          readingState.textContent = mode === 'full'
            ? readingState.dataset.fullMessage || locale.t('reading.full')
            : readingState.dataset.briefMessage || locale.t('reading.brief');
        }
        if (shouldStore) safeSet('research-reading-mode', mode);
        updateProgress();
      }

      function setFontMode(mode, shouldStore) {
        root.dataset.font = mode;
        setPressed('.font-button', 'fontMode', mode);
        if (shouldStore) safeSet('research-font-mode', mode);
      }

      function setTheme(mode, shouldStore) {
        root.dataset.theme = mode;
        var isDim = mode === 'dim';
        if (themeButton) {
          themeButton.setAttribute('aria-pressed', String(isDim));
          themeButton.setAttribute('aria-label', isDim ? locale.t('theme.toLight') : locale.t('theme.toDim'));
          themeButton.setAttribute('title', isDim ? locale.t('theme.toLight') : locale.t('theme.toDim'));
          themeButton.textContent = isDim ? locale.t('theme.light') : locale.t('theme.dim');
        }
        if (shouldStore) safeSet('research-theme', mode);
      }

      document.querySelectorAll('.reading-button').forEach(function (button) {
        button.addEventListener('click', function () {
          setReadingMode(button.dataset.readingMode, true);
        });
      });

      document.querySelectorAll('[data-switch-full]').forEach(function (button) {
        button.addEventListener('click', function () {
          setReadingMode('full', true);
          var section = button.closest('.section');
          if (section) section.scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
      });

      document.querySelectorAll('.font-button').forEach(function (button) {
        button.addEventListener('click', function () {
          setFontMode(button.dataset.fontMode, true);
        });
      });

      if (themeButton) {
        themeButton.addEventListener('click', function () {
          setTheme(root.dataset.theme === 'dim' ? 'light' : 'dim', true);
        });
      }

      function openNav() {
        if (!menuButton || !sideNav || !navClose) return;
        body.classList.add('nav-open');
        menuButton.setAttribute('aria-expanded', 'true');
        menuButton.setAttribute('aria-label', locale.t('menu.close'));
        navClose.focus();
      }

      function closeNav(restoreFocus) {
        if (!menuButton) return;
        body.classList.remove('nav-open');
        menuButton.setAttribute('aria-expanded', 'false');
        menuButton.setAttribute('aria-label', locale.t('menu.open'));
        if (restoreFocus) menuButton.focus();
      }

      if (menuButton) {
        menuButton.addEventListener('click', function () {
          if (body.classList.contains('nav-open')) closeNav(true);
          else openNav();
        });
      }

      if (navBackdrop) {
        navBackdrop.addEventListener('click', function () {
          closeNav(true);
        });
      }

      if (navClose) {
        navClose.addEventListener('click', function () {
          closeNav(true);
        });
      }

      if (sideNav) sideNav.querySelectorAll('a').forEach(function (link) {
        link.addEventListener('click', function () {
          var target = document.querySelector(link.getAttribute('href'));
          if (target && target.classList.contains('detail-layer') && root.dataset.reading === 'brief') {
            setReadingMode('full', true);
          }
          closeNav(false);
        });
      });

      document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape' && body.classList.contains('nav-open')) closeNav(true);
        if (event.key === 'Tab' && sideNav && body.classList.contains('nav-open')) {
          var focusable = Array.from(sideNav.querySelectorAll('button:not([disabled]), a[href]'));
          if (!focusable.length) return;
          var first = focusable[0];
          var last = focusable[focusable.length - 1];
          if (event.shiftKey && document.activeElement === first) {
            event.preventDefault();
            last.focus();
          } else if (!event.shiftKey && document.activeElement === last) {
            event.preventDefault();
            first.focus();
          }
        }
      });

      function updateProgress() {
        if (!progressBar) return;
        var scrollTop = window.scrollY || document.documentElement.scrollTop;
        var scrollable = document.documentElement.scrollHeight - window.innerHeight;
        var value = scrollable > 0 ? Math.min(100, Math.max(0, scrollTop / scrollable * 100)) : 0;
        progressBar.style.width = value.toFixed(2) + '%';
      }

      window.addEventListener('scroll', updateProgress, { passive: true });
      window.addEventListener('resize', updateProgress);

      var navLinks = sideNav ? Array.from(sideNav.querySelectorAll('a')) : [];
      var observedSections = navLinks.map(function (link) {
        return document.querySelector(link.getAttribute('href'));
      }).filter(Boolean);

      if ('IntersectionObserver' in window) {
        var sectionObserver = new IntersectionObserver(function (entries) {
          var visible = entries.filter(function (entry) { return entry.isIntersecting; })
            .sort(function (a, b) { return b.intersectionRatio - a.intersectionRatio; });
          if (!visible.length) return;
          var id = '#' + visible[0].target.id;
          navLinks.forEach(function (link) {
            link.setAttribute('aria-current', String(link.getAttribute('href') === id));
          });
        }, { rootMargin: '-22% 0px -68% 0px', threshold: [0, 0.05, 0.2] });
        observedSections.forEach(function (section) { sectionObserver.observe(section); });
      }

      var pledgeInput = document.getElementById('pledge-total');
      var costInputs = Array.from(document.querySelectorAll('[data-cost]'));
      var costTotal = document.getElementById('cost-total');
      var netAmount = document.getElementById('net-amount');
      var netStatus = document.getElementById('net-status');
      var calculatorRoot = document.querySelector('[data-net-calculator]');
      var currencyCode = calculatorRoot ? calculatorRoot.dataset.currency || 'CNY' : 'CNY';
      var currency = new Intl.NumberFormat(locale.get() === 'zh-CN' ? 'zh-CN' : 'en-US', {
        style: 'currency',
        currency: currencyCode,
        maximumFractionDigits: 0
      });

      function updateCalculator() {
        if (!pledgeInput || !costTotal || !netAmount || !netStatus) return;
        var pledge = Math.max(0, Number(pledgeInput.value) || 0);
        var totalRate = 0;
        costInputs.forEach(function (input) {
          var rate = Number(input.value) || 0;
          totalRate += rate;
          var output = input.parentElement.querySelector('output');
          if (output) output.textContent = rate + '%';
        });
        var retained = pledge * (1 - totalRate / 100);
        costTotal.textContent = totalRate + '%';
        netAmount.textContent = currency.format(retained);
        if (totalRate <= 85) {
          netStatus.textContent = locale.t('calculator.healthy');
          netStatus.dataset.state = 'healthy';
        } else if (totalRate <= 100) {
          netStatus.textContent = locale.t('calculator.thin');
          netStatus.dataset.state = 'thin';
        } else {
          netStatus.textContent = locale.t('calculator.loss');
          netStatus.dataset.state = 'loss';
        }
      }

      if (pledgeInput) pledgeInput.addEventListener('input', updateCalculator);
      costInputs.forEach(function (input) {
        input.addEventListener('input', updateCalculator);
      });

      var filterButtons = Array.from(document.querySelectorAll('[data-game-filter]'));
      var gameRows = Array.from(document.querySelectorAll('#game-table tbody tr'));
      var gameFilterStatus = document.getElementById('game-filter-status');

      filterButtons.forEach(function (button) {
        button.addEventListener('click', function () {
          var filter = button.dataset.gameFilter;
          var visibleCount = 0;
          filterButtons.forEach(function (item) {
            item.setAttribute('aria-pressed', String(item === button));
          });
          gameRows.forEach(function (row) {
            var matches = filter === 'all' || row.dataset.gameType.split(' ').indexOf(filter) !== -1;
            row.hidden = !matches;
            if (matches) visibleCount += 1;
          });
          if (gameFilterStatus) {
            gameFilterStatus.textContent = filter === 'all'
              ? locale.t('filter.all', { count: visibleCount })
              : locale.t('filter.filtered', { count: visibleCount });
          }
        });
      });

      var scoreSelects = Array.from(document.querySelectorAll('[data-score]'));
      var decisionScore = document.getElementById('decision-score');
      var decisionHeading = document.getElementById('decision-heading');
      var decisionCopy = document.getElementById('decision-copy');

      function updateDecision() {
        if (!scoreSelects.length || !decisionScore || !decisionHeading || !decisionCopy) return;
        var answered = scoreSelects.filter(function (select) { return select.value !== ''; });
        var score = answered.reduce(function (total, select) {
          return total + Number(select.value);
        }, 0);
        if (answered.length < scoreSelects.length) {
          decisionScore.textContent = score + '/10';
          decisionHeading.textContent = locale.t('decision.remaining', { count: scoreSelects.length - answered.length });
          decisionCopy.textContent = locale.t('decision.partial');
          return;
        }
        decisionScore.textContent = score + '/10';
        if (score >= 8) {
          decisionHeading.textContent = locale.t('decision.readyTitle');
          decisionCopy.textContent = locale.t('decision.readyCopy');
        } else if (score >= 6) {
          decisionHeading.textContent = locale.t('decision.repairTitle');
          decisionCopy.textContent = locale.t('decision.repairCopy');
        } else {
          decisionHeading.textContent = locale.t('decision.stopTitle');
          decisionCopy.textContent = locale.t('decision.stopCopy');
        }
      }

      scoreSelects.forEach(function (select) {
        select.addEventListener('change', updateDecision);
      });

      var savedReading = safeGet('research-reading-mode');
      var savedFont = safeGet('research-font-mode');
      var savedTheme = safeGet('research-theme');
      var prefersDim = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
      var deepLinkTarget = location.hash ? document.querySelector(location.hash) : null;
      var initialReading = savedReading === 'full' || (deepLinkTarget && deepLinkTarget.classList.contains('detail-layer'))
        ? 'full'
        : 'brief';
      setReadingMode(initialReading, false);
      setFontMode(savedFont === 'large' ? 'large' : 'standard', false);
      setTheme(savedTheme || (prefersDim ? 'dim' : 'light'), false);
      updateCalculator();
      updateDecision();
      updateProgress();
      if (deepLinkTarget) {
        requestAnimationFrame(function () {
          deepLinkTarget.scrollIntoView({ behavior: 'instant', block: 'start' });
        });
      }

      var printState = null;
      window.addEventListener('beforeprint', function () {
        printState = {
          reading: root.dataset.reading,
          openDetails: Array.from(document.querySelectorAll('details')).filter(function (item) { return item.open; })
        };
        root.dataset.reading = 'full';
        document.querySelectorAll('details').forEach(function (item) { item.open = true; });
      });
      window.addEventListener('afterprint', function () {
        if (!printState) return;
        root.dataset.reading = printState.reading;
        document.querySelectorAll('details').forEach(function (item) {
          item.open = printState.openDetails.indexOf(item) !== -1;
        });
        printState = null;
      });
    }());

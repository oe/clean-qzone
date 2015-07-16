/**
 * create a fn that will delay to exec util wait milliseconds has passed
 *     since last time invoked
 * @param  {Function} fn      fn to exec
 * @param  {Object}   context fn's exec context
 * @param  {Number}   wait    time to wait, millisecond
 * @return {Function}           a new fn
*/

var EXT_VERSION, addSettingMenu, adscount, attachSettingPanelEvents, blockedKwds, checkUpdate, debounce, doRemoveDynamicMoments, doUXOpt, encodeHtml, getParent, getSettingPanel, initSettingPanel, injectStyle, leftSidebar, lstore, mainFeed, onAddKwdBtn, onAddThemeClick, onKeyPress, onMScroll, onMenuItemClick, onRemoveKwd, onSwitchTheme, onThemeClick, pageContent, prependKwd, refreshKwdsList, removeAds, removeElement, removeKwdMoment, removeKwdMoments, removeOfficalMoments, removeSingleMoment, rightSidebar, showExtUpdateAlert, stopBgMusic, throttle, toggleSettingsDlg, updateBgImg,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

debounce = function(fn, context, wait) {
  var tid;
  tid = null;
  if (isNaN(wait) || wait < 0) {
    wait = 200;
  }
  if (!isNaN(context)) {
    if (context > 0) {
      wait = context;
    }
    context = void 0;
  }
  return function() {
    clearTimeout(tid);
    tid = setTimeout(function() {
      if (fn != null) {
        fn.call(context);
      }
    }, wait);
  };
};

/**
 * create a new function that will exec every wait milliseconds even when
 *     it frequently invoked
 * @param  {Function} fn      fn to exec
 * @param  {Object}   context fn's exec context
 * @param  {Number}   wait    time to wait, milisecond
 * @return {Function}           a new function
*/


throttle = function(fn, context, wait) {
  var last, tid;
  last = false;
  tid = null;
  if (isNaN(wait) || wait < 0) {
    wait = 200;
  }
  if (!isNaN(context)) {
    if (context > 0) {
      wait = +context;
    }
    context = void 0;
  }
  return function() {
    var now, remain;
    now = +new Date();
    if (last === false) {
      last = now;
    }
    remain = wait - (now - last);
    clearTimeout(tid);
    if (remain <= 0) {
      if (fn != null) {
        fn.call(context);
      }
      wait = false;
    } else {
      tid = setTimeout(function() {
        if (fn != null) {
          fn.call(context);
        }
      }, remain);
    }
  };
};

getParent = function(elem, pClass) {
  while (elem) {
    if (elem.classList.contains(pClass)) {
      return elem;
    }
    elem = elem.parentElement;
  }
};

removeElement = function(elem) {
  if (elem && elem.parentElement) {
    elem.parentElement.removeChild(elem);
    return true;
  } else {
    return false;
  }
};

encodeHtml = function(str) {
  return String(str).replace(/&/g, '&amp;'.replace(/</g, '&lt;'.replace(/>/g, '&gt;'.replace(/"/g, '&quot;'))));
};

lstore = {
  _storeKey: 'isa-cq-settings',
  kwdsKey: 'kwds',
  set: function(key, val) {
    this._data[key] = val;
    return this.save();
  },
  get: function(key) {
    return this._data[key];
  },
  save: function() {
    return localStorage.setItem(this._storeKey, JSON.stringify(this._data));
  },
  getKwds: function() {
    var kwds;
    kwds = this.get(this.kwdsKey);
    if (kwds == null) {
      kwds = [];
    }
    return kwds;
  },
  addKwd: function(kwd) {
    var kwds;
    kwds = this.getKwds(this.kwdsKey);
    if (__indexOf.call(kwds, kwd) >= 0) {
      return false;
    }
    kwds.unshift(kwd);
    this.set(this.kwdsKey, kwds);
    return true;
  },
  removeKwd: function(kwd) {
    var idx, kwds;
    kwds = this.getKwds(this.kwdsKey);
    idx = kwds.indexOf(kwd);
    if (!~idx) {
      return;
    }
    kwds.splice(idx, 1);
    return this.set(this.kwdsKey, kwds);
  }
};

lstore._data = (function() {
  var d;
  d = localStorage.getItem(lstore._storeKey);
  return JSON.parse(d || '{}');
})();

injectStyle = function() {
  var style, styleId;
  styleId = 'isa-qzone-style';
  if (document.getElementById(styleId)) {
    return;
  }
  style = document.createElement('style');
  style.id = styleId;
  style.setAttribute('type', 'text/css');
  style.textContent = ".cq-hide{display:none !important}.cq-yosemite-style-bg{-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-disabled{opacity:.6;cursor:default;pointer-events:none}.cq-input{border:1px solid #bfbfbf;border-radius:2px;box-sizing:border-box;color:#444;font:inherit;margin:0;padding:2px 6px;outline:none}.cq-input:focus{outline:none}.cq-btn{border:1px solid #cfcfcf;background:none;color:#666;text-align:center;border-radius:3px;line-height:26px;box-sizing:border-box;-webkit-appearance:none;-moz-appearance:none;appearance:none;padding:0 10px;margin:0;height:28px;white-space:nowrap;position:relative;overflow:hidden;text-overflow:ellipsis;font-size:14px;font-family:inherit;cursor:pointer;outline:none}.cq-btn:active{text-decoration:none;background:#f5f5f5}[data-url^=\"http://c.gdt.qq.com\"],.gdtads_box,.ck-act,.icenter-right-ad,.fn_paipai,.mod-side-nav-recently-used,.hot-msg,.msg-channel-wrapper,.user-vip-info,.gb_ad_tearing_angle,.icon_app_new,.fn_accessLog_tips,.qz-app-flag,.icon-new-fun,.hotbar_wrap,.icon-red-dot,.sn-radio,.user-home,.mall-sp-container{display:none !important}.cq-remove-qzvip .vip-setting,.cq-remove-qzvip .qz-f-vip-l-y,.cq-remove-qzvip .detail-info-level{display:none !important}.cq-fixed-sidebar{position:fixed;width:170px;top:41px}.cq-fullwidth{-webkit-transition:width .3s linear;transition:width .3s linear;width:100% !important}.cq-fullwidth .img-box-row-wrap .img-box-row{display:inline !important}.cq-fullwidth .img-box-row-wrap .img-box-row+.img-box-row{margin-left:4px}.cq-yosemite .cq-bg{position:fixed;top:0;bottom:0;right:0;left:0;-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-yosemite .background-container{position:relative;background:none}.cq-yosemite .mod-side-nav{box-shadow:0 0 1px rgba(0,0,0,0.07);background-color:#f9f9f9;border:1px solid #e9e9e9}.cq-overlay{position:fixed;top:0;left:0;bottom:0;right:0;background-color:rgba(0,0,0,0.1);z-index:99999}.cq-settings-dialog{position:absolute;top:0;left:0;bottom:0;right:0;height:60%;width:60%;min-width:600px;max-width:700px;margin:auto;overflow:hidden;border:1px solid rgba(0,0,0,0.1);background-color:#f9f9f9;box-shadow:0 0 1px rgba(0,0,0,0.07);color:#333;border-radius:6px;font:14px/1.6 Tahoma,Geneva,'Simsun';box-sizing:border-box}.cq-sidemenu{position:absolute;left:0;top:0;width:20%;height:100%}.cq-sidemenu .title{padding:10px 6px;color:#08c;font-weight:bold;text-align:center}.cq-sidemenu .cq-menus{list-style:none;padding:0;color:#999;margin:10px 6px 0 0}.cq-sidemenu .cq-menus>li{box-sizing:border-box;padding:4px 8px;border-left:4px solid transparent;cursor:pointer}.cq-sidemenu .cq-menus>li.active{color:#666;border-left-color:#999;cursor:default;pointer-events:none}.cq-settings-close{position:absolute;top:6px;right:6px;font-size:3em;width:20px;height:20px}.cq-settings-close:after,.cq-settings-close:before{position:absolute;left:9px;content:' ';width:3px;height:100%;background-color:#ccc;-webkit-transition:all .2s linear;transition:all .2s linear}.cq-settings-close:after{-webkit-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg)}.cq-settings-close:before{-webkit-transform:rotate(-45deg);-ms-transform:rotate(-45deg);transform:rotate(-45deg)}.cq-settings-close:hover:after,.cq-settings-close:hover:before{background-color:#555}.cq-setting-wrapper{width:80%;margin-left:20%;padding:8px 14px 8px 0;box-sizing:border-box;height:100%;overflow:hidden;overflow-y:auto}.cq-setting-content{display:none}.cq-setting-content.active{display:block}.cq-setting-content .title{font-size:1.2em;padding:8px;border-bottom:1px solid #ccc;margin-bottom:10px}.cq-setting-content .title>small{color:#777;font-size:.8em;margin-left:8px}.cq-input-wrapper{margin-bottom:10px}.cq-kwds{list-style:none;padding:0;margin:0;color:#888;font-size:.8em}.cq-kwds>li{display:inline-block;margin-right:4px;border:1px solid #ddd;padding:3px 12px;border-radius:16px;margin-bottom:6px;cursor:default}.cq-kwds>li>.close{margin-left:2px;font-size:1.2em;cursor:pointer}.cq-kwds>li>.close:after{content:'×'}.cq-kwds>li:hover{box-shadow:0 2px 2px #ccc}.cq-kwds>li:hover>.close{color:#333}.cq-themes{list-style:none;padding:0;margin:0}.cq-themes>li{position:relative;display:inline-block;margin-right:1em;border-radius:6px;border:1px solid #ddd;width:46%;padding-bottom:23%;margin-bottom:6px;cursor:pointer;vertical-align:middle;overflow:hidden}.cq-themes>li>img{position:absolute;top:0;-webkit-filter:blur(6px) saturate(2);background-size:cover;max-width:100%;height:auto}.cq-themes>li.cq-selected{cursor:default;pointer-events:none}.cq-themes>li.cq-selected:before{position:absolute;top:0;left:0;bottom:0;right:0;content:' ';background-color:rgba(255,255,255,0.3);z-index:1}.cq-themes>li.cq-selected:after{content:'✓';font-size:2em;position:absolute;top:50%;left:50%;margin-top:-1em;margin-left:-0.5em;z-index:2}";
  document.head.appendChild(style);
};

pageContent = document.getElementById('pageContent');

leftSidebar = document.querySelector('.mod-side-nav-message');

rightSidebar = document.querySelector('.col-main-sidebar');

mainFeed = document.querySelector('.col-main-feed');

onMScroll = function() {
  var action, top;
  top = pageContent.getBoundingClientRect().top;
  leftSidebar.classList[top <= 41 ? 'add' : 'remove']('cq-fixed-sidebar');
  action = top <= -1750 ? 'add' : 'remove';
  rightSidebar.classList[action]('cq-hide');
  mainFeed.classList[action]('cq-fullwidth');
};

onKeyPress = function(e) {
  var btn, elem;
  if (e.metaKey && e.keyCode === 13 && (elem = getParent(e.target, 'qz-poster-inner'))) {
    btn = elem.querySelector('.btn-post');
    if (btn != null) {
      btn.click();
    }
  }
};

stopBgMusic = function() {
  var e;
  try {
    QZONE.music.qqplayer_play_flag = 0;
    return QZONE.music.pauseMusic();
  } catch (_error) {
    e = _error;
  }
};

doUXOpt = function() {
  var thOnscroll;
  thOnscroll = throttle(onMScroll);
  thOnscroll();
  window.addEventListener('scroll', thOnscroll);
  if (!~navigator.userAgent.indexOf('OS X')) {
    return;
  }
  pageContent.addEventListener('keydown', function(e) {
    if (e.target.classList.contains('textarea')) {
      onKeyPress(e);
    }
  }, true);
};

adscount = 0;

lstore.addKwd('莱特币');

blockedKwds = [];

removeAds = function() {
  removeOfficalMoments();
  removeKwdMoments();
};

removeOfficalMoments = function() {
  var ads, adsSelector;
  adsSelector = ['.votestar', '.buy-info', '[href="http://user.qzone.qq.com/20050606"]'];
  ads = document.querySelectorAll(adsSelector.join(','));
  Array.prototype.forEach.call(ads, removeSingleMoment);
};

removeKwdMoments = function() {
  var moments, momentsSelector;
  blockedKwds = lstore.getKwds();
  if (!(blockedKwds && blockedKwds.length)) {
    return;
  }
  momentsSelector = ['.f-info', '.f-ct'];
  moments = document.querySelectorAll(momentsSelector.join(','));
  Array.prototype.forEach.call(moments, removeKwdMoment);
};

removeKwdMoment = function(elem) {
  var hasKwd, text;
  text = elem.textContent;
  hasKwd = blockedKwds.some(function(kwd) {
    return ~text.indexOf(kwd);
  });
  hasKwd && removeSingleMoment(elem);
};

removeSingleMoment = function(elem) {
  if (elem = getParent(elem, 'f-single')) {
    if (removeElement(elem)) {
      console.info('%cremove ads(NO.' + (++adscount) + '): %c' + elem.textContent, 'color:#5d7895', 'color: #333');
    }
    elem = null;
  }
};

doRemoveDynamicMoments = function() {
  var deRemoveAds;
  deRemoveAds = debounce(removeAds);
  deRemoveAds();
  document.getElementById('main_feed_container').addEventListener('DOMSubtreeModified', deRemoveAds);
};

showExtUpdateAlert = function() {};

toggleSettingsDlg = function(isShow) {
  var wp;
  wp = getSettingPanel();
  wp.classList[isShow ? 'remove' : 'add']('cq-hide');
  if (isShow) {
    refreshKwdsList();
  }
};

getSettingPanel = function() {
  var html;
  if (getSettingPanel.wp) {
    return getSettingPanel.wp;
  }
  html = '<div class="cq-settings-dialog">\n  <div class="cq-settings-close"></div>\n  <div class="cq-sidemenu">\n    <div class="title">\n       Clean Qzone\n    </div>\n    <ul class="cq-menus" id="cq-settings-menus">\n      <li class="active" data-target="cq-setting-kwds">屏蔽关键字</li>\n      <li data-target="cq-setting-theme">主题设置</li>\n    </ul>\n  </div>\n  <div class="cq-setting-wrapper" id="cq-setting-wrapper">\n    <div class="cq-setting-content active" id="cq-setting-kwds">\n      <div class="title">屏蔽关键字 <small>屏蔽含有关键字的动态</small></div>\n      <div class="cq-input-wrapper">\n        <label>添加关键字 <input type="text" class="cq-input" id="cq-kwd-input"></label> <button class="cq-btn" id="cq-kwd-add-btn">添加</button>\n      </div>\n      <ul class="cq-kwds" id="cq-kwds-list">\n      </ul>\n    </div>\n\n    <div class="cq-setting-content" id="cq-setting-theme">\n      <div class="title">主题设置 <small>使用 OS X Yosemite风格主题</small></div>\n      <div class="cq-input-wrapper">\n        <label><input type="checkbox" id="cq-theme-checkbox"> 启用 Yosemite 主题, 高大上!</label>\n      </div>\n      <div class="cq-theme-choose-wrapper" id="cq-theme-choose-wrapper">\n        <div class="cq-input-wrapper">\n          选择下列背景图, 或者自定义图片URL\n          <input type="text" class="cq-input"> <button class="cq-btn" id="cq-theme-add-btn">设置</button>\n        </div>\n        <ul class="cq-themes" id="cq-themes-list">\n          <li class="cq-selected"><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>\n          <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>\n          <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>\n          <li><img src="http://b.zol-img.com.cn/desk/bizhi/image/6/1440x900/1436338676892.jpg"></li>\n        </ul>\n      </div>\n    </div>\n  </div>\n</div>';
  getSettingPanel.wp = document.createElement('div');
  getSettingPanel.wp.classList.add('cq-overlay');
  getSettingPanel.wp.classList.add('cq-hide');
  getSettingPanel.wp.innerHTML = html;
  document.body.appendChild(getSettingPanel.wp);
  return getSettingPanel.wp;
};

attachSettingPanelEvents = function() {
  var _ref;
  document.getElementById('cq-settings-menus').addEventListener('click', onMenuItemClick);
  document.getElementById('cq-kwd-add-btn').addEventListener('click', onAddKwdBtn);
  document.getElementById('cq-kwds-list').addEventListener('click', onRemoveKwd);
  document.getElementById('cq-theme-checkbox').addEventListener('change', onSwitchTheme);
  document.getElementById('cq-theme-add-btn').addEventListener('click', onAddThemeClick);
  document.getElementById('cq-themes-list').addEventListener('click', onThemeClick);
  if ((_ref = document.querySelector('.cq-settings-close')) != null) {
    _ref.addEventListener('click', function() {
      return toggleSettingsDlg();
    });
  }
};

onMenuItemClick = function(e) {
  var elem, now, targetId;
  elem = e.target;
  if (elem.tagName.toLowerCase() !== 'li') {
    return;
  }
  if (elem.classList.contains('active')) {
    return;
  }
  now = this.querySelector('.active');
  if (now) {
    now.classList.remove('active');
  }
  elem.classList.add('active');
  targetId = elem.getAttribute('data-target');
  if (!targetId) {
    return;
  }
  now = document.getElementById('cq-setting-wrapper').querySelector('.cq-setting-content.active');
  if (now) {
    now.classList.remove('active');
  }
  elem = document.getElementById(targetId);
  if (elem) {
    elem.classList.add('active');
  }
};

onAddKwdBtn = function(e) {
  var ipt, v;
  ipt = document.getElementById('cq-kwd-input');
  v = ipt.value.trim();
  if (!v) {
    return;
  }
  if (lstore.addKwd(v)) {
    prependKwd(v);
    ipt.value = '';
  } else {
    console.log('关键字已存在');
  }
};

prependKwd = function(v) {
  var li, list;
  li = document.createElement('li');
  li.innerHTML = "" + (encodeHtml(v)) + "<span class='close'></span>";
  list = document.getElementById('cq-kwds-list');
  list.insertBefore(li, list.firstChild);
};

onRemoveKwd = function(e) {
  var kwd, li, target;
  target = e.target;
  if (!(target.tagName.toLowerCase() === 'span' && target.classList.contains('close'))) {
    return;
  }
  li = target.parentElement;
  kwd = li.textContent.trim();
  lstore.removeKwd(kwd);
  removeElement(li);
};

onSwitchTheme = function() {
  var enabled;
  enabled = this.checked;
  document.getElementById('cq-theme-choose-wrapper').classList[enabled ? 'remove' : 'add']('cq-disabled');
  document.documentElement.classList[enabled ? 'add' : 'remove']('cq-yosemite');
};

refreshKwdsList = function() {
  var html, kwds;
  kwds = lstore.getKwds();
  html = kwds.reduce(function(prev, kwd) {
    return prev + ("<li>" + (encodeHtml(kwd)) + "<span class='close'></span></li>");
  }, '');
  document.getElementById('cq-kwds-list').innerHTML = html;
};

onAddThemeClick = function() {};

onThemeClick = function(e) {
  var li, target, _ref;
  target = e.target;
  if (target.tagName.toLowerCase() !== 'img') {
    return;
  }
  li = target.parentElement;
  if (li.classList.contains('cq-selected')) {
    return;
  }
  if ((_ref = this.querySelector('.cq-selected')) != null) {
    _ref.classList.remove('cq-selected');
  }
  li.classList.add('cq-selected');
  updateBgImg(target.src);
};

updateBgImg = function(url) {
  if (!(updateBgImg.wp && url)) {
    updateBgImg.wp = document.createElement('div');
    updateBgImg.wp.classList.add('cq-bg');
    document.body.insertBefore(updateBgImg.wp, document.body.firstChild);
  }
  updateBgImg.wp.style.backgroundImage = "url(" + url + ")";
};

addSettingMenu = function() {
  var menu, menus;
  if (!(menus = document.querySelector('#tb_setting_panel .drop-down-setting'))) {
    return;
  }
  menu = document.createElement('a');
  menu.href = 'javascript:;';
  menu.textContent = 'Clean Qzone';
  menu.addEventListener('click', function() {
    toggleSettingsDlg(true);
  });
  menus.insertBefore(menu, menus.firstChild);
};

initSettingPanel = function() {
  getSettingPanel();
  addSettingMenu();
  attachSettingPanelEvents();
};

EXT_VERSION = "0.0.14";

Global.checkCqUpdate = function(versionInfo) {
  if (EXT_VERSION !== versionInfo.version && versionInfo.version !== lstore.get('version')) {
    versionInfo.oldVersion = EXT_VERSION;
    showExtUpdateAlert(versionInfo);
    lstore.get('version', versionInfo.version);
  }
};

checkUpdate = function() {
  var script;
  script = document.createElement('script');
  script.src = "https://cdn.rawgit.com/evecalm/clean-qzone/master/dist/clean-qzone.check-update.js";
  script.type = 'text/javascript';
  document.body.appendChild(script);
};

(function() {
  injectStyle();
  if (!document.querySelector('.mod-side-nav-message')) {
    return;
  }
  doRemoveDynamicMoments();
  doUXOpt();
  checkUpdate();
  initSettingPanel();
})();

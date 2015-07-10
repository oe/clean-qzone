/**
 * create a fn that will delay to exec util wait milliseconds has passed
 *     since last time invoked
 * @param  {Function} fn      fn to exec
 * @param  {Object}   context fn's exec context
 * @param  {Number}   wait    time to wait, millisecond
 * @return {Function}           a new fn
*/

var adscount, debounce, doRemoveDynamicMoments, doUXOpt, getParent, injectStyle, leftSidebar, mainFeed, onKeyPress, onMScroll, pageContent, removeDynamicMoments, removeSingleMoment, rightSidebar, throttle;

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

injectStyle = function() {
  var style, styleId;
  styleId = 'isa-qzone-style';
  if (document.getElementById(styleId)) {
    return;
  }
  style = document.createElement('style');
  style.id = styleId;
  style.setAttribute('type', 'text/css');
  style.innerText = "[data-url^=\"http://c.gdt.qq.com\"],.gdtads_box,.ck-act,.icenter-right-ad,.fn_paipai,.mod-side-nav-recently-used,.hot-msg,.msg-channel-wrapper,.user-vip-info,.gb_ad_tearing_angle,.icon_app_new,.fn_accessLog_tips,.qz-app-flag,.icon-new-fun,.hotbar_wrap,.icon-red-dot,.sn-radio{display:none !important}.cq-fixed-sidebar{position:fixed;width:170px;top:41px}.cq-hide{display:none !important}.cq-fullwidth{-webkit-transition:width .3s linear;transition:width .3s linear;width:100% !important}.cq-fullwidth .img-box-row-wrap .img-box-row{display:inline !important}.cq-fullwidth .img-box-row-wrap .img-box-row+.img-box-row{margin-left:4px}.yosemite .background-container{background:none}.yosemite .mod-side-nav{box-shadow:0 0 1px rgba(0,0,0,0.07);background-color:#f9f9f9;border:1px solid #e9e9e9}";
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

removeDynamicMoments = function() {
  var ads, adsSelector;
  adsSelector = ['.votestar', '.buy-info', '[href="http://user.qzone.qq.com/20050606"]'];
  ads = document.querySelectorAll(adsSelector.join(','));
  Array.prototype.forEach.call(ads, removeSingleMoment);
};

removeSingleMoment = function(elem) {
  if (elem = getParent(elem, 'f-single')) {
    console.log('remove ads(NO.' + (++adscount) + '): ' + elem.innerText);
    if (elem.parentElement) {
      elem.parentElement.removeChild(elem);
    }
    elem = null;
  }
};

doRemoveDynamicMoments = function() {
  var deRemoveDynamicAds;
  deRemoveDynamicAds = debounce(removeDynamicMoments);
  deRemoveDynamicAds();
  document.getElementById('main_feed_container').addEventListener('DOMSubtreeModified', deRemoveDynamicAds);
};

(function() {
  if (!document.querySelector('.mod-side-nav-message')) {
    return;
  }
  injectStyle();
  doRemoveDynamicMoments();
  doUXOpt();
})();

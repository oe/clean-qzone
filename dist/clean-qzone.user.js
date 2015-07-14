// ==UserScript==
// @name           Clean Qzone
// @namespace      com.saiya.clean-qzone
// @description    Remove all Qzone ads, make your Qzone center clean and clear.
// @match          http://*.qzone.qq.com/*
// @include        http://*.qzone.qq.com/*
// @updateURL      https://cdn.rawgit.com/evecalm/clean-qzone/master/dist/clean-qzone.meta.js
// @downloadURL    https://cdn.rawgit.com/evecalm/clean-qzone/master/dist/clean-qzone.user.js
// @version        0.0.14
// ==/UserScript==
// source code: https://github.com/evecalm/clean-qzone
function proxy(a){var b=document.createElement("script");b.textContent="("+a.toString()+")(window);",document.body.appendChild(b)}function main(a){var b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z=[].indexOf||function(a){for(var b=0,c=this.length;c>b;b++)if(b in this&&this[b]===a)return b;return-1};f=function(a,b,c){var d;return d=null,(isNaN(c)||0>c)&&(c=200),isNaN(b)||(b>0&&(c=b),b=void 0),function(){clearTimeout(d),d=setTimeout(function(){null!=a&&a.call(b)},c)}},y=function(a,b,c){var d,e;return d=!1,e=null,(isNaN(c)||0>c)&&(c=200),isNaN(b)||(b>0&&(c=+b),b=void 0),function(){var f,g;f=+new Date,d===!1&&(d=f),g=c-(f-d),clearTimeout(e),0>=g?(null!=a&&a.call(b),c=!1):e=setTimeout(function(){null!=a&&a.call(b)},g)}},i=function(a,b){for(;a;){if(a.classList.contains(b))return a;a=a.parentElement}},r=function(a){return a&&a.parentElement?(a.parentElement.removeChild(a),!0):!1},l={_storeKey:"isa-cq-settings",kwdsKey:"kwds",set:function(a,b){return this._data[a]=b,this.save()},get:function(a){return this._data[a]},save:function(){return localStorage.setItem(this._storeKey,JSON.stringify(this._data))},getKwds:function(){var a;return a=this.get(this.kwdsKey),null==a&&(a=[]),a},addKwd:function(a){var b;return b=this.getKwds(this.kwdsKey),z.call(b,a)>=0?!1:(b.unshift(a),this.set(this.kwdsKey,b),!0)},removeKwd:function(a){var b,c;return c=this.getKwds(this.kwdsKey),b=c.indexOf(a),~b?(c.splice(b,1),this.set(this.kwdsKey,c)):void 0}},l._data=function(){var a;return a=localStorage.getItem(l._storeKey),JSON.parse(a||"{}")}(),j=function(){var a,b;b="isa-qzone-style",document.getElementById(b)||(a=document.createElement("style"),a.id=b,a.setAttribute("type","text/css"),a.innerText=".cq-hide{display:none !important}.cq-yosemite-style-bg{-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-disabled{opacity:.6;cursor:default;pointer-events:none}.cq-input{border:1px solid #bfbfbf;border-radius:2px;box-sizing:border-box;color:#444;font:inherit;margin:0;padding:2px 6px;outline:none}.cq-input:focus{outline:none}.cq-btn{border:1px solid #cfcfcf;background:none;color:#666;text-align:center;border-radius:3px;line-height:26px;box-sizing:border-box;-webkit-appearance:none;-moz-appearance:none;appearance:none;padding:0 10px;margin:0;height:28px;white-space:nowrap;position:relative;overflow:hidden;text-overflow:ellipsis;font-size:14px;font-family:inherit;cursor:pointer;outline:none}.cq-btn:active{text-decoration:none;background:#f5f5f5}[data-url^=\"http://c.gdt.qq.com\"],.gdtads_box,.ck-act,.icenter-right-ad,.fn_paipai,.mod-side-nav-recently-used,.hot-msg,.msg-channel-wrapper,.user-vip-info,.gb_ad_tearing_angle,.icon_app_new,.fn_accessLog_tips,.qz-app-flag,.icon-new-fun,.hotbar_wrap,.icon-red-dot,.sn-radio,.user-home,.mall-sp-container{display:none !important}.cq-fixed-sidebar{position:fixed;width:170px;top:41px}.cq-fullwidth{-webkit-transition:width .3s linear;transition:width .3s linear;width:100% !important}.cq-fullwidth .img-box-row-wrap .img-box-row{display:inline !important}.cq-fullwidth .img-box-row-wrap .img-box-row+.img-box-row{margin-left:4px}.cq-yosemite .cq-bg{position:fixed;top:0;bottom:0;right:0;left:0;-webkit-filter:blur(6px) saturate(2);background-size:cover}.cq-yosemite .background-container{position:relative;background:none}.cq-yosemite .mod-side-nav{box-shadow:0 0 1px rgba(0,0,0,0.07);background-color:#f9f9f9;border:1px solid #e9e9e9}.cq-overlay{position:fixed;top:0;left:0;bottom:0;right:0;background-color:rgba(0,0,0,0.1)}.cq-settings-dialog{position:absolute;top:0;left:0;bottom:0;right:0;height:60%;width:60%;min-width:600px;max-width:700px;margin:auto;overflow:hidden;border:1px solid rgba(0,0,0,0.1);background-color:#f9f9f9;box-shadow:0 0 1px rgba(0,0,0,0.07);color:#333;border-radius:6px;font:14px/1.6 Tahoma,Geneva,'Simsun';box-sizing:border-box}.cq-sidemenu{position:absolute;left:0;top:0;width:20%;height:100%}.cq-sidemenu .title{padding:10px 6px;color:#08c;font-weight:bold;text-align:center}.cq-sidemenu .cq-menus{list-style:none;padding:0;color:#999;margin:10px 6px 0 0}.cq-sidemenu .cq-menus>li{box-sizing:border-box;padding:4px 8px;border-left:4px solid transparent;cursor:pointer}.cq-sidemenu .cq-menus>li.active{color:#666;border-left-color:#999;cursor:default;pointer-events:none}.cq-settings-close{position:absolute;top:6px;right:6px;font-size:3em;width:20px;height:20px}.cq-settings-close:after,.cq-settings-close:before{position:absolute;left:9px;content:' ';width:3px;height:100%;background-color:#ccc;-webkit-transition:all .2s linear;transition:all .2s linear}.cq-settings-close:after{-webkit-transform:rotate(45deg);-ms-transform:rotate(45deg);transform:rotate(45deg)}.cq-settings-close:before{-webkit-transform:rotate(-45deg);-ms-transform:rotate(-45deg);transform:rotate(-45deg)}.cq-settings-close:hover:after,.cq-settings-close:hover:before{background-color:#555}.cq-setting-wrapper{width:80%;margin-left:20%;padding:8px 14px 8px 0;box-sizing:border-box;height:100%;overflow:hidden;overflow-y:auto}.cq-setting-content{display:none}.cq-setting-content.active{display:block}.cq-setting-content .title{font-size:1.2em;padding:8px;border-bottom:1px solid #ccc;margin-bottom:10px}.cq-setting-content .title>small{color:#777;font-size:.8em;margin-left:8px}.cq-input-wrapper{margin-bottom:10px}.cq-kwds{list-style:none;padding:0;margin:0;color:#888;font-size:.8em}.cq-kwds>li{display:inline-block;margin-right:4px;border:1px solid #ddd;padding:3px 12px;border-radius:16px;margin-bottom:6px;cursor:default}.cq-kwds>li>.close{margin-left:2px;font-size:1.2em;cursor:pointer}.cq-kwds>li>.close:after{content:'×'}.cq-kwds>li:hover{box-shadow:0 2px 2px #ccc}.cq-kwds>li:hover>.close{color:#333}.cq-themes{list-style:none;padding:0;margin:0}.cq-themes>li{position:relative;display:inline-block;margin-right:1em;border-radius:6px;border:1px solid #ddd;width:46%;padding-bottom:23%;margin-bottom:6px;cursor:pointer;vertical-align:middle;overflow:hidden}.cq-themes>li>img{position:absolute;top:0;-webkit-filter:blur(6px) saturate(2);background-size:cover;max-width:100%;height:auto}.cq-themes>li.cq-selected{cursor:default;pointer-events:none}.cq-themes>li.cq-selected:before{position:absolute;top:0;left:0;bottom:0;right:0;content:' ';background-color:rgba(255,255,255,0.3);z-index:1}.cq-themes>li.cq-selected:after{content:'✓';font-size:2em;position:absolute;top:50%;left:50%;margin-top:-1em;margin-left:-0.5em;z-index:2}",document.head.appendChild(a))},p=document.getElementById("pageContent"),k=document.querySelector(".mod-side-nav-message"),w=document.querySelector(".col-main-sidebar"),m=document.querySelector(".col-main-feed"),o=function(){var a,b;b=p.getBoundingClientRect().top,k.classList[41>=b?"add":"remove"]("cq-fixed-sidebar"),a=-1750>=b?"add":"remove",w.classList[a]("cq-hide"),m.classList[a]("cq-fullwidth")},n=function(a){var b,c;a.metaKey&&13===a.keyCode&&(c=i(a.target,"qz-poster-inner"))&&(b=c.querySelector(".btn-post"),null!=b&&b.click())},x=function(){var a;try{return QZONE.music.qqplayer_play_flag=0,QZONE.music.pauseMusic()}catch(b){a=b}},h=function(){var a;a=y(o),a(),window.addEventListener("scroll",a),~navigator.userAgent.indexOf("OS X")&&p.addEventListener("keydown",function(a){a.target.classList.contains("textarea")&&n(a)},!0)},c=0,l.addKwd("莱特币"),d=[],q=function(){u(),t()},u=function(){var a,b;b=[".votestar",".buy-info",'[href="http://user.qzone.qq.com/20050606"]'],a=document.querySelectorAll(b.join(",")),Array.prototype.forEach.call(a,v)},t=function(){var a,b;d=l.getKwds(),d&&d.length&&(b=[".f-info",".f-ct"],a=document.querySelectorAll(b.join(",")),Array.prototype.forEach.call(a,s))},s=function(a){var b,c;c=a.innerText,b=d.some(function(a){return~c.indexOf(a)}),b&&v(a)},v=function(a){(a=i(a,"f-single"))&&(r(a)&&console.info("%cremove ads(NO."+ ++c+"): %c"+a.innerText,"color:#5d7895","color: #333"),a=null)},g=function(){var a;a=f(q),a(),document.getElementById("main_feed_container").addEventListener("DOMSubtreeModified",a)},b="0.0.14",a.checkCqUpdate=function(a){b!==a.version&&a.version!==l.get("version")&&(a.oldVersion=b,showExtUpdateAlert(a),l.get("version",a.version))},e=function(){var a;a=document.createElement("script"),a.src="https://cdn.rawgit.com/evecalm/clean-qzone/master/dist/clean-qzone.check-update.js",a.type="text/javascript",document.body.appendChild(a)},function(){j(),document.querySelector(".mod-side-nav-message")&&(g(),h(),e())}()}proxy(main);
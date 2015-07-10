# 初始化
do ->
  # 不在个人主页则返回
  return unless document.querySelector '.mod-side-nav-message'

  do injectStyle
  do doRemoveDynamicMoments
  do doUXOpt

  return

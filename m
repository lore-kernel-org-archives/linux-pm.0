From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] thermal: rockchip: fix compile error
Date: Wed, 11 Nov 2015 19:43:11 -0800
Message-ID: <1447299791-9419-2-git-send-email-edubezval@gmail.com>
References: <1447299791-9419-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447299791-9419-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Caesar Wang <wxt@rock-chips.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Caesar Wang <wxt@rock-chips.com>

Missing a include file caused compile error.

drivers/thermal/rockchip_thermal.c:
In function 'rockchip_thermal_suspend':
drivers/thermal/rockchip_thermal.c:720:2: error: implicit
declaration of function 'pinctrl_pm_select_sleep_state'
[-Werror=implicit-function-declaration]
pinctrl_pm_select_sleep_state(dev);
                 ^
drivers/thermal/rockchip_thermal.c:
In function 'rockchip_thermal_resume':
drivers/thermal/rockchip_thermal.c:759:2: error: implicit
declaration of function 'pinctrl_pm_select_default_state'
[-Werror=implicit-function-declaration]
^pinctrl_pm_select_default_state(dev);
cc1: some warnings being treated as errors

Fixes: 7e38a5b1daa1 ("thermal: rockchip: support the sleep pinctrl state
to avoid glitches")

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/rockchip_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 2b58870..9787e8a 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/thermal.h>
+#include <linux/pinctrl/consumer.h>
 
 /**
  * If the temperature over a period of time High,
-- 
2.5.0

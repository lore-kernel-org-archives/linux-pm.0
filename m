From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] thermal: rockchip: fix compile error
Date: Sun,  8 Nov 2015 21:40:43 +0800
Message-ID: <1446990043-8096-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

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

Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Reported-by: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/thermal/rockchip_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index df28049..8928d67 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/thermal.h>
+#include <linux/pinctrl/consumer.h>
 
 /**
  * If the temperature over a period of time High,
-- 
1.9.1

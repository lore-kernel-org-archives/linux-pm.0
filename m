From: <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v1 08/16] rtc: mediatek: remove unnecessary irq_dispose_mapping
Date: Fri, 23 Mar 2018 17:15:05 +0800
Message-ID: <96f39ce7f57a4dcd7653e049eebc87c83bcbdfc9.1521794177.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1521794176.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

It's unnecessary doing irq_dispose_mapping as a reverse operation for
platform_get_irq.

Ususally, irq_dispose_mapping should be called in error path or module
removal to release the resources for irq_of_parse_and_map requested.

Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/rtc/rtc-mt6397.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index b62eaa8..cefb83b 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/irqdomain.h>
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
@@ -336,7 +335,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
-		goto out_dispose_irq;
+		return ret;
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
@@ -353,8 +352,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 out_free_irq:
 	free_irq(rtc->irq, rtc->rtc_dev);
-out_dispose_irq:
-	irq_dispose_mapping(rtc->irq);
+
 	return ret;
 }
 
@@ -364,7 +362,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
 
 	rtc_device_unregister(rtc->rtc_dev);
 	free_irq(rtc->irq, rtc->rtc_dev);
-	irq_dispose_mapping(rtc->irq);
 
 	return 0;
 }
-- 
2.7.4

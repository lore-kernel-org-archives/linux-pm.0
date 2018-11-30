From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] thermal/drivers/hisi: Fix wrong platform_get_irq_byname()
Date: Fri, 30 Nov 2018 09:00:31 +0100
Message-ID: <1543564833-643-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: vincent.guittot@linaro.org, john.stultz@linaro.org, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Without this patch, the thermal driver on hi6220 and hi3660 is broken.

That is due because part of the posted patchset was merged but a small
change in the DT was dropped.

The hi6220 and hi3660 do not have an interrupt name in the DT, so
finding interrupt by name fails.

Fix this by returning back to the platform_get_irq() function call.

Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index c4111a9..50f4d00 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -589,7 +589,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		ret = platform_get_irq_byname(pdev, sensor->irq_name);
+		ret = platform_get_irq(pdev, 0);
 		if (ret < 0)
 			return ret;
 
-- 
2.7.4

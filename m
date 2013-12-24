From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V2] thermal: imx: correct suspend/resume flow
Date: Tue, 24 Dec 2013 09:43:24 -0500
Message-ID: <1387896204-31754-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:29162
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757912Ab3LXCpa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 21:45:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, shawn.guo@linaro.org, eduardo.valentin@ti.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes regression introduced by:

commit 37713a1e8e4c1a1067ad4c99296f78d3c82ed9c4
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu Aug 1 18:33:12 2013 +0200

    thermal: imx: implement thermal alarm interrupt handling

The commit 37713a1e8e4 makes imx thermal sensor always powered up as alarm
function is enabled, but the suspend callback of imx thermal returns
success only if thermal sensor is powered down, so it will always returns
fail hence break system's suspend, this patch disables imx thermal sensor
before suspend and re-enable it after resume.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/thermal/imx_thermal.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index cbb16f3..9a9a6c2 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -510,27 +510,30 @@ static int imx_thermal_suspend(struct device *dev)
 {
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	struct regmap *map = data->tempmon;
-	u32 val;
 
-	regmap_read(map, TEMPSENSE0, &val);
-	if ((val & TEMPSENSE0_POWER_DOWN) == 0) {
-		/*
-		 * If a measurement is taking place, wait for a long enough
-		 * time for it to finish, and then check again.  If it still
-		 * does not finish, something must go wrong.
-		 */
-		udelay(50);
-		regmap_read(map, TEMPSENSE0, &val);
-		if ((val & TEMPSENSE0_POWER_DOWN) == 0)
-			return -ETIMEDOUT;
-	}
+	/*
+	 * Need to disable thermal sensor, otherwise, when thermal core
+	 * try to get temperature before thermal sensor resume, a wrong
+	 * temperature will be read as the thermal sensor is powered
+	 * down.
+	 */
+	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	data->mode = THERMAL_DEVICE_DISABLED;
 
 	return 0;
 }
 
 static int imx_thermal_resume(struct device *dev)
 {
-	/* Nothing to do for now */
+	struct imx_thermal_data *data = dev_get_drvdata(dev);
+	struct regmap *map = data->tempmon;
+
+	/* Enabled thermal sensor after resume */
+	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	return 0;
 }
 #endif
-- 
1.7.9.5



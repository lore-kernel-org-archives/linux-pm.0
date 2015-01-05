From: Anson Huang <b20788@freescale.com>
Subject: [PATCH] Thermal: imx: add clk disable/enable for suspend/resume
Date: Mon, 5 Jan 2015 22:29:13 +0800
Message-ID: <1420468153-19142-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2on0137.outbound.protection.outlook.com ([207.46.100.137]:54592
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751068AbbAEHHV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 Jan 2015 02:07:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com

Thermal sensor's clk is from pll3_usb_otg, per hardware
design requirement, need to make sure pll3_usb_otg is disabled
before STOP mode is entered, otherwise, all PFDs under it may
enter incorrect state, this patch disables pll3_usb_otg before
suspend and enables it after resume.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/thermal/imx_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 461bf3d..03894da 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -600,6 +600,8 @@ static int imx_thermal_suspend(struct device *dev)
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
 	data->mode = THERMAL_DEVICE_DISABLED;
+	if (!IS_ERR(data->thermal_clk))
+		clk_disable_unprepare(data->thermal_clk);
 
 	return 0;
 }
@@ -609,6 +611,8 @@ static int imx_thermal_resume(struct device *dev)
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	struct regmap *map = data->tempmon;
 
+	if (!IS_ERR(data->thermal_clk))
+		clk_prepare_enable(data->thermal_clk);
 	/* Enabled thermal sensor after resume */
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
-- 
1.9.1


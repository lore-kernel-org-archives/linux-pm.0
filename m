From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V2] Thermal: imx: add clk disable/enable for suspend/resume
Date: Tue, 6 Jan 2015 18:50:22 +0800
Message-ID: <1420541422-27602-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, jangra.pankaj9@gmail.com
List-Id: linux-pm@vger.kernel.org

Thermal sensor's clk is from pll3_usb_otg, per hardware
design requirement, need to make sure pll3_usb_otg is disabled
before STOP mode is entered, otherwise, all PFDs under it may
enter incorrect state, this patch disables pll3_usb_otg before
suspend and enables it after resume.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/thermal/imx_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 461bf3d..dc8bcd8 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -600,6 +600,7 @@ static int imx_thermal_suspend(struct device *dev)
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
 	data->mode = THERMAL_DEVICE_DISABLED;
+	clk_disable_unprepare(data->thermal_clk);
 
 	return 0;
 }
@@ -609,6 +610,7 @@ static int imx_thermal_resume(struct device *dev)
 	struct imx_thermal_data *data = dev_get_drvdata(dev);
 	struct regmap *map = data->tempmon;
 
+	clk_prepare_enable(data->thermal_clk);
 	/* Enabled thermal sensor after resume */
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
-- 
1.9.1

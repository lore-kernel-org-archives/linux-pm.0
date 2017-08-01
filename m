From: Louis Yu <louis.yu@mediatek.com>
Subject: [PATCH v2 3/4] thermal: mediatek: extend calibration data for mt2712 chip
Date: Tue, 1 Aug 2017 15:28:32 +0800
Message-ID: <1501572513-7958-4-git-send-email-louis.yu@mediatek.com>
References: <1501572513-7958-1-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:31241 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751615AbdHAH3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 03:29:53 -0400
In-Reply-To: <1501572513-7958-1-git-send-email-louis.yu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dawei Chien <dawei.chien@mediatek.com>, Fan Chen <fan.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Louis Yu <louis.yu@mediatek.com>

This patch adds support for mt2712 chip thermal calibration data
and calculation, and is compatible with the existing chips.

Signed-off-by: Louis Yu <louis.yu@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index e35d28d..b609589 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -112,10 +112,10 @@
 
 /*
  * Layout of the fuses providing the calibration data
- * These macros could be used for both MT8173, MT2701, and MT2712.
- * MT8173 has five sensors and need five VTS calibration data,
- * and MT2701 has three sensors and need three VTS calibration data,
- * and MT2712 has four sensors and need four VTS calibration data.
+ * These macros could be used for MT8173, MT2701, and MT2712.
+ * MT8173 has 5 sensors and needs 5 VTS calibration data.
+ * MT2701 has 3 sensors and needs 3 VTS calibration data.
+ * MT2712 has 4 sensors and needs 4 VTS calibration data.
  */
 #define MT8173_CALIB_BUF0_VALID		BIT(0)
 #define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
@@ -126,6 +126,8 @@
 #define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14) & 0x1ff)
 #define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
 #define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
+#define MT8173_CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
+#define MT8173_CALIB_BUF1_ID(x)	(((x) >> 9) & 0x1)
 
 /* MT2701 thermal sensors */
 #define MT2701_TS1	0
@@ -609,7 +611,11 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 		mt->vts[MT8173_TS4] = MT8173_CALIB_BUF2_VTS_TS4(buf[2]);
 		mt->vts[MT8173_TSABB] = MT8173_CALIB_BUF2_VTS_TSABB(buf[2]);
 		mt->degc_cali = MT8173_CALIB_BUF0_DEGC_CALI(buf[0]);
-		mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
+		if (MT8173_CALIB_BUF1_ID(buf[1]) &
+		    MT8173_CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
+			mt->o_slope = -MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
+		else
+			mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
 	} else {
 		dev_info(dev, "Device not calibrated, using default calibration values\n");
 	}
-- 
1.8.1.1.dirty

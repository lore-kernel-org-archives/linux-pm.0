From: <louis.yu@mediatek.com>
Subject: [PATCH v1 3/4] thermal: mediatek: extend calibration data for mt2712 chip
Date: Thu, 27 Jul 2017 13:46:56 +0800
Message-ID: <1501134417-3505-4-git-send-email-louis.yu@mediatek.com>
References: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:37381 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdG0FsK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 01:48:10 -0400
In-Reply-To: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, dawei.chien@mediatek.com, fan.chen@mediatek.com, eddie.huang@mediatek.com, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Louis Yu <louis.yu@mediatek.com>

From: Louis Yu <louis.yu@mediatek.com>

This patch adds support for mt2712 chip thermal calibration data
and calculation.

Signed-off-by: Louis Yu <louis.yu@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index e35d28d..f2a7155 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
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
1.9.1

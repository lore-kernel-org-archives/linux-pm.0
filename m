From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/2] thermal: mtk: Cleanup unused defines
Date: Fri,  1 Dec 2017 11:43:21 +0100
Message-ID: <20171201104321.8410-1-matthias.bgg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: matthias.bgg@gmail.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
List-Id: linux-pm@vger.kernel.org

The mtk_thermal has some defiens which are never used within the driver.
This patch delets them.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/thermal/mtk_thermal.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 1e61c09153c9..c75661a3801a 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -32,15 +32,10 @@
 #include <linux/types.h>
 
 /* AUXADC Registers */
-#define AUXADC_CON0_V		0x000
-#define AUXADC_CON1_V		0x004
 #define AUXADC_CON1_SET_V	0x008
 #define AUXADC_CON1_CLR_V	0x00c
 #define AUXADC_CON2_V		0x010
 #define AUXADC_DATA(channel)	(0x14 + (channel) * 4)
-#define AUXADC_MISC_V		0x094
-
-#define AUXADC_CON1_CHANNEL(x)	BIT(x)
 
 #define APMIXED_SYS_TS_CON1	0x604
 
@@ -158,8 +153,6 @@
 /* The number of sensing points per bank */
 #define MT2712_NUM_SENSORS_PER_ZONE	4
 
-#define THERMAL_NAME    "mtk-thermal"
-
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -765,7 +758,7 @@ static struct platform_driver mtk_thermal_driver = {
 	.probe = mtk_thermal_probe,
 	.remove = mtk_thermal_remove,
 	.driver = {
-		.name = THERMAL_NAME,
+		.name = "mtk-thermal",
 		.of_match_table = mtk_thermal_of_match,
 	},
 };
-- 
2.12.3

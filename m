From: <sean.wang@mediatek.com>
Subject: [PATCH v2 2/2] soc: mediatek: reuse regmap_read_poll_timeout helpers
Date: Mon, 23 Apr 2018 14:42:45 +0800
Message-ID: <ed866d3345a27b2c87b570562d9ad9132bca6062.1524465345.git.sean.wang@mediatek.com>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Reuse the common helpers regmap_read_poll_timeout provided by Linux core
instead of an open-coded handling.

v1 -> v2:
 - use macro definitions MTK_POLL_DELAY_US and MTK_POLL_TIMEOUT for
   arguments sleep_us and timeout_us passing in regmap_read_poll_timeout.
 - remove unnecessary linux/iopoll.h being included in.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-infracfg.c | 46 ++++++++++---------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index 8c310de..958861c 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -17,6 +17,9 @@
 #include <linux/soc/mediatek/infracfg.h>
 #include <asm/processor.h>
 
+#define MTK_POLL_DELAY_US   10
+#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
+
 #define INFRA_TOPAXI_PROTECTEN		0x0220
 #define INFRA_TOPAXI_PROTECTSTA1	0x0228
 #define INFRA_TOPAXI_PROTECTEN_SET	0x0260
@@ -37,7 +40,6 @@
 int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 		bool reg_update)
 {
-	unsigned long expired;
 	u32 val;
 	int ret;
 
@@ -47,22 +49,11 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 	else
 		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
 
-	expired = jiffies + HZ;
-
-	while (1) {
-		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
-		if (ret)
-			return ret;
-
-		if ((val & mask) == mask)
-			break;
+	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
+				       val, (val & mask) == mask,
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 
-		cpu_relax();
-		if (time_after(jiffies, expired))
-			return -EIO;
-	}
-
-	return 0;
+	return ret;
 }
 
 /**
@@ -80,30 +71,17 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
 		bool reg_update)
 {
-	unsigned long expired;
 	int ret;
+	u32 val;
 
 	if (reg_update)
 		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
 	else
 		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
 
-	expired = jiffies + HZ;
-
-	while (1) {
-		u32 val;
-
-		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
-		if (ret)
-			return ret;
-
-		if (!(val & mask))
-			break;
-
-		cpu_relax();
-		if (time_after(jiffies, expired))
-			return -EIO;
-	}
+	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
+				       val, !(val & mask),
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 
-	return 0;
+	return ret;
 }
-- 
2.7.4

From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] thermal: mediatek: use of_device_get_match_data()
Date: Mon, 16 Apr 2018 10:34:16 +0800
Message-ID: <475b09ee810255f6e98fb7a63e5afb1723b0328c.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dawei Chien <dawei.chien@mediatek.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>
List-Id: linux-pm@vger.kernel.org

The usage of of_device_get_match_data() reduce the code size a bit.

Also, the only way to call mtk_thermal_probe() is to match an entry in
mtk_thermal_of_match[], so of_id cannot be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index c75661a..12c3bc4 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -642,7 +642,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	struct device_node *auxadc, *apmixedsys, *np = pdev->dev.of_node;
 	struct mtk_thermal *mt;
 	struct resource *res;
-	const struct of_device_id *of_id;
 	u64 auxadc_phys_base, apmixed_phys_base;
 	struct thermal_zone_device *tzdev;
 
@@ -650,9 +649,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (!mt)
 		return -ENOMEM;
 
-	of_id = of_match_device(mtk_thermal_of_match, &pdev->dev);
-	if (of_id)
-		mt->conf = (const struct mtk_thermal_data *)of_id->data;
+	mt->conf = of_device_get_match_data(&pdev->dev);
 
 	mt->clk_peri_therm = devm_clk_get(&pdev->dev, "therm");
 	if (IS_ERR(mt->clk_peri_therm))
-- 
1.9.1

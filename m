From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V3 20/21] thermal: exynos: Support for TMU regulator defined at device tree
Date: Tue,  7 May 2013 18:31:10 +0530
Message-ID: <1367931671-3906-21-git-send-email-amit.daniel@samsung.com>
References: <1367931671-3906-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1367931671-3906-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

TMU probe function now checks for a device tree defined regulator.
For compatibility reasons it is allowed to probe driver even without
this regulator defined.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 .../devicetree/bindings/thermal/exynos-thermal.txt |    4 ++++
 drivers/thermal/samsung/exynos_tmu.c               |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 970eeba..ff62f7a 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -14,6 +14,9 @@
 - interrupts : Should contain interrupt for thermal system
 - clocks : The main clock for TMU device
 - clock-names : Thermal system clock name
+- vtmu-supply: This entry is optional and provides the regulator node supplying
+		voltage to TMU. If needed this entry can be placed inside
+		board/platform specific dts file.
 
 Example 1):
 
@@ -25,6 +28,7 @@ Example 1):
 		clocks = <&clock 383>;
 		clock-names = "tmu_apbif";
 		status = "disabled";
+		vtmu-supply = <&tmu_regulator_node>;
 	};
 
 Example 2):
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 72446c9..b7c609a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -32,6 +32,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include "exynos_thermal_common.h"
@@ -52,6 +53,7 @@
  * @clk: pointer to the clock structure.
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
+ * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  */
 struct exynos_tmu_data {
@@ -65,6 +67,7 @@ struct exynos_tmu_data {
 	struct mutex lock;
 	struct clk *clk;
 	u8 temp_error1, temp_error2;
+	struct regulator *regulator;
 	struct thermal_sensor_conf *reg_conf;
 };
 
@@ -501,10 +504,23 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	struct resource res;
+	int ret;
 
 	if (!data)
 		return -ENODEV;
 
+	/* Try enabling the regulator if found */
+	data->regulator = devm_regulator_get(&pdev->dev, "vtmu");
+	if (!IS_ERR(data->regulator)) {
+		ret = regulator_enable(data->regulator);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable vtmu\n");
+			return ret;
+		}
+	} else {
+		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
+	}
+
 	data->id = of_alias_get_id(pdev->dev.of_node, "tmuctrl");
 	if (data->id < 0)
 		data->id = 0;
@@ -669,6 +685,9 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_unprepare(data->clk);
 
+	if (!IS_ERR(data->regulator))
+		regulator_disable(data->regulator);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.7.1

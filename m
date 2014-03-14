From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 4/8] devfreq: exynos4: Add ppmu's clock control and code
 clean about regulator control
Date: Fri, 14 Mar 2014 18:30:04 +0900
Message-ID: <1394789408-14648-5-git-send-email-cw00.choi@samsung.com>
References: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

There are not the clock controller of ppmudmc0/1. This patch control the clock
of ppmudmc0/1 which is used for monitoring memory bus utilization.

Also, this patch code clean about regulator control and free resource
when calling exit/remove function.

For example,
busfreq@106A0000 {
	compatible = "samsung,exynos4x12-busfreq";

	/* Clock for PPMUDMC0/1 */
	clocks = <&clock CLK_PPMUDMC0>, <&clock CLK_PPMUDMC1>;
	clock-names = "ppmudmc0", "ppmudmc1";

	/* Regulator for MIF/INT block */
	vdd_mif-supply = <&buck1_reg>;
	vdd_int-supply = <&buck3_reg>;
};

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c | 104 ++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index 8ccbb31..60539e8 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -62,6 +62,11 @@ enum exynos_ppmu_idx {
 	PPMU_END,
 };
 
+static const char *exynos_ppmu_clk_name[] = {
+	[PPMU_DMC0]	= "ppmudmc0",
+	[PPMU_DMC1]	= "ppmudmc1",
+};
+
 #define EX4210_LV_MAX	LV_2
 #define EX4x12_LV_MAX	LV_4
 #define EX4210_LV_NUM	(LV_2 + 1)
@@ -86,6 +91,7 @@ struct busfreq_data {
 	struct regulator *vdd_mif; /* Exynos4412/4212 only */
 	struct busfreq_opp_info curr_oppinfo;
 	struct exynos_ppmu ppmu[PPMU_END];
+	struct clk *clk_ppmu[PPMU_END];
 
 	struct notifier_block pm_notifier;
 	struct mutex lock;
@@ -724,6 +730,19 @@ static void exynos4_bus_exit(struct device *dev)
 	struct busfreq_data *data = dev_get_drvdata(dev);
 	int i;
 
+	/*
+	 * Un-map memory map and disable regulator/clocks
+	 * to prevent power leakage.
+	 */
+	regulator_disable(data->vdd_int);
+	if (data->type == TYPE_BUSF_EXYNOS4x12)
+		regulator_disable(data->vdd_mif);
+
+	for (i = 0; i < PPMU_END; i++) {
+		if (data->clk_ppmu[i])
+			clk_disable_unprepare(data->clk_ppmu[i]);
+	}
+
 	for (i = 0; i < PPMU_END; i++) {
 		if (data->ppmu[i].hw_base)
 			iounmap(data->ppmu[i].hw_base);
@@ -991,6 +1010,7 @@ static int exynos4_busfreq_parse_dt(struct busfreq_data *data)
 {
 	struct device *dev = data->dev;
 	struct device_node *np = dev->of_node;
+	const char **clk_name = exynos_ppmu_clk_name;
 	int i, ret;
 
 	if (!np) {
@@ -1009,8 +1029,70 @@ static int exynos4_busfreq_parse_dt(struct busfreq_data *data)
 		}
 	}
 
+	/*
+	 * Get PPMU's clocks to control them. But, if PPMU's clocks
+	 * is default 'pass' state, this driver don't need control
+	 * PPMU's clock.
+	 */
+	for (i = 0; i < PPMU_END; i++) {
+		data->clk_ppmu[i] = devm_clk_get(dev, clk_name[i]);
+		if (IS_ERR_OR_NULL(data->clk_ppmu[i])) {
+			dev_warn(dev, "Cannot get %s clock\n", clk_name[i]);
+			data->clk_ppmu[i] = NULL;
+		}
+
+		ret = clk_prepare_enable(data->clk_ppmu[i]);
+		if (ret < 0) {
+			dev_warn(dev, "Cannot enable %s clock\n", clk_name[i]);
+			data->clk_ppmu[i] = NULL;
+			goto err_clocks;
+		}
+	}
+
+	/* Get regulator to control voltage of int block */
+	data->vdd_int = devm_regulator_get(dev, "vdd_int");
+	if (IS_ERR(data->vdd_int)) {
+		dev_err(dev, "Failed to get the regulator of vdd_int\n");
+		ret = PTR_ERR(data->vdd_int);
+		goto err_clocks;
+	}
+	ret = regulator_enable(data->vdd_int);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulator of vdd_int\n");
+		goto err_clocks;
+	}
+
+	switch (data->type) {
+	case TYPE_BUSF_EXYNOS4210:
+		break;
+	case TYPE_BUSF_EXYNOS4x12:
+		/* Get regulator to control voltage of mif blk if Exynos4x12 */
+		data->vdd_mif = devm_regulator_get(dev, "vdd_mif");
+		if (IS_ERR(data->vdd_mif)) {
+			dev_err(dev, "Failed to get the regulator vdd_mif\n");
+			ret = PTR_ERR(data->vdd_mif);
+			goto err_regulator;
+		}
+		ret = regulator_enable(data->vdd_mif);
+		if (ret < 0) {
+			dev_err(dev, "Failed to enable regulator of vdd_mif\n");
+			goto err_regulator;
+		}
+		break;
+	default:
+		dev_err(dev, "Unknown device type : %d\n", data->type);
+		return -EINVAL;
+	};
+
 	return 0;
 
+err_regulator:
+	regulator_disable(data->vdd_int);
+err_clocks:
+	for (i = 0; i < PPMU_END; i++) {
+		if (data->clk_ppmu[i])
+			clk_disable_unprepare(data->clk_ppmu[i]);
+	}
 err_iomap:
 	for (i = 0; i < PPMU_END; i++) {
 		if (data->ppmu[i].hw_base)
@@ -1075,19 +1157,6 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	data->vdd_int = devm_regulator_get(dev, "vdd_int");
-	if (IS_ERR(data->vdd_int)) {
-		dev_err(dev, "Cannot get the regulator \"vdd_int\"\n");
-		return PTR_ERR(data->vdd_int);
-	}
-	if (data->type == TYPE_BUSF_EXYNOS4x12) {
-		data->vdd_mif = devm_regulator_get(dev, "vdd_mif");
-		if (IS_ERR(data->vdd_mif)) {
-			dev_err(dev, "Cannot get the regulator \"vdd_mif\"\n");
-			return PTR_ERR(data->vdd_mif);
-		}
-	}
-
 	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_floor(dev,
 					 &exynos4_devfreq_profile.initial_freq);
@@ -1147,6 +1216,15 @@ err_notifier_opp:
 	return err;
 
 err_devfreq:
+	regulator_disable(data->vdd_int);
+	if (data->type == TYPE_BUSF_EXYNOS4x12)
+		regulator_disable(data->vdd_mif);
+
+	for (i = 0; i < PPMU_END; i++) {
+		if (data->clk_ppmu[i])
+			clk_disable_unprepare(data->clk_ppmu[i]);
+	}
+
 	for (i = 0; i < PPMU_END; i++) {
 		if (data->ppmu[i].hw_base)
 			iounmap(data->ppmu[i].hw_base);
-- 
1.8.0

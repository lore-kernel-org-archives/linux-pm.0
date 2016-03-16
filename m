From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V8 11/14] thermal: tegra: handle HW initialization in one funcotion
Date: Wed, 16 Mar 2016 16:58:35 +0800
Message-ID: <1458118715-30036-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Handle HW initialization in one function soctherm_init(),
so that the codes are more clear.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 85 +++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index f60106884ac4..52793132bd4e 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -95,19 +95,11 @@ struct tegra_soctherm {
 	struct dentry *debugfs_dir;
 };
 
-static int enable_tsensor(struct tegra_soctherm *tegra,
-			  unsigned int i,
-			  const struct tsensor_shared_calib *shared)
+static void enable_tsensor(struct tegra_soctherm *tegra, unsigned int i)
 {
 	const struct tegra_tsensor *sensor = &tegra->soc->tsensors[i];
 	void __iomem *base = tegra->regs + sensor->base;
-	u32 *calib = &tegra->calib[i];
 	unsigned int val;
-	int err;
-
-	err = tegra_calc_tsensor_calib(sensor, shared, calib);
-	if (err)
-		return err;
 
 	val = sensor->config->tall << SENSOR_CONFIG0_TALL_SHIFT;
 	writel(val, base + SENSOR_CONFIG0);
@@ -118,9 +110,7 @@ static int enable_tsensor(struct tegra_soctherm *tegra,
 	val |= SENSOR_CONFIG1_TEMP_ENABLE;
 	writel(val, base + SENSOR_CONFIG1);
 
-	writel(*calib, base + SENSOR_CONFIG2);
-
-	return 0;
+	writel(tegra->calib[i], base + SENSOR_CONFIG2);
 }
 
 /*
@@ -461,6 +451,34 @@ static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
 	return 0;
 }
 
+static void soctherm_init(struct platform_device *pdev)
+{
+	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
+	const struct tegra_tsensor_group **ttgs = tegra->soc->ttgs;
+	int i;
+	u32 pdiv, hotspot;
+
+	/* Initialize raw sensors */
+	for (i = 0; i < tegra->soc->num_tsensors; ++i)
+		enable_tsensor(tegra, i);
+
+	/* program pdiv and hotspot offsets per THERM */
+	pdiv = readl(tegra->regs + SENSOR_PDIV);
+	hotspot = readl(tegra->regs + SENSOR_HOTSPOT_OFF);
+	for (i = 0; i < tegra->soc->num_ttgs; ++i) {
+		pdiv = REG_SET_MASK(pdiv, ttgs[i]->pdiv_mask,
+				    ttgs[i]->pdiv);
+		/* hotspot offset from PLLX, doesn't need to configure PLLX */
+		if (ttgs[i]->id == TEGRA124_SOCTHERM_SENSOR_PLLX)
+			continue;
+		hotspot =  REG_SET_MASK(hotspot,
+					ttgs[i]->pllx_hotspot_mask,
+					ttgs[i]->pllx_hotspot_diff);
+	}
+	writel(pdiv, tegra->regs + SENSOR_PDIV);
+	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
+}
+
 static const struct of_device_id tegra_soctherm_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 	{
@@ -488,7 +506,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	struct tegra_soctherm_soc *soc;
 	unsigned int i;
 	int err;
-	u32 pdiv, hotspot;
 
 	match = of_match_node(tegra_soctherm_of_match, pdev->dev.of_node);
 	if (!match)
@@ -529,45 +546,31 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->clock_soctherm);
 	}
 
-	err = soctherm_clk_enable(pdev, true);
-	if (err)
-		return err;
-
-	/* Initialize raw sensors */
-
 	tegra->calib = devm_kzalloc(&pdev->dev,
 				    sizeof(u32) * soc->num_tsensors,
 				    GFP_KERNEL);
-	if (!tegra->calib) {
-		err = -ENOMEM;
-		goto disable_clocks;
-	}
+	if (!tegra->calib)
+		return -ENOMEM;
 
+	/* calculate shared calibration data */
 	err = tegra_calc_shared_calib(soc->tfuse, &shared_calib);
 	if (err)
-		goto disable_clocks;
+		return err;
 
+	/* calculate tsensor calibaration data */
 	for (i = 0; i < soc->num_tsensors; ++i) {
-		err = enable_tsensor(tegra, i, &shared_calib);
+		err = tegra_calc_tsensor_calib(&soc->tsensors[i],
+					       &shared_calib,
+					       &tegra->calib[i]);
 		if (err)
-			goto disable_clocks;
+			return err;
 	}
 
-	/* Program pdiv and hotspot offsets per THERM */
-	pdiv = readl(tegra->regs + SENSOR_PDIV);
-	hotspot = readl(tegra->regs + SENSOR_HOTSPOT_OFF);
-	for (i = 0; i < soc->num_ttgs; ++i) {
-		pdiv = REG_SET_MASK(pdiv, soc->ttgs[i]->pdiv_mask,
-				    soc->ttgs[i]->pdiv);
-		/* hotspot offset from PLLX, doesn't need to configure PLLX */
-		if (soc->ttgs[i]->id == TEGRA124_SOCTHERM_SENSOR_PLLX)
-			continue;
-		hotspot =  REG_SET_MASK(hotspot,
-					soc->ttgs[i]->pllx_hotspot_mask,
-					soc->ttgs[i]->pllx_hotspot_diff);
-	}
-	writel(pdiv, tegra->regs + SENSOR_PDIV);
-	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
+	err = soctherm_clk_enable(pdev, true);
+	if (err)
+		return err;
+
+	soctherm_init(pdev);
 
 	for (i = 0; i < soc->num_ttgs; ++i) {
 		struct tegra_thermctl_zone *zone =
-- 
1.9.1

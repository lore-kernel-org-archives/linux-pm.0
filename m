From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V9 RESEND 11/14] thermal: tegra: handle HW initialization in one funcotion
Date: Tue, 29 Mar 2016 18:29:21 +0800
Message-ID: <1459247364-1139-12-git-send-email-wni@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459247364-1139-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Handle HW initialization in one function soctherm_init(),
so that the codes are more clear.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/tegra/soctherm.c | 85 +++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index deeb3b7e4dac..d2b7c255d71f 100644
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

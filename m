Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10C3A1687;
	Thu, 30 Jul 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400501; cv=none; b=T4KUwuycrf5dgL0SB230HuzlKjrEhzwskTfrZwEVwe6BsjyhjOljPM61o3DvfBD2YKSl/SKe4GQjkKHmSTqYTLIOk249+P0wsjpqtMl3Mjirxqazm7o1ZMsvQywvnhMB2mzYIeDcEBska0iytoOgLu5ZX9zq5ihZEFtdj9BTOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400501; c=relaxed/simple;
	bh=d7tDHoboVhuxtOob+TZ2oOt1FDoIpcp+2xMOD4GJZrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJnUZtvc5r5bJtVKE5FlFEkSSeYPID08iQdGy/cKR0kC0ZYkOdDi1mR9fboo4FjCYA8WYJYoM1WdGb+1kUML1E6k2Aa5stjUxJnPW8O3i5i+wtQHZwIv/PS5pgxhToTRd+NP98ERQA3caFXPYMJ8HXH4k5TOcPoJJj2JpuO62pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfXcimdu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfXcimdu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF741C2BCB9;
	Thu, 30 Jul 2026 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785400500;
	bh=d7tDHoboVhuxtOob+TZ2oOt1FDoIpcp+2xMOD4GJZrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rfXcimduWWGnyI6qHNKjk1Efg+NB3/wnWZD3osKiVjJyZW11gLEaM1yuIbJRJqxWP
	 NqTbi84rQjHNb1lMbvyzsjnd5myrbzmX/SDnZ73AscNhNLI6qQOtk1e0A4XdKIhJuF
	 TEP48OCdfSdhrtJ9WCali6yezmVe07dogfiM7PeD1SECKy/thaRx6A+1kdGYr0ngGy
	 WId9YUCEd0UJ+j8PiWBsovmEvN36csDAoU6MMvSOFKxUmNvQLwlAzPhxBNWwrq4FoL
	 z+2FF889w8rgdrT9/qQWFySKwnQ9ICQvMxdmtKJCqEzVNxipBHdYLEjHMBxzxSKOTj
	 242mtQ4y5nStg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF9C54FDF;
	Thu, 30 Jul 2026 08:35:00 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 30 Jul 2026 08:34:38 +0000
Subject: [PATCH 2/2] thermal: amlogic: Add support for A9 thermal
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-a9-thermal-v1-2-d786d37cba58@amlogic.com>
References: <20260730-a9-thermal-v1-0-d786d37cba58@amlogic.com>
In-Reply-To: <20260730-a9-thermal-v1-0-d786d37cba58@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785400497; l=7558;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Y4V0AqFV2T4jFS5DC+M4FyFAU3c3mwLSP42UnGL/D8w=;
 b=Z5MRBnovNEr9ni5vF8IQNcr6UnZ+KWi3PfkRbPFHqHDrrCPReczDqXtr3S969gAGveX0zKkqB
 SokB2LXrSzfDhWVLV38EF9KCPr+dCWmtL518Ef5OPlEKp7Y5Bn92WvH
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for the Amlogic A9 thermal controller.

The A9 thermal controller uses different calibration parameters, requires
separate core and bus clocks, and supports a hardware over-temperature
reset mechanism.

Add the A9 calibration data, retrieve the clocks by name, and configure
the hardware reset temperature through the optional 'amlogic,hw-reset-temp'
DT property. When the property is absent, use the default reset temperature
of 110°C.

Also restore the hardware reset configuration after resume.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/thermal/amlogic_thermal.c | 107 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index a0b530624b60..c9c351496653 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -45,6 +45,18 @@
 		 TSENSOR_CFG_REG1_DEM_EN |	\
 		 TSENSOR_CFG_REG1_CH_SEL)
 
+#define TSENSOR_CFG_REG2			0x8
+	#define TSENSOR_CFG_REG2_HITEMP_EN	BIT(31)
+	#define TSENSOR_CFG_REG2_REBOOT_EN	BIT(30)
+	#define TSENSOR_CFG_REG2_REBOOT_CODE	GENMASK(15, 4)
+	#define TSENSOR_CFG_REG2_REBOOT_TIME	GENMASK(23, 16)
+	#define TSENSOR_CFG_REG2_ENABLE		\
+		(TSENSOR_CFG_REG2_HITEMP_EN |	\
+		 TSENSOR_CFG_REG2_REBOOT_EN |	\
+		 TSENSOR_CFG_REG2_REBOOT_TIME)
+
+#define TSENSOR_TEMP_CAL		1
+
 #define TSENSOR_STAT0			0x40
 
 #define TSENSOR_STAT9			0x64
@@ -63,6 +75,7 @@
 
 #define TSENSOR_CALIB_OFFSET	1
 #define TSENSOR_CALIB_SHIFT	4
+#define TSENSOR_HW_RESET_DEFAULT_TEMP	110000
 
 /**
  * struct amlogic_thermal_soc_calib_data
@@ -93,6 +106,7 @@ struct amlogic_thermal_data {
 	const struct amlogic_thermal_soc_calib_data *calibration_parameters;
 	const struct regmap_config *regmap_config;
 	bool use_sm;
+	bool has_sysclk;
 };
 
 struct amlogic_thermal {
@@ -101,8 +115,10 @@ struct amlogic_thermal {
 	struct regmap *regmap;
 	struct regmap *sec_ao_map;
 	struct clk *clk;
+	struct clk *sysclk;
 	struct thermal_zone_device *tzd;
 	u32 trim_info;
+	u32 temp_code;
 	struct meson_sm_firmware *sm_fw;
 	u32 tsensor_id;
 };
@@ -138,6 +154,46 @@ static int amlogic_thermal_code_to_millicelsius(struct amlogic_thermal *pdata,
 	return temp;
 }
 
+/*
+ * Calculate a temperature code from a temperature value .
+ * The unit of the temperature is degree milliCelsius.
+ */
+static u32 amlogic_thermal_millicelsius_to_code(struct amlogic_thermal *pdata, int millicelsius)
+{
+	const struct amlogic_thermal_soc_calib_data *param =
+					pdata->data->calibration_parameters;
+	s64 factor, uptat, uefuse;
+	u32 temp_code;
+
+	uefuse = pdata->trim_info & TSENSOR_TRIM_SIGN_MASK ?
+			     ~(pdata->trim_info & TSENSOR_TRIM_TEMP_MASK) + 1 :
+			     (pdata->trim_info & TSENSOR_TRIM_TEMP_MASK);
+
+	factor = param->B + div_s64(millicelsius, 100);
+	factor = BIT(16) * factor;
+	factor = div_s64(factor, param->A);
+	factor = factor - (uefuse & TSENSOR_TRIM_TEMP_MASK);
+
+	uptat = param->n * factor;
+	uptat = div_s64(uptat, BIT(16));
+	uptat = param->m - uptat;
+
+	factor = factor * 100;
+	factor = div_s64(factor, uptat);
+
+	temp_code = ((factor >> 0x4) & TSENSOR_TEMP_MASK) + TSENSOR_TEMP_CAL;
+
+	return temp_code;
+}
+
+static void amlogic_tsensor_setup_hw_reset(struct amlogic_thermal *data)
+{
+	regmap_update_bits(data->regmap, TSENSOR_CFG_REG2, TSENSOR_CFG_REG2_REBOOT_CODE,
+			   data->temp_code << 0x4);
+	regmap_update_bits(data->regmap, TSENSOR_CFG_REG2,
+			   TSENSOR_CFG_REG2_ENABLE, TSENSOR_CFG_REG2_ENABLE);
+}
+
 static int amlogic_thermal_enable(struct amlogic_thermal *data)
 {
 	int ret;
@@ -254,6 +310,13 @@ static const struct amlogic_thermal_soc_calib_data amlogic_thermal_g12a = {
 	.n = 324,
 };
 
+static const struct amlogic_thermal_soc_calib_data amlogic_thermal_a9 = {
+	.A = 9164,
+	.B = 2747,
+	.m = 370,
+	.n = 270,
+};
+
 static const struct amlogic_thermal_data amlogic_thermal_g12a_cpu_param = {
 	.u_efuse_off = 0x128,
 	.calibration_parameters = &amlogic_thermal_g12a,
@@ -272,6 +335,13 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
 	.regmap_config = &amlogic_thermal_regmap_config_g12a,
 };
 
+static const struct amlogic_thermal_data amlogic_thermal_a9_param = {
+	.use_sm			= true,
+	.has_sysclk		= true,
+	.calibration_parameters	= &amlogic_thermal_a9,
+	.regmap_config		= &amlogic_thermal_regmap_config_g12a,
+};
+
 static const struct amlogic_thermal_data amlogic_thermal_t7_param = {
 	.use_sm			= true,
 	.calibration_parameters	= &amlogic_thermal_g12a,
@@ -291,6 +361,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
 		.compatible = "amlogic,a1-cpu-thermal",
 		.data = &amlogic_thermal_a1_cpu_param,
 	},
+	{
+		.compatible = "amlogic,a9-thermal",
+		.data = &amlogic_thermal_a9_param,
+	},
 	{
 		.compatible = "amlogic,t7-thermal",
 		.data = &amlogic_thermal_t7_param,
@@ -305,6 +379,7 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	int ret;
+	u32 reset_temp;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -323,9 +398,24 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata->regmap))
 		return PTR_ERR(pdata->regmap);
 
-	pdata->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(pdata->clk))
-		return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed to get clock\n");
+	if (pdata->data->has_sysclk) {
+		pdata->clk = devm_clk_get(dev, "core");
+		if (IS_ERR(pdata->clk))
+			return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed to get core clk\n");
+		pdata->sysclk = devm_clk_get_enabled(dev, "pclk");
+		if (IS_ERR(pdata->sysclk))
+			return dev_err_probe(dev, PTR_ERR(pdata->sysclk), "failed to get pclk\n");
+	} else {
+		pdata->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(pdata->clk))
+			return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed to get clock\n");
+	}
+
+	if (of_property_read_u32(pdev->dev.of_node, "amlogic,hw-reset-temp", &reset_temp)) {
+		dev_dbg(dev, "using default hardware reset temperature\n");
+		reset_temp = TSENSOR_HW_RESET_DEFAULT_TEMP;
+	}
+
 
 	if (pdata->data->use_sm)
 		ret = amlogic_thermal_probe_sm(pdev, pdata);
@@ -346,6 +436,10 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
+	pdata->temp_code = amlogic_thermal_millicelsius_to_code(pdata, reset_temp);
+
+	amlogic_tsensor_setup_hw_reset(pdata);
+
 	ret = amlogic_thermal_enable(pdata);
 
 	return ret;
@@ -355,6 +449,8 @@ static void amlogic_thermal_remove(struct platform_device *pdev)
 {
 	struct amlogic_thermal *data = platform_get_drvdata(pdev);
 
+	if (data->data->has_sysclk)
+		clk_disable_unprepare(data->sysclk);
 	amlogic_thermal_disable(data);
 }
 
@@ -363,6 +459,8 @@ static int amlogic_thermal_suspend(struct device *dev)
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
 
 	amlogic_thermal_disable(data);
+	if (data->data->has_sysclk)
+		clk_disable_unprepare(data->sysclk);
 
 	return 0;
 }
@@ -371,6 +469,9 @@ static int amlogic_thermal_resume(struct device *dev)
 {
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
 
+	amlogic_tsensor_setup_hw_reset(data);
+	if (data->data->has_sysclk)
+		clk_prepare_enable(data->sysclk);
 	return amlogic_thermal_enable(data);
 }
 

-- 
2.52.0



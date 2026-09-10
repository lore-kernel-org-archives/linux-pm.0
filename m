Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218453D3492;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022337; cv=none; b=V8/B8zoAjIw7NPr+xGuy/FodQwh2vKDUQwqiynmwD9LWeaj1Zj+WoTemy31NHCEKZ4dBL7zR7WM/7IhlNRxIL67f+hBDqYFWPq8q9qurrHPbDfaArKWQMXD79sd+oA3dq8FfhJMd38Kz7kc3Lzbgzmytdm7MjKQ5X0N3bX/vIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022337; c=relaxed/simple;
	bh=Zb/LwgGr7DEM3tO0ucLyrTnmcy1CRThDJrc9WTV8lvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afjRr2zWZpnAnzCjEgkIezwjQgHvBJotjs/GEg8uEuINYqKYfSAsWDuHQSRYQr2oPSTOChg2oKyooP9nYTMev2WDtWXY0GDMEqwygGVTsRpH2yrfuu9Ey6UGXDn/Q65vOVhPtT2pwb9v7/IV29Uc4X8n+UWzxkCAqZXdlMx5/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv4CuJQm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv4CuJQm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E9A6C2BCFB;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789022336;
	bh=Zb/LwgGr7DEM3tO0ucLyrTnmcy1CRThDJrc9WTV8lvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jv4CuJQmb8nCqAad34jJJ7eAqEyxRXKYwxyoeWs4KA2t06fCOI2WaNNztsTtnFRzY
	 hNTs4Fk3df2gx5L9r8Rvh3yM2M/+Z74AU+4mioBV+ZXTQZCSoN3+gJKNJoI28TlB3M
	 QPbmGVPsZIOF3rCV81+PU9Mqf5gllxX7c0AObjYaBPFGMc14HoEYovbVmVFCaIHPol
	 tFe72Vhl2yCWaHXEw3wI2gAUtjnE1QgP/aJmn4rzgnWt2XgfTa6pEL4mM3wfpS7e3d
	 Nvyo/Bjo0b8KH8juVwL0jgRuHSdMKn4sOG/zj7S9CI8izJrNAseckbKOyp3OqsXjy2
	 Dh539ky6MmItw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E749C79FB9;
	Thu, 10 Sep 2026 06:38:56 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 10 Sep 2026 06:38:53 +0000
Subject: [PATCH v5 2/2] thermal: amlogic: Add support for A9 thermal
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-a9-thermal-v5-2-892d798723e1@amlogic.com>
References: <20260910-a9-thermal-v5-0-892d798723e1@amlogic.com>
In-Reply-To: <20260910-a9-thermal-v5-0-892d798723e1@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789022333; l=7899;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=oYdIslolzA3DJMsonLIFZ8XXaiSWr9vCeZbDJqhZZ+8=;
 b=8afdYiCb4M8S5u40CzJgmoU1mo831WNIy/wj2QJ06RlamFx1QDeoS/lru0BoJBN4I4aJlQf6/
 rCWVeUwDL8pBtiK0Ech4QGd6MsoxGEcOkjFRcCM0dKwLiI0kpYPcB29
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
reset mechanism, and restore the hardware reset configuration after resume.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/thermal/amlogic_thermal.c | 121 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index a0b530624b60..e7cedb944315 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -45,6 +45,19 @@
 		 TSENSOR_CFG_REG1_DEM_EN |	\
 		 TSENSOR_CFG_REG1_CH_SEL)
 
+#define TSENSOR_CFG_REG2			0x8
+	#define TSENSOR_CFG_REG2_HITEMP_EN	BIT(31)
+	#define TSENSOR_CFG_REG2_REBOOT_EN	BIT(30)
+	#define TSENSOR_CFG_REG2_REBOOT_CODE	GENMASK(15, 4)
+	#define TSENSOR_CFG_REG2_REBOOT_TIME	GENMASK(23, 16)
+	#define TSENSOR_CFG_REG2_ENABLE		\
+		(TSENSOR_CFG_REG2_HITEMP_EN |	\
+		 TSENSOR_CFG_REG2_REBOOT_EN)
+
+#define TSENSOR_REBOOT_TIME_MAX		(0xff << 16)
+
+#define TSENSOR_TEMP_CAL		1
+
 #define TSENSOR_STAT0			0x40
 
 #define TSENSOR_STAT9			0x64
@@ -63,6 +76,7 @@
 
 #define TSENSOR_CALIB_OFFSET	1
 #define TSENSOR_CALIB_SHIFT	4
+#define TSENSOR_HW_RESET_DEFAULT_TEMP	110000
 
 /**
  * struct amlogic_thermal_soc_calib_data
@@ -85,14 +99,18 @@ struct amlogic_thermal_soc_calib_data {
  * @u_efuse_off: register offset to read fused calibration value
  * @calibration_parameters: calibration parameters structure pointer
  * @regmap_config: regmap config for the device
+ * @reset_temp: the hardware-controlled reset temperature value
  * @use_sm: read data from secure monitor instead of efuse
+ * @has_sysclk: sensor driver control sysclk
  * This structure is required for configuration of amlogic thermal driver.
  */
 struct amlogic_thermal_data {
 	int u_efuse_off;
 	const struct amlogic_thermal_soc_calib_data *calibration_parameters;
 	const struct regmap_config *regmap_config;
+	u32 reset_temp;
 	bool use_sm;
+	bool has_sysclk;
 };
 
 struct amlogic_thermal {
@@ -101,8 +119,10 @@ struct amlogic_thermal {
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
@@ -138,6 +158,51 @@ static int amlogic_thermal_code_to_millicelsius(struct amlogic_thermal *pdata,
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
+	factor = factor - uefuse;
+
+	uptat = param->n * factor;
+	uptat = div_s64(uptat, BIT(16));
+	uptat = param->m - uptat;
+
+	factor = factor * 100;
+	if (!uptat)
+		factor = (TSENSOR_TEMP_MASK - TSENSOR_TEMP_CAL) << 0x4;
+	else
+		factor = div_s64(factor, uptat);
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
+	regmap_update_bits(data->regmap, TSENSOR_CFG_REG2, TSENSOR_CFG_REG2_REBOOT_TIME,
+			   TSENSOR_REBOOT_TIME_MAX);
+	regmap_update_bits(data->regmap, TSENSOR_CFG_REG2,
+			   TSENSOR_CFG_REG2_ENABLE, TSENSOR_CFG_REG2_ENABLE);
+}
+
 static int amlogic_thermal_enable(struct amlogic_thermal *data)
 {
 	int ret;
@@ -254,6 +319,13 @@ static const struct amlogic_thermal_soc_calib_data amlogic_thermal_g12a = {
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
@@ -272,6 +344,14 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
 	.regmap_config = &amlogic_thermal_regmap_config_g12a,
 };
 
+static const struct amlogic_thermal_data amlogic_thermal_a9_param = {
+	.use_sm			= true,
+	.has_sysclk		= true,
+	.calibration_parameters	= &amlogic_thermal_a9,
+	.regmap_config		= &amlogic_thermal_regmap_config_g12a,
+	.reset_temp		= 110000,
+};
+
 static const struct amlogic_thermal_data amlogic_thermal_t7_param = {
 	.use_sm			= true,
 	.calibration_parameters	= &amlogic_thermal_g12a,
@@ -291,6 +371,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
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
@@ -305,6 +389,7 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	int ret;
+	u32 reset_temp;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -323,9 +408,18 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
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
 
 	if (pdata->data->use_sm)
 		ret = amlogic_thermal_probe_sm(pdev, pdata);
@@ -346,6 +440,17 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
+	if (pdata->data->reset_temp) {
+		reset_temp = pdata->data->reset_temp;
+	} else {
+		dev_dbg(dev, "using default hardware reset temperature\n");
+		reset_temp = TSENSOR_HW_RESET_DEFAULT_TEMP;
+	}
+
+	pdata->temp_code = amlogic_thermal_millicelsius_to_code(pdata, reset_temp);
+
+	amlogic_tsensor_setup_hw_reset(pdata);
+
 	ret = amlogic_thermal_enable(pdata);
 
 	return ret;
@@ -363,6 +468,8 @@ static int amlogic_thermal_suspend(struct device *dev)
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
 
 	amlogic_thermal_disable(data);
+	if (data->data->has_sysclk)
+		clk_disable_unprepare(data->sysclk);
 
 	return 0;
 }
@@ -370,7 +477,15 @@ static int amlogic_thermal_suspend(struct device *dev)
 static int amlogic_thermal_resume(struct device *dev)
 {
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
+	int ret;
+
+	if (data->data->has_sysclk) {
+		ret = clk_prepare_enable(data->sysclk);
+		if (ret)
+			return ret;
+	}
 
+	amlogic_tsensor_setup_hw_reset(data);
 	return amlogic_thermal_enable(data);
 }
 

-- 
2.52.0



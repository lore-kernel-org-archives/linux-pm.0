Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACF3CCFD1;
	Fri,  3 Apr 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232567; cv=none; b=TlBz5v6rlYrKwsMEkc6x8D0K6kttvqI8+PSuAWdTH3AiRiEqOV1ZBcCUAMAy/05eDE/wQCH0rcObTUf7XtFJzeVuzjjNPSOGWxQgZCo5qlWkkYtxmHK1hAAXd590QoYgWCTRvGkv/DzSF4Wz/o2LX+rf/zV3aHtVxyfY0Rr0KWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232567; c=relaxed/simple;
	bh=emjopVGd5uVLfwcqEy71jr1NYUE1/T1lgxk1RfDuCzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+KwmA7MwvY4e732s71rVPHLgVjxgjrWQBio0cXhS4V89UoeGrtVI7YpcgY1F80wV13Qr6nNxI8MVkoaJMHBnxLnWTkAaAo80Xd4tV7OqMTBGPF2ysiY4LjWnr73vx6g9DyMhibCCyRHVbQAUGcovWxmbZvgxerg37J0ZIYV9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=syPq+mVR; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="syPq+mVR"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775232559;
	bh=emjopVGd5uVLfwcqEy71jr1NYUE1/T1lgxk1RfDuCzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=syPq+mVRfCWfVMO5kwGj5d87YfQIA8M8v5mx3QAzGQPSVEB2LIRNy34U31VsWEhPI
	 zaYj4LvmDfdagEhc9HBu1qP9u5JLT87WVjtcdgIlBckDp1lYAy8ozszD4FbnkQUGbZ
	 NPM2Tx26mP9XX+gnqKZ7Ck6zFHtiyS7fmwOMyzN4=
Date: Fri, 03 Apr 2026 18:08:37 +0200
Subject: [PATCH v2 4/8] mfd: khadas-mcu: Add support for VIM4 MCU variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-add-mcu-fan-khadas-vim4-v2-4-70536b22439a@aliel.fr>
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
In-Reply-To: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1775232552; l=5062;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=emjopVGd5uVLfwcqEy71jr1NYUE1/T1lgxk1RfDuCzk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIsXEJ4KldedgbozLhByCUwgiAptnRgyd6YnNjxsASYMDtbP1w6KzoV+MY6POn72D1RG5kMF5hy
 F9AK2tmMcQg8=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Refactor probe() to use per-variant khadas_mcu_data
instead of hardcoded globals.

Add dedicated regmap configuration and device data for the VIM4 MCU,
with its own volatile/writeable registers.

Add the fan control register
(0–100 levels vs 0–3 for previous supported boards).

Add a new compatible string "khadas,vim4-mcu".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/mfd/khadas-mcu.c | 106 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index ba981a7886921..b36b3b3ab73c0 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -75,15 +75,91 @@ static const struct regmap_config khadas_mcu_regmap_config = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
+	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
+	.max_level	= 3,
+};
+
 static struct mfd_cell khadas_mcu_fan_cells[] = {
 	/* VIM1/2 Rev13+ and VIM3 only */
-	{ .name = "khadas-mcu-fan-ctrl", },
+	{
+		.name = "khadas-mcu-fan-ctrl",
+		.platform_data = &khadas_mcu_fan_pdata,
+		.pdata_size    = sizeof(khadas_mcu_fan_pdata),
+	},
 };
 
 static struct mfd_cell khadas_mcu_cells[] = {
 	{ .name = "khadas-mcu-user-mem", },
 };
 
+static const struct khadas_mcu_data khadas_mcu_data = {
+	.regmap_config	= &khadas_mcu_regmap_config,
+	.cells		= khadas_mcu_cells,
+	.ncells		= ARRAY_SIZE(khadas_mcu_cells),
+	.fan_cells	= khadas_mcu_fan_cells,
+	.nfan_cells	= ARRAY_SIZE(khadas_mcu_fan_cells),
+};
+
+static bool khadas_mcu_vim4_reg_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case KHADAS_MCU_PWR_OFF_CMD_REG:
+	case KHADAS_MCU_VIM4_REST_CONF_REG:
+	case KHADAS_MCU_WOL_INIT_START_REG:
+	case KHADAS_MCU_VIM4_LED_ON_RAM_REG:
+	case KHADAS_MCU_VIM4_FAN_CTRL_REG:
+	case KHADAS_MCU_VIM4_WDT_EN_REG:
+	case KHADAS_MCU_VIM4_SYS_RST_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool khadas_mcu_vim4_reg_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case KHADAS_MCU_VERSION_0_REG:
+	case KHADAS_MCU_VERSION_1_REG:
+	case KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct regmap_config khadas_mcu_vim4_regmap_config = {
+	.reg_bits	= 8,
+	.reg_stride	= 1,
+	.val_bits	= 8,
+	.max_register	= KHADAS_MCU_VIM4_SYS_RST_REG,
+	.volatile_reg	= khadas_mcu_vim4_reg_volatile,
+	.writeable_reg	= khadas_mcu_vim4_reg_writeable,
+	.cache_type	= REGCACHE_MAPLE,
+};
+
+static const struct khadas_mcu_fan_pdata khadas_vim4_fan_pdata = {
+	.fan_reg	= KHADAS_MCU_VIM4_FAN_CTRL_REG,
+	.max_level	= 0x64,
+};
+
+static const struct mfd_cell khadas_mcu_vim4_cells[] = {
+	{
+		.name		= "khadas-mcu-fan-ctrl",
+		.platform_data	= &khadas_vim4_fan_pdata,
+		.pdata_size	= sizeof(khadas_vim4_fan_pdata),
+	},
+};
+
+static const struct khadas_mcu_data khadas_vim4_mcu_data = {
+	.regmap_config	= &khadas_mcu_vim4_regmap_config,
+	.cells		= NULL,
+	.ncells		= 0,
+	.fan_cells	= khadas_mcu_vim4_cells,
+	.nfan_cells	= ARRAY_SIZE(khadas_mcu_vim4_cells),
+};
+
 static int khadas_mcu_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -94,28 +170,35 @@ static int khadas_mcu_probe(struct i2c_client *client)
 	if (!ddata)
 		return -ENOMEM;
 
+	ddata->data = i2c_get_match_data(client);
+	if (!ddata->data)
+		return -EINVAL;
+
 	i2c_set_clientdata(client, ddata);
 
 	ddata->dev = dev;
 
-	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
+	ddata->regmap = devm_regmap_init_i2c(client,
+					     ddata->data->regmap_config);
 	if (IS_ERR(ddata->regmap)) {
 		ret = PTR_ERR(ddata->regmap);
 		dev_err(dev, "Failed to allocate register map: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-				   khadas_mcu_cells,
-				   ARRAY_SIZE(khadas_mcu_cells),
-				   NULL, 0, NULL);
-	if (ret)
-		return ret;
+	if (ddata->data->cells && ddata->data->ncells) {
+		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+					   ddata->data->cells,
+					   ddata->data->ncells,
+					   NULL, 0, NULL);
+		if (ret)
+			return ret;
+	}
 
 	if (of_property_present(dev->of_node, "#cooling-cells"))
 		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-					    khadas_mcu_fan_cells,
-					    ARRAY_SIZE(khadas_mcu_fan_cells),
+					    ddata->data->fan_cells,
+					    ddata->data->nfan_cells,
 					    NULL, 0, NULL);
 
 	return 0;
@@ -123,7 +206,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
 
 #ifdef CONFIG_OF
 static const struct of_device_id khadas_mcu_of_match[] = {
-	{ .compatible = "khadas,mcu", },
+	{ .compatible = "khadas,mcu", .data = &khadas_mcu_data },
+	{ .compatible = "khadas,vim4-mcu", .data = &khadas_vim4_mcu_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);

-- 
2.49.0


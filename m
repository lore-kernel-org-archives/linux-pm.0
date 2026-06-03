Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC1383322;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509967; cv=none; b=QSafbgLWmcRQkVYpe7zRDCHfDstfaP6I5DQdOpoju381uAYzkdAFt4I6o7qtNirYuqFhVjtfxp0KjmAJLIeHbGRq5v5Ht5xp/n4K151NGHYTLzSavK2qF+xXjn3xR62ZjkziBSm1dyC8Hy9aAKvq3ocXdYS52OjBxEJCjXwM8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509967; c=relaxed/simple;
	bh=VN/DBSuD9mZkIFCk7YdJ1TtQBUrJ0jCl1G3CK51+LfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGveeG7sulQ2gqdHXKZhnMOikJTh0p/NuV5s+4E2WKdN5oT8JqyIE+zu0XU4kLh/lSPPbkCN/obI0MF9crc51haPEufwmKyGyEuYV73rH3kM12B2gVChEw/yVcC+5RXYiC4dpBxfcbkZ47e2dunA7iXRpUUE6LrWObtiGCSUSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkT1r6mM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkT1r6mM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BC9BC2BCF5;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780509967;
	bh=VN/DBSuD9mZkIFCk7YdJ1TtQBUrJ0jCl1G3CK51+LfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DkT1r6mMo0PA0MU1YYCLG3oRigCdhQYM1d8c0zxtvqmNSG6x1EYuOuSj8/SVkL2jh
	 MKEWilczTYIGnhVqPbZGYmNWtcJ/ZrqpqJxiAXSpZUPe7yRadUR+1+fF4XDuvSAhdj
	 SS/Ao9tUqJ5sPl2bE99RVHXR1wKxGZxOrGQJBYMjmAE2XCviywWZCQ/EPXsdGw+Sqt
	 INMN/fv8Z+Aub1i6Fl4egMeCUG0F7YBpwbUBOxy/l81njIEvcJ4IwmG8osFe+r12Eq
	 itOByZlSiUss/efK9RxcHNxN5TDjC1G7fxppUam3dGYauBjoyYE86thrwBcBr7DOMK
	 72El34xY6q1Sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42048CD6E55;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 03 Jun 2026 20:05:26 +0200
Subject: [PATCH v7 4/8] mfd: khadas-mcu: Add support for VIM4 MCU variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-add-mcu-fan-khadas-vim4-v7-4-594ba8a965d8@aliel.fr>
References: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
In-Reply-To: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5322;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=LymTegcHEv//8DPFWEx4uXWKzb7ITVj0UFHAs4lH89A=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ZCLhtn5MMHqk6dAR4yahc1y1h9zF8rsE75q2a/lFumZ
 /5cn+COUhYGMS4GWTFFlv65lifeXT565use9RSYOaxMIEMYuDgFYCIdNYwM1z6Y+0+s1ni643HG
 yv5E1Rt6X78X/Gh7xRd/26rqX/OObwz/TDqPP5ryPtBX6ljh9k3GufELQmL0VlzSFE5+WNG4efc
 +BgA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Refactor probe() to use per-variant values
instead of hardcoded globals.

Add dedicated regmap configuration for the VIM4 MCU,
with its own volatile/writeable registers.

Add the fan control register
(0–100 levels vs 0–3 for previous supported boards).

Add a new compatible string "khadas,vim4-mcu".

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/mfd/khadas-mcu.c | 115 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index ba981a7886921..1bf260729d73b 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -75,47 +75,129 @@ static const struct regmap_config khadas_mcu_regmap_config = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
-static struct mfd_cell khadas_mcu_fan_cells[] = {
+static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
+	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
+	.max_level	= 3, /* Fan speed: 0 = off, 1 = low, 2 = medium, 3 = high */
+};
+
+static const struct mfd_cell khadas_mcu_fan_cells[] = {
 	/* VIM1/2 Rev13+ and VIM3 only */
-	{ .name = "khadas-mcu-fan-ctrl", },
+	{
+		.name = "khadas-mcu-fan-ctrl",
+		.platform_data = &khadas_mcu_fan_pdata,
+		.pdata_size    = sizeof(khadas_mcu_fan_pdata),
+	},
 };
 
-static struct mfd_cell khadas_mcu_cells[] = {
+static const struct mfd_cell khadas_mcu_cells[] = {
 	{ .name = "khadas-mcu-user-mem", },
 };
 
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
 static int khadas_mcu_probe(struct i2c_client *client)
 {
+	const struct mfd_cell *cells, *fan_cells;
+	const struct regmap_config *regmap_cfg;
 	struct device *dev = &client->dev;
+	int ncells, nfan_cells, ret;
 	struct khadas_mcu *ddata;
-	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
+	switch ((uintptr_t)i2c_get_match_data(client)) {
+	case KHADAS_MCU_GENERIC:
+		regmap_cfg	= &khadas_mcu_regmap_config;
+		cells		= khadas_mcu_cells;
+		ncells		= ARRAY_SIZE(khadas_mcu_cells);
+		fan_cells	= khadas_mcu_fan_cells;
+		nfan_cells	= ARRAY_SIZE(khadas_mcu_fan_cells);
+		break;
+	case KHADAS_MCU_VIM4:
+		regmap_cfg	= &khadas_mcu_vim4_regmap_config;
+		cells		= NULL;
+		ncells		= 0;
+		fan_cells	= khadas_mcu_vim4_cells;
+		nfan_cells	= ARRAY_SIZE(khadas_mcu_vim4_cells);
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	i2c_set_clientdata(client, ddata);
 
 	ddata->dev = dev;
 
-	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
+	ddata->regmap = devm_regmap_init_i2c(client, regmap_cfg);
 	if (IS_ERR(ddata->regmap)) {
 		ret = PTR_ERR(ddata->regmap);
-		dev_err(dev, "Failed to allocate register map: %d\n", ret);
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to allocate register map\n");
 	}
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-				   khadas_mcu_cells,
-				   ARRAY_SIZE(khadas_mcu_cells),
-				   NULL, 0, NULL);
-	if (ret)
-		return ret;
+	if (cells && ncells) {
+		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+					   cells,
+					   ncells,
+					   NULL, 0, NULL);
+		if (ret)
+			return ret;
+	}
 
 	if (of_property_present(dev->of_node, "#cooling-cells"))
 		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-					    khadas_mcu_fan_cells,
-					    ARRAY_SIZE(khadas_mcu_fan_cells),
+					    fan_cells,
+					    nfan_cells,
 					    NULL, 0, NULL);
 
 	return 0;
@@ -123,7 +205,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
 
 #ifdef CONFIG_OF
 static const struct of_device_id khadas_mcu_of_match[] = {
-	{ .compatible = "khadas,mcu", },
+	{ .compatible = "khadas,mcu", .data = (void *)KHADAS_MCU_GENERIC },
+	{ .compatible = "khadas,vim4-mcu", .data = (void *)KHADAS_MCU_VIM4 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);

-- 
2.49.0



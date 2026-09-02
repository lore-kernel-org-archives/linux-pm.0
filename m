Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2284968F3;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353537; cv=none; b=HYsOifEQA65uzu1OQoPyZB9kI12vAvb9DpO3+6975u0TTO2mhQiI3FkEmv50FC/xGk6AlsO1FI988t8Ph9mdJh49twp+AiEO9h/moboM9e/TA+UEWg/kU0aBJgqlet8TLDIdUTrNid+ytLvWJygJ45OGE2xUbxvNWq0mRC2nuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353537; c=relaxed/simple;
	bh=TpKUTT9UnXyJkMGklfvshLexshR4zNIwKPjchubwhf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiUGiQnP5bHChtapiDPb3R8zpwTyQ0Abj00HXJTJyvQFfB1WU5KWo5lW9YVXbuEFItdFy1WyMU8NFdK5qWiY6CrmXQqiNOe4AJTuwyD9O63DUfCyNvUoEN+CN2A8XOI8BfgBf7YRFDIFNtOado1crlPkvlxGlHxTJfJLIqLabho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeJJzAo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeJJzAo+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D980C2BCFF;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788353537;
	bh=TpKUTT9UnXyJkMGklfvshLexshR4zNIwKPjchubwhf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AeJJzAo+wDUSmOjhqmiTOs+eOdv3kPpdD6x1e6cRbZvJTQySkZHAplXxfszsXRMcX
	 iqGpeSSkpG9yp+StF0JZvErKJ7Jp81cpV4jRo39lOpSzOnlNrZjidqQer9MxQqpD5L
	 vfAxMikMsP5VigfGf8yytgcd6/bU1ZHYiLCPAq5GnYk5E21B5vz2npBh++6pwTmOs8
	 Ddf3iJ19aImiXRRf74UbmsjYjjq0Uoce6rTZMc7vAPsgcM3eFv+zgcZVvW4ZtkkERo
	 oJumev1YWcnZ6ka3s6mS9Ll6m34+biUwmZiUjo8pezlnO/B/mVF9+DzP5QtJw11aQS
	 dCF5J3uUIOAZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D3C624D7;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 02 Sep 2026 14:51:07 +0200
Subject: [PATCH v11 3/6] mfd: khadas-mcu: Add support for VIM4 MCU variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-mcu-fan-khadas-vim4-v11-3-5f1610d83bf0@aliel.fr>
References: <20260902-add-mcu-fan-khadas-vim4-v11-0-5f1610d83bf0@aliel.fr>
In-Reply-To: <20260902-add-mcu-fan-khadas-vim4-v11-0-5f1610d83bf0@aliel.fr>
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
 mfd@lists.linux.dev, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5696;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=huWXhUHwpCRJwBvPNQon4ySNunAT1WR74/SHbV4RoFk=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9YM6fdqTq57TFPWRfD4L45yfPFVPYEv+7tJbhT7Qxfe7
 1IqnpIdpSwMYlwMsmKKLP1zLU+8u3z0zNc96ikwc1iZQIYwcHEKwESMHBn+KR1ZUPLY0SDq2POS
 B+p/VWP6XnznOvEhrmhNdceO5B9yixgZOo6nZlXzHX62UH3Ky7sZ89okC5ml5KtD7cXfxDZ85gr
 iBwA=
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

Introduce struct khadas_mcu_fan_pdata to pass the fan
control register and duty-cycle levels per variant.
VIM4 uses a different register and level set (0-100)
 declared as a list (0, 30, 40, 55, 75, 100) compared
 to previous boards (0-3).

Add a new compatible string "khadas,vim4-mcu".

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/mfd/khadas-mcu.c | 120 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index 0e74efe14f367..4cb305ac915e1 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -75,47 +75,138 @@ static const struct regmap_config khadas_mcu_regmap_config = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+static const unsigned int khadas_mcu_fan_levels[] = {
+	0, 1, 2, 3,
+};
+
+static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
+	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
+	.levels		= khadas_mcu_fan_levels,
+	.nlevels	= ARRAY_SIZE(khadas_mcu_fan_levels),
+};
+
 static const struct mfd_cell khadas_mcu_fan_cells[] = {
 	/* VIM1/2 Rev13+ and VIM3 only */
-	MFD_CELL_NAME("khadas-mcu-fan-ctrl"),
+	MFD_CELL_BASIC("khadas-mcu-fan-ctrl", NULL, &khadas_mcu_fan_pdata,
+		       sizeof(khadas_mcu_fan_pdata), 0),
 };
 
 static const struct mfd_cell khadas_mcu_cells[] = {
 	MFD_CELL_NAME("khadas-mcu-user-mem"),
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
+static const unsigned int khadas_mcu_vim4_fan_levels[] = {
+	0, 30, 40, 55, 75, 100,
+};
+
+static const struct khadas_mcu_fan_pdata khadas_mcu_vim4_fan_pdata = {
+	.fan_reg	= KHADAS_MCU_VIM4_FAN_CTRL_REG,
+	.levels		= khadas_mcu_vim4_fan_levels,
+	.nlevels	= ARRAY_SIZE(khadas_mcu_vim4_fan_levels),
+};
+
+static const struct mfd_cell khadas_mcu_vim4_fan_cells[] = {
+	MFD_CELL_BASIC("khadas-mcu-fan-ctrl", NULL, &khadas_mcu_vim4_fan_pdata,
+		       sizeof(khadas_mcu_vim4_fan_pdata), 0),
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
+	const void *match;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
+	match = i2c_get_match_data(client);
+	if (!match)
+		return -ENODEV;
+
+	switch ((uintptr_t)match) {
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
+		fan_cells	= khadas_mcu_vim4_fan_cells;
+		nfan_cells	= ARRAY_SIZE(khadas_mcu_vim4_fan_cells);
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
@@ -123,7 +214,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
 
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



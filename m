Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB33F164C
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352331; cv=none; b=EqN8LQaqfjLEZXyhmtUq2x5kZjC/HQ+q4C4BxMfA4oswYjDfEimzLeJcKE2At1MESgI7DvPIFJ6190Nzi14IhlC8IZe/6xlMz7/riYnTf92WcZqybpDjGC+CvayDkoUeUrRwvPtDZ0Fa5yYdooe0D75epXBQFq586EdI1LEI5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352331; c=relaxed/simple;
	bh=C6/PRjiNea0BB85b9/KEzvMseEcJT2a6cx1X8uTzZJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rn9lRo5fg2pzMHfq19YdyvebwbtwLXBBvC8xBANCEWo83N1ePBoZ0+j5vnI+nX5a8kdEVdDk3YU8kSNvQtiAFbIuqcL7c60ihyqEU9amsLsNy8UnE3RvJcK7Bcp1FHq4VdmPWpFebStmkkM4j4O6UvNIgQOTyG88Pj1DLv8ST88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=cjkpTIvT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="cjkpTIvT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439af7d77f0so3910898f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352328; x=1774957128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL68ZlGfWsk8bC/BMkTEjWufsytaDZaH5faiZPZv5OM=;
        b=cjkpTIvTQ9eQ/7GtPcDmlt2+o8iDZn6TxyjMvUeJtjFxQBBJsaBRhLo5pfXN6MOGmB
         LfXOP/tL50msirPdZ59uj6quKqyaZBZlA9IOOjfVpMJwPAcFBKJ6US5J7CXD9NwdE0Kr
         +T+0mkHU57VNg6TNp5UK+K2mnWZIkkBAr2AeL0mOBrFNb9komVEQOn6C5wEAmVxePiOF
         63dDaewUl9McRbb4cny9mAy4g0K3mnM1pMYfjIJU3PcuOUJCBu4Q/mWDYiVcec5GQwuu
         6Nz4ziabhEsrOjDZe6k8C5DYKWc2n57TCnTG6kDtbtc4ILPE/8OYgNiWtYDCVrnpH0uV
         A2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352328; x=1774957128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cL68ZlGfWsk8bC/BMkTEjWufsytaDZaH5faiZPZv5OM=;
        b=h36Hku5j0AgOtak6uzOjIhQrwtMzsBDZ6Ltg2UFkaUK7IU9fmopN9IQi6Nd08YEide
         vfpe2OXvQpiWWut6fNCos/zJbk+CBgmSMcXPcI0FoXPiGZsyDAnNhQjC82cpzLrVdYSh
         NFQNWKCR5a+EDX6SEHPk4q6MEszPIZmbbicnBs/NGeeAJ5FrqxcTchd9zFioT9Wfake3
         tUtS2hFnFg6Yo6uQrmu0zbT9luSA2mq5FWCXfGhd8Vdr6wQtXFIbhzikX1CYVk1nLKRS
         yczKAHiu+WVxFSsWmMsnxOwti+J39QPNX6DH+Qh+br4TsT+IvtukTikeE5p7jdQ3/Xy4
         1zPg==
X-Forwarded-Encrypted: i=1; AJvYcCU+beFq5CNTSMfAg275IEjcLiAy18+pkxzHIFIIH3fKJXslR5ToAIdQNT6CFbZuCgzLmKlkMG/iXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uNP8xtkHx+xfEforj6+5ZyXqQE9ublzZk/Q4eNQAgpeTfvBN
	J8EzykjyDJF7jL15ozHTD4UtDLnRaYBLgzEfnjLK75Bm+o83TMZmuLT05k7MnMklTGA=
X-Gm-Gg: ATEYQzwjRsqACUnxGPMRpdppd7D4y+6krUfEIgLs08Qc+mFUHRElzD60v6P2d17JLL/
	yGLuTWTM/d9klFtkJZg0IIe8I4yKOd6gXPi/PxsvyAVJMtrTj9jkAPpsHWqPO3K6H+BgXsDHLy8
	kX3zB90c0HpZdchRYpbl2ykimSufh7PpBFoM0a8vrigXb5R3QdBwOW3NE7+BmMl5RYjm5CbXXrT
	kMZnzAl4OlENUaBH/T7O8wl1rTwx+o9CEnsua6x2X/3PN2k72jaJ9LTlHk0d+V+qBKYCvQ/x4bv
	2y2V5z4sUSDd7UY0zIiKmw/VvkD+Dg3txa7VidqYYMFseHcqfVSZrEN2Tpgfw7SgGRLjtCErX/H
	fWXP4McpTCng1JCr+6gcREnupTQ1mvY7M+jEigWHrtIAa9CE5V3xKxm9/SwT7djhUJhZZqMd3q/
	7pdbeL3dHd1g3L7517t/p5en6ZNo25oa/5wekzhZ+oLFT1pxkAX/Oagv64rBMkQvl1v+z9+WIwX
	/Jw3JdZDSU2sdMr
X-Received: by 2002:a05:600c:4ecd:b0:485:3f58:d84 with SMTP id 5b1f17b1804b1-486fee30199mr204763505e9.32.1774352327742;
        Tue, 24 Mar 2026 04:38:47 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:47 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:14 +0400
Subject: [PATCH v5 09/11] mfd: bq257xx: Add BQ25792 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-9-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=19368; i=alchark@flipper.net;
 h=from:subject:message-id; bh=C6/PRjiNea0BB85b9/KEzvMseEcJT2a6cx1X8uTzZJE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl8rePls/pSNu9v52U/l5z3Qrt9178Avdv2Nryc1N
 1VMP3KnqmMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICpZjZmZGjZazhtyaOrP8+6HDmg+LhMblITm5h5iNeth+m2J8UTDBwZGa5PftZ
 bVWkQf/vc90nVuQIRDVGLq47eNrUosJof45yYzwIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add register definitions and a new 'type' enum to be passed via MFD
private data to support the BQ25792, which is a newer variant of the
BQ257xx family.

BQ25792 shares similar logic of operation with the already supported
BQ25703A but has a completely different register map and different
electrical constraints.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/mfd/bq257xx.c       |  54 +++++-
 include/linux/mfd/bq257xx.h | 412 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 463 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
index e9d49dac0a16..31654925afa5 100644
--- a/drivers/mfd/bq257xx.c
+++ b/drivers/mfd/bq257xx.c
@@ -39,6 +39,39 @@ static const struct regmap_config bq25703_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
+static const struct regmap_range bq25792_writeable_reg_ranges[] = {
+	regmap_reg_range(BQ25792_REG00_MIN_SYS_VOLTAGE,
+			 BQ25792_REG18_NTC_CONTROL_1),
+	regmap_reg_range(BQ25792_REG28_CHARGER_MASK_0,
+			 BQ25792_REG30_ADC_FUNCTION_DISABLE_1),
+};
+
+static const struct regmap_access_table bq25792_writeable_regs = {
+	.yes_ranges = bq25792_writeable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bq25792_writeable_reg_ranges),
+};
+
+static const struct regmap_range bq25792_volatile_reg_ranges[] = {
+	regmap_reg_range(BQ25792_REG19_ICO_CURRENT_LIMIT,
+			 BQ25792_REG27_FAULT_FLAG_1),
+	regmap_reg_range(BQ25792_REG31_IBUS_ADC,
+			 BQ25792_REG47_DPDM_DRIVER),
+};
+
+static const struct regmap_access_table bq25792_volatile_regs = {
+	.yes_ranges = bq25792_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bq25792_volatile_reg_ranges),
+};
+
+static const struct regmap_config bq25792_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = BQ25792_REG48_PART_INFORMATION,
+	.cache_type = REGCACHE_MAPLE,
+	.wr_table = &bq25792_writeable_regs,
+	.volatile_table = &bq25792_volatile_regs,
+};
+
 static const struct mfd_cell cells[] = {
 	MFD_CELL_NAME("bq257xx-regulator"),
 	MFD_CELL_NAME("bq257xx-charger"),
@@ -46,6 +79,7 @@ static const struct mfd_cell cells[] = {
 
 static int bq257xx_probe(struct i2c_client *client)
 {
+	const struct regmap_config *rcfg;
 	struct bq257xx_device *ddata;
 	int ret;
 
@@ -53,9 +87,21 @@ static int bq257xx_probe(struct i2c_client *client)
 	if (!ddata)
 		return -ENOMEM;
 
+	ddata->type = (uintptr_t)i2c_get_match_data(client);
 	ddata->client = client;
 
-	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
+	switch (ddata->type) {
+	case BQ25703A:
+		rcfg = &bq25703_regmap_config;
+		break;
+	case BQ25792:
+		rcfg = &bq25792_regmap_config;
+		break;
+	default:
+		return dev_err_probe(&client->dev, -EINVAL, "Unsupported device type\n");
+	}
+
+	ddata->regmap = devm_regmap_init_i2c(client, rcfg);
 	if (IS_ERR(ddata->regmap)) {
 		return dev_err_probe(&client->dev, PTR_ERR(ddata->regmap),
 				     "Failed to allocate register map\n");
@@ -73,13 +119,15 @@ static int bq257xx_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq257xx_i2c_ids[] = {
-	{ "bq25703a" },
+	{ "bq25703a", BQ25703A },
+	{ "bq25792", BQ25792 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
 
 static const struct of_device_id bq257xx_of_match[] = {
-	{ .compatible = "ti,bq25703a" },
+	{ .compatible = "ti,bq25703a", .data = (void *)BQ25703A },
+	{ .compatible = "ti,bq25792", .data = (void *)BQ25792 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bq257xx_of_match);
diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
index 1d6ddc7fb09f..4ec72eb920f2 100644
--- a/include/linux/mfd/bq257xx.h
+++ b/include/linux/mfd/bq257xx.h
@@ -98,7 +98,419 @@
 
 #define BQ25703_EN_OTG_MASK			BIT(12)
 
+#define BQ25792_REG00_MIN_SYS_VOLTAGE		0x00
+#define BQ25792_REG01_CHARGE_VOLTAGE_LIMIT	0x01
+#define BQ25792_REG03_CHARGE_CURRENT_LIMIT	0x03
+#define BQ25792_REG05_INPUT_VOLTAGE_LIMIT	0x05
+#define BQ25792_REG06_INPUT_CURRENT_LIMIT	0x06
+#define BQ25792_REG08_PRECHARGE_CONTROL		0x08
+#define BQ25792_REG09_TERMINATION_CONTROL	0x09
+#define BQ25792_REG0A_RECHARGE_CONTROL		0x0a
+#define BQ25792_REG0B_VOTG_REGULATION		0x0b
+#define BQ25792_REG0D_IOTG_REGULATION		0x0d
+#define BQ25792_REG0E_TIMER_CONTROL		0x0e
+#define BQ25792_REG0F_CHARGER_CONTROL_0		0x0f
+#define BQ25792_REG10_CHARGER_CONTROL_1		0x10
+#define BQ25792_REG11_CHARGER_CONTROL_2		0x11
+#define BQ25792_REG12_CHARGER_CONTROL_3		0x12
+#define BQ25792_REG13_CHARGER_CONTROL_4		0x13
+#define BQ25792_REG14_CHARGER_CONTROL_5		0x14
+/* REG15 reserved */
+#define BQ25792_REG16_TEMPERATURE_CONTROL	0x16
+#define BQ25792_REG17_NTC_CONTROL_0		0x17
+#define BQ25792_REG18_NTC_CONTROL_1		0x18
+#define BQ25792_REG19_ICO_CURRENT_LIMIT		0x19
+#define BQ25792_REG1B_CHARGER_STATUS_0		0x1b
+#define BQ25792_REG1C_CHARGER_STATUS_1		0x1c
+#define BQ25792_REG1D_CHARGER_STATUS_2		0x1d
+#define BQ25792_REG1E_CHARGER_STATUS_3		0x1e
+#define BQ25792_REG1F_CHARGER_STATUS_4		0x1f
+#define BQ25792_REG20_FAULT_STATUS_0		0x20
+#define BQ25792_REG21_FAULT_STATUS_1		0x21
+#define BQ25792_REG22_CHARGER_FLAG_0		0x22
+#define BQ25792_REG23_CHARGER_FLAG_1		0x23
+#define BQ25792_REG24_CHARGER_FLAG_2		0x24
+#define BQ25792_REG25_CHARGER_FLAG_3		0x25
+#define BQ25792_REG26_FAULT_FLAG_0		0x26
+#define BQ25792_REG27_FAULT_FLAG_1		0x27
+#define BQ25792_REG28_CHARGER_MASK_0		0x28
+#define BQ25792_REG29_CHARGER_MASK_1		0x29
+#define BQ25792_REG2A_CHARGER_MASK_2		0x2a
+#define BQ25792_REG2B_CHARGER_MASK_3		0x2b
+#define BQ25792_REG2C_FAULT_MASK_0		0x2c
+#define BQ25792_REG2D_FAULT_MASK_1		0x2d
+#define BQ25792_REG2E_ADC_CONTROL		0x2e
+#define BQ25792_REG2F_ADC_FUNCTION_DISABLE_0	0x2f
+#define BQ25792_REG30_ADC_FUNCTION_DISABLE_1	0x30
+#define BQ25792_REG31_IBUS_ADC			0x31
+#define BQ25792_REG33_IBAT_ADC			0x33
+#define BQ25792_REG35_VBUS_ADC			0x35
+#define BQ25792_REG37_VAC1_ADC			0x37
+#define BQ25792_REG39_VAC2_ADC			0x39
+#define BQ25792_REG3B_VBAT_ADC			0x3b
+#define BQ25792_REG3D_VSYS_ADC			0x3d
+#define BQ25792_REG3F_TS_ADC			0x3f
+#define BQ25792_REG41_TDIE_ADC			0x41
+#define BQ25792_REG43_DP_ADC			0x43
+#define BQ25792_REG45_DM_ADC			0x45
+#define BQ25792_REG47_DPDM_DRIVER		0x47
+#define BQ25792_REG48_PART_INFORMATION		0x48
+
+/* Minimal System Voltage */
+#define BQ25792_REG00_VSYSMIN_MASK		GENMASK(5, 0)
+
+#define BQ25792_MINVSYS_MIN_UV			2500000
+#define BQ25792_MINVSYS_STEP_UV			250000
+#define BQ25792_MINVSYS_MAX_UV			16000000
+
+/* Charge Voltage Limit */
+#define BQ25792_REG01_VREG_MASK			GENMASK(10, 0)
+
+#define BQ25792_VBATREG_MIN_UV			3000000
+#define BQ25792_VBATREG_STEP_UV			10000
+#define BQ25792_VBATREG_MAX_UV			18800000
+
+/* Charge Current Limit */
+#define BQ25792_REG03_ICHG_MASK			GENMASK(8, 0)
+
+#define BQ25792_ICHG_MIN_UA			50000
+#define BQ25792_ICHG_STEP_UA			10000
+#define BQ25792_ICHG_MAX_UA			5000000
+
+/* Input Voltage Limit */
+#define BQ25792_REG05_VINDPM_MASK		GENMASK(7, 0)
+
+/* Input Current Limit */
+#define BQ25792_REG06_IINDPM_MASK		GENMASK(8, 0)
+#define BQ25792_IINDPM_DEFAULT_UA		3000000
+#define BQ25792_IINDPM_STEP_UA			10000
+#define BQ25792_IINDPM_MIN_UA			100000
+#define BQ25792_IINDPM_MAX_UA			3300000
+
+/* Precharge Control */
+#define BQ25792_REG08_VBAT_LOWV_MASK		GENMASK(7, 6)
+#define BQ25792_REG08_IPRECHG_MASK		GENMASK(5, 0)
+
+/* Termination Control */
+#define BQ25792_REG09_REG_RST			BIT(6)
+#define BQ25792_REG09_ITERM_MASK		GENMASK(4, 0)
+
+/* Re-charge Control */
+#define BQ25792_REG0A_CELL_MASK			GENMASK(7, 6)
+#define BQ25792_REG0A_TRECHG_MASK		GENMASK(5, 4)
+#define BQ25792_REG0A_VRECHG_MASK		GENMASK(3, 0)
+
+/* VOTG regulation */
+#define BQ25792_REG0B_VOTG_MASK			GENMASK(10, 0)
+
+#define BQ25792_OTG_VOLT_MIN_UV			2800000
+#define BQ25792_OTG_VOLT_STEP_UV		10000
+#define BQ25792_OTG_VOLT_MAX_UV			22000000
+#define BQ25792_OTG_VOLT_NUM_VOLT		((BQ25792_OTG_VOLT_MAX_UV \
+						  - BQ25792_OTG_VOLT_MIN_UV) \
+						  / BQ25792_OTG_VOLT_STEP_UV + 1)
+
+/* IOTG regulation */
+#define BQ25792_REG0D_PRECHG_TMR		BIT(7)
+#define BQ25792_REG0D_IOTG_MASK			GENMASK(6, 0)
+
+#define BQ25792_OTG_CUR_MIN_UA		120000
+#define BQ25792_OTG_CUR_STEP_UA		40000
+#define BQ25792_OTG_CUR_MAX_UA		3320000
+
+/* Timer Control */
+#define BQ25792_REG0E_TOPOFF_TMR_MASK		GENMASK(7, 6)
+#define BQ25792_REG0E_EN_TRICHG_TMR		BIT(5)
+#define BQ25792_REG0E_EN_PRECHG_TMR		BIT(4)
+#define BQ25792_REG0E_EN_CHG_TMR		BIT(3)
+#define BQ25792_REG0E_CHG_TMR_MASK		GENMASK(2, 1)
+#define BQ25792_REG0E_TMR2X_EN			BIT(0)
+
+/* Charger Control 0 */
+#define BQ25792_REG0F_EN_AUTO_IBATDIS		BIT(7)
+#define BQ25792_REG0F_FORCE_IBATDIS		BIT(6)
+#define BQ25792_REG0F_EN_CHG			BIT(5)
+#define BQ25792_REG0F_EN_ICO			BIT(4)
+#define BQ25792_REG0F_FORCE_ICO			BIT(3)
+#define BQ25792_REG0F_EN_HIZ			BIT(2)
+#define BQ25792_REG0F_EN_TERM			BIT(1)
+/* bit0 reserved */
+
+/* Charger Control 1 */
+#define BQ25792_REG10_VAC_OVP_MASK		GENMASK(5, 4)
+#define BQ25792_REG10_WD_RST			BIT(3)
+#define BQ25792_REG10_WATCHDOG_MASK		GENMASK(2, 0)
+
+/* Charger Control 2 */
+#define BQ25792_REG11_FORCE_INDET		BIT(7)
+#define BQ25792_REG11_AUTO_INDET_EN		BIT(6)
+#define BQ25792_REG11_EN_12V			BIT(5)
+#define BQ25792_REG11_EN_9V			BIT(4)
+#define BQ25792_REG11_HVDCP_EN			BIT(3)
+#define BQ25792_REG11_SDRV_CTRL_MASK		GENMASK(2, 1)
+#define BQ25792_REG11_SDRV_DLY			BIT(0)
+
+/* Charger Control 3 */
+#define BQ25792_REG12_DIS_ACDRV			BIT(7)
+#define BQ25792_REG12_EN_OTG			BIT(6)
+#define BQ25792_REG12_PFM_OTG_DIS		BIT(5)
+#define BQ25792_REG12_PFM_FWD_DIS		BIT(4)
+#define BQ25792_REG12_WKUP_DLY			BIT(3)
+#define BQ25792_REG12_DIS_LDO			BIT(2)
+#define BQ25792_REG12_DIS_OTG_OOA		BIT(1)
+#define BQ25792_REG12_DIS_FWD_OOA		BIT(0)
+
+/* Charger Control 4 */
+#define BQ25792_REG13_EN_ACDRV2			BIT(7)
+#define BQ25792_REG13_EN_ACDRV1			BIT(6)
+#define BQ25792_REG13_PWM_FREQ			BIT(5)
+#define BQ25792_REG13_DIS_STAT			BIT(4)
+#define BQ25792_REG13_DIS_VSYS_SHORT		BIT(3)
+#define BQ25792_REG13_DIS_VOTG_UVP		BIT(2)
+#define BQ25792_REG13_FORCE_VINDPM_DET		BIT(1)
+#define BQ25792_REG13_EN_IBUS_OCP		BIT(0)
+
+/* Charger Control 5 */
+#define BQ25792_REG14_SFET_PRESENT		BIT(7)
+/* bit6 reserved */
+#define BQ25792_REG14_EN_IBAT			BIT(5)
+#define BQ25792_REG14_IBAT_REG_MASK		GENMASK(4, 3)
+#define BQ25792_REG14_EN_IINDPM			BIT(2)
+#define BQ25792_REG14_EN_EXTILIM		BIT(1)
+#define BQ25792_REG14_EN_BATOC			BIT(0)
+
+#define BQ25792_IBAT_3A				FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 0)
+#define BQ25792_IBAT_4A				FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 1)
+#define BQ25792_IBAT_5A				FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 2)
+#define BQ25792_IBAT_UNLIM			FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 3)
+
+/* Temperature Control */
+#define BQ25792_REG16_TREG_MASK			GENMASK(7, 6)
+#define BQ25792_REG16_TSHUT_MASK		GENMASK(5, 4)
+#define BQ25792_REG16_VBUS_PD_EN		BIT(3)
+#define BQ25792_REG16_VAC1_PD_EN		BIT(2)
+#define BQ25792_REG16_VAC2_PD_EN		BIT(1)
+
+/* NTC Control 0 */
+#define BQ25792_REG17_JEITA_VSET_MASK		GENMASK(7, 5)
+#define BQ25792_REG17_JEITA_ISETH_MASK		GENMASK(4, 3)
+#define BQ25792_REG17_JEITA_ISETC_MASK		GENMASK(2, 1)
+
+/* NTC Control 1 */
+#define BQ25792_REG18_TS_COOL_MASK		GENMASK(7, 6)
+#define BQ25792_REG18_TS_WARM_MASK		GENMASK(5, 4)
+#define BQ25792_REG18_BHOT_MASK			GENMASK(3, 2)
+#define BQ25792_REG18_BCOLD			BIT(1)
+#define BQ25792_REG18_TS_IGNORE			BIT(0)
+
+/* ICO Current Limit */
+#define BQ25792_REG19_ICO_ILIM_MASK		GENMASK(8, 0)
+
+/* Charger Status 0 */
+#define BQ25792_REG1B_IINDPM_STAT		BIT(7)
+#define BQ25792_REG1B_VINDPM_STAT		BIT(6)
+#define BQ25792_REG1B_WD_STAT			BIT(5)
+#define BQ25792_REG1B_POORSRC_STAT		BIT(4)
+#define BQ25792_REG1B_PG_STAT			BIT(3)
+#define BQ25792_REG1B_AC2_PRESENT_STAT		BIT(2)
+#define BQ25792_REG1B_AC1_PRESENT_STAT		BIT(1)
+#define BQ25792_REG1B_VBUS_PRESENT_STAT		BIT(0)
+
+/* Charger Status 1 */
+#define BQ25792_REG1C_CHG_STAT_MASK		GENMASK(7, 5)
+#define BQ25792_REG1C_VBUS_STAT_MASK		GENMASK(4, 1)
+#define BQ25792_REG1C_BC12_DONE_STAT		BIT(0)
+
+/* Charger Status 2 */
+#define BQ25792_REG1D_ICO_STAT_MASK		GENMASK(7, 6)
+#define BQ25792_REG1D_TREG_STAT			BIT(2)
+#define BQ25792_REG1D_DPDM_STAT			BIT(1)
+#define BQ25792_REG1D_VBAT_PRESENT_STAT		BIT(0)
+
+/* Charger Status 3 */
+#define BQ25792_REG1E_ACRB2_STAT		BIT(7)
+#define BQ25792_REG1E_ACRB1_STAT		BIT(6)
+#define BQ25792_REG1E_ADC_DONE_STAT		BIT(5)
+#define BQ25792_REG1E_VSYS_STAT			BIT(4)
+#define BQ25792_REG1E_CHG_TMR_STAT		BIT(3)
+#define BQ25792_REG1E_TRICHG_TMR_STAT		BIT(2)
+#define BQ25792_REG1E_PRECHG_TMR_STAT		BIT(1)
+
+/* Charger Status 4 */
+#define BQ25792_REG1F_VBATOTG_LOW_STAT		BIT(4)
+#define BQ25792_REG1F_TS_COLD_STAT		BIT(3)
+#define BQ25792_REG1F_TS_COOL_STAT		BIT(2)
+#define BQ25792_REG1F_TS_WARM_STAT		BIT(1)
+#define BQ25792_REG1F_TS_HOT_STAT		BIT(0)
+
+/* FAULT Status 0 */
+#define BQ25792_REG20_IBAT_REG_STAT		BIT(7)
+#define BQ25792_REG20_VBUS_OVP_STAT		BIT(6)
+#define BQ25792_REG20_VBAT_OVP_STAT		BIT(5)
+#define BQ25792_REG20_IBUS_OCP_STAT		BIT(4)
+#define BQ25792_REG20_IBAT_OCP_STAT		BIT(3)
+#define BQ25792_REG20_CONV_OCP_STAT		BIT(2)
+#define BQ25792_REG20_VAC2_OVP_STAT		BIT(1)
+#define BQ25792_REG20_VAC1_OVP_STAT		BIT(0)
+
+#define BQ25792_REG20_OVERVOLTAGE_MASK		(BQ25792_REG20_VBAT_OVP_STAT | \
+						 BQ25792_REG20_VAC2_OVP_STAT | \
+						 BQ25792_REG20_VAC1_OVP_STAT)
+#define BQ25792_REG20_OVERCURRENT_MASK		(BQ25792_REG20_IBAT_OCP_STAT | \
+						 BQ25792_REG20_CONV_OCP_STAT)
+
+/* FAULT Status 1 */
+#define BQ25792_REG21_VSYS_SHORT_STAT		BIT(7)
+#define BQ25792_REG21_VSYS_OVP_STAT		BIT(6)
+#define BQ25792_REG21_OTG_OVP_STAT		BIT(5)
+#define BQ25792_REG21_OTG_UVP_STAT		BIT(4)
+#define BQ25792_REG21_TSHUT_STAT		BIT(2)
+
+
+/* Charger Flag 0 */
+#define BQ25792_REG22_IINDPM_FLAG		BIT(7)
+#define BQ25792_REG22_VINDPM_FLAG		BIT(6)
+#define BQ25792_REG22_WD_FLAG			BIT(5)
+#define BQ25792_REG22_POORSRC_FLAG		BIT(4)
+#define BQ25792_REG22_PG_FLAG			BIT(3)
+#define BQ25792_REG22_AC2_PRESENT_FLAG		BIT(2)
+#define BQ25792_REG22_AC1_PRESENT_FLAG		BIT(1)
+#define BQ25792_REG22_VBUS_PRESENT_FLAG		BIT(0)
+
+/* Charger Flag 1 */
+#define BQ25792_REG23_CHG_FLAG			BIT(7)
+#define BQ25792_REG23_ICO_FLAG			BIT(6)
+#define BQ25792_REG23_VBUS_FLAG			BIT(4)
+#define BQ25792_REG23_TREG_FLAG			BIT(2)
+#define BQ25792_REG23_VBAT_PRESENT_FLAG		BIT(1)
+#define BQ25792_REG23_BC12_DONE_FLAG		BIT(0)
+
+/* Charger Flag 2 */
+#define BQ25792_REG24_DPDM_DONE_FLAG		BIT(6)
+#define BQ25792_REG24_ADC_DONE_FLAG		BIT(5)
+#define BQ25792_REG24_VSYS_FLAG			BIT(4)
+#define BQ25792_REG24_CHG_TMR_FLAG		BIT(3)
+#define BQ25792_REG24_TRICHG_TMR_FLAG		BIT(2)
+#define BQ25792_REG24_PRECHG_TMR_FLAG		BIT(1)
+#define BQ25792_REG24_TOPOFF_TMR_FLAG		BIT(0)
+
+/* Charger Flag 3 */
+#define BQ25792_REG25_VBATOTG_LOW_FLAG		BIT(4)
+#define BQ25792_REG25_TS_COLD_FLAG		BIT(3)
+#define BQ25792_REG25_TS_COOL_FLAG		BIT(2)
+#define BQ25792_REG25_TS_WARM_FLAG		BIT(1)
+#define BQ25792_REG25_TS_HOT_FLAG		BIT(0)
+
+/* FAULT Flag 0 */
+#define BQ25792_REG26_IBAT_REG_FLAG		BIT(7)
+#define BQ25792_REG26_VBUS_OVP_FLAG		BIT(6)
+#define BQ25792_REG26_VBAT_OVP_FLAG		BIT(5)
+#define BQ25792_REG26_IBUS_OCP_FLAG		BIT(4)
+#define BQ25792_REG26_IBAT_OCP_FLAG		BIT(3)
+#define BQ25792_REG26_CONV_OCP_FLAG		BIT(2)
+#define BQ25792_REG26_VAC2_OVP_FLAG		BIT(1)
+#define BQ25792_REG26_VAC1_OVP_FLAG		BIT(0)
+
+/* FAULT Flag 1 */
+#define BQ25792_REG27_VSYS_SHORT_FLAG		BIT(7)
+#define BQ25792_REG27_VSYS_OVP_FLAG		BIT(6)
+#define BQ25792_REG27_OTG_OVP_FLAG		BIT(5)
+#define BQ25792_REG27_OTG_UVP_FLAG		BIT(4)
+#define BQ25792_REG27_TSHUT_FLAG		BIT(2)
+
+/* Charger Mask 0 */
+#define BQ25792_REG28_IINDPM_MASK		BIT(7)
+#define BQ25792_REG28_VINDPM_MASK		BIT(6)
+#define BQ25792_REG28_WD_MASK			BIT(5)
+#define BQ25792_REG28_POORSRC_MASK		BIT(4)
+#define BQ25792_REG28_PG_MASK			BIT(3)
+#define BQ25792_REG28_AC2_PRESENT_MASK		BIT(2)
+#define BQ25792_REG28_AC1_PRESENT_MASK		BIT(1)
+#define BQ25792_REG28_VBUS_PRESENT_MASK		BIT(0)
+
+/* Charger Mask 1 */
+#define BQ25792_REG29_CHG_MASK			BIT(7)
+#define BQ25792_REG29_ICO_MASK			BIT(6)
+#define BQ25792_REG29_VBUS_MASK			BIT(4)
+#define BQ25792_REG29_TREG_MASK			BIT(2)
+#define BQ25792_REG29_VBAT_PRESENT_MASK		BIT(1)
+#define BQ25792_REG29_BC12_DONE_MASK		BIT(0)
+
+/* Charger Mask 2 */
+#define BQ25792_REG2A_DPDM_DONE_MASK		BIT(6)
+#define BQ25792_REG2A_ADC_DONE_MASK		BIT(5)
+#define BQ25792_REG2A_VSYS_MASK			BIT(4)
+#define BQ25792_REG2A_CHG_TMR_MASK		BIT(3)
+#define BQ25792_REG2A_TRICHG_TMR_MASK		BIT(2)
+#define BQ25792_REG2A_PRECHG_TMR_MASK		BIT(1)
+#define BQ25792_REG2A_TOPOFF_TMR_MASK		BIT(0)
+
+/* Charger Mask 3 */
+#define BQ25792_REG2B_VBATOTG_LOW_MASK		BIT(4)
+#define BQ25792_REG2B_TS_COLD_MASK		BIT(3)
+#define BQ25792_REG2B_TS_COOL_MASK		BIT(2)
+#define BQ25792_REG2B_TS_WARM_MASK		BIT(1)
+#define BQ25792_REG2B_TS_HOT_MASK		BIT(0)
+
+/* FAULT Mask 0 */
+#define BQ25792_REG2C_IBAT_REG_MASK		BIT(7)
+#define BQ25792_REG2C_VBUS_OVP_MASK		BIT(6)
+#define BQ25792_REG2C_VBAT_OVP_MASK		BIT(5)
+#define BQ25792_REG2C_IBUS_OCP_MASK		BIT(4)
+#define BQ25792_REG2C_IBAT_OCP_MASK		BIT(3)
+#define BQ25792_REG2C_CONV_OCP_MASK		BIT(2)
+#define BQ25792_REG2C_VAC2_OVP_MASK		BIT(1)
+#define BQ25792_REG2C_VAC1_OVP_MASK		BIT(0)
+
+/* FAULT Mask 1 */
+#define BQ25792_REG2D_VSYS_SHORT_MASK		BIT(7)
+#define BQ25792_REG2D_VSYS_OVP_MASK		BIT(6)
+#define BQ25792_REG2D_OTG_OVP_MASK		BIT(5)
+#define BQ25792_REG2D_OTG_UVP_MASK		BIT(4)
+#define BQ25792_REG2D_TSHUT_MASK		BIT(2)
+
+/* ADC Control */
+#define BQ25792_REG2E_ADC_EN			BIT(7)
+#define BQ25792_REG2E_ADC_RATE			BIT(6)
+#define BQ25792_REG2E_ADC_SAMPLE_MASK		GENMASK(5, 4)
+#define BQ25792_REG2E_ADC_AVG			BIT(3)
+#define BQ25792_REG2E_ADC_AVG_INIT		BIT(2)
+
+/* ADC Function Disable 0 */
+#define BQ25792_REG2F_IBUS_ADC_DIS		BIT(7)
+#define BQ25792_REG2F_IBAT_ADC_DIS		BIT(6)
+#define BQ25792_REG2F_VBUS_ADC_DIS		BIT(5)
+#define BQ25792_REG2F_VBAT_ADC_DIS		BIT(4)
+#define BQ25792_REG2F_VSYS_ADC_DIS		BIT(3)
+#define BQ25792_REG2F_TS_ADC_DIS		BIT(2)
+#define BQ25792_REG2F_TDIE_ADC_DIS		BIT(1)
+
+/* ADC Function Disable 1 */
+#define BQ25792_REG30_DP_ADC_DIS		BIT(7)
+#define BQ25792_REG30_DM_ADC_DIS		BIT(6)
+#define BQ25792_REG30_VAC2_ADC_DIS		BIT(5)
+#define BQ25792_REG30_VAC1_ADC_DIS		BIT(4)
+
+/* 0x31-0x45: ADC result registers (16-bit, RO): single full-width field */
+
+#define BQ25792_ADCVSYSVBAT_STEP_UV		1000
+#define BQ25792_ADCIBAT_STEP_UA			1000
+
+/* DPDM Driver */
+#define BQ25792_REG47_DPLUS_DAC_MASK		GENMASK(7, 5)
+#define BQ25792_REG47_DMINUS_DAC_MASK		GENMASK(4, 2)
+
+/* Part Information */
+#define BQ25792_REG48_PN_MASK			GENMASK(5, 3)
+#define BQ25792_REG48_DEV_REV_MASK		GENMASK(2, 0)
+
+enum bq257xx_type {
+	BQ25703A = 1,
+	BQ25792,
+};
+
 struct bq257xx_device {
 	struct i2c_client *client;
 	struct regmap *regmap;
+	enum bq257xx_type type;
 };

-- 
2.52.0


Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7F36BCDD
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431101; cv=none; b=VDGzHf9F7A0HMDcqoEJt1j7pmMpD6OKH7ob5i8560ttu29KF0UASSgXZ0Zb75xwWK8wfoT0FLxB8L9s57lWkDqRRCgmmWpJT3uduYC+5+BuuZffq9SoMEX+xcWnfiK6DczI8syMZhSpM8/NmgOFhbUI6sGu59NMDjgRRQNORSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431101; c=relaxed/simple;
	bh=Vi8lBOp630ilsbWu7TQVgNwOksr7IIsbE6AqM8rs6Ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCjy2DGlfPH3PIVnBVF8O57wKScsidykgWGYlfSQodnnO6rUm3nukaEZCV5KfHy9WeWVRqIk2ghgyqJdff0FpLJ3HVs/N+tfQ+AzVOR5NViJmD7DzpWjTwc9DsOCbLK9m6rFpCkGQ1SXRcW3Q7/RXHzvB7UD0ln2sRV1beqV5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=q2G5AtRd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="q2G5AtRd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490686877a1so72293995e9.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431098; x=1781035898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqOFWfl1z1GfCJI9RlnRCpt/iBEpv3vNYTRFI/Bs01A=;
        b=q2G5AtRdqUcC7nCU4UMPFh2YpYcD+Y7SZByEqm0L7wHN1iOYpuY8bLW+MOaGuOmBY3
         AYn3XaxapfG9akOZ0Jb5iD7deTmpb6uCiG4mJ5LorSefoz66SY9nK0WOludRutEYbiNq
         JlwtQeH3dVPYzqVm1LH8IKcbdKhaqx4PV+ixSR6ZR9Fki6rzK30vlO08biovPu7WG2Rx
         CNWkfpdcppKhlqFR2XPcck/oF/V04EcJMD/r1RHpK+evzSiOwzCTZHFC3MMiV3MOl1b6
         EnAk1P/cQDBnvkYKHPMWwPHkBmcZrFOM0DheusC1SVCWaqWi0G2PDA05n00vX3fr2MSW
         mYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431098; x=1781035898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FqOFWfl1z1GfCJI9RlnRCpt/iBEpv3vNYTRFI/Bs01A=;
        b=Jw2j0OEYbh3WK7E7rVhakfDxd5gCe0JLb1lSmNTWIxbSg+bd8wW9Fy/aYAFzjz7iJW
         2gvM9a4GW1FsFgRAWBjPjIkmVYbnCYhzhi4i+JIbH3qb1tt0zTVUr/PvwcRYOl4HaNPo
         +/IlSAtqpTp7ywWkMWR3QQEmV8jFrLUDOd/r0/+qq2Rw+KhkepAVntmE2RjWQw6IP17y
         /vssZ12FubB4YuqHXqBva3t89v4vhE5CHE7CP63DfsCagJjPcDox10v2aya8tbjq0BVG
         YbgipV7fIyR4H1xotteFDHqKzA0BVbD/0l36jfFoBOYQtniHcz633J8tUT2Epl56P3a9
         Xajg==
X-Forwarded-Encrypted: i=1; AFNElJ++25TrMxsBie93wlU6vX7Ok5oo0mYNSTcA5nuElkO2eWV3mOw/lcGmB+5ZjCvYAfEOkK997afb6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9bgm7JOtmb6FE8XIfT8U+1H26IuPiJI4RZlqw1cdGXBGxxiC
	AcCs9Ho/8U5X8A4cJKc74a8oRHnVCne8sQnJmbTS+uImRD525LcIkYwUnv7iKd/ZSGk=
X-Gm-Gg: Acq92OFdxowr8t4QsSEZouKBCgN/YEC45nmtwgXpyHOtOROPQC/vt7Zm2pc05JNZ3xC
	XhqGQf2oCjNVl5i1iC8LjLFzmeMCmVzlIm10/01/gZ0tjzffwR+engF3xCruSM49k4SCHvGpAd4
	nAdDVZJZa1PbOo/M3B0ihgcBkfLJT9Be6x2s94ugYI+t96Py1ljVGwZ8uxjiBofbaOBnQGAZedr
	QukOHp7q1J5WCdL3I8L5VcX0CMUpa2vpnX0ZIgvHCKdTKKql+MwFnndxNKQe/e8hhK+e3LlScQf
	KDPXrSqE13c+XKuhC05Q8i26f+B4BbBsLve8iKDzV+WeIBMKfrmuHVAQy1ZG+f8zh2eKPcYl8Kh
	lLI6Cs2X8C7q8mtmsjL2XgbPJHEDvFwrYXIHFqcZ33tK/VgRFS9BDfVCEufnAxJUTSX4aP1IRHU
	VYFpI4ZCEjLR6+ABodwqxOMOikdLblOh+0zCfcoPAUV51cj7vMbY4=
X-Received: by 2002:a05:600c:4509:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490b613c9cfmr2628325e9.11.1780431098383;
        Tue, 02 Jun 2026 13:11:38 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:38 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:54 +0400
Subject: [PATCH v7 6/7] regulator: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-6-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5043; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Vi8lBOp630ilsbWu7TQVgNwOksr7IIsbE6AqM8rs6Ns=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzyf3xwg9UG1av6tOUcdLHNUtstefKRyJ7naNVPK4
 oTozCynjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKZ6fRYjw1uZ6uumO6e4bv0vcch77uOOrMf5TDP5r/h9uCftcOtg6jSG/9Ercni
 l7qqsMSrwntbo235hVoePkNw62yUL2u3jizW28wEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add support for TI BQ25792, an integrated battery charger and buck/boost
regulator. This enables VBUS output from the charger's boost converter
for use in USB OTG applications, supporting 2.8-22V output at up to 3.32A
with 10mV and 40mA resolution.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 98 ++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 913ca9186bf1..fec75b23cd40 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -31,6 +31,32 @@ static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
 	return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
 }
 
+static int bq25792_vbus_get_cur_limit(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(regmap, BQ25792_REG0D_IOTG_REGULATION, &reg);
+	if (ret)
+		return ret;
+	return FIELD_GET(BQ25792_REG0D_IOTG_MASK, reg) * BQ25792_OTG_CUR_STEP_UA;
+}
+
+static int bq25792_vbus_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__be16 reg;
+	int ret;
+
+	ret = regmap_raw_read(regmap, BQ25792_REG0B_VOTG_REGULATION,
+			      &reg, sizeof(reg));
+	if (ret)
+		return ret;
+
+	return FIELD_GET(BQ25792_REG0B_VOTG_MASK, be16_to_cpu(reg));
+}
+
 /*
  * Check if the minimum current and maximum current requested are
  * sane values, then set the register accordingly.
@@ -54,6 +80,37 @@ static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
 			    FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
 }
 
+static int bq25792_vbus_set_cur_limit(struct regulator_dev *rdev,
+				      int min_uA, int max_uA)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int reg;
+
+	if ((min_uA > BQ25792_OTG_CUR_MAX_UA) ||
+	    (max_uA < BQ25792_OTG_CUR_MIN_UA))
+		return -EINVAL;
+
+	reg = (max_uA / BQ25792_OTG_CUR_STEP_UA);
+
+	/* Catch rounding errors since our step is 40000uA. */
+	if ((reg * BQ25792_OTG_CUR_STEP_UA) < min_uA)
+		return -EINVAL;
+
+	return regmap_write(regmap, BQ25792_REG0D_IOTG_REGULATION,
+			    FIELD_PREP(BQ25792_REG0D_IOTG_MASK, reg));
+}
+
+static int bq25792_vbus_set_voltage_sel(struct regulator_dev *rdev,
+					unsigned int sel)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__be16 reg;
+
+	reg = cpu_to_be16(FIELD_PREP(BQ25792_REG0B_VOTG_MASK, sel));
+	return regmap_raw_write(regmap, BQ25792_REG0B_VOTG_REGULATION,
+				&reg, sizeof(reg));
+}
+
 static int bq25703_vbus_enable(struct regulator_dev *rdev)
 {
 	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
@@ -101,6 +158,34 @@ static const struct regulator_desc bq25703_vbus_desc = {
 	.vsel_mask = BQ25703_OTG_VOLT_MASK,
 };
 
+static const struct regulator_ops bq25792_vbus_ops = {
+	/* No GPIO for enabling the OTG regulator */
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.get_voltage_sel = bq25792_vbus_get_voltage_sel,
+	.set_voltage_sel = bq25792_vbus_set_voltage_sel,
+	.get_current_limit = bq25792_vbus_get_cur_limit,
+	.set_current_limit = bq25792_vbus_set_cur_limit,
+};
+
+static const struct regulator_desc bq25792_vbus_desc = {
+	.name = "vbus",
+	.of_match = of_match_ptr("vbus"),
+	.regulators_node = of_match_ptr("regulators"),
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq25792_vbus_ops,
+	.min_uV = BQ25792_OTG_VOLT_MIN_UV,
+	.uV_step = BQ25792_OTG_VOLT_STEP_UV,
+	.n_voltages = BQ25792_OTG_VOLT_NUM_VOLT,
+	.enable_mask = BQ25792_REG12_EN_OTG,
+	.enable_reg = BQ25792_REG12_CHARGER_CONTROL_3,
+	.enable_val = BQ25792_REG12_EN_OTG,
+	.disable_val = 0,
+};
+
 /* Get optional GPIO for OTG regulator enable. */
 static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 {
@@ -141,6 +226,7 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 static int bq257xx_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
@@ -152,7 +238,17 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->desc = bq25703_vbus_desc;
+	switch (bq->type) {
+	case BQ25703A:
+		pdata->desc = bq25703_vbus_desc;
+		break;
+	case BQ25792:
+		pdata->desc = bq25792_vbus_desc;
+		break;
+	default:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Unsupported device type\n");
+	}
 
 	platform_set_drvdata(pdev, pdata);
 	bq257xx_reg_dt_parse_gpio(pdev);

-- 
2.53.0


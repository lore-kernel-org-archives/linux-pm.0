Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4B3DFC84
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138786; cv=none; b=s5t80W437bNOjZ8piiQXik3BHPwK1hG2ZxhUUCYB4QlwPTbSSOnxfsu+vD7yH0YTtklfPwAtVcXDyhelQSxesb3hZ7D7k2FS0xOandWTxQ6wnjb2tZpTGL+DscF5ft/qEFyp/3gnjFrq6Ta4Vlj/7g1VTHpbCWel1aGjlDqdHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138786; c=relaxed/simple;
	bh=iGZpiET9IUnV8I/l8oUOyWubk+/NWbwwk0XgyKhRn88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTr1Jk9np/hGFlporX8lOcddl4iNo6BGM209PtkvFu2+FPFxozUweweCJLOk8FalsMgtzy6wqinuTg5DlQc3z/AyX6rZzMPGAjogybQHMT9JzleuRtaVMhWeRYUtsO0mHj2g+eRx9G0sW//nprv/qEdWSYRk89MoLRndEudYEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=DNXdHIgw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="DNXdHIgw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1362504f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1785138783; x=1785743583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xvTMn3jbJLoQpoSz4VCNMn0fL0sMx+MYa124HsagJ4g=;
        b=DNXdHIgwO3aMhq7kgv0WZZTNQKCf/HseFg9WlWZXN+kgfbbK5CZGP0xp/L7VdJK0TD
         gugFMbmhHob4+/KDjIfJUaZiqF0WG7mttkseEu3LbhJUHQWbbrhC3OpZVwS69I2Zyo8f
         TvzBnEC6y5ydnHOma5qJOgzQSuww7C3HpXCGsyMx8nuj+Ljlnz5f/HOEKlN/SB9O7iyI
         p1QBGaf+rmUGNDiFjIKFGmUghhLI+62jW3rjNIPKhY6C/6NjX1pd7cfzPRFG5+TqnF8Z
         h5E8ofXzPqd4Sr1/g3cY2DhtsYmqMPgs/RHnxiZqY49pkI7/5nwIMykB1L/9zuJUPhNs
         WBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138783; x=1785743583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvTMn3jbJLoQpoSz4VCNMn0fL0sMx+MYa124HsagJ4g=;
        b=fq7L1QoPl3URJQnJpD9b1Or13Qmv1RFhbQwgUZfbsNoXwtMZYKsuq3QSrum5Lmvxhk
         k322GlL9fOBUBO2a4HBut1ZJjsCU5c7N5IPXQHQUvJ9ICKdXkgkSfOWc7kZbnisrOnK+
         cmTohqEYRPTMMVzUkUQ5hGdPRQyf3U3I+v4i782WoimVmLoCM//XZlGsqelhXyDAMf/Q
         EGP1QR9k+DMi+pPiy9dtpHCnS9qOvdBcdhGcC1vCjfWWDYYT49Uyni1W49hW7+bdeS/b
         UVU1vdbSSMO18i6M5bkVA1StKrl0XVkCKUdkTEaC9zfdBLvzAKuRamXww2wq+60HJkOI
         w/VQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUUT7IRR6dFm9cLOYul8Gm3zMt9r7414/FLxIp/iIZvMBLqEkuHp2j/MSKufoilM8uGz1sOFCwkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6Mw4gA+W1laOgSWaNbYC4pF0EMG1etfDEusFGm7xlqybD+g0
	wAaVDeX9Qh7SYPDOoN3TUgLiBJj+mOmNsmU8Ns01q2ChJwcFcFSCMf1eXCeEmTfawSQ=
X-Gm-Gg: AR+sD13ztuejtYaWITAuZ8rbmfL21wA/7M9h7DV6U5Qmep24raEYtQRpCb9b+ic+tA1
	ibCg41NpWkrGsP0seJGrAt5w/3o/Ay0sMZkWDuYUMqoKU49asMq0pB5poyQPwskLzV1Chwfab/c
	JG8CV2zmNp5m+ElUQu9854g14PxxMD8MCsPOUhYceBrJ16DHiz4N5PXdNYjtuVopsuT/4b2msPU
	pisuzypcC3d3qeIjq8oMbQc1cX2kSDXIts7yiS2ra6WaKF1tpNqeFUqZdkn8ae7LcehgOhzh1cy
	tAon8hKU2ACfdbhpbmt28ZQrVIdJi5aPPhQQS9lZk5RazQuEvslWp9179sMnj5IjxIAef3Dlo/0
	WqktU2e5X44zovFlzQxaBSDsn2TgbNP3brLAjcrEfx889vYQLgLeXFFZXiM1wyn62soyT0hx2ow
	2W2IHhIjB/JJXwnVlMNjbZ+z7NqrOVTEzkMIxiVRQqPpVtZ8QQzV3jnQ==
X-Received: by 2002:a5d:64c3:0:b0:47f:83ee:e56f with SMTP id ffacd0b85a97d-47f9fc91abfmr9500716f8f.18.1785138782571;
        Mon, 27 Jul 2026 00:53:02 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae. [92.99.174.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531basm50841449f8f.19.2026.07.27.00.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:53:02 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 27 Jul 2026 11:52:37 +0400
Subject: [PATCH v8 2/2] regulator: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bq25792-v8-2-c1c70473bbe7@flipper.net>
References: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
In-Reply-To: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5032; i=alchark@flipper.net;
 h=from:subject:message-id; bh=iGZpiET9IUnV8I/l8oUOyWubk+/NWbwwk0XgyKhRn88=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSl8wW/O/Jpt3+sutvUxE0rBLumVTlLLRafKmJ/d/Gn5
 uMccSzRHRNYGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy1wQpGhtX8XEpl087OZ07hT8s31uxqVcvvs95T9uGGQ9C6xy1q4QzfLEtuZ8n
 7fHrf+G7hlii3uR0q18N0p61cW8K9da0Njw0LAA==
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
index b8d6d578285c..c450e23ee7a6 100644
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
 	struct regulator_config cfg = {};
 	struct regulator_dev *rdev;
@@ -151,7 +237,17 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
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
2.54.0


Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEF423146
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971856; cv=none; b=ZxSMi81wOOSaJPDNdzytZmoQzxaRecKo1765Al1TI2965nv6U0FtLHembRBggt7UvACNBVc4ad2J/QkVLpJI0kZbjUqS4fbo40C1L6Hl3AmQAQSSBRCPsewqBKb3/vshs7Pxeb59s8ZJ1yOpuV7C0zk/4zptRGbB1FfLd6jsfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971856; c=relaxed/simple;
	bh=q9BptJDuAQnjOV/HxIZuYo7P6hJdxkSiFaoHcUpNVb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMrOSjrRCZwezYOAXvBIvjrplMKHYwxtSDFE0t/YohCUwJzP6WR2lE09wbNWSTlcABibT78ypbNUWv7GquCr+OC19cVwqzC3rU8Y2EoHdHiVPl/DsLqLoVEsv2KevCk4eUqlskLfT4lpcPu8+PYPDBF6ppLPFdBmu1di2ivmYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=jlMXsJjA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="jlMXsJjA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso50293555e9.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971853; x=1775576653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzdSIakIBsa879u0fxfflVhMlKymXjPa/1rJ4QxUnO8=;
        b=jlMXsJjAOg5oD7hc1Dj08nUdrf56nun6f/NabowWGpajBW5IqfUezrzyfOx+qGlEB9
         dBa4uc2dRNmYI+Al5OOkfxSSPFGZ6n29F6hJ4KlznTl0wSiDIbgg0N0MwjKzmJS5BqY8
         bkhF2mMmenbl3P5IAGgnGPOjHaf9t5hok+nRi9M1syVRwMpFLT54vfXHtjxgp0xF0AeA
         c36Dl+Mk3gUiP3e0v1r0EAZT+du5HhhFOpIhmYe/MkK2JP41KD4sTpbslCbXb5VCZQrC
         LSAcQQb8Q6+zMq8RsihDkru4CXb3/QRdPxvKj1CdAx7tw0BxFXep+nIoA/rQGmrKPgiS
         bkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971853; x=1775576653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzdSIakIBsa879u0fxfflVhMlKymXjPa/1rJ4QxUnO8=;
        b=JPw0+45VDnSMXXqkMERhv5uXaWJLVfBubR6n5NTInLSCCEV3e8ABn8R4jmuPWDGrkI
         lG9OiORD5UvYTXvDL4AmBKbOYOyyuBGqPfs7LE7Nmt9VFZLmrKU4j0ZV284T3YqtxG8T
         Qel4YJqNETU9yB7DvrOQzmdSOImq/vG+jxESxrENhzE0uDwjM93l5dJKEqvb9qHU44UV
         Po3sJM+dmlcUktFQV+pSMKYlQ+pvhvqvGXDrLYLWd5iaDiJUgdWKo7UFl7XhN4mPfSKu
         1fCtpZiPt9TZ/0XW2JR5QHFBbJIXNolKkbQxcrrkaHtPJcv/BTw/34pWW0LPaFgfjcuF
         d/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV85T3ntARlV1T2ODjjlYvRZ0PthsUF7+QMZjV/Wci8udhf1Wv+DamRYedB2MZWbr+9Xk4rwbVoww==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8zw5obizg8+DMaH8xXsCHLmAS2S+uSlVkdLdcmqBIC0I9dyF
	DlQxOQpPuIw8r/y2V0Mi9B/GxcUfMjDLZB1YUcdbctCFFYCiQYcabIiGbylROPym8ME5iBsvDkD
	oiycFxW8=
X-Gm-Gg: ATEYQzzZnM+fhyx+NpvfwTIqVLwMuGhJZ01Zf1pXsZyT0r0t7HkCX5gj/qZnV0b+RD6
	f4qcCEtRQyRhrVxTfGwRBieHqtgi+V3PVFuiVove0VkolWP0MQWPLe91OH0KrcxZv+AhouH7CLW
	l46lHIYF83/hJ65KHiqunnyVUMe0LIxqlauIKD7kFB15myv1zI62tGji3rx0LIsnnkxM10590a8
	arEGNGWjzId5XQ0TXkQsmtEP4uyUUGLD2oWCa4s/YFm6ccjgTsb/Yjj18EXse6EgwfJPoxiRne5
	/oHZR/oDSFETJ/KxzNk/BT7TWRBAh5zQc1M0onAIT1kripZmHhG9jQ18MxCDLNsb5+Vn0IeigRE
	LMkhKdEhcfdCTWf930kJYOqBdc39pn38D59YOXiUMpAq4XwDTLYN3pCAc2B0QTXXp40ESxKK7bb
	0MYEPaAQqiWh88jiAPIpwoClFTYySSCsF8+vZbforMnr3uncm35b1k0QIgFBy4yLk+ojZVxU0iV
	sfQ4A==
X-Received: by 2002:a05:600d:7:b0:485:439b:683f with SMTP id 5b1f17b1804b1-48727f5fe73mr231743725e9.20.1774971853323;
        Tue, 31 Mar 2026 08:44:13 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:44:13 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:47 +0400
Subject: [PATCH v6 10/11] regulator: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-10-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5094; i=alchark@flipper.net;
 h=from:subject:message-id; bh=q9BptJDuAQnjOV/HxIZuYo7P6hJdxkSiFaoHcUpNVb0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr1+nnr8Vq/ebevVT8ZJSTIv+7aPtey6+pzVRxW3P
 Y8WenHneMdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ioY6xjxMDFKQBT3dLIyPCjuZlBa44m3w1nCR0Tp7hfc77fmn1IcXXChJ0bTRk17YIY/js8CHm
 pKfDl7/XrCVceKicdmlnw/5dXmuGGoOeT77C77OIAAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add support for TI BQ25792, an integrated battery charger and buck/boost
regulator. This enables VBUS output from the charger's boost converter
for use in USB OTG applications, supporting 2.8-22V output at up to 3.32A
with 10mV and 40mA resolution.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 98 ++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 0bb58ab4b8d4..f197162382cc 100644
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
@@ -153,7 +239,17 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
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
2.52.0


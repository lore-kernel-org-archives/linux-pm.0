Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BB3F164C
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352335; cv=none; b=XEDbbQ1+ZFacD5SOKYj1nk1wZ1xNaTc4HNRByHMYqM8l2eBMz9bN+Usz2FNeHn5qZxkghvg4W5asP9KiXxDPCHPUpHVV2emuBmzqz5zYpOlID7etKXmzf8h/N9BafFY1DLhu9AWhpW8yP5n96OQIrhQYmqDevpBKYTVDmt3uQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352335; c=relaxed/simple;
	bh=q9BptJDuAQnjOV/HxIZuYo7P6hJdxkSiFaoHcUpNVb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZzUGsUW6hpIsfio7rRgSx5Ex2UqMSYxDmhaRuDWkWB3RwRUM7b4gJU7rKiYJTkrHvu/ANoLBXwP6MMpKqKSR1FHmb9eoZFcbxaekVFVbzig70nwbJAFKakBCqIreIHdvN2hZp4mxX5OwZTnfxFTyvjrY6/LRky0dCrwNh7tY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=z+Af7ybM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="z+Af7ybM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48704db565eso29812405e9.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352331; x=1774957131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzdSIakIBsa879u0fxfflVhMlKymXjPa/1rJ4QxUnO8=;
        b=z+Af7ybMDeDxHoYjyX6A3X/5nLpChJaMOHXBeIDqtommvTuA8gSP0VIh1jBO6ELlX8
         gJS8TB+jQgSr02km22+uidJ7KwBsgzBSrIf0jpN4HKbaiW5dojCLYRkS+5qYfo5wH/Vf
         1WXkDDRAwK1CQOsRUBY7LOnA5rR+Wb76FwxSmRfQuRRwO0ykYUCSnFNQfOV/m3yNpO4j
         TUaA+S/0mP4WHCuTHEmtSHZJIk1Z4u3Vw0dZlIu6zvu6r7ysROg0+YnCcOsqHO2UgEuu
         5Ikbb8E9VJh+j1frg6e7IOR9QoInpAzw4Y0wA0vimV8bTYTlmSeTpmXzmi+9Q1dodc2/
         0ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352331; x=1774957131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzdSIakIBsa879u0fxfflVhMlKymXjPa/1rJ4QxUnO8=;
        b=pf30shD99EHn7fF5DvlWPLcAB2ON1SL4hV6SwUl1p5dsdvSzBUwwlBG+PAgVZdn3XO
         e+N8hPoiBwp4sSpFico4Kj9Z5VOwbWGHuKvBLwyCk/iQEZEoF3YR89g8P0B85WUdUhst
         0udjT0Ul4wDCNgB+zHGmaj9PjAdTpVifWN12aGUXEdHC3ybPrg14BrOeaBsOhvF7BxG8
         Qr0IJ67JjPxJn0G6utqXPSrcOjPdLJ9S0XCaij3mC74HeW7RvqFJ8MV7yvoQ1wMoTuTV
         QhpNyxJYyZaiABqeigTko/CTo+930vL/dYK/V8FS8HJvt80YXJ5X/7jqTSCWbolaHchn
         VG1g==
X-Forwarded-Encrypted: i=1; AJvYcCUOIogxn7VZ5rk3dZGL1pwljLHEZDKA2W3E/99hTJJ5Jns6YF8JBLEjUgHZU5EElpGKjxWMHvp21g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsdS7brCaDqyNLGUSsokVadRWBcfA3ock+PCgArtRMMSPLLCJ
	7HZaV9OWU+1bEcZEuGrBqmuw50k+edsFWV0GSpPZhaQ3HV8g16NTPf9NHblRlMDpAcA=
X-Gm-Gg: ATEYQzwa9tTR/pCC5RGWsREN/D9RZZW6PSVv/FAMxxFgMJrx4RbDfCtStV+CKM4c+bZ
	LWse+OBrR8s15bVTM5aPmxWwSb1DVxAobyDaO6RJHef/FsZL5QQxs24AdQ+JgoJN3oh2zETG2iR
	FIHFOXchexv22VJvxhOZaUvgFDNdslNsd/aqwc/plW6KRF/AGhuZoz4Mbs11qjSMb8V2aypQI4F
	qpFHdBqmsJiw+kltuCH0+wkH+2kSFn5oKXWI9VZGjEWGElcqI0B5YD41CBS1ayYQJtQm6Xx84HR
	Qg9zSofX4wy4yGhy7NXA31ZOMrGnh1Kf2TlsKHpcnsrrBonwM7PQm3Bazyoq53w6miHZBdUd1Zy
	izE61Q5nArIu2oSP+DEey05Gc6RVt3vTM5Gy1sEl8A/IpguIaSsD6O7bnHXD23eCO/7m2DBpeeM
	jHdRXDl1yVtyyzPZwFVp+41LMJ3OYJ04Aa3GYv1Z1onq4cGJ4YXDxCFoDGzRDaqGCZ1i5d2lx0r
	MTy4w==
X-Received: by 2002:a05:600c:3b1e:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-486fee05925mr211358475e9.19.1774352330747;
        Tue, 24 Mar 2026 04:38:50 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:15 +0400
Subject: [PATCH v5 10/11] regulator: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-10-0a2eb58cf11d@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5094; i=alchark@flipper.net;
 h=from:subject:message-id; bh=q9BptJDuAQnjOV/HxIZuYo7P6hJdxkSiFaoHcUpNVb0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl9bOIX1qU7uv0cVcss2Pwx+s8FztqSVc+qLbOtPD
 LPXOP5/3TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBUJ75lZJi5z78goz2uPJd5nbXDpuOL0/0snVnXaHxol2TN8jj3wJeR4brZbd/
 Wzz3spUxrNvDuOHrY4bjXve6LHhs9apLWXfvPzgUA
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


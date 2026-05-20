Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8B33F8A2
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292562; cv=none; b=UfXSgxWvsctMFBn2cAtddlOROpP35a/lbln3kykVWp9t54uICaW/iikCGN0qzjtuDe5G0qNiOO6v/YZ47zZUqTzMOVH6slD1KPnDLjIBOUKgEygGG30NycvW0rCjQT8ScrHEuYepXc0Ov/4eUwzxLeq/GdvPPeRPrpB0msLYImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292562; c=relaxed/simple;
	bh=gCW1JK9UfuVJlNjcjVAgFsmrKOhj8oYjfr8zCWm7Bfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzUFz9Gp8jyUofwW8Fej0cGhn9f0SIIHviUJ4TT4yr4SNBp+PW0umwjB3cM9WaSKbHBAsJGc/CIaDPJxOe7jV7gfYaUIVYZFAjAXTUFInoyMm1sVWFwyzVTBheW/1UjDGuEyLrrRL0GBix5XxEJPmpmdDQTDRyP8CEQHky80oPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMTtc0yM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMTtc0yM"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48e82c23840so41400745e9.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292555; x=1779897355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXeSKigfSE7Ujy9dejCk8EK2GGuGXGtDonABN0rEpDQ=;
        b=FMTtc0yMGQe1cpHJeDknQXZ5ZQoaCfNc38EMEVsQCKqpb8pMh2tDdEh//8sXyCMHKx
         a3zn4N5Sgk53zW87A9KiisrQzJGHRdR8+Fw48HvJ3pyYMVFasaGFiakB/N3EbJpSRwZ6
         erqVQWn5fmfINE8u7U++h/4mxfuqg6EfJgSp1BWjmIS2yMVW9bGYDP1BPS15gbw+0TdZ
         YXfq+0RR+jDjvkn5q8ZFhJbIsbV8NcfKJiA326h88zjKRZsJnHAzP89l3kqx4c8ua5gJ
         LCde9dFetglKIVpzUvyW9plNh/+edj+JMvgJP3AjHjMedkujFRD1H0fRBRw02qocRKff
         r1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292555; x=1779897355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXeSKigfSE7Ujy9dejCk8EK2GGuGXGtDonABN0rEpDQ=;
        b=I1qs2EpYu0dPReI4nBMUSU2GzxPD10Wajm2RSCrle1PikeCfXGMhYdv8gu2SIXAnsj
         wanoR1O+8Gy9x8fpRenEuInxJueiyka+J67Gz2wD5fq77C2r4s1lslTcfDnIdaMe+0/S
         n8+MW3HE2ZpJ9tcxRaaEIgvlIbXxRIJZvRrBZFPD/8CL6hq4d41Kt77kGfpxkgEInoa6
         XuND6V2dgo0VTGaMcrx/6sLj+xRPB7BDIIOOb+xOZTSHm1/6qKZ1K1JMUMRTQ+SwIcIC
         WEjHt6r9pF0GdXDveHGIa/UhEJY2EhAmZc49r61Ujlj2zN+rupw0Nt0H1aRMuI84LXJj
         xfAw==
X-Forwarded-Encrypted: i=1; AFNElJ8G3I2tpWFXmlyV7lG9FHpE2OtdluYAm8pH2YgTnJQyKDbCSiq273WCM4eodOhd4EUlORC1c3gIIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziSgBxRVI2zDqfcaSaQYmSK3yWPXGG2yyo0hrkE59Ctsj1N1Ew
	BV/njo75o6Ofg9hBI0tqSI+OiBcIDUPe5oqGsExaScckZt1IIoGEnq4A
X-Gm-Gg: Acq92OEEyWtswk9ulDIlz+Ty3eXhue8xKO+hoyuFqEIMEHT2Oa5ncxXf1cVxBmae2GA
	ODBX/y0FQ9hVxNfb9KmA+45JMR6khvD8BYEcBxOi6KiguMpWfeRzzZ91OnEwZxrSkCqtgh/VyyN
	HaPHYt9b2FicInWykdThxINdQjiSjdf6ldfvTdewZUAS0UlXHexnitLbzqdUwC9QkDVGuTgbKs5
	E3FSkkW8V3P8KvOrt3gPXz38LGCIlb5f5MsJbeLlii8+qc4L8MxC2tqr/HqpRYid42yzwSV8AP2
	3tWTz6C3gSa2MtDd4VEBbYAxnDHO00v1EHNZekISybmtI95MxMOY0mW7oB7FGbzBzbAc+EFKU3Z
	EbabuoMDIcxD+KGhW+S6SezR3SeopCE4yG1x0VHhcBnyla4koYuCLoRpCpbBbt1wOreiXdyh7mm
	hO7oida815VbzYt1F61ohRxWSnsVyd4UHtkbi6IKlld0JtbAvf5kxI1+kWGKuiqYk=
X-Received: by 2002:a05:600c:3e1b:b0:48a:6fd4:d3d4 with SMTP id 5b1f17b1804b1-48fe6626c48mr336469215e9.29.1779292555212;
        Wed, 20 May 2026 08:55:55 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-22-5-99.retail.telecomitalia.it. [79.22.5.99])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fed253f93sm132123215e9.16.2026.05.20.08.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:55:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 5/7] thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux function
Date: Wed, 20 May 2026 17:55:18 +0200
Message-ID: <20260520155525.22239-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520155525.22239-1-ansuelsmth@gmail.com>
References: <20260520155525.22239-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support of Airoha AN7583, generalize
get_thermal_ADC() and set_thermal_mux() with the use of reg_field API.

This is to account the same logic between the current supported SoC and
the new one but with different register address.

While at it also further improve some comments and move sleep inside the
set_thermal_mux function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 56 +++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index ebb47ae5f2ce..249abbbd46bc 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -193,9 +193,18 @@
 
 #define AIROHA_MAX_SAMPLES			6
 
+enum airoha_thermal_chip_scu_field {
+	AIROHA_THERMAL_DOUT_TADC,
+	AIROHA_THERMAL_MUX_TADC,
+
+	/* keep last */
+	AIROHA_THERMAL_FIELD_MAX,
+};
+
 struct airoha_thermal_priv {
 	struct regmap *map;
 	struct regmap *chip_scu;
+	struct regmap_field *chip_scu_fields[AIROHA_THERMAL_FIELD_MAX];
 	struct resource scu_adc_res;
 
 	u32 pllrg_protect;
@@ -219,25 +228,32 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
 
-	regmap_read(priv->chip_scu, EN7581_DOUT_TADC, &val);
-	return FIELD_GET(EN7581_DOUT_TADC_MASK, val);
+	regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_DOUT_TADC],
+			  &val);
+	return val;
 }
 
-static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
+static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
+				   int tdac_idx)
 {
-	u32 adc_mux, pllrg;
+	u32 pllrg;
 
 	/* Save PLLRG current value */
 	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
 
-	/* Give access to thermal regs */
+	/* Give access to Thermal regs */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
 		     priv->pllrg_protect);
-	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
-	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
+
+	/* Configure Thermal ADC mux to tdac_idx */
+	regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
+			   tdac_idx);
 
 	/* Restore PLLRG value on exit */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
+
+	/* Sleep 10 ms for Thermal ADC to enable */
+	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
 }
 
 static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
@@ -344,10 +360,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 	u32 efuse_calib_info = 0;
 	u32 cpu_sensor = 0;
 
-	/* Setup thermal sensor to ADC mode and setup the mux to DIODE1 */
-	airoha_init_thermal_ADC_mode(priv);
-	/* sleep 10 ms for ADC to enable */
-	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
+	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
+	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
 
 	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
@@ -430,13 +444,18 @@ static const struct regmap_config en7581_thermal_regmap_config = {
 	.val_bits		= 32,
 };
 
+static const struct reg_field en7581_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
+	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(EN7581_DOUT_TADC, 0, 15),
+	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(EN7581_PWD_TADC, 1, 3),
+};
+
 static int en7581_thermal_probe(struct platform_device *pdev,
 				struct airoha_thermal_priv *priv)
 {
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
-	int irq, ret;
+	int i, irq, ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -455,6 +474,19 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->chip_scu))
 		return PTR_ERR(priv->chip_scu);
 
+	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
+		struct regmap_field *field;
+
+		field = devm_regmap_field_alloc(dev, priv->chip_scu,
+						en7581_chip_scu_fields[i]);
+		if (IS_ERR(field)) {
+			of_node_put(chip_scu_np);
+			return PTR_ERR(field);
+		}
+
+		priv->chip_scu_fields[i] = field;
+	}
+
 	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);
 
-- 
2.53.0


Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B313ED11C
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229491; cv=none; b=KCfSsx6mPV/82dbC94UFXn835zIlylJ4UNd+fzTVhzADdgDWCVf2QWG4Uv8Rsnodeoo2usizaDtxA9MBZOHZE8M0TmK57uVQGBqz7f0F6b2rymAyCdK/2HkZ+wvnp3g+fwBFtP2UqANZmyPBXQcJKn6I9apCEBRuDXaL5EXbWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229491; c=relaxed/simple;
	bh=htW4hYRWiUwplPFj0d2TFcKHJJnYxiOgcNIGqQlWOpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC0tWpjRdOfeuKVjk84WdQASxDBkmjJdCj9NCb9TTlmbeUvMav5NgVVOGOkYmy9YUGPVX2DZ046AMEfzLAeYEY2+I+MuF79lc3EIbqtigr5ID1WCt9TwSRLpY+M3ot7HCNSHZy5f6Vn/7ogtXXIITXnYDAtjEPFc308wVsy1+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnmdBpFX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnmdBpFX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48fde648a71so30361575e9.0
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229488; x=1779834288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbT6JFfEI94054ct5KRMwXyHu29ZqKoVeW1+JvOnT90=;
        b=HnmdBpFXPEqS4zuy6011Fz2KSaTkdrxS6r9OmUjbGVf/XuaTtp3al/f4Dp/DbaGh3P
         zkLPSwcNn9Qn4waP4MTunj0KAaT5oDUMEP8p0kLQVu79QBegjMGsTeRdOvA6w6/I/QaA
         CvnehZ3ajapeiMBDo1Gn9CNjcdCBYc/1ACvwmYM9KWyodiWY8afw7hU2sekb2WUhX3Jb
         oNyf5wVX9YqFRFq8JuigG+UYH0xlWA3uzxHI9Pq1pswr6WVrEH0aATd6hf/pgMhKrHGl
         N3x28btNkMK905oZB+0qeorXbnBJwrK1riXKicFL8+owfRLWViCTLlwa0d5MehPZMIkb
         DqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229488; x=1779834288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LbT6JFfEI94054ct5KRMwXyHu29ZqKoVeW1+JvOnT90=;
        b=akNxCNxR9mwhPAvyQmCMWpexf+vk1cHMvoL5qvRIOUeoix6twXlT5v6BcGQgtU6BfW
         VwGj8z69LN3nPMfUAHCfJL6BMpwbWQe3AvpT9JCR22iS2ZmpbCJh3Fh0lhN7gcqqhnFZ
         BNwaD5YA/l2bkghxUwPWeC34Y0IVrR71LoGa9+EhbIguFgfdVj/8TYlLXzYjJnRsXcyZ
         uTC4kvqu9XlYH0+BC9ja4OFXwnAQprUhTmI8oRelLRyV6fLZmH0wXmw2Lq9Czy56MDsG
         b+Qc6B1pjJjtJkzIRSiBNWhwUJUVT6DzxuIMUAQEaWPw4QXFuW03erg0PSz0K/+UOXMO
         HWRA==
X-Forwarded-Encrypted: i=1; AFNElJ8pfig0CZGsCsy8FR3cUINvYGTYgUfWilE5H/d5l7b92z0vQsAGXlOLCvcOWY2fl+lC4MnmHXeOlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygDAeA+2Px646Guz5aCmyvTMDcPX/ArTqdhVX6bVHydxz1sqxY
	VDpyArPeltqnjUdgnnMQxjzIZ5TvqIue7LwTiEAPUpuo+3tc+s+5wxyD
X-Gm-Gg: Acq92OHnjqiNRV5wW3seECDMog8Wczj5fTDsRxSrh7rHcYzoNRtA9pVDPNT4eQBeM3A
	ayGoShlF80R6pk5GujivSrMrr6rvYwT5tupm0dPxl2iDWrBqsTPMqhJKgst7yu7XdaFiP68jc/G
	e4QuPS0UqNsm8PUBT/ROUratZMypdF/CskbDaApT2kZhi6Aoy4uQSobrhrun4UXsnJH/2h2ixml
	6sI7jf7CBPO1FVWrJjwBfIdXOzo3sjPfJb3+c2SD33Usgdzvr+AunIbSSO9m7qIyvyXJyBmLvQM
	ymuZY6qWG9v0dOqcJ1/kB65AyNvMTZgwJjDlb7GH5Son916zwHoOROl6+tTvhFkxcDzzr3K3AxO
	FaeqYNvhGbKaQ7XrWXgdeXAIDR8FqnU98+lTKIv/TdUYGnuvEv4y4aNskkmlPPRS72UqG9mncfk
	0XaEP2VEq1d7237l2JKdz56AJ6Pdm/tVQ3wonjfXUl7FpZHt37WneMS6wI2QxypWQ86Glw7DI=
X-Received: by 2002:a05:600c:83c7:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-48fe53a8eccmr324459715e9.16.1779229487782;
        Tue, 19 May 2026 15:24:47 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm381097435e9.3.2026.05.19.15.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:24:47 -0700 (PDT)
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
Subject: [PATCH v4 1/5] thermal/drivers: airoha: Convert to regmap API
Date: Wed, 20 May 2026 00:24:22 +0200
Message-ID: <20260519222433.29684-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519222433.29684-1-ansuelsmth@gmail.com>
References: <20260519222433.29684-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for support of Airoha AN7583, convert the driver to
regmap API. This is needed as Airoha AN7583 will be based on syscon
regmap.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 72 +++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88e5..01ed49a4887e 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -194,7 +194,7 @@
 #define AIROHA_MAX_SAMPLES			6
 
 struct airoha_thermal_priv {
-	void __iomem *base;
+	struct regmap *map;
 	struct regmap *chip_scu;
 	struct resource scu_adc_res;
 
@@ -265,8 +265,8 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 			       RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
 
 		/* We offset the high temp of 1°C to trigger correct event */
-		writel(TEMP_TO_RAW(priv, high) >> 4,
-		       priv->base + EN7581_TEMPOFFSETH);
+		regmap_write(priv->map, EN7581_TEMPOFFSETH,
+			     TEMP_TO_RAW(priv, high) >> 4);
 
 		enable_monitor = true;
 	}
@@ -277,15 +277,15 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
 
 		/* We offset the low temp of 1°C to trigger correct event */
-		writel(TEMP_TO_RAW(priv, low) >> 4,
-		       priv->base + EN7581_TEMPOFFSETL);
+		regmap_write(priv->map, EN7581_TEMPOFFSETL,
+			     TEMP_TO_RAW(priv, high) >> 4);
 
 		enable_monitor = true;
 	}
 
 	/* Enable sensor 0 monitor after trip are set */
 	if (enable_monitor)
-		writel(EN7581_SENSE0_EN, priv->base + EN7581_TEMPMONCTL0);
+		regmap_write(priv->map, EN7581_TEMPMONCTL0, EN7581_SENSE0_EN);
 
 	return 0;
 }
@@ -302,7 +302,7 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 	bool update = false;
 	u32 status;
 
-	status = readl(priv->base + EN7581_TEMPMONINTSTS);
+	regmap_read(priv->map, EN7581_TEMPMONINTSTS, &status);
 	switch (status & (EN7581_HOFSINTSTS0 | EN7581_LOFSINTSTS0)) {
 	case EN7581_HOFSINTSTS0:
 		event = THERMAL_TRIP_VIOLATED;
@@ -318,7 +318,7 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 	}
 
 	/* Reset Interrupt */
-	writel(status, priv->base + EN7581_TEMPMONINTSTS);
+	regmap_write(priv->map, EN7581_TEMPMONINTSTS, status);
 
 	if (update)
 		thermal_zone_device_update(priv->tz, event);
@@ -336,11 +336,11 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 	/* sleep 10 ms for ADC to enable */
 	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
 
-	efuse_calib_info = readl(priv->base + EN7581_EFUSE_TEMP_OFFSET_REG);
+	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
 		priv->default_offset = FIELD_GET(EN7581_EFUSE_TEMP_OFFSET, efuse_calib_info);
 		/* Different slope are applied if the sensor is used for CPU or for package */
-		cpu_sensor = readl(priv->base + EN7581_EFUSE_TEMP_CPU_SENSOR_REG);
+		regmap_read(priv->map, EN7581_EFUSE_TEMP_CPU_SENSOR_REG, &cpu_sensor);
 		if (cpu_sensor) {
 			priv->default_slope = EN7581_SLOPE_X100_DIO_DEFAULT;
 			priv->init_temp = EN7581_INIT_TEMP_FTK_X10;
@@ -359,8 +359,8 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 {
 	/* Set measure mode */
-	writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
-	       priv->base + EN7581_TEMPMSRCTL0);
+	regmap_write(priv->map, EN7581_TEMPMSRCTL0,
+		     FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4));
 
 	/*
 	 * Configure ADC valid reading addr
@@ -375,15 +375,15 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	 * We set valid instead of volt as we don't enable valid/volt
 	 * split reading and AHB read valid addr in such case.
 	 */
-	writel(priv->scu_adc_res.start + EN7581_DOUT_TADC,
-	       priv->base + EN7581_TEMPADCVALIDADDR);
+	regmap_write(priv->map, EN7581_TEMPADCVALIDADDR,
+		     priv->scu_adc_res.start + EN7581_DOUT_TADC);
 
 	/*
 	 * Configure valid bit on a fake value of bit 16. The ADC outputs
 	 * max of 2 bytes for voltage.
 	 */
-	writel(FIELD_PREP(EN7581_ADV_RD_VALID_POS, 16),
-	       priv->base + EN7581_TEMPADCVALIDMASK);
+	regmap_write(priv->map, EN7581_TEMPADCVALIDMASK,
+		     FIELD_PREP(EN7581_ADV_RD_VALID_POS, 16));
 
 	/*
 	 * AHB supports max 12 bytes for ADC voltage. Shift the read
@@ -391,40 +391,52 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	 * in the order of half a °C and is acceptable in the context
 	 * of triggering interrupt in critical condition.
 	 */
-	writel(FIELD_PREP(EN7581_ADC_VOLTAGE_SHIFT, 4),
-	       priv->base + EN7581_TEMPADCVOLTAGESHIFT);
+	regmap_write(priv->map, EN7581_TEMPADCVOLTAGESHIFT,
+		     FIELD_PREP(EN7581_ADC_VOLTAGE_SHIFT, 4));
 
 	/* BUS clock is 300MHz counting unit is 3 * 68.64 * 256 = 52.715us */
-	writel(FIELD_PREP(EN7581_PERIOD_UNIT, 3),
-	       priv->base + EN7581_TEMPMONCTL1);
+	regmap_write(priv->map, EN7581_TEMPMONCTL1,
+		     FIELD_PREP(EN7581_PERIOD_UNIT, 3));
 
 	/*
 	 * filt interval is 1 * 52.715us = 52.715us,
 	 * sen interval is 379 * 52.715us = 19.97ms
 	 */
-	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
-	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
-	       priv->base + EN7581_TEMPMONCTL2);
+	regmap_write(priv->map, EN7581_TEMPMONCTL2,
+		     FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
+		     FIELD_PREP(EN7581_FILT_INTERVAL, 379));
 
 	/* AHB poll is set to 146 * 68.64 = 10.02us */
-	writel(FIELD_PREP(EN7581_ADC_POLL_INTVL, 146),
-	       priv->base + EN7581_TEMPAHBPOLL);
+	regmap_write(priv->map, EN7581_TEMPAHBPOLL,
+		     FIELD_PREP(EN7581_ADC_POLL_INTVL, 146));
 }
 
+static const struct regmap_config airoha_thermal_regmap_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+};
+
 static int airoha_thermal_probe(struct platform_device *pdev)
 {
 	struct airoha_thermal_priv *priv;
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
+	void __iomem *base;
 	int irq, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->map = devm_regmap_init_mmio(dev, base,
+					  &airoha_thermal_regmap_config);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
 
 	chip_scu_np = of_parse_phandle(dev->of_node, "airoha,chip-scu", 0);
 	if (!chip_scu_np)
@@ -462,8 +474,8 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	/* Enable LOW and HIGH interrupt */
-	writel(EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0,
-	       priv->base + EN7581_TEMPMONINT);
+	regmap_write(priv->map, EN7581_TEMPMONINT,
+		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
 
 	return 0;
 }
-- 
2.53.0


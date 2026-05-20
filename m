Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE6344D9D
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292557; cv=none; b=gL74FLBbNZSzUXIrfFRh1wiBl/mOZfIlHaLZ01lZxtJ9qUIwnqRbpxwG+PjTNRX+KD+D78qkEuiPs8Cr8xohg2DTaGWaPonuFGJgz5tX7bc3LvsKwyZ6QRxxcXeN2Khk9RCTxvXIs/bxMNrUjQK7jRiHo/JBkfHxlvO8Xjm2lhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292557; c=relaxed/simple;
	bh=6ky9g4KHbUV3l6SHftocKchWejvDlv/fyysqR2kd4OU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pq7V5MACyJioa/wwSTR230A/xS/0QyPl/12k18aWgnXyChEImf92M+GNu4wDaLDxQIWPJy8qyarawxzvFHYRileUJiqfHJLPGHW3dA6tQ7y0ubfW2IzmotcbVz4xJReskdwTHwSj7uejJkzMUQi5kpr0BwC1JD1Q7Cvjmp0I3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBRAZSDF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBRAZSDF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so56078525e9.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292552; x=1779897352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e97GBzjavtlOTUp72tsBF2P0b5wNf0hxsRbkXrGaZ4=;
        b=XBRAZSDFtv1qF2ZqP/hyiktKWPFIS0yrCWad3mMQi25Ad+0lQv4UjSwwmnPTC6dYV4
         3iXWCQL7OuOF1Gl+i6VAnfb3aQ6bKPUBO70YFq7VfRC+DawrY2GvoompP20QZpPc15ON
         Q0/qkwHtPPx798HrUl+yQ2Ju5xIAta8LLDk5UkGASxlppyPimql5n65wEBWox/42MBgo
         RJWpkEC7wVKh9BmLMk/HnvGlgoR45AXhsjxBsVjDCfmRS98a8DZEghy6Cb/VnyxLkRLg
         O91sOFkIEV4+iPpHi+Fo5g3z8e+V5qe7/Vzs2dAKRRbiguS6oXZE6BCNeZXM8EKHJaWo
         vzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292552; x=1779897352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0e97GBzjavtlOTUp72tsBF2P0b5wNf0hxsRbkXrGaZ4=;
        b=dqstkuHXc4cZdCJmjy9DuPUnOO0LOi6Zuy/DIJiBNkm0/BvbsButNpNgFZ2jSS3uqt
         /UaJXb8AFYO6ZeKimhiC4ol7UIo/XYXBSMBvyrkFjNXMeQFZVafgp/50hQgCyotboUYS
         cgYXEVmAaiXeupQSNFTH+fCq8kyu7M0B4j9L5xsnYfmJuVUWBlSKbmCQmRdtr9Kq2yGl
         JUkeajV9YfdnRUCtqFogcwexJDYToUqNpsD3aMyGseO6CFFewsaQ3tUPD+q9oNldNC4C
         kf1lnZfH1Q4lMSES/JC/GL3CzHzYyVPzJDVRP2R3pDf9yLOU01+xN+iW7N8bSGyJyBco
         9IjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JuPTLhrZqfT/VqwmeFHGOi/TJ0X5UZDVqTgAPXxoWwQMZil2v5/IBLYuhX2bCKsA9RPMxPc28vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwbHiNCuCJyLn3qwqztmkI1RWb2mfsGEs+CcRUrFIT59UNA79
	VXQVt8cg3kCzqKnkXcLCtGwntKuDk/C0+DaSvoCn8FYZS0JH6GccWLZ7
X-Gm-Gg: Acq92OF1eCRVqEV0jidCfG3mld2ggfvUCtCxH5+NWp9BGw37TIdSHJ2QuZDScBnjP5S
	pcgqUTvH2Xj8fxHi0bWvAhD7iKGXCqI0wL+Fp9rN01CSdZstC9isTHJ44ihVkDOHUX1acFc/TcH
	cEOd55S1ErYEM+s5Ec5B+ms9auy9Z93LLCwuSoKyRRFi7O+wsge70WipC+EoacQI8RZxHibI1VE
	dXXMn/1XEVk8idFAQlQ1OqeQUtO3AQ9DV55i0EoXAN20c2S+S7QD537fuHJGhP3hTUNpfyvZoJc
	Dq6UAkzMsr/KWfQcJ0ZRmFrYis1JUOiWPH74mx7TijNSdhBMS50UR6jMkH4kRJ27ltrFfCPYGUg
	K+XT4vvwqTHwnTsc9tJBhB3Uq5WfAPSkl0UxdNeT7G84rgZRd6T/p2/lCQ7f+Nn3uHTbsOMBpat
	nDZCMInW85X0vRogSj7+s5Nljgndf0fal5B4YV521/q0rNw+FICcN7AHolsZlX/qE2r7lVvm8Aa
	Q==
X-Received: by 2002:a05:600c:491e:b0:48e:978f:c45a with SMTP id 5b1f17b1804b1-48fed455991mr235608125e9.19.1779292551997;
        Wed, 20 May 2026 08:55:51 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-22-5-99.retail.telecomitalia.it. [79.22.5.99])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fed253f93sm132123215e9.16.2026.05.20.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:55:51 -0700 (PDT)
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
Subject: [PATCH v5 3/7] thermal/drivers: airoha: Convert to regmap API
Date: Wed, 20 May 2026 17:55:16 +0200
Message-ID: <20260520155525.22239-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520155525.22239-1-ansuelsmth@gmail.com>
References: <20260520155525.22239-1-ansuelsmth@gmail.com>
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
 drivers/thermal/airoha_thermal.c | 77 +++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 829a7327fc40..b63893a8997a 100644
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
+			     TEMP_TO_RAW(priv, low) >> 4);
 
 		enable_monitor = true;
 	}
 
 	/* Enable sensor 0 monitor after trip are set */
 	if (enable_monitor)
-		writel(EN7581_SENSE0_EN, priv->base + EN7581_TEMPMONCTL0);
+		regmap_write(priv->map, EN7581_TEMPMONCTL0, EN7581_SENSE0_EN);
 
 	return 0;
 }
@@ -300,9 +300,9 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 	struct airoha_thermal_priv *priv = data;
 	enum thermal_notify_event event;
 	bool update = false;
-	u32 status;
+	u32 status = 0;
 
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
@@ -329,18 +329,19 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 static void airoha_thermal_setup_adc_val(struct device *dev,
 					 struct airoha_thermal_priv *priv)
 {
-	u32 efuse_calib_info, cpu_sensor;
+	u32 efuse_calib_info = 0;
+	u32 cpu_sensor = 0;
 
 	/* Setup thermal sensor to ADC mode and setup the mux to DIODE1 */
 	airoha_init_thermal_ADC_mode(priv);
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
@@ -359,8 +360,8 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 {
 	/* Set measure mode */
-	writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
-	       priv->base + EN7581_TEMPMSRCTL0);
+	regmap_write(priv->map, EN7581_TEMPMSRCTL0,
+		     FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4));
 
 	/*
 	 * Configure ADC valid reading addr
@@ -375,15 +376,15 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
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
@@ -391,40 +392,52 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
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
-	       FIELD_PREP(EN7581_SEN_INTERVAL, 379),
-	       priv->base + EN7581_TEMPMONCTL2);
+	regmap_write(priv->map, EN7581_TEMPMONCTL2,
+		     FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
+		     FIELD_PREP(EN7581_SEN_INTERVAL, 379));
 
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
@@ -462,8 +475,8 @@ static int airoha_thermal_probe(struct platform_device *pdev)
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


Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1FC3EF0D4
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229497; cv=none; b=Mf0HZYGiNm57nL+i2tUVkkEzGG2smNiRULiVpw2kOzLAMccFkgI/nlxjIHRsWHx95MWC5ZE548pY2gFDadQmv5k/cdsx3Rb3RJ9r2CmPifgPjsUInl+xGUJ/3fW/ZFn04/gqVo/hvYbmzeL4oxb47qZoWFOx8MqNeACxHXA608U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229497; c=relaxed/simple;
	bh=2QrxJ04gUsivjRWmGX+lX65XI8PHqJkzMXBht0ubDxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIjpptz7znxGy0NzSAU3FmWkVqgqDLDp/IuYciwyDhNoMdSFPSi+g3BI+NZdEa0mvLvVaLNrWnKCqmXvzV3HMOo1zKm+Hf9eqxJhK/AmstZONM47VMddYm9FHdVLJKaBDAnL2MazVgwoCpKe9wkB3sNHnhz5TYn2Cwkkl6vGGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFlp2fpc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFlp2fpc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48e82c23840so33792815e9.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229494; x=1779834294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Y1t2qqzyl1q+h7yDIYdn/bWsIjxK4gxr9iT28eZ+QM=;
        b=fFlp2fpcG2urjonZmanRBahBUdlVCfbVxwQo7sMI0nrcr5oJRJzG3uQINsrbryloNM
         EYyAUH80vFDrMLt/fK692ZXagjh6nElrA0qcbkdFRhxEs+0Zgzm1XRoyLNM2dQnzXhD3
         OmYJ3W151JAbBY5bL4TpUf7BkcGB97yipjcGKQeKgRkRrA76/UXLy7dlbHFtJYobCNED
         L1NPiHsSJ8wGYoanh610sf9fL3GG4CSSNP9ExwPcoohS1b+O8gdqLD3ljcyhr/r0VaYn
         vkGQrh/AGLI307wco/9Scj1PFMbRoSZxZNCttPkwkcDyaZMi97s+rSo0Pn9Z5S6uwEBC
         1kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229494; x=1779834294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Y1t2qqzyl1q+h7yDIYdn/bWsIjxK4gxr9iT28eZ+QM=;
        b=q0bdtUF9Y8U6EEdd0hu0own6q4GyDCV5e62ImT/iZLmeheueFjNE8vCLQktCbL505R
         +m8jwzzf099GIx2xXN2ozpfW4yQFUvrnLDP0PKgjVl5XMkA4GuG/E+XUf8CBXaTKngyT
         t24hbfUsQWW3omd0zVFApvkeIgUeOuQ+myNiObuaF6upKvCpv3smbM5Xyt8IDHlGQ/OB
         i5wc0oYe4zleEgnZErEZsGdK6K8TucKXQpTLOeSpejRymgn65hYW9TGL/Glb+ew/ufON
         USHXMrjA/FMsf18hkIsLBmnNg4ps7o8O0JKllH0xPxm1sXh4lhkwupWRjydS7PMfMCSM
         UcZA==
X-Forwarded-Encrypted: i=1; AFNElJ8YOU77bkWmYZ5njXsp2+mfN5fl1yx13RMiWwnjjVPGHIZIif59HjhTiYcnZO58dm9oQBKc+l93yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKDjL0XTF6hT75Yzbp3Tvdwh19NHDO9LeLMlTLoQILIC/jirVm
	rDJ3pgJR2Jh+ItMs009LCImPUP+xrXDLrWcti/u1vymwQA+TFvF+A3Wc
X-Gm-Gg: Acq92OGV+wUQKEapo1G3ISB1+x2vsx94/I7xEqywhnl6QnFw/rtPMsSm8WrLL7qcude
	SxWu1I+O5XcoG16O1I0Fkm45UknotbSsyi6gD96WwFffRcaNTZbblIJ1EcwtZGVzP+zul7ju24M
	2aFilD/iK5blqCOvSAUJS8WxFu7XJDaABdmO5XbXnWVRbTkDSkXuOmUvjB4usDkVDDqdz8U4/D9
	uKKBbFt49iNJkz/fjAfU/yd4a8Pn3mF3ZWrl0sqQUsSCIVvPu9zJzBdRQ/P4fvh9EcWtI9o/IbA
	hIX5eIntPrNvrFJxa1Z0qWjgUeQtMC91u8otIzCqUzbKEsMof7Q+lQhGgo5uz2YpP6SItMZOw5g
	nTa1P16jhnFv9LcxiKvcXnCqgvTXuT1EhZXwOZRtNyCgPC/LLx4s0AYdN/YYTEbSpBbdNW020En
	y1l/83X563qCxXBM6rIkbdNlHvPeyB5UYqb4BR+56FOVPlicfNKtWHIgEW93CpDJpFHozkqy0=
X-Received: by 2002:a05:600c:8189:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48fe632374fmr318299645e9.20.1779229493377;
        Tue, 19 May 2026 15:24:53 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm381097435e9.3.2026.05.19.15.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:24:53 -0700 (PDT)
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
Subject: [PATCH v4 5/5] thermal/drivers: airoha: Add support for AN7583 Thermal Sensor
Date: Wed, 20 May 2026 00:24:26 +0200
Message-ID: <20260519222433.29684-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519222433.29684-1-ansuelsmth@gmail.com>
References: <20260519222433.29684-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN7583 Thermal driver. This apply similar logic
on how to read the temperature but totally drop support for the
PTP_THERMAL subsystem. PTP_THERMAL subsystem was a way to trigger trip
point from hardware by configuring how to read the temperature
internally.

This subsystem has been totally removed from Airoha AN7583 permitting
only to read the temperature.

The SoC support up to 3 sensor but the original driver always read the
BGA sensor hence it's currently implemented reading only this specific
sensor. Reference and values for the other 2 sensor are defined for
further implementation if confirmed working.

set_thermal_mux() is extended to also address muxing the sensor as
AN7583 use a different way to read the temperature from 3 different
diode. The EN7581 code is updated to account for these changes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 158 ++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index a062922cb116..c190b696d3a8 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -18,6 +18,12 @@
 #define EN7581_DOUT_TADC			0x2f8
 #define   EN7581_DOUT_TADC_MASK			GENMASK(15, 0)
 
+#define AN7583_MUX_SENSOR			0x2a0
+#define   AN7583_LOAD_ADJ			GENMASK(3, 2)
+#define AN7583_MUX_TADC				0x2e4
+#define   AN7583_MUX_TADC_MASK			GENMASK(3, 1)
+#define AN7583_DOUT_TADC			0x2f0
+
 /* PTP_THERMAL regs */
 #define EN7581_TEMPMONCTL0			0x800
 #define   EN7581_SENSE3_EN			BIT(3)
@@ -181,6 +187,11 @@
 #define EN7581_SCU_THERMAL_PROTECT_KEY		0x12
 #define EN7581_SCU_THERMAL_MUX_DIODE1		0x7
 
+#define AN7583_SCU_THERMAL_PROTECT_KEY		0x80
+#define AN7583_NUM_SENSOR			3
+
+#define AIROHA_THERMAL_NO_MUX_SENSOR		-1
+
 /* Convert temp to raw value as read from ADC	((((temp / 100) - init) * slope) / 1000) + offset */
 #define TEMP_TO_RAW(priv, temp)			((((((temp) / 100) - (priv)->init_temp) * \
 						  (priv)->default_slope) / 1000) + \
@@ -193,8 +204,39 @@
 
 #define AIROHA_MAX_SAMPLES			6
 
+/*
+ * AN7583 supports all these ADC mux but the original driver
+ * always checked temp with the AN7583_BGP_TEMP_SENSOR.
+ * Assume using the other sensor temperature is invalid and
+ * always read from AN7583_BGP_TEMP_SENSOR.
+ *
+ * On top of this it's defined that AN7583 supports 3
+ * sensor: AN7583_BGP_TEMP_SENSOR, AN7583_GBE_TEMP_SENSOR,
+ * AN7583_CPU_TEMP_SENSOR.
+ *
+ * Provide the ADC mux for reference.
+ */
+enum an7583_thermal_adc_mux {
+	AN7583_BGP_TEMP_SENSOR,
+	AN7583_PAD_AVS,
+	AN7583_CORE_POWER,
+	AN7583_AVSDAC_OUT,
+	AN7583_VCM,
+	AN7583_GBE_TEMP_SENSOR,
+	AN7583_CPU_TEMP_SENSOR,
+
+	AN7583_ADC_MUX_MAX,
+};
+
+enum an7583_thermal_diode_mux {
+	AN7583_D0_TADC,
+	AN7583_ZERO_TADC,
+	AN7583_D1_TADC,
+};
+
 enum airoha_thermal_chip_scu_field {
 	AIROHA_THERMAL_DOUT_TADC,
+	AIROHA_THERMAL_MUX_SENSOR,
 	AIROHA_THERMAL_MUX_TADC,
 
 	/* keep last */
@@ -208,6 +250,7 @@ struct airoha_thermal_priv {
 	struct resource scu_adc_res;
 
 	u32 pllrg_protect;
+	int current_adc;
 
 	struct thermal_zone_device *tz;
 	int init_temp;
@@ -224,6 +267,24 @@ struct airoha_thermal_soc_data {
 	int (*post_probe)(struct platform_device *pdev);
 };
 
+static const unsigned int an7583_thermal_coeff[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 973,
+	[AN7583_GBE_TEMP_SENSOR] = 995,
+	[AN7583_CPU_TEMP_SENSOR] = 1035,
+};
+
+static const unsigned int an7583_thermal_slope[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 7440,
+	[AN7583_GBE_TEMP_SENSOR] = 7620,
+	[AN7583_CPU_TEMP_SENSOR] = 8390,
+};
+
+static const unsigned int an7583_thermal_offset[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 294,
+	[AN7583_GBE_TEMP_SENSOR] = 298,
+	[AN7583_CPU_TEMP_SENSOR] = 344,
+};
+
 static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
@@ -234,7 +295,7 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 }
 
 static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
-				   int tdac_idx)
+				   int tdac_idx, int sensor_idx)
 {
 	u32 pllrg;
 
@@ -245,9 +306,20 @@ static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
 		     priv->pllrg_protect);
 
+	/*
+	 * Configure Thermal Sensor mux to sensor_idx.
+	 * (if not supported, sensor_idx is AIROHA_THERMAL_NO_MUX_SENSOR)
+	 */
+	if (sensor_idx != AIROHA_THERMAL_NO_MUX_SENSOR)
+		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],
+				   sensor_idx);
+
 	/* Configure Thermal ADC mux to tdac_idx */
-	regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
-			   tdac_idx);
+	if (priv->current_adc != tdac_idx) {
+		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
+				   tdac_idx);
+		priv->current_adc = tdac_idx;
+	}
 
 	/* Sleep 10 ms for Thermal ADC to enable */
 	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
@@ -360,7 +432,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 	u32 efuse_calib_info, cpu_sensor;
 
 	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
-	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
+	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1,
+			       AIROHA_THERMAL_NO_MUX_SENSOR);
 
 	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
@@ -476,6 +549,10 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
 		struct regmap_field *field;
 
+		/* Skip registering MUX_SENSOR field as not supported */
+		if (i == AIROHA_THERMAL_MUX_SENSOR)
+			continue;
+
 		field = devm_regmap_field_alloc(dev, priv->chip_scu,
 						en7581_chip_scu_fields[i]);
 		if (IS_ERR(field))
@@ -516,6 +593,71 @@ static int en7581_thermal_post_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int an7583_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
+	int sensor_idx;
+	int delta_diode, delta_gain;
+	int coeff, slope, offset;
+
+	int diode_zero, diode_d0, diode_d1;
+
+	/* Always read sensor AN7583_BGP_TEMP_SENSOR */
+	sensor_idx = AN7583_BGP_TEMP_SENSOR;
+
+	coeff = an7583_thermal_coeff[sensor_idx];
+	slope = an7583_thermal_slope[sensor_idx];
+	offset = an7583_thermal_offset[sensor_idx];
+
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_ZERO_TADC);
+	diode_zero = airoha_get_thermal_ADC(priv);
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_D0_TADC);
+	diode_d0 = airoha_get_thermal_ADC(priv);
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_D1_TADC);
+	diode_d1 = airoha_get_thermal_ADC(priv);
+
+	delta_diode = diode_d1 - diode_d0;
+	delta_gain = (delta_diode * coeff) / 100 + (diode_zero - diode_d1);
+	*temp = (slope * delta_diode * 10) / delta_gain - offset * 10;
+	*temp *= 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops an7583_tz_ops = {
+	.get_temp = an7583_thermal_get_temp,
+};
+
+static const struct reg_field an7583_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
+	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(AN7583_DOUT_TADC, 0, 31),
+	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(AN7583_MUX_TADC, 1, 3),
+	[AIROHA_THERMAL_MUX_SENSOR] = REG_FIELD(AN7583_MUX_SENSOR, 2, 3),
+};
+
+static int an7583_thermal_probe(struct platform_device *pdev,
+				struct airoha_thermal_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	int i;
+
+	priv->chip_scu = device_node_to_regmap(dev->of_node);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
+		struct regmap_field *field;
+
+		field = devm_regmap_field_alloc(dev, priv->chip_scu,
+						an7583_chip_scu_fields[i]);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		priv->chip_scu_fields[i] = field;
+	}
+
+	return 0;
+}
+
 static int airoha_thermal_probe(struct platform_device *pdev)
 {
 	const struct airoha_thermal_soc_data *soc_data;
@@ -530,6 +672,7 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->pllrg_protect = soc_data->pllrg_protect;
+	priv->current_adc = -1;
 
 	if (!soc_data->probe)
 		return -EINVAL;
@@ -558,8 +701,15 @@ static const struct airoha_thermal_soc_data en7581_data = {
 	.post_probe = &en7581_thermal_post_probe,
 };
 
+static const struct airoha_thermal_soc_data an7583_data = {
+	.pllrg_protect = AN7583_SCU_THERMAL_PROTECT_KEY,
+	.thdev_ops = &an7583_tz_ops,
+	.probe = &an7583_thermal_probe,
+};
+
 static const struct of_device_id airoha_thermal_match[] = {
 	{ .compatible = "airoha,en7581-thermal", .data = &en7581_data },
+	{ .compatible = "airoha,an7583-chip-scu", .data = &an7583_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, airoha_thermal_match);
-- 
2.53.0


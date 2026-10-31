Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456390;
	b=dOTMGpGQL9alPaPEGEuC5KKZljf6ZERPg4HmeochAuggvquPyhVL1xww8wIz1/zh2IZw
	 JOnscXF5WNqJaKfx0OVV/Le9QGnaNeD+X5szOy34FnyMpJjch4quqiegM882f7hQBbEh7
	 OLOp1qqsntdsZLJKXg3xLitWJLy81LaDTawHI1e1A8k6BrPS90atSX44CFCDu+xtHOQOd
	 H4F2fz4o0UeYlMlHl3CG/GuYN/lmz/eREWQV7bmyjDBamsl0qXaswJIFJAQP7j2yeGxT2
	 ju4TL0Fkzy1CaT9+/k7FPIJrNDgr95L8Cr3lmfPXZiCaZSkafVeARqXRdkXppLzgxkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rej3bXCAP+KjyaBqazcdRvbtdKQGp5ZBUcG9XyBku1c=;
	b=h8P4AiaKLJtZZHdsO3k046NQP59sghk+fyfkLxQF1P8vWOm1t0EjsUO+Nlne3Pob8sN+
	 i/n2jsjEL9TRh3SkzLQo/cBOdRD/UpLbf5+AaFNQD88C0LPIRAD4nzkZxZyrPfkvpENCp
	 LFYM3IOezDhXfLAls7O0xy4fTtI5rI9/mivB/3cHbnGb5sTYE7R/FkOHv3D7SozESNPpi
	 f+vtctHAN4k6IuQXhgK77Ae7J7ClKi4mnX+2BZHZIMYAEorXMDgRT5fwiKkvD1JLr66gV
	 fHH3rB2yyQJze31AEsKTghONFi3V3WSDrPRsDX5fqDA699P28YDoWJoOhQTXzAQ265g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7nBpwle;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F3606A327
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 14:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 741F3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7nBpwle
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afbd2c386so885413f8f.3
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793456389; x=1794061189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rej3bXCAP+KjyaBqazcdRvbtdKQGp5ZBUcG9XyBku1c=;
        b=H7nBpwle+mHqAf9JIVZdI28ifLoQvfTut+HiHb71pyp5ICyc4q/7zDeezZd/9BEu7H
         FsBuKOgJN6epqqGcEeg8fhi7bYPX4MeqvjWSSjHe1pz1jlQtB+4FBgcnUsmUPxvfkpIq
         3Kk2ytgTB2djUYCRFWJGjhTUUMpWTVeQgDrXfncfbGrQfYLubsCkkvLFUqJKmQjhmQOH
         rMBhNcDVKcziNvniOd+Y5oWuH1jezLTVAX8urCv9muwbK40U+DLmDJdctXoAD6jpOtxZ
         Jmh11SUee5Yvfhx0vdk/yu4i55a48HCwEZjmTMu6wulDCMIAsqa8MbgsiqGgaLpy789m
         0ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793456389; x=1794061189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rej3bXCAP+KjyaBqazcdRvbtdKQGp5ZBUcG9XyBku1c=;
        b=Qu+6DHoOsbsppEttvRG+MKKlBSNLyNbX4Jduowoj4d2nOS1a2hsNvM/EjRDS89d4r5
         RyP85uj0H5+18PuOBgSptRD0bXeBWvZ/W+gJmROzgcbdN1kMUFqXRv+RMXjI1Sdg91OF
         DYtk4QboETM9A8pCNCWVlwkeHbaCu7EV2f0azpwOKL1QYHHEqQkZNsihGFhyp3i6mJme
         3kdVDv1nRa9xX7njaRMlS/u1hcnX+v6hENVv3ICT5n1XXPncevkyrh3LlzxS9SzhyGOE
         ywtH+Z/MWeojK79m9jpYyJy69H7No5aqojN7oqN4MekFaZwqL5cg5JXgI4Sw+JJczEuj
         SsFA==
X-Forwarded-Encrypted: i=1; AKwUvBwdOR2vpYIV2YPJBiVY2vvjwz7bZZAlhLxMcT4t9VFjW9KekL5AxKB/NsF64zyKn1JxXXDStoJEHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJzqCcVMbrYtUdc7/3OHNIzox39g84NsfxKbw3tMsgkg/LYgI0I
	0nz2AvKSpNb9KB3IC2GmD2oEEbkn02p1DDlk78EjRqzwZ5BmmASMVIo=
X-Gm-Gg: AYBFou3I1Fgokfml7yaGBpEBb8lQS8qnc1Xf4MTGHRDHl1dzYoLcVP85dFscjwDFF51
	b3e3h+NSSgpPIyjswrSPo1UDYrLmX8PCrgj5bwFnb4vh6jcZddoQzPbjr4t1DJthFeDzb6lIbyy
	AvIdPvEloFY1CP5mQPpwtl+D9RPez1sQLQwcCx4+uVMXfRMkSjOkKbs/SuUvYIFW/ZxkiKACcMU
	4Jh4ErQaFZYeruxfViG3FG7k6+fup7xsKO7nknO2wse9dbwlqd3VDIWk/4LnOJ5Ja7fcPLxmp8P
	1nF3XXAwJoRLR9PPV9sIhEsMzLAXvPpAApvSs+Bm6ltJx32Vnrobd9HBppaIniYn8/53hTIYssh
	Qqwd79wFfTphj+aXduwgvzeyIJx82+lRGq8ura3qj6EjPtLwev+oxN8OKbl5iWdGR4Mg9LGwkpI
	KxO6cLiIGzy5LLEB2H0dueUy71LKo9yumoiZAOJp9w7chC8ehIq4bBvVChxHF56yZe0vHAV5WxC
	ZUoo853/doEr39PiTbi2uhvk2VDMZ30FSGbM0ilgGKYwwS0Pu+N5eNhyoypmT1Pvu/PD7n+YJ4I
	BqnF4kAuQjCDa6krk1k=
X-Received: by 2002:a05:600c:3b2a:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4ac1709a2c3mr114534825e9.15.1793456388879;
        Sat, 31 Oct 2026 07:19:48 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm209871275e9.4.2026.10.31.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:19:48 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: daniel.lezcano@kernel.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 2/2] thermal/drivers/airoha: Read the EN7581 CPU ADC
Date: Sat, 31 Oct 2026 16:19:12 +0200
Message-ID: <20261031141912.1664575-3-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031141912.1664575-1-sochnev.v.74@gmail.com>
References: <20261031141912.1664575-1-sochnev.v.74@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the second EN7581 ADC as a read-only thermal zone. The
hardware monitor and interrupt continue to use the main ADC. Use the
CPU calibration offset from efuse, falling back to the main ADC when
it is absent.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 157 +++++++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 7c63a1b44a6b9..982b0736df9a3 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -18,6 +18,8 @@
 #define   EN7581_MUX_TADC			GENMASK(3, 1)
 #define EN7581_DOUT_TADC			0x2f8
 #define   EN7581_DOUT_TADC_MASK			GENMASK(15, 0)
+#define EN7581_PWD_TADC_CPU			0x2fc
+#define EN7581_DOUT_TADC_CPU			0x308
 
 #define AN7583_MUX_TADC				0x2a0
 #define   AN7583_LOAD_ADJ			GENMASK(3, 2)
@@ -236,6 +238,13 @@ enum an7583_thermal_diode_mux {
 	AN7583_D1_TADC,
 };
 
+enum en7581_thermal_sensor {
+	EN7581_TADC,
+	EN7581_TADC_CPU,
+
+	EN7581_NUM_SENSOR,
+};
+
 enum airoha_thermal_chip_scu_field {
 	AIROHA_THERMAL_DOUT_TADC,
 	AIROHA_THERMAL_MUX_SENSOR,
@@ -264,6 +273,8 @@ struct airoha_thermal_priv {
 	int init_temp;
 	int default_slope;
 	int default_offset;
+	int cpu_offset;
+	bool cpu_adc_failed;
 };
 
 struct airoha_thermal_soc_data {
@@ -354,19 +365,53 @@ static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
 	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
 }
 
+static int en7581_thermal_read_adc(struct airoha_thermal_priv *priv, int sensor,
+				   int *value)
+{
+	u32 val;
+	int ret;
+
+	if (sensor != EN7581_TADC_CPU) {
+		*value = airoha_get_thermal_ADC(priv);
+		return 0;
+	}
+
+	ret = regmap_read(priv->chip_scu, EN7581_DOUT_TADC_CPU, &val);
+	if (ret)
+		return ret;
+
+	*value = FIELD_GET(EN7581_DOUT_TADC_MASK, val);
+	return 0;
+}
+
 static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct airoha_thermal_zone *zone = thermal_zone_device_priv(tz);
 	struct airoha_thermal_priv *priv = zone->priv;
 	int min_value, max_value, avg_value, value;
-	int i;
+	int offset = priv->default_offset;
+	int i, ret;
+	u32 sel;
+
+	if (zone->sensor == EN7581_TADC_CPU) {
+		/* Other mux positions convert to temperatures above the trips */
+		ret = regmap_read(priv->chip_scu, EN7581_PWD_TADC_CPU, &sel);
+		if (ret)
+			return ret;
+		if (FIELD_GET(EN7581_MUX_TADC, sel) != EN7581_SCU_THERMAL_MUX_DIODE1)
+			return -EAGAIN;
+
+		offset = priv->cpu_offset;
+	}
 
 	avg_value = 0;
 	min_value = INT_MAX;
 	max_value = INT_MIN;
 
 	for (i = 0; i < AIROHA_MAX_SAMPLES; i++) {
-		value = airoha_get_thermal_ADC(priv);
+		ret = en7581_thermal_read_adc(priv, zone->sensor, &value);
+		if (ret)
+			return ret;
 		min_value = min(value, min_value);
 		max_value = max(value, max_value);
 		avg_value += value;
@@ -376,7 +421,8 @@ static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	avg_value -= (min_value + max_value);
 	avg_value /= AIROHA_MAX_SAMPLES - 2;
 
-	*temp = RAW_TO_TEMP(priv, avg_value);
+	*temp = (((avg_value - offset) * 1000) / priv->default_slope +
+		 priv->init_temp) * 100;
 	return 0;
 }
 
@@ -387,6 +433,10 @@ static int en7581_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	struct airoha_thermal_priv *priv = zone->priv;
 	bool enable_monitor = false;
 
+	/* The temperature monitor samples only the main ADC */
+	if (zone->sensor == EN7581_TADC_CPU)
+		return 0;
+
 	if (high != INT_MAX) {
 		/* Validate high and clamp it a supported value */
 		high = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
@@ -484,6 +534,70 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 	}
 }
 
+static int en7581_thermal_setup_cpu_adc(struct device *dev,
+					struct airoha_thermal_priv *priv)
+{
+	int tries = AIROHA_THERMAL_MUX_TRIES;
+	u32 pllrg, sel, efuse, main;
+	int cpu;
+	int ret, restore_ret;
+
+	ret = regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
+			   priv->pllrg_protect);
+	if (ret)
+		goto restore_protect;
+
+	/* Unprotected writes are dropped silently, so read the value back */
+	do {
+		ret = regmap_update_bits(priv->chip_scu, EN7581_PWD_TADC_CPU,
+					 EN7581_MUX_TADC,
+					 FIELD_PREP(EN7581_MUX_TADC,
+						    EN7581_SCU_THERMAL_MUX_DIODE1));
+		if (ret)
+			break;
+		ret = regmap_read(priv->chip_scu, EN7581_PWD_TADC_CPU, &sel);
+		if (ret)
+			break;
+	} while (FIELD_GET(EN7581_MUX_TADC, sel) != EN7581_SCU_THERMAL_MUX_DIODE1 &&
+		 --tries);
+
+	if (!ret && FIELD_GET(EN7581_MUX_TADC, sel) != EN7581_SCU_THERMAL_MUX_DIODE1)
+		ret = -EIO;
+
+restore_protect:
+	restore_ret = regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
+	if (ret)
+		return ret;
+	if (restore_ret)
+		return restore_ret;
+
+	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
+
+	ret = regmap_read(priv->map, EN7581_PTPSPARE1, &efuse);
+	if (ret)
+		return ret;
+	if (FIELD_GET(EN7581_EFUSE_TEMP_OFFSET, efuse)) {
+		priv->cpu_offset = FIELD_GET(EN7581_EFUSE_TEMP_OFFSET, efuse);
+		return 0;
+	}
+
+	/* Without calibration assume both ADCs are at the same temperature */
+	ret = en7581_thermal_read_adc(priv, EN7581_TADC_CPU, &cpu);
+	if (ret)
+		return ret;
+	ret = regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_DOUT_TADC],
+				&main);
+	if (ret)
+		return ret;
+	priv->cpu_offset = cpu - (int)main + priv->default_offset;
+	dev_info(dev, "missing CPU thermal calibration EFUSE, using main sensor offset\n");
+	return 0;
+}
+
 static void en7581_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 {
 	/* Set measure mode */
@@ -495,8 +609,7 @@ static void en7581_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	 * The AHB temp monitor system doesn't have direct access to the
 	 * thermal sensor. It does instead work by providing various
 	 * addresses to configure how to access and setup an ADC for the
-	 * sensor. EN7581 supports only one sensor hence the
-	 * implementation is greatly simplified but the AHB supports
+	 * sensor. EN7581 monitors only the main ADC here; the AHB supports
 	 * up to 4 different sensors from the same ADC that can be
 	 * switched by tuning the ADC mux or writing address.
 	 *
@@ -556,7 +669,8 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
-	int i;
+	u32 sensor_cells = 0;
+	int i, ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -572,8 +686,11 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 		return -EINVAL;
 
 	priv->chip_scu = syscon_node_to_regmap(chip_scu_np);
-	if (IS_ERR(priv->chip_scu))
-		return PTR_ERR(priv->chip_scu);
+	if (IS_ERR(priv->chip_scu)) {
+		ret = PTR_ERR(priv->chip_scu);
+		of_node_put(chip_scu_np);
+		return ret;
+	}
 
 	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
 		struct regmap_field *field;
@@ -592,11 +709,21 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 		priv->chip_scu_fields[i] = field;
 	}
 
-	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
+	ret = of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);
+	if (ret)
+		return ret;
 
 	en7581_thermal_setup_monitor(priv);
 	en7581_thermal_setup_adc_val(dev, priv);
+	of_property_read_u32(dev->of_node, "#thermal-sensor-cells", &sensor_cells);
+	if (sensor_cells) {
+		ret = en7581_thermal_setup_cpu_adc(dev, priv);
+		if (ret) {
+			dev_warn(dev, "CPU thermal ADC unavailable: %d\n", ret);
+			priv->cpu_adc_failed = true;
+		}
+	}
 
 	return 0;
 }
@@ -751,6 +878,9 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		struct airoha_thermal_zone *zone;
 		struct thermal_zone_device *tz;
 
+		if (priv->cpu_adc_failed && soc_data->sensors[i] == EN7581_TADC_CPU)
+			continue;
+
 		zone = devm_kzalloc(dev, sizeof(*zone), GFP_KERNEL);
 		if (!zone)
 			return -ENOMEM;
@@ -786,8 +916,15 @@ static const int an7583_zone_sensors[AN7583_NUM_SENSOR] = {
 	AN7583_CPU_TEMP_SENSOR,
 };
 
+/* The main ADC stays zone 0 */
+static const int en7581_zone_sensors[EN7581_NUM_SENSOR] = {
+	EN7581_TADC,
+	EN7581_TADC_CPU,
+};
+
 static const struct airoha_thermal_soc_data en7581_data = {
-	.num_sensors = 1,
+	.sensors = en7581_zone_sensors,
+	.num_sensors = EN7581_NUM_SENSOR,
 	.pllrg_protect = EN7581_SCU_THERMAL_PROTECT_KEY,
 	.thdev_ops = &en7581_thdev_ops,
 	.probe = &en7581_thermal_probe,
-- 
2.55.0


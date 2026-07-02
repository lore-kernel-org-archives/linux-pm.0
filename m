Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB4496916
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985744; cv=none; b=qUtaqHKgw349K0jVhwKBkVVKlFwBlFkCpM3jLh7aKhxtzrVOiMhr4oklg/RDA+8N9CRoPzJ8XM3CXtVfFSLuT6t7Pkp4TzHSSWUUI3L07j9/GjHUw+FZI6zk13/kI0KRula/OYXuBsthgwxEuE8O4HiCSigufCOiz1cqVOELyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985744; c=relaxed/simple;
	bh=gCW1JK9UfuVJlNjcjVAgFsmrKOhj8oYjfr8zCWm7Bfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqufM3Ewmoqkt+jSTgg0kg0mJVt0ZpdiRjKCxHQDwnMNC+JRysuIeipwhutleAVajMyW33wXi2H2V3+vDy+dnJz6UfdJcwAVXtqvnVKwmkxUJZrmroNTE4XQtQYwS6h3ujS9jNasr7EX/u5D4v8IRU4Lw5vV3SP2rvzn07qvVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiTro3IZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiTro3IZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso1533982f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985741; x=1783590541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXeSKigfSE7Ujy9dejCk8EK2GGuGXGtDonABN0rEpDQ=;
        b=jiTro3IZ//UI+g7vVXPiTjrzgP7wUrwbHBiBZiKsA8cSrA94OXXG7lr8F3NC6Wh5Xz
         fLXT6tGJH2DgODsglEv1/fZhJsAoJmz760USwjGKySvN2HsuA/uAV2/2AjM2P+h8mDJp
         /2rmO1fJJwaXFqNmLr8puF6oStQXxvKZE1rmfSyQFsAFUb2tkGeEOhc6riBgwaTVA5Cn
         3y+rw59cXY3iwzVRNA9sj8DYH1MJ7/9rmCrfnPQ4uFrlT9BkCndnhgATkYbca9+E4fTe
         Rg72Hf9/1vQIxt7nJXL3IVZMH6gFIS/i3Qskz6KBQhcfovC8oeZvSR3YTUPQoQOazLpr
         JJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985741; x=1783590541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXeSKigfSE7Ujy9dejCk8EK2GGuGXGtDonABN0rEpDQ=;
        b=B+Mcz0+FjvjTFrkkemiMjPjuYGcvuQpq7axR/I2cYwotduVrd9p/lvb/jY9K6ZtEHW
         F4j1IvDPMYFSgk25RdD9ObbzJ7fzlhqW20hB7vLYCK8v+qY0uUXuTu/L6tXA+9ZFVa2g
         Qk2BjyTFxsg29RS2mdyGEzn1oUVfJJ+HvWOOer8XG7rVoU28lSGlk3NmroP8bPlM/32K
         kbS/sPY3A2JCdinNINOeP3jKM0QKxGCxAZsGdhGiWuxDgRGARRY/noI4x870ZOvGCWO7
         axl+Zr+CKS6ZQ/M7ECo2+VtfO/6hX/gWc/I4bknNuf28Nr10neaKEF99dIDxP+zZ6lur
         JtpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVi9XBZw6VgmeSSzEznZxf1bfSBeOEWVODFtktWLDL6n6ZQBmB3TrfB//+ucAqwjtnVHBn1L8doQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2YflNWz/T30oK8Xe285uRRFeu7yo0MluIRcl+aguDhH4oTs4x
	Ca5rqdinhHPQUbwujmd9S/Ulz2c0fn4FH5Rk+EXCGE/JiqfU0Q4Nxdtf
X-Gm-Gg: AfdE7cm4WdPmCFc5DZ/tu1rVeyBY/VzwhiA4Q/aYfTqzqXKk8rRpd0Ujo20cIKfqH2x
	mycDsNpjCpDVDsTa9qyxYwo/saVsRoANM6fPqJlvYS9LqgXvizT0IlnWRPUv/eJJPxKWs5+8NPn
	Vlpd6vZO0nZ4/rJNpGI8zbyNveCfViJiZjsVGaVRA13b4I/4tomE0qQi5Tjv37ENZxuE40N6QhI
	L8HzGE/tvHQ4Fme2hj4f1s+kklwsEi5fHT5h7XvRamyh6v2GIvGP1kebgo5lJM/kSmV66AsZElA
	QPru+7tsYKqg+9lcXi/+qS+igtrEAgvjVTY3Q4atxWYpFpKl4l93SRpPDBUzB+TH3EusclOAP0R
	Y/HB6pmhXgJv9NnjS5RNJOWkiys2jnKE393s7AYmBBCiBDY5G9OdKbyoWQ/D4GmHC1xPZz4nCEa
	iok/vxfJ26QBJ1YEAxrdlPSRMn7gLBmXdJ5BXd0pV+pIV/90a0VE/tK4VNHVEncTK00Pi21/T3Z
	pgW4Q==
X-Received: by 2002:a05:6000:2c07:b0:461:e27d:5690 with SMTP id ffacd0b85a97d-47758fa28ebmr7571330f8f.26.1782985740932;
        Thu, 02 Jul 2026 02:49:00 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-52-250-217.retail.telecomitalia.it. [79.52.250.217])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm7381364f8f.16.2026.07.02.02.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:49:00 -0700 (PDT)
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
Subject: [PATCH v6 5/7] thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux function
Date: Thu,  2 Jul 2026 11:48:33 +0200
Message-ID: <20260702094846.17325-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702094846.17325-1-ansuelsmth@gmail.com>
References: <20260702094846.17325-1-ansuelsmth@gmail.com>
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


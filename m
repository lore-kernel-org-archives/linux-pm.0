Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB13EEAC6
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229494; cv=none; b=LOLSXvUUZXXhE6nmsnGDfuxLr16T/N2KcGW3FzPkTLa99IQEdvqJos15ZPDfrSffA7X5m+ubTWiPvpJwAbQRx+DSlDE7hqsSFTzhz+qLsJlxqyipX03l8JmLSnMw7arLaAMJIYcGCZYQEUJNr2Jg7r/0Bx4USktGynD1vJo7WUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229494; c=relaxed/simple;
	bh=OF1jcQiNuZ76zJkVKyHL6MQuNZTUl0y/mdnj3N/jK1k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjf00B7G2XbbYs4R74/6EJcuL4EgzIbuy9RzL6DCKd/tqf/GyxuJkqPA4JdY2BljwDwUveb+i2BGryjW6HAiVPh2g6JJnLjVP2iWyJW8x2wsLNV28wdA9tm9/b7WET2xJ7hfGFYc4iEqzmHeGZE2vYzfD3JQf4hvAkBCV4km9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOEficZ/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOEficZ/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso47107625e9.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229491; x=1779834291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeJvbLLXeYwkiGt215xzsc9IViQy8pVQx2rwLoJOdxs=;
        b=YOEficZ/uxE8u+7DcSvo1VckuIUhBXxSQCirYRn2Rre72MUU7QmddIp+HliypWVhv7
         h2R0wuFgNypZ9+uYeR25SP/IIZDSl23JXgM8rXPf/pMdFcs2K3lPagnEfEy3hmhhg8KB
         zS8m48YskyQIlWI80dSh/SWWVLJ/THq7qQj+M26P2WuUSaUm4bJcg6IKD5MbRGrw/JHC
         Xk9UPhGWVbrk10g3yEhpBzYX55ka0O+8SWJyDVBpIFXOaOzidOmnagHv2xi8snA/j4NS
         VHrmOn4A9Zkou0foGwtp+XDbPJYQ3h1TbR6OOWCzGwL31LW1TSvrVOSWalvOy4lue7Pb
         tY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229491; x=1779834291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JeJvbLLXeYwkiGt215xzsc9IViQy8pVQx2rwLoJOdxs=;
        b=QVYvHLlcwpwEvcMONTLi2DNs7Q7bQ8amAvRWgU/vp5iQbd+FXza6LMighko+UmVmLi
         Fcf81BvURQo2jXsC9Tu264S7pQfrbZnAZAHPh8z7+HjEGnuWlTmuHdY3aqQutdj/WkHg
         m0rbjJ5hfse+EL9wJS0mV3A6KkV87rDsgY69TqC0MIXiUEhjG+U028xipOYcVOonSLbx
         sWwnl5HlMN5FFdQSGC1SZ3bo8OoJIra0ewvAA60EPRzf657ZA2ltcSEuRmRzVafhvoEg
         NzF6nYxCs+LfAfTMWV9+9JkJY/dl30D7vaJZgqSTWWaqxwOp0xAPjFyYxnMJ26wQ7GrI
         59pg==
X-Forwarded-Encrypted: i=1; AFNElJ9p0gmi0uL3rl4SrJS83R7NyiJONgxggoTSuJu7atevylmOrvqaGy7Ko6iDyvSs0YvvmWdGacvLaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfas2iRB0rlHM+FQLHCmGJQTluO0sXYtHDqm+476SXrPUdhl4y
	yPpSHAjszCqN9DXvncN9dvKVh8HmH3Q3ho+7csxFD3wXY++1doo0BvtM+W4fVw==
X-Gm-Gg: Acq92OHFpPF5BKNo8Sp4up6g12CylFtM11Cq+77qvJ8PAG7u0XiGtgO0beB29rvJaOw
	DLG9ES663xJ56UCUH6xB8B8BsRAfZe8UBuqqFYP/tP2E4xkqV4qfdddQj6NwuASKH5TuYErXFRv
	14KEKu4RGhAJTpNXN3I0mhKtwCHLGhbPEylkUrSyN9roSdgQRHpXBmIyrsjFMoEOhflFWu6lR7U
	rCqYszIOtoMWCc2vdAKgq5PNIa/TRGzChmxsXn78EPDTB8IRJZM1NyZ6WSGv7Ox5ALpS0SNTnCd
	EVvy4SgqYjczp/65Si4hzsQHcvCDh1gP5HH9Hh/fEsePuj5aM9rhjW40VWEP09HAFmLMs5hnQMO
	l9d1F/6SNO2uY0l3TMQeH6WyEyLFpm+hP3dA06tvQo98I01GWpG/iANZgpD/MTDl61KgbN7gdim
	l7BcrBWOagYj5KHn40QN0O6BDbN0tECQSMf/P3bRG3NlkGowgWM4N0z00dh2w1ciIx0ahkHoA=
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id 5b1f17b1804b1-48fe60e7d6emr273378365e9.10.1779229490937;
        Tue, 19 May 2026 15:24:50 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm381097435e9.3.2026.05.19.15.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:24:50 -0700 (PDT)
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
Subject: [PATCH v4 3/5] thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux function
Date: Wed, 20 May 2026 00:24:24 +0200
Message-ID: <20260519222433.29684-4-ansuelsmth@gmail.com>
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

In preparation for support of Airoha AN7583, generalize
get_thermal_ADC() and set_thermal_mux() with the use of reg_field API.

This is to account the same logic between the current supported SoC and
the new one but with different register address.

While at it also further improve some comments and move sleep inside the
set_thermal_mux function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 54 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 864a01fd8fd8..a062922cb116 100644
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
@@ -219,22 +228,29 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
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
+
+	/* Sleep 10 ms for Thermal ADC to enable */
+	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
 
 	/* Restore PLLRG value on exit */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
@@ -343,10 +359,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 {
 	u32 efuse_calib_info, cpu_sensor;
 
-	/* Setup thermal sensor to ADC mode and setup the mux to DIODE1 */
-	airoha_init_thermal_ADC_mode(priv);
-	/* sleep 10 ms for ADC to enable */
-	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
+	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
+	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
 
 	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
@@ -429,13 +443,18 @@ static const struct regmap_config en7581_thermal_regmap_config = {
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
@@ -454,6 +473,17 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->chip_scu))
 		return PTR_ERR(priv->chip_scu);
 
+	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
+		struct regmap_field *field;
+
+		field = devm_regmap_field_alloc(dev, priv->chip_scu,
+						en7581_chip_scu_fields[i]);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		priv->chip_scu_fields[i] = field;
+	}
+
 	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);
 
-- 
2.53.0


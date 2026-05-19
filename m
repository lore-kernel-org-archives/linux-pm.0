Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220C3EDADB
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229493; cv=none; b=RktkqOa42mfvGl+fB4hyW8AaH9rcvjhe2n8+t3WZj1HpyQWQ/Zl1YP4oCVpdw+1flUzFbVx4B/WhJGWOCL5aMTxvFGELfP+YOSDePSDqISRFUgOGBd5Yexn0I6AF0l8cHixKbiyLbcfE8cvFo0ZY86vRBAejRzIX7ku6Jx9bpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229493; c=relaxed/simple;
	bh=jZjVVRTMSOBTxHfQ9tWQQQ3/FZCaEcOCPXkupXgvp0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nhl5Q4eXITzkhB4N7PxGwClGqXN9JrBYcwGeMcY2+qLk2+/BgRYAFwtMHmr2Rz5lyjui72AqUEEQWGwaaPqiSkTSM9C/0GvquzH7zQT/TIThUQVmt244kBz+oITWnO26wEdC48SQl01uor+RCVXxq5Al4fnleVGrCsouA6A0eK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNCMoFEN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNCMoFEN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so23918525e9.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229490; x=1779834290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EB72+GNLjTykeQdPDqWdzy0ATqpCM1uFByZoN9dOlQw=;
        b=tNCMoFENYqo1+Le4+Ckm3w9/A4wIgpjD15Mir8qdMLxO0049BcUGyNTVnXYVtuSR1r
         IRwnu+cZaoOIOcFkXL/ealHVIYZmegQSf7UrPu9diydRrdKkYMrCaSLXXRhC40XoeZXW
         6PLWcJd3X1sKna23Rj3PJdgJ5uWBRTA/1ZAKl3JajF9XTi9SOIR5NO+pYWxm7ufQL+JP
         iLGFejwyUlnwdfQihjp1W1S2sKtYhzBFHX3/AJyiTQFEkXriyIubsa5yLeDgOcj43Cic
         whZ2xfk/875ikLOmpXkfABY7LCJnpapnXe4f5lG70aM2UJYrFaNlg2Nbqyw74B0xk8lq
         NG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229490; x=1779834290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EB72+GNLjTykeQdPDqWdzy0ATqpCM1uFByZoN9dOlQw=;
        b=YfbyKgWCBUOn4WVEYTgEGgplbCZmi4LPnIHtZqewLsa97N12zOLll7XKdVPJGMTCm7
         /PXc/RNEn6+h8NdBgqsxukFYsEmY8Tt9r9h92A2X8OiEATiQSpAOqTUpfRElC0TW7tCW
         1elfOytPKkyq9IXE7P59S/L3j67aQhwTjRlDKm2a8LCza9s2l1So4C8tTDk+qpRDNf/9
         DDw3LLaAstCcwwGJvoizAPDMjtPDc2L+fT6rGmqnf96xvb6wagIdLiKaRGvJxvC0xxTW
         2A3k7dePc+aD+WrpJnj3x9pL0OKWzW807m7FMptATH61OkDdvvE48OFB76ATUFJiHTFM
         IfXg==
X-Forwarded-Encrypted: i=1; AFNElJ9bjkFk0xMuNntm6zSJcvXhppT9RBAvV8f6gqrO0kM2dR45q4A+75jqxxwvn1PMp9wADW8bwTKXag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdiWigxukW9sKq6kI3sQirAfeyF7fKz0POyFwuSeIOe8guc4Zp
	mPn5WrHycehbQ2E1tLYWy5fvUVdFNhTdUEDNtsfq/HOX1RAAz/y3FmY8
X-Gm-Gg: Acq92OEDwMUTdl2gBoal9bnrk6epqtaoBY27lEESdjLyzkp62HuogDFXs2oOKy5cB3L
	qpWVnUB28KvJsgOZpZRx75tYyeUhLExbEu7TL2zYWvq1UK24HlkIzLE+CGJnTodXb33HBTMeAE6
	hUtgHX1B3XPBhxFfohQCUitx/vNL4CLaRzIvSW5WkscgtJmj1df9SuevLSrvTojYEgB6o5h/Sqb
	QnVBctIltA022q5s8nshlO2SKmC1J29ZoWnuTFF2vBOMxE2lxFYERpSgejhRGoYUgy+mWBLBUbC
	Tz4/48UIgDIeT3Wn7p2VYoQ7ixa/JimOfgr+xsxCFuI3ZY0IdAW6ISROo3fqq/K7at9DD6WpxVp
	w9d38xEdiWe2eJMrQQgLo0uH6+83rp0vZXgpAsDYPxI636BuiEguayxnE4CL3nhxMpm0rB8bfcP
	hpPJeWjiHJA0P83+VkGPYZF2R/6/BUHxAQYqw8AxSol2q5vPCQ1JfP05xy9zTDqnYTF0ArGy4=
X-Received: by 2002:a05:600c:3b19:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-4900f7c0f52mr123899895e9.0.1779229489703;
        Tue, 19 May 2026 15:24:49 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm381097435e9.3.2026.05.19.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:24:48 -0700 (PDT)
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
Subject: [PATCH v4 2/5] thermal/drivers: airoha: Generalize probe function
Date: Wed, 20 May 2026 00:24:23 +0200
Message-ID: <20260519222433.29684-3-ansuelsmth@gmail.com>
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

In preparation for support of Airoha AN7583, generalize the probe
function to address for the 2 SoC differece.

Implement a match_data struct where it's possible to define a more
specific probe and post_probe function and specific thermal ops and
pllrg protect value.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 102 +++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 01ed49a4887e..864a01fd8fd8 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -198,12 +198,23 @@ struct airoha_thermal_priv {
 	struct regmap *chip_scu;
 	struct resource scu_adc_res;
 
+	u32 pllrg_protect;
+
 	struct thermal_zone_device *tz;
 	int init_temp;
 	int default_slope;
 	int default_offset;
 };
 
+struct airoha_thermal_soc_data {
+	u32 pllrg_protect;
+
+	const struct thermal_zone_device_ops *thdev_ops;
+	int (*probe)(struct platform_device *pdev,
+		     struct airoha_thermal_priv *priv);
+	int (*post_probe)(struct platform_device *pdev);
+};
+
 static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
@@ -220,7 +231,8 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
 	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
 
 	/* Give access to thermal regs */
-	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, EN7581_SCU_THERMAL_PROTECT_KEY);
+	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
+		     priv->pllrg_protect);
 	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
 	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
 
@@ -228,7 +240,7 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
 }
 
-static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
 	int min_value, max_value, avg_value, value;
@@ -253,7 +265,7 @@ static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
-static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
+static int en7581_thermal_set_trips(struct thermal_zone_device *tz, int low,
 				    int high)
 {
 	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
@@ -290,12 +302,12 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	return 0;
 }
 
-static const struct thermal_zone_device_ops thdev_ops = {
-	.get_temp = airoha_thermal_get_temp,
-	.set_trips = airoha_thermal_set_trips,
+static const struct thermal_zone_device_ops en7581_thdev_ops = {
+	.get_temp = en7581_thermal_get_temp,
+	.set_trips = en7581_thermal_set_trips,
 };
 
-static irqreturn_t airoha_thermal_irq(int irq, void *data)
+static irqreturn_t en7581_thermal_irq(int irq, void *data)
 {
 	struct airoha_thermal_priv *priv = data;
 	enum thermal_notify_event event;
@@ -326,7 +338,7 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void airoha_thermal_setup_adc_val(struct device *dev,
+static void en7581_thermal_setup_adc_val(struct device *dev,
 					 struct airoha_thermal_priv *priv)
 {
 	u32 efuse_calib_info, cpu_sensor;
@@ -356,7 +368,7 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 	}
 }
 
-static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
+static void en7581_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 {
 	/* Set measure mode */
 	regmap_write(priv->map, EN7581_TEMPMSRCTL0,
@@ -411,30 +423,26 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 		     FIELD_PREP(EN7581_ADC_POLL_INTVL, 146));
 }
 
-static const struct regmap_config airoha_thermal_regmap_config = {
+static const struct regmap_config en7581_thermal_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
 	.val_bits		= 32,
 };
 
-static int airoha_thermal_probe(struct platform_device *pdev)
+static int en7581_thermal_probe(struct platform_device *pdev,
+				struct airoha_thermal_priv *priv)
 {
-	struct airoha_thermal_priv *priv;
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	int irq, ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	priv->map = devm_regmap_init_mmio(dev, base,
-					  &airoha_thermal_regmap_config);
+					  &en7581_thermal_regmap_config);
 	if (IS_ERR(priv->map))
 		return PTR_ERR(priv->map);
 
@@ -454,18 +462,55 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					airoha_thermal_irq, IRQF_ONESHOT,
+					en7581_thermal_irq, IRQF_ONESHOT,
 					pdev->name, priv);
 	if (ret) {
 		dev_err(dev, "Can't get interrupt working.\n");
 		return ret;
 	}
 
-	airoha_thermal_setup_monitor(priv);
-	airoha_thermal_setup_adc_val(dev, priv);
+	en7581_thermal_setup_monitor(priv);
+	en7581_thermal_setup_adc_val(dev, priv);
+
+	return 0;
+}
+
+static int en7581_thermal_post_probe(struct platform_device *pdev)
+{
+	struct airoha_thermal_priv *priv = platform_get_drvdata(pdev);
+
+	/* Enable LOW and HIGH interrupt (if supported) */
+	regmap_write(priv->map, EN7581_TEMPMONINT,
+		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
+
+	return 0;
+}
+
+static int airoha_thermal_probe(struct platform_device *pdev)
+{
+	const struct airoha_thermal_soc_data *soc_data;
+	struct airoha_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	soc_data = device_get_match_data(dev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pllrg_protect = soc_data->pllrg_protect;
+
+	if (!soc_data->probe)
+		return -EINVAL;
+
+	ret = soc_data->probe(pdev, priv);
+	if (ret)
+		return ret;
 
 	/* register of thermal sensor and get info from DT */
-	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &thdev_ops);
+	priv->tz = devm_thermal_of_zone_register(dev, 0, priv,
+						 soc_data->thdev_ops);
 	if (IS_ERR(priv->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(priv->tz);
@@ -473,15 +518,18 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	/* Enable LOW and HIGH interrupt */
-	regmap_write(priv->map, EN7581_TEMPMONINT,
-		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
-
-	return 0;
+	return soc_data->post_probe ? soc_data->post_probe(pdev) : 0;
 }
 
+static const struct airoha_thermal_soc_data en7581_data = {
+	.pllrg_protect = EN7581_SCU_THERMAL_PROTECT_KEY,
+	.thdev_ops = &en7581_thdev_ops,
+	.probe = &en7581_thermal_probe,
+	.post_probe = &en7581_thermal_post_probe,
+};
+
 static const struct of_device_id airoha_thermal_match[] = {
-	{ .compatible = "airoha,en7581-thermal" },
+	{ .compatible = "airoha,en7581-thermal", .data = &en7581_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, airoha_thermal_match);
-- 
2.53.0


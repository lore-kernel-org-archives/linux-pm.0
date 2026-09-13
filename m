Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE8352019
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311615; cv=none; b=XQ85+ceoB+8ds8U2C/rw31BeaWl82qgL4fLS9KP6l+9y+GBEAik/b22esOIw+kBp77rHwO6HCG3BPoa+uJF+v2qXyXGBhMQHNsQUwEKw1V+P5EtiegwVNrs8tCc29XJcXoYMdO4TZMfTRxwbo8Ptlii9UcOdg6Jcx/PNeBZO1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311615; c=relaxed/simple;
	bh=Fqx/Why65ntDuLsjE2Hge2Y5XJMOcjUmtfTFWTyd2qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfnhXZKACr5EzSqE6ijAM/KKiVvOl8m8QEuCgIE1dNS6BwnD/5HYYQ56qx7m0jwu96LY8a4M72ympdLjtmgWO/i7o4VyR2Kl2nbyCrZvY2NkIvqt5rWlRx3IguiN64l7argUU4CQkzwC7a/b2fCuzZwEqgR5QXm7Jsk5oLTYmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBDZVsF+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBDZVsF+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so2963657a91.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311613; x=1789916413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWlrSuY01GdV11TIXI5P8cmkxAQSB0ZioYMZIiZx+uQ=;
        b=dBDZVsF+/W/cpmglgHKOD96944NNMz5bR+fmoKWhn0w7tjSkJRg75Fvc0Sh74Xim8/
         oDqv0orYGRxEiEr/9kVwGybmLcV8HT65zs3kle/L7f2WhrbpJ8L9R95e5BH9f7bwN9id
         3puqW7MTAdXx/+A+WnAJDgx8BHEYTkI6WG20E3vNroKTo5Dzbj169G6QMXECVJi/cnuv
         Pu6L9/VHoj+w7QaS70eWSeFpHHY1dVoIE1W3kdcWSDDULmHi+/CPIczYVRkO2UPaTlSz
         EmGAEHVH6WgDICxpSNoI34AjmsmpRWdigPEYBSLnga20gAPWOSosupo4lYv8GWQv5G4a
         AgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311613; x=1789916413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWlrSuY01GdV11TIXI5P8cmkxAQSB0ZioYMZIiZx+uQ=;
        b=VuSPS0/Shg5IJozppWV8OO92KVeThaaCxkMNfjpmOLWYHgUPNXz+9MhgT2H63kM/zv
         AzJNqUMGib6wVWNTM9zW79qmve8BlSlVvRBmgRICDJc9kf7rw1yw7fhyyzTw5/9ULzyK
         V1BzaYFhQnk+DCOQHmxN4Sr14wghNDKriCHfqKBr9ibFjOQg6b/MW7yQSlH/QZlO/p2J
         GNkj92ZKpxCtnMeo/GEYOC3tk30eEOH3/Hwf+/IzZMvu7/HjSyjvBBLQjU3PL5LL7EIP
         7u3a4VaVSTwEnnMmDkoQk06g3N1CSXZIY9Q58vqkW/V0i54qJ1ADd3TeNsh2ehkmVDSW
         ricg==
X-Forwarded-Encrypted: i=1; AKwUvBwYrlKTAQg0IpYad9o/GOTcfbHf5RAK5E8X+bkaqCLulnam6PRD8l7PvZHt6E3Bfm12UA+5epIqSg==@vger.kernel.org
X-Gm-Message-State: AFuF++m1QvsuSFhO5QpH5WJNaBUmPUxhRV8V85f3znRAoaaDRphCCvZY
	SYxMyoAXS5btIKqfw133x+2q/ms9jNbC5wA41E7+yTZKYh8+/XANWj9y
X-Gm-Gg: AYBFou3CbcNdWW+GDj0RboQHq6BRK1MifiRCr5W4W9/gwmumwktKc7ilMHY3PBtyz8R
	dg3Cm7IdG14viS9Bixq1icwkYzUbNRnzHt6b88uiDxZ+sNZVCF1rHBlxeUG+iC+BMQOFeEj84mz
	L07wAqzIEXJfQT2fTtud7WS6lFeUfye495zZsbb6ZCjBE7P/37dshVDMp5vERIRRmlOnR8kq5dO
	8NfjC18O124kRgHNGSsR8J56ui9mf34LzBgHDV3Cb/OOh7mNFFN9/CNg2LxDtnqJrNdRW6mnDfv
	+NFkGfExtpEGdfMoZTpJ41CvPkcVYmv0UYvYQglYTPUIPldM53EkWPnejGElDa4Vrmlg7IADfDv
	ggurVYksMUFZ4mOKHiPvSKlnrDY/eYFKALTlXz3KSrV4HNHpSopA1Ebk+7cy1HN9FQTaeYHeI3S
	MzghAPXrgJAMlvWybbgCmFHCEXXB6g9YH1JL3UYY+60sMziQV9wEs3w7WuZtugdkJEEkgREHFl
X-Received: by 2002:a17:90b:4cc6:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-39dd54eacd9mr3419850a91.14.1789311607909;
        Sun, 13 Sep 2026 08:00:07 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.08.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 08:00:07 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 7/9] thermal/drivers/exynos: Move thermal zone ops to variant data
Date: Sun, 13 Sep 2026 20:28:35 +0530
Message-ID: <20260913145905.9404-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145905.9404-1-linux.amoon@gmail.com>
References: <20260913145905.9404-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the thermal zone device operations into the SoC-specific variant
data and use the variant when registering the thermal zone.

Store a thermal_zone_device_ops pointer in struct exynos_tmu_variant
so that each supported SoC can provide its own thermal zone operations.

This allows thermal zone registration to be selected together with the
other SoC-specific TMU configuration through the device tree match data.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 69 ++++++++++++++++------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a689c6a40b67..0e7b92035850 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -186,6 +186,7 @@ struct exynos_tmu_data {
  * @tmu_read: SoC-specific TMU temperature read method.
  * @tmu_set_emulation: SoC-specific TMU emulation setting method.
  * @tmu_clear_irqs: SoC-specific TMU interrupt clearing method.
+ * @tmu_ops: SoC-specific thermal zone device operations.
  */
 struct exynos_tmu_variant {
 	enum soc_type soc;
@@ -205,6 +206,7 @@ struct exynos_tmu_variant {
 	int (*tmu_read)(struct exynos_tmu_data *data);
 	void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
 	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
+	const struct thermal_zone_device_ops *tmu_ops;
 };
 
 /*
@@ -809,6 +811,34 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	writel(val_irq, data->base + tmu_intclear);
 }
 
+static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
+
+	mutex_lock(&data->lock);
+	clk_enable(data->clk);
+
+	if (low > INT_MIN)
+		data->variant->tmu_set_low_temp(data, low / MCELSIUS);
+	else
+		data->variant->tmu_disable_low(data);
+	if (high < INT_MAX)
+		data->variant->tmu_set_high_temp(data, high / MCELSIUS);
+	else
+		data->variant->tmu_disable_high(data);
+
+	clk_disable(data->clk);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops exynos_sensor_ops = {
+	.get_temp = exynos_get_temp,
+	.set_emul_temp = exynos_tmu_set_emulation,
+	.set_trips = exynos_set_trips,
+};
+
 static const struct exynos_tmu_variant exynos3250_data = {
 	.soc = SOC_ARCH_EXYNOS3250,
 	.gain = 8,
@@ -826,6 +856,7 @@ static const struct exynos_tmu_variant exynos3250_data = {
 	.tmu_read = exynos4412_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos4210_data = {
@@ -844,6 +875,7 @@ static const struct exynos_tmu_variant exynos4210_data = {
 	.tmu_control = exynos4210_tmu_control,
 	.tmu_read = exynos4210_tmu_read,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos4412_data = {
@@ -863,6 +895,7 @@ static const struct exynos_tmu_variant exynos4412_data = {
 	.tmu_read = exynos4412_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos5250_data = {
@@ -882,6 +915,7 @@ static const struct exynos_tmu_variant exynos5250_data = {
 	.tmu_read = exynos4412_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos5260_data = {
@@ -901,6 +935,7 @@ static const struct exynos_tmu_variant exynos5260_data = {
 	.tmu_read = exynos4412_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos5420_data = {
@@ -920,6 +955,7 @@ static const struct exynos_tmu_variant exynos5420_data = {
 	.tmu_read = exynos4412_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos5420_triminfo_data = {
@@ -939,6 +975,7 @@ static const struct exynos_tmu_variant exynos5420_triminfo_data = {
 	.tmu_read = exynos4412_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos5433_data = {
@@ -958,6 +995,7 @@ static const struct exynos_tmu_variant exynos5433_data = {
 	.tmu_read = exynos4412_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct exynos_tmu_variant exynos7_data = {
@@ -977,6 +1015,7 @@ static const struct exynos_tmu_variant exynos7_data = {
 	.tmu_read = exynos7_tmu_read,
 	.tmu_set_emulation = exynos4412_tmu_set_emulation,
 	.tmu_clear_irqs = exynos4210_tmu_clear_irqs,
+	.tmu_ops = &exynos_sensor_ops,
 };
 
 static const struct of_device_id exynos_tmu_match[] = {
@@ -1052,34 +1091,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	return 0;
 }
 
-static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
-{
-	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
-
-	mutex_lock(&data->lock);
-	clk_enable(data->clk);
-
-	if (low > INT_MIN)
-		data->variant->tmu_set_low_temp(data, low / MCELSIUS);
-	else
-		data->variant->tmu_disable_low(data);
-	if (high < INT_MAX)
-		data->variant->tmu_set_high_temp(data, high / MCELSIUS);
-	else
-		data->variant->tmu_disable_high(data);
-
-	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
-
-	return 0;
-}
-
-static const struct thermal_zone_device_ops exynos_sensor_ops = {
-	.get_temp = exynos_get_temp,
-	.set_emul_temp = exynos_tmu_set_emulation,
-	.set_trips = exynos_set_trips,
-};
-
 static int exynos_tmu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1144,7 +1155,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	}
 
 	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
-						  &exynos_sensor_ops);
+						  data->variant->tmu_ops);
 	if (IS_ERR(data->tzd))
 		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
 
-- 
2.55.0


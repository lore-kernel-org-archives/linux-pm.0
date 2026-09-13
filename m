Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D203ED12C
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303982; cv=none; b=V12OeNqtUF99XlrYEKkJXNAciWsKkC4vOzai+Iq7ge9Bzvc/PgHS5iF/CK8Tc31omE+E6ZjMEvCZSm2uMAuej4fUxQfBJmBTQSRRWbLr30GujWi/q82vCTrC5b+o4tFHadqymctO+6/GT2fCSlRFGQaOLMzr6uhfkpsxpAluPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303982; c=relaxed/simple;
	bh=2r0CGwnbhw+4LMmv7iYh/YHAix4sdwnKIMTStdJVtsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Bu1wc7Nq9Saf7YRurxKHyxFD31lsHH+bX+c4g8DyURDjEluejkOq40EJJFOunYMfCHBtoX2FjAiwWUgLBwGm1QJYqRvTfPeslIgBLHYKN8V9p2nZQ9OV6Q4M0sTGJharAL+8pSmv1AP6MgCKPxS45aq95DGf9RO5c/M2ARX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cjy+BW8r; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjy+BW8r"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651cso808947e87.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789303979; x=1789908779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhwkJWnv59ZKHCv2u+n64jx0w7NQkxuLbLuAE4ou0xQ=;
        b=Cjy+BW8r1bhyo3sHyI9aWSnH9GwoFinNgx6O1kWLt6Ozrfgewm+vbhlR8bnGvEQhs4
         oicZHm1Bh7TNOl1JVAYGb0lqmGyEQWWwYj7AJRqiLQFw0XmmktRBoCqlJUtK/2y/CnDT
         ThSuQ/BCF5Ao2kP+6TyeHDXzlDcciVZjHeuCcfbeLoih+p5K62XGC58z/+0Wk5Ij4A3I
         sHPKJbBPC+r8CRlRKUp+4YttX7xah6VCBMr7WxJsGqxZL4sys89aDk/usVUjWBP13O4T
         R6/S0PEq3r3QTmObB5Kt26YEv+OZfvyj3RjrpHjOH8Lgqg8MiaYycAVWg5A2NRBFplce
         OPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789303979; x=1789908779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qhwkJWnv59ZKHCv2u+n64jx0w7NQkxuLbLuAE4ou0xQ=;
        b=cCnc2Rc1LMrvs0+KrKhvtpz7ZXg86uVcJUM9W8uUa2c9hMcIbeZ4OsGNAlL3bQ7OJ1
         mjgl+M+gLsRGAo0NhrXEc7/0mVCWhkna3/wbECE0muH8ss87LbyFQt1UqZFcW+ui38Xm
         gPuVRzwPLrahBks+N2HxVZwTlMNMC/BkDbQL44KH10VkQ1DVvTBkq5wj+kVZ4iLu4RrA
         Bgg69dTDRP2KNcpeFb85bXN/xK0YEV+uE3N8MmVxvH4qxit975GUkrLCK0+6s3wBG1/B
         j6ZHGj1QVgX5NIT823A+Nfa9d/RdsTpiMk7VVbBLSDz1isA5/5Sg66IOGj7RqiQhYmLZ
         /O0g==
X-Forwarded-Encrypted: i=1; AKwUvBwn0EhRJtCRadpoy6UXuAkBPTvDUC+3msoRQc7kEWs5IIUXUMf4yt8jr9gFCV7Ar0DxfFCiyIudcA==@vger.kernel.org
X-Gm-Message-State: AFuF++lSI5RLILEvkVL1gaaZ1d0gYcB+AGLDdFbQid7vmXUi5Ay/vQD8
	41v5A0ilU+Uh3pT6K51aqQ6fgx0A3+udqvVxzoseUWD3kODFo2c7Cv4=
X-Gm-Gg: AYBFou34LUKefDJOSN1SZuZU9uIwTnW8+fDRXwjg00+pPEbXgi1QoiJzKHNX+4YSHGj
	ACyNeDSUp1zCakDzlwRM2LuIUZzREvm+icGRVOuVQSxxLYmvlKrcWcXzbOXQ4tHT69LjCtcDRiG
	3fI6E6W4L9VGJiW0J42Vv2xsLjiJUTJYK5rDqo3m8jXT/n55XB6loeWr72BYU1Tha4SMiGI9EvX
	wTkRDF2xcnfseDzF6fth8f6PWsYkiBE1Xvtgvy6HNOHVIPkj4g9HyBv6Xvh2SqgW6Mvdqjx+Vhy
	RXtJVrc4ob781+jsF3vJh/SuJzAz64fL+PnMfkb3VyQvoueiIv0UOXldt3egEE8seMv/zd0dniR
	HIeivuMbqfWmyrG1QkPRxaoZd64dgFqZwalBIED/5PXWQOLGDvCRB/yVZsWznjl/fOK9nPGFc4s
	2pPOPXL1wBRgZQPlo+7L20OaFF+n6jF1D8MzSq+SnL9N/eGOKmZFJ+GwOfVOjBXY0=
X-Received: by 2002:a05:6512:224e:b0:5b6:1870:268b with SMTP id 2adb3069b0e04-5b8a8eff12bmr1319989e87.60.1789303978537;
        Sun, 13 Sep 2026 05:52:58 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0469a8esm1762844e87.50.2026.09.13.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:52:58 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 2/4] thermal/drivers/airoha: Serialise access to the shared ADC
Date: Sun, 13 Sep 2026 15:52:24 +0100
Message-ID: <20260913145226.34643-3-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145226.34643-1-sochnev.v.74@gmail.com>
References: <20260913145226.34643-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A read selects the sensor and walks three diodes with a 10 ms settle on
each. Nothing serialises this, so concurrent reads interleave and
convert samples taken at another mux position.

Mux writes are dropped silently unless PLLRG_PROTECT is lifted, and its
save and restore do not nest. The cached TADC value also skips a write
after another reader has moved the mux.

With the AN7583 sensors read as parallel zones during CPU frequency
changes, a zone crossed its critical trip on a chip at 55 C and the
board shut down.

Serialise the sequence, drop the cache, check the selection after
writing and after sampling, and return -EAGAIN if it does not hold.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 85 +++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 2934d6aba0ed..d7e4a088b7ea 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -191,6 +192,7 @@
 #define AN7583_NUM_SENSOR			3
 
 #define AIROHA_THERMAL_NO_MUX_SENSOR		-1
+#define AIROHA_THERMAL_MUX_TRIES		3
 
 /* Convert temp to raw value as read from ADC	((((temp / 100) - init) * slope) / 1000) + offset */
 #define TEMP_TO_RAW(priv, temp)			((((((temp) / 100) - (priv)->init_temp) * \
@@ -250,7 +252,8 @@ struct airoha_thermal_priv {
 	struct resource scu_adc_res;
 
 	u32 pllrg_protect;
-	int current_adc;
+	/* Serialises mux selection and ADC sampling */
+	struct mutex lock;
 
 	struct thermal_zone_device *tz;
 	int init_temp;
@@ -294,9 +297,26 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 	return val;
 }
 
+static bool airoha_thermal_mux_holds(struct airoha_thermal_priv *priv,
+				     int tdac_idx, int sensor_idx)
+{
+	unsigned int val;
+
+	if (regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC], &val) ||
+	    val != tdac_idx)
+		return false;
+
+	if (sensor_idx == AIROHA_THERMAL_NO_MUX_SENSOR)
+		return true;
+
+	return !regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR], &val) &&
+	       val == sensor_idx;
+}
+
 static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
 				   int tdac_idx, int sensor_idx)
 {
+	int tries = AIROHA_THERMAL_MUX_TRIES;
 	u32 pllrg;
 
 	/* Save PLLRG current value */
@@ -307,19 +327,17 @@ static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
 		     priv->pllrg_protect);
 
 	/*
-	 * Configure Thermal Sensor mux to sensor_idx.
+	 * Configure Thermal Sensor mux to sensor_idx and Thermal ADC mux to
+	 * tdac_idx. Writes can be dropped silently, so read them back.
 	 * (if not supported, sensor_idx is AIROHA_THERMAL_NO_MUX_SENSOR)
 	 */
-	if (sensor_idx != AIROHA_THERMAL_NO_MUX_SENSOR)
-		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],
-				   sensor_idx);
-
-	/* Configure Thermal ADC mux to tdac_idx */
-	if (priv->current_adc != tdac_idx) {
+	do {
+		if (sensor_idx != AIROHA_THERMAL_NO_MUX_SENSOR)
+			regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],
+					   sensor_idx);
 		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
 				   tdac_idx);
-		priv->current_adc = tdac_idx;
-	}
+	} while (!airoha_thermal_mux_holds(priv, tdac_idx, sensor_idx) && --tries);
 
 	/* Restore PLLRG value on exit */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
@@ -594,12 +612,40 @@ static int en7581_thermal_post_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int an7583_thermal_read_diode(struct airoha_thermal_priv *priv,
+				     int diode, int sensor_idx, int *val)
+{
+	airoha_set_thermal_mux(priv, diode, sensor_idx);
+	*val = airoha_get_thermal_ADC(priv);
+
+	return airoha_thermal_mux_holds(priv, diode, sensor_idx) ? 0 : -EAGAIN;
+}
+
+static int an7583_thermal_read_diodes(struct airoha_thermal_priv *priv,
+				      int sensor_idx, int *zero, int *d0,
+				      int *d1)
+{
+	int ret;
+
+	ret = an7583_thermal_read_diode(priv, AN7583_ZERO_TADC, sensor_idx, zero);
+	if (ret)
+		return ret;
+
+	ret = an7583_thermal_read_diode(priv, AN7583_D0_TADC, sensor_idx, d0);
+	if (ret)
+		return ret;
+
+	return an7583_thermal_read_diode(priv, AN7583_D1_TADC, sensor_idx, d1);
+}
+
 static int an7583_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
 	int sensor_idx;
 	int delta_diode, delta_gain;
 	int coeff, slope, offset;
+	int tries = AIROHA_THERMAL_MUX_TRIES;
+	int ret;
 
 	int diode_zero, diode_d0, diode_d1;
 
@@ -610,12 +656,14 @@ static int an7583_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	slope = an7583_thermal_slope[sensor_idx];
 	offset = an7583_thermal_offset[sensor_idx];
 
-	airoha_set_thermal_mux(priv, AN7583_ZERO_TADC, sensor_idx);
-	diode_zero = airoha_get_thermal_ADC(priv);
-	airoha_set_thermal_mux(priv, AN7583_D0_TADC, sensor_idx);
-	diode_d0 = airoha_get_thermal_ADC(priv);
-	airoha_set_thermal_mux(priv, AN7583_D1_TADC, sensor_idx);
-	diode_d1 = airoha_get_thermal_ADC(priv);
+	mutex_lock(&priv->lock);
+	do {
+		ret = an7583_thermal_read_diodes(priv, sensor_idx, &diode_zero,
+						 &diode_d0, &diode_d1);
+	} while (ret == -EAGAIN && --tries);
+	mutex_unlock(&priv->lock);
+	if (ret)
+		return ret;
 
 	delta_diode = diode_d1 - diode_d0;
 	delta_gain = (delta_diode * coeff) / 100 + (diode_zero - diode_d1);
@@ -676,7 +724,10 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->pllrg_protect = soc_data->pllrg_protect;
-	priv->current_adc = -1;
+
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
 
 	if (!soc_data->probe)
 		return -EINVAL;
-- 
2.55.0


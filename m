Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09F4A843D
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492403; cv=none; b=SZ0mWoVwOHZNISFCEvq4D8NSCFffrGEeNi+GDS2dd4EySd937qcjsCr8p+pXoZmjWOijmm0l2qgV0k3Pe6nAUn5PvJGssetQygBj/oSnypHIOP7FTVpTIKybJJ1K0okBmktteSxVy7McrsobJLEv8VtJFLFmwfd6sYPYyjDnjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492403; c=relaxed/simple;
	bh=2r0CGwnbhw+4LMmv7iYh/YHAix4sdwnKIMTStdJVtsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4fTewnfzaFwdOsageRIUMMHBuSMdUhau6B14H3qnxgB6EQhoApyB4s1lgxqp5/2aN04uEz9w/DlS6bznrtZ9/ouWoK220whOk/RLD9k8yJAaiXObRtCb90C1L47UV81264ChEQd+TkkFJTBH8di4Gz/3ff1ZMA6niFGaC7FN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM5sncDP; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM5sncDP"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so1009323e87.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492398; x=1790097198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhwkJWnv59ZKHCv2u+n64jx0w7NQkxuLbLuAE4ou0xQ=;
        b=ZM5sncDP+8texOSeFeFr8gC/i1ugBafurUUBKpq9X/vwAlKsAvkhHOW6MWCpO2fa2c
         sTEB1RxuvSd3Svhx7joHNAdMR6v9QdrQrp9JWwbbBVyhKwaobng9HgXEkIK8b1ySZgLP
         T7XHyL4HqEYWnB3Stra3rvi610DcBkz3b7OwOfdMQzMHLILgv7T6ndWyNWEfRPdkLBj0
         nZ/Zw8S5fmSrqV4/kL3Meovj1wxtTc5GzHhzy/XMVjg6mN+jU7AjwQXBkd8kPKl2fz9a
         9aVSWemz43rUwMUZVYe1rZ7IKBS7ZPhknpzAdhGY8pPceaLRggPaAYYFutzWmlok156k
         ceBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492398; x=1790097198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qhwkJWnv59ZKHCv2u+n64jx0w7NQkxuLbLuAE4ou0xQ=;
        b=YkeMWCECf1Q0prxee+rZa4Zio8ShFD8iGm+IKxomrkdbV/TsXC3jk7UfQ4BFnwGPdl
         Hm0PLXCCJU/SGWuBaC0r7+p/1kXxynVGniFL71eHfFUYt0pFYBAtYIMmgX4XsMjY433w
         N82mc7aJg6GqGg+sASybuF4iGoWU0R3GFzm0rD6XbPKoIyhRzDHX9q0PnZyI/EsVTutJ
         TQJzZCq/kM9dt+NSs0AUYlXH5oQrzvl68fDWZLzcQzLjt3MiQJUH1QXEMbt4AS6FUcG2
         8GVZN6/RBcsrKTGVvJl0g0G2ify9Lj4zM176glr3N5yRBla4ujkSukGyk2Z09xInIW/E
         YfSg==
X-Forwarded-Encrypted: i=1; AKwUvBxWQLZCk/Mn7GPJF06PXdapwS1a9uHtdJDt3/WQm1Fs8h6IeMl7PoeYju4FySJ2N4bLlWCeWM5jhg==@vger.kernel.org
X-Gm-Message-State: AFuF++njFz1i71zUjicwsZZZBdQZlJQF5BnT5CWYzl+1QHe5/Y3CeMDc
	dJvRZwiLcpofNejf6Xq832espaJ8l0zJwajZ02BSMmZ+2PeJk593DAQ=
X-Gm-Gg: AYBFou2C1+M+suufCgqAqCDJPCsUuQVYp7u+b+oCRmF/ymwVeoSTEvoTxYxc19CTMbs
	+QOFirm2No0W+bDsghEkBerxMA+ysiOQrlaRXxUMNgi38GN7uDJHte7aB4eCJnIAe4Q/JtcF99i
	7X1xW5OX4RfGkn+BRjHL/RbUvmzAMZSyyenXkGfLrAJ9yXgR3vPQ/yRw1wLiOlAZT/1p1yrLZOe
	o20T4rEI0Y+UukDxraaqT7fW3fjt0furUME6aLEa4dEwgMLseTNYaRIL1friP82/wMBm5W5VRsP
	GnBby0ou88DFrO5JIWVtjUJsoavjX2yHGmDrq8Ke1woc1r+SUHC9HyWZaQspN5wFhQBv3ZEFxvx
	HfnteaedBemJOdFtUF6SumNlFobrgbjgfQh/QFUhZ3mALJ3ltKwhYOrM5wIJ9u/zk9jm3B/vS3b
	aqOH+eTfyVxHPn8Uud862Q2kZ1EZkoB4OA5BScRdrB8aAi2JuuRQX+RMOWCGvAMA==
X-Received: by 2002:a05:6512:3a96:b0:5b6:19fe:a5a9 with SMTP id 2adb3069b0e04-5b8ae6b8986mr4523493e87.26.1789492397996;
        Tue, 15 Sep 2026 10:13:17 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57eb908sm91791e87.79.2026.09.15.10.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:13:17 -0700 (PDT)
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
Subject: [PATCH v2 2/4] thermal/drivers/airoha: Serialise access to the shared ADC
Date: Tue, 15 Sep 2026 20:11:29 +0100
Message-ID: <20260915191131.25214-3-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915191131.25214-1-sochnev.v.74@gmail.com>
References: <20260915191131.25214-1-sochnev.v.74@gmail.com>
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


Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D973909B1
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559446; cv=none; b=jv6+6QNHCCKA0O07JkimHtnU4RchF1+jXv6aiRSZ1pm/e/Rf+VvlKADmp9pqLCqdSZC3UAWVc3ksvPTWHKc+TlioelC8BFiSbyKqNoXnYKNLCWyMqqe5+uBE1yjq3sPYTnkGBIsdARu2Ym+OQ9wiRGG5YGCB0BawsKbI25lZ6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559446; c=relaxed/simple;
	bh=NorYOSPVJZcKZxDpD9sKvkFX7ejrxkySeB+SqU3BlRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ql+AGlSRDnK6a4tBA6LcHTDJ6132KZAtlCLP3taHEp3rzezDJUCqekaG8zt6PDr+VXwo+oI5agstUugoh6gislZNeZHDOsbUohMtVYAQTvA3j8BUpb70kaz+pjQsvmoBxkNQimaWVNmaqiscBBJFCPES0de78fmFgfa+PBvwCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2r95X5/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2r95X5/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47d70879764so892072f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783559438; x=1784164238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8L+CQ4Gynkx2AYXtRuWONCUauUOwqk9uV3HudEHaG/k=;
        b=K2r95X5/djCO11/JBj5MiLSOqZ0od2M56LwKbw/edr6lKyuLN+gzxllYpB+cAOG85M
         9zsUrbf4xjRAhuAtPQUdB7oIrDhODuDFD+we0dh4nGnQ8ks6v4H4EVduO9mWIcuy9Y5W
         W6Ai3L6OiAm0tLbja6Unga/UUB8Vs96p+00Y6sOFK2pDemrkHoFCQKeklAv75BH+q20x
         ezv/WhFuvj4njKo1pbxpx5HXjvJS7P8sefmhnCi3QcKPpsE3GIAIm7xOmiOod+XoGkuv
         o/Stp0OAxezH7MQDD6GZyoQ0QEH2MrHx/gTr3Rytl1gRrxFB5foBMK5gEcRaqSwP1Xei
         oN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783559438; x=1784164238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L+CQ4Gynkx2AYXtRuWONCUauUOwqk9uV3HudEHaG/k=;
        b=clu5UWq9ZMGunJ4Az8PSE3J+vBD1GE0eK4hFmZWsMwAoc+VAQsZMzDgtJMMUe2c1D9
         P8dIevM4MRCGN5jcya+Htr+T7Q/rsuRK9wgZgfV4OCfQI8AFan4p4UbUamQM4hUW8zHL
         5JDT9r4uCO742G1jqCf8TFllpEj5dOv6PtdxO79xML/q3S1/Iu1x5agh7z1/mYEE4Npv
         Ct4TUiFwilm+1fDckQHnubvT6sYS0C3BtcVVttbS3cMFAQtKfoGgBn3Mu217G/ht4hT2
         +oIXL3bz3K4cI5WhV8/Ze9zZrd1/J3rFSriPBuyTalG6xeyTZbMzWqU3V+O0cQKUHf3N
         7Ndw==
X-Forwarded-Encrypted: i=1; AHgh+RqWJ+696fvbXRC+8e4ZA+oqYYXCxvKV/0auvq1EcCWiTIR0S83U0+eFFZwY/r1mmrcyy0ojRSNfVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKg0+7prOnr/2t0/glYAMfU2dgdFxLZmmewPQeZzkigV23mqb6
	g5qTDyT3wcjTl+zb5/3sWXdnMU4mEEVJKsJHDJ0E5ssMDabSTlnivkoN/dY2iFv8xL8=
X-Gm-Gg: AfdE7cmT6v24cT09sR3smA791QCG8FrAkkIS325U/mH/SjrIW8cs3MpshRaoNoaa21g
	cu0b+paeZeuozADkzYilvgj+5tHL1jcB3jrlRXnoxzYuye4ccyWGu56DOMNCu2w+DVCCiPDFu5T
	Ih41BPcEt2sZPIxjcJv4wY99fNZAeyzCz+gUzmGqCFQLjVrhudRu7PMuL6rs9u0d/NNBRmAIzjJ
	QR+U8FDbxZ/N9+kX9mBo+gRI9VcmiBNv7IuWJbwg89kWUDz68QEuf+n1L9EdF0/2qydzAttnbOo
	+MdP3ULScSzUSgNniNoOfaHTRNkqCqds7Vn1fQhNq2jm3swK16aoqTrEiIMrjEIp0dfuhbZTMIY
	EqFjSdiVLcCV7Z/fgKTLGUy2StkjIMPxed5uUzdWDVozy+EqGVBsHUaqu1izr7fYcPQltOFAFnE
	kafLaYbLaEvSbGoSq5OHV3/QKXb+sEe9l3baiIv3X6Aphf4xyxbybHu+yllNXCRkk/6F4ru795k
	EFe
X-Received: by 2002:a05:600c:1910:b0:493:e52f:6ee1 with SMTP id 5b1f17b1804b1-493e8a618bamr27806825e9.0.1783559438392;
        Wed, 08 Jul 2026 18:10:38 -0700 (PDT)
Received: from [127.0.1.1] ([2.122.8.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742d0esm18994725e9.13.2026.07.08.18.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:10:37 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 09 Jul 2026 02:10:29 +0100
Subject: [PATCH 3/3] thermal: samsung: acpm-tmu: add Exynos850 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-acpm-tmu-e850-support-v1-3-9fdd58b634af@linaro.org>
References: <20260709-acpm-tmu-e850-support-v1-0-9fdd58b634af@linaro.org>
In-Reply-To: <20260709-acpm-tmu-e850-support-v1-0-9fdd58b634af@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mateusz Majewski <m.majewski2@samsung.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.3

Add support for the Thermal Management Unit block found on the
Exynos850 SoC.

Unlike the GS101, the Exynos850 ACPM firmware implements a smaller
set of IPC commands (primarily basic TMU initialization, suspend/resume,
and temperature reading). While the firmware supports basic TMU
initialization, suspend/resume, and temperature polling, it lacks the
ability to fully configure the hardware. The remaining functionality
is implemented via direct MMIO access:
- TMU initialization sequence,
- setting falling and rising thresholds and associated IRQs,
- helpers to convert temperature to hardware values,
- handling of IRQs,
- thermal zone control (TMU core enable/disable).

Additionally, this also reorders the sensor group assignment in
acpm_tmu_probe() to let it happen before TMU init SoC callback.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 356 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 355 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index b3cea9890b4b..2bf880515e31 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -5,6 +5,7 @@
  * Copyright 2026 Linaro Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device/devres.h>
@@ -23,9 +24,79 @@
 
 #include "../thermal_hwmon.h"
 
+#define TYPE_TWO_POINT_TRIMMING		1
+
 #define EXYNOS_TMU_SENSOR(i)		BIT(i)
 #define EXYNOS_TMU_SENSORS_MAX_COUNT	16
 
+#define EXYNOS850_INTPEND_RISE_MASK	GENMASK(8, 0)
+#define EXYNOS850_INTPEND_FALL_MASK	GENMASK(23, 16)
+
+#define EXYNOS850_GPU_SENSOR_MASK	(EXYNOS_TMU_SENSOR(3))
+#define EXYNOS850_CPUCL1_SENSOR_MASK	(EXYNOS_TMU_SENSOR(2))
+#define EXYNOS850_CPUCL0_SENSOR_MASK	(EXYNOS_TMU_SENSOR(1))
+
+#define EXYNOS_TMU_REG_TRIMINFO		(0x0)
+#define EXYNOS850_TMU_TRIMINFO_SHIFT	4
+#define EXYNOS850_TMU_TRIMINFO_OFFSET(n)	\
+	(EXYNOS_TMU_REG_TRIMINFO + (n) * EXYNOS850_TMU_TRIMINFO_SHIFT)
+
+#define EXYNOS_FIRST_POINT_TRIM		25
+#define EXYNOS_SECOND_POINT_TRIM	85
+
+#define EXYNOS_TRIMINFO_CALIB_SEL_MASK	BIT(23)
+#define EXYNOS_TRIMINFO_25_MASK		GENMASK(8, 0)
+#define EXYNOS_TRIMINFO_85_MASK		GENMASK(17, 9)
+#define EXYNOS850_TMU_BGRI_TRIM_SHIFT	20
+#define EXYNOS850_TMU_BGRI_TRIM_MASK	0xf
+#define EXYNOS850_TMU_VREF_TRIM_SHIFT	12
+#define EXYNOS850_TMU_VREF_TRIM_MASK	0xf
+#define EXYNOS850_TMU_VBEI_TRIM_SHIFT	8
+#define EXYNOS850_TMU_VBEI_TRIM_MASK	0xf
+
+#define EXYNOS850_TMU_CONTROL		(0x20)
+#define EXYNOS850_TMU_CONTROL1		(0x24)
+#define EXYNOS850_TMU_COUNTER_VALUE0	(0x30)
+#define EXYNOS850_TMU_COUNTER_VALUE1	(0x34)
+#define EXYNOS850_TMU_AVG_CONTROL	(0x38)
+#define EXYNOS850_TMU_TRIM0		(0x3c)
+
+#define EXYNOS_TMU_REG_INTPEND0		(0x118)
+#define EXYNOS_TMU_REG_INTPEND5		(0x318)
+#define EXYNOS_TMU_REG_INTPEND8		(0x658)
+
+#define EXYNOS_TMU_REG_INTEN0		(0x110)
+#define EXYNOS_TMU_REG_INTEN5		(0x310)
+#define EXYNOS_TMU_REG_INTEN8		(0x650)
+#define EXYNOS850_RISE_LEVEL1		BIT(1)
+#define EXYNOS850_FALL_LEVEL1		BIT(17)
+
+#define EXYNOS_TMU_REG_THD_TEMP0	(0x50)
+#define EXYNOS_TMU_REG_THD_TEMP1	(0x170)
+#define EXYNOS_TMU_REG_THD_TEMP8	(0x450)
+
+#define EXYNOS850_REG_RISE1_0_OFFSET	(0xc)
+#define EXYNOS850_REG_FALL1_0_OFFSET	(EXYNOS850_REG_RISE1_0_OFFSET + 0x10)
+#define EXYNOS850_THD_LEVEL1_MASK	GENMASK(24, 16)
+
+#define EXYNOS850_TMU_REG_THD(p)	((p == 0) ?					\
+					EXYNOS_TMU_REG_THD_TEMP0 :			\
+					((p < 8) ?					\
+					(EXYNOS_TMU_REG_THD_TEMP1 + (p - 1) * 0x20) :	\
+					(EXYNOS_TMU_REG_THD_TEMP8 + (p - 8) * 0x20)))
+
+#define EXYNOS850_TMU_REG_INTEN(p)	((p < 5) ?					\
+					(EXYNOS_TMU_REG_INTEN0 + p * 0x10) :		\
+					((p < 8) ?					\
+					(EXYNOS_TMU_REG_INTEN5 + (p - 5) * 0x10) :	\
+					(EXYNOS_TMU_REG_INTEN8 + (p - 8) * 0x10)))
+
+#define EXYNOS850_REG_INTPEND(p)	((p < 5) ?					\
+					(EXYNOS_TMU_REG_INTPEND0 + p * 0x10) :		\
+					((p < 8) ?					\
+					(EXYNOS_TMU_REG_INTPEND5 + (p - 5) * 0x10) :	\
+					(EXYNOS_TMU_REG_INTPEND8 + (p - 8) * 0x10)))
+
 #define GS101_CPUCL2_SENSOR_MASK (EXYNOS_TMU_SENSOR(0) |	\
 				  EXYNOS_TMU_SENSOR(6) |	\
 				  EXYNOS_TMU_SENSOR(7) |	\
@@ -69,6 +140,9 @@ struct acpm_tmu_sensor {
 	struct acpm_tmu_priv *priv;
 	struct mutex lock; /* protects sensor state */
 	bool enabled;
+
+	u32 efuse_value;
+	u16 temp_error1, temp_error2;
 };
 
 struct acpm_tmu_priv {
@@ -81,6 +155,7 @@ struct acpm_tmu_priv {
 	unsigned int mbox_chan_id;
 	unsigned int num_sensors;
 	int irq;
+	u32 cal_type;
 	struct acpm_tmu_sensor sensors[] __counted_by(num_sensors);
 };
 
@@ -92,6 +167,7 @@ struct acpm_tmu_driver_data {
 	unsigned int mbox_chan_id;
 
 	/* SoC-specific TMU routines and values */
+	u32 efuse_value;
 	int (*tz_control)(struct acpm_tmu_sensor *sensor, bool on);
 	int (*tmu_check_and_clear_irqs)(struct acpm_tmu_sensor *sensor,
 					bool *pending_irq);
@@ -139,6 +215,40 @@ static const struct regmap_config gs101_regmap_config = {
 	.max_register = GS101_REG_INTPEND(15),
 };
 
+static const struct acpm_tmu_sensor_group exynos850_sensor_groups[] = {
+	ACPM_TMU_SENSOR_GROUP(EXYNOS850_CPUCL0_SENSOR_MASK, 0),
+	ACPM_TMU_SENSOR_GROUP(EXYNOS850_CPUCL1_SENSOR_MASK, 1),
+	ACPM_TMU_SENSOR_GROUP(EXYNOS850_GPU_SENSOR_MASK, 2),
+};
+
+static const struct reg_field exynos850_reg_fields[REG_INTPEND_COUNT] = {
+	[P0_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(0), 0, 23),
+	[P1_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(1), 0, 23),
+	[P2_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(2), 0, 23),
+	[P3_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(3), 0, 23),
+	[P4_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(4), 0, 23),
+	[P5_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(5), 0, 23),
+	[P6_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(6), 0, 23),
+	[P7_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(7), 0, 23),
+	[P8_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(8), 0, 23),
+	[P9_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(9), 0, 23),
+	[P10_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(10), 0, 23),
+	[P11_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(11), 0, 23),
+	[P12_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(12), 0, 23),
+	[P13_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(13), 0, 23),
+	[P14_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(14), 0, 23),
+	[P15_INTPEND] =		REG_FIELD(EXYNOS850_REG_INTPEND(15), 0, 23),
+};
+
+static const struct regmap_config exynos850_regmap_config = {
+	.name = "e850_tmu_regs",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.use_relaxed_mmio = true,
+	.max_register = EXYNOS850_REG_INTPEND(15),
+};
+
 static int gs101_tz_control(struct acpm_tmu_sensor *sensor, bool on)
 {
 	struct acpm_tmu_priv *priv = sensor->priv;
@@ -155,6 +265,129 @@ static int gs101_tmu_init(struct acpm_tmu_priv *priv)
 	return handle->ops->tmu.init(handle, priv->mbox_chan_id);
 }
 
+static int exynos850_tz_control(struct acpm_tmu_sensor *sensor, bool on)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+
+	regmap_update_bits(priv->regmap, EXYNOS850_TMU_CONTROL,
+			   BIT(0), on ? BIT(0) : 0);
+	return 0;
+}
+
+static int exynos850_tmu_init(struct acpm_tmu_priv *priv)
+{
+	struct acpm_handle *handle = priv->handle;
+	struct regmap *regmap = priv->regmap;
+	unsigned int trim_info, trim;
+	unsigned int t_buf_vref_sel, t_buf_slope_sel, avg_mode;
+	unsigned int t_bgri_trim, t_vref_trim, t_vbei_trim;
+	u32 trim0_mask, trim0_val;
+	int ret, i;
+
+	ret = handle->ops->tmu.init(handle, priv->mbox_chan_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * Bootloader may partly initialise TMU or may not initialise it at all,
+	 * regardless of that we do the full TMU initialisation here and
+	 * collect calibration info.
+	 */
+	regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(0), &trim_info);
+	priv->cal_type = FIELD_GET(EXYNOS_TRIMINFO_CALIB_SEL_MASK, trim_info);
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+		unsigned long mask = sensor->group->mask;
+		int t;
+		u16 temp_error1, temp_error2;
+
+		for_each_set_bit(t, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+			regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(t), &trim_info);
+
+			temp_error1 = FIELD_GET(EXYNOS_TRIMINFO_25_MASK, trim_info);
+			temp_error2 = FIELD_GET(EXYNOS_TRIMINFO_85_MASK, trim_info);
+
+			if (temp_error1)
+				sensor->temp_error1 = temp_error1;
+			else
+				sensor->temp_error1 = FIELD_GET(EXYNOS_TRIMINFO_25_MASK,
+								priv->data->efuse_value);
+
+			if (priv->cal_type == TYPE_TWO_POINT_TRIMMING) {
+				if (temp_error1)
+					sensor->temp_error2 = temp_error2;
+				else
+					sensor->temp_error2 = FIELD_GET(EXYNOS_TRIMINFO_85_MASK,
+									priv->data->efuse_value);
+			}
+		}
+	}
+
+	/* Read TRIMINFO 0, 1, 2 settings */
+	regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(0), &trim);
+	t_buf_vref_sel = FIELD_GET(GENMASK(22, 18), trim);
+
+	regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(1), &trim);
+	t_buf_slope_sel = FIELD_GET(GENMASK(21, 18), trim);
+
+	regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(2), &trim);
+	avg_mode = FIELD_GET(GENMASK(20, 18), trim);
+
+	/*
+	 * Set BUF_VREF_SEL and BUF_SLOPE_SEL.
+	 * Clear bit 12 -- disable thermal tripping for now.
+	 * Clear bit 0 -- TMU core off
+	 */
+	regmap_update_bits(regmap, EXYNOS850_TMU_CONTROL,
+			   GENMASK(28, 24) | BIT(12) | GENMASK(11, 8) | BIT(0),
+			   FIELD_PREP(GENMASK(28, 24), t_buf_vref_sel) |
+			   FIELD_PREP(GENMASK(11, 8), t_buf_slope_sel));
+
+	/*
+	 * Set NUM_PROBE equal to number of sensors.
+	 * Disable LPI by clearing bit 10.
+	 */
+	regmap_update_bits(regmap, EXYNOS850_TMU_CONTROL1,
+			   GENMASK(19, 16) | BIT(10),
+			   FIELD_PREP(GENMASK(19, 16), priv->num_sensors));
+
+	/* Set AVG_MODE (If avg_mode > 0, set bit 4 and insert avg_mode into bits [2:0]) */
+	regmap_update_bits(regmap, EXYNOS850_TMU_AVG_CONTROL,
+			   BIT(4) | GENMASK(2, 0),
+			   avg_mode ? (BIT(4) | FIELD_PREP(GENMASK(2, 0), avg_mode)) : 0);
+
+	/* Set COUNTER_VALUE 0 & 1 */
+	regmap_update_bits(regmap, EXYNOS850_TMU_COUNTER_VALUE0,
+			   GENMASK(15, 0), FIELD_PREP(GENMASK(15, 0), 0x028A));
+
+	regmap_update_bits(regmap, EXYNOS850_TMU_COUNTER_VALUE1,
+			   GENMASK(31, 16), FIELD_PREP(GENMASK(31, 16), 0x028A));
+
+	/* Read TRIMINFO 3, 4, 5 for BGR_I/VREF/VBE_I */
+	regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(3), &trim);
+	t_bgri_trim = FIELD_GET(GENMASK(21, 18), trim);
+
+	regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(4), &trim);
+	t_vref_trim = FIELD_GET(GENMASK(21, 18), trim);
+
+	regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(5), &trim);
+	t_vbei_trim = FIELD_GET(GENMASK(21, 18), trim);
+
+	/* Set TRIM0 */
+	trim0_mask = (EXYNOS850_TMU_BGRI_TRIM_MASK << EXYNOS850_TMU_BGRI_TRIM_SHIFT) |
+		     (EXYNOS850_TMU_VREF_TRIM_MASK << EXYNOS850_TMU_VREF_TRIM_SHIFT) |
+		     (EXYNOS850_TMU_VBEI_TRIM_MASK << EXYNOS850_TMU_VBEI_TRIM_SHIFT);
+
+	trim0_val = (t_bgri_trim << EXYNOS850_TMU_BGRI_TRIM_SHIFT) |
+		    (t_vref_trim << EXYNOS850_TMU_VREF_TRIM_SHIFT) |
+		    (t_vbei_trim << EXYNOS850_TMU_VBEI_TRIM_SHIFT);
+
+	regmap_update_bits(regmap, EXYNOS850_TMU_TRIM0, trim0_mask, trim0_val);
+
+	return 0;
+}
+
 static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor *sensor, bool on)
 {
 	struct acpm_tmu_priv *priv = sensor->priv;
@@ -268,6 +501,74 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int temp_to_code(struct acpm_tmu_sensor *sensor, u8 temp)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+
+	if (priv->cal_type == TYPE_TWO_POINT_TRIMMING)
+		return (temp - EXYNOS_FIRST_POINT_TRIM) *
+		       (sensor->temp_error2 - sensor->temp_error1) /
+		       (EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
+		       sensor->temp_error1;
+
+	return temp + sensor->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
+}
+
+static int exynos850_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
+				      u8 thresholds[2], u8 inten)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	unsigned long mask = sensor->group->mask;
+	bool was_enabled;
+	int ret, restore_ret, i, trip_code, trip_code_low;
+	u32 addr;
+
+	guard(mutex)(&sensor->lock);
+
+	was_enabled = sensor->enabled;
+
+	if (was_enabled) {
+		ret = acpm_tmu_op_tz_control(sensor, false);
+		if (ret)
+			return ret;
+	}
+
+	trip_code = temp_to_code(sensor, thresholds[1]);
+	trip_code_low = temp_to_code(sensor, thresholds[0]);
+
+	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+		u32 irq_en = 0;
+
+		if (inten & BIT(0)) {
+			addr = EXYNOS850_TMU_REG_THD(i) + EXYNOS850_REG_FALL1_0_OFFSET;
+			regmap_update_bits(priv->regmap, addr, EXYNOS850_THD_LEVEL1_MASK,
+					   FIELD_PREP(EXYNOS850_THD_LEVEL1_MASK, trip_code_low));
+			irq_en = EXYNOS850_FALL_LEVEL1;
+		}
+
+		if (inten & BIT(1)) {
+			addr = EXYNOS850_TMU_REG_THD(i) + EXYNOS850_REG_RISE1_0_OFFSET;
+			regmap_update_bits(priv->regmap, addr, EXYNOS850_THD_LEVEL1_MASK,
+					   FIELD_PREP(EXYNOS850_THD_LEVEL1_MASK, trip_code));
+			irq_en |= EXYNOS850_RISE_LEVEL1;
+		}
+
+		regmap_update_bits(priv->regmap, EXYNOS850_TMU_REG_INTEN(i),
+				   (EXYNOS850_FALL_LEVEL1 | EXYNOS850_RISE_LEVEL1), irq_en);
+	}
+
+	if (was_enabled) {
+		restore_ret = acpm_tmu_op_tz_control(sensor, true);
+		if (restore_ret)
+			dev_err(priv->dev, "Failed to restore sensor state: %d\n",
+				restore_ret);
+		if (!ret)
+			ret = restore_ret;
+	}
+
+	return 0;
+}
+
 static int gs101_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 				       u8 thresholds[2], u8 inten)
 {
@@ -376,6 +677,36 @@ static int gs101_handle_irqs(struct acpm_tmu_sensor *sensor, bool *pending_irq)
 	return ret;
 }
 
+static int exynos850_handle_irqs(struct acpm_tmu_sensor *sensor,
+				 bool *pending_irq)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	unsigned long mask = sensor->group->mask;
+	int i, ret;
+	u32 val, clear_val;
+
+	guard(mutex)(&sensor->lock);
+
+	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+		ret = regmap_field_read(priv->regmap_fields[i], &val);
+		if (ret)
+			return ret;
+
+		if (val) {
+			clear_val = val &
+				(EXYNOS850_INTPEND_RISE_MASK | EXYNOS850_INTPEND_FALL_MASK);
+			ret = regmap_field_force_write(priv->regmap_fields[i], clear_val);
+			if (ret)
+				dev_err(priv->dev,
+					 "sensor %d: failed to clear IRQ (%d)\n", i, ret);
+			*pending_irq = true;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
 {
 	struct acpm_tmu_priv *priv = id;
@@ -423,11 +754,28 @@ static const struct acpm_tmu_driver_data acpm_tmu_gs101 = {
 	.tmu_update_thresholds = gs101_tmu_update_thresholds,
 };
 
+static const struct acpm_tmu_driver_data acpm_tmu_exynos850 = {
+	.reg_fields = exynos850_reg_fields,
+	.regmap_config = &exynos850_regmap_config,
+	.sensor_groups = exynos850_sensor_groups,
+	.num_sensor_groups = ARRAY_SIZE(exynos850_sensor_groups),
+	.mbox_chan_id = 9,
+	.efuse_value = 55,
+	.tz_control = exynos850_tz_control,
+	.tmu_check_and_clear_irqs = exynos850_handle_irqs,
+	.tmu_init = exynos850_tmu_init,
+	.tmu_update_thresholds = exynos850_tmu_update_thresholds,
+};
+
 static const struct of_device_id acpm_tmu_match[] = {
 	{
 		.compatible = "google,gs101-tmu-top",
 		.data = &acpm_tmu_gs101
 	},
+	{
+		.compatible = "samsung,exynos850-tmu-top",
+		.data = &acpm_tmu_exynos850,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, acpm_tmu_match);
@@ -501,6 +849,13 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to resume device\n");
 
+	/* Sensor groups should be assigned before ->tmu_init() for some SoCs */
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+
+		sensor->group = &data->sensor_groups[i];
+	}
+
 	if (priv->data->tmu_init) {
 		ret = priv->data->tmu_init(priv);
 		if (ret) {
@@ -513,7 +868,6 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
 
 		mutex_init(&sensor->lock);
-		sensor->group = &data->sensor_groups[i];
 		sensor->priv = priv;
 
 		sensor->tzd = devm_thermal_of_zone_register(dev, i, sensor,

-- 
2.51.0


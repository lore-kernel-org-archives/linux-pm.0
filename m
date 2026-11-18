Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009917;
	b=o2TJ1PcJofOXRg7pL6w01CUrH/QayvvmtpwhoX791MyF4ydJjXkepLy9looIFkezECBW
	 DFTw1YZ6yH1J8WIj5SJGHyhhax0N9QENggO5bJ8oai36K9QfTcDqfcDaSXn0MFDW7OdR+
	 XQGtqtZusMGKKNy3b3bTjRuZYDbTGewYGbp8vwBXVKSlKQ7HklsCg3MR5q4HZdvtTtN8e
	 yZcetEk621df4uGr6eCDVBZhS2zQ7fhoRxK43mKLEepuOV81kqGWK4/ajzQF68pZq5REu
	 dojcJXAJMq8n5id4yoVQ/z+tlJqTAgDTkozR1mxsAtWz4++y65qFRa57/pvT/ouxMbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=B9Q9sAYRbahVlvjfV5GFNd+V6JblkA9c+4dDLZl3TFI=;
	b=JtQEaslY2O8KoLpmoeqt642/hW94KX3ajIK712H2NNoCu2OlWqo1Zm5tKwaonLCt8jyJ
	 RtbfU9FQL6vEwovsxhFZbzGSvgfbLZTmtfsLhXATkGG/PBsKeJVMqRii/K4nqN/G9YBMg
	 ruNISRY8cLa8rjG2lx3n7+X94E+EAH5uv24lXZ4ur0UZvEVORs4MtUarnvYs+SBdolDsq
	 kdnPk567bAK6lNVWg1SDA7Sops4oFzBH2NyR63dBdD7SV3L0DHLiPd5wGeL2EXZuk2bmh
	 3Hmt8L5HMXxMMuv+chospMp5fo6VYXDIIROfPkCDxtDvqZX5IFVDwbzrWckR2TW3X2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j3frSGlE;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDD606A339
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DFDD606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j3frSGlE
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb606491faso5562695e9.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795009914; x=1795614714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9Q9sAYRbahVlvjfV5GFNd+V6JblkA9c+4dDLZl3TFI=;
        b=j3frSGlENZssxpezYKrVcoYqCJiZ9NmlUHkTmdTqXRmY6yWZzvF4u96Lv42yn/hbU5
         mGqWTvq17o440S5GAySGsQj+e5YA6ly+733N8HTfdSNqbJDICH8SsSOoN2QegtnNmka+
         usu31ZhxWy3pOT8m5NW1zHj7Qpem6RerGZOa5lxx90BZjKIQrPxjUQ24yRYXY5FqWKOR
         j9lw2CsEbaFVGaP8wbpbuisJBValSEtsgcoGePuHdty/ISPBGi3C/21uixp8WqPaNqqE
         s+IPVBCnqnj0r0oZCmEZRW/pO1DPDTKkVS9rz5IQhlhqRFVD4+pXbfdQQHFN1cfEvB7t
         fyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009914; x=1795614714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B9Q9sAYRbahVlvjfV5GFNd+V6JblkA9c+4dDLZl3TFI=;
        b=V7/wPsRKxbNndlT5uG6pHlP+K3NT6DMMn+GKL91I5ZzDnpx3WaRMuLhdtYP1rdgXII
         NTL7/Hgty+ZmOTibTz0rpuBXH+sGxaEDMh/u92OwSZj7W12bL4FqWtkLQ/PztOQFSicV
         3N478PbrZQLH040Jd7CkyB5BUKec/DqJWZ2oxnCOROZRn7AhX4WD0mliHw/b5WJn53+I
         rqKse0SfsLSVCkxCwgOsSWP/5RoVnRMklSr059w4uz6gP+krKHBTvBWoqXs1IPOQDkcS
         jFXuNGdAXKrjJwgGq1BVK8+ScVpgJo4TKT9FsGW+igH6/V3P99kfMLQM4OXZOqqrUuwa
         HaUg==
X-Forwarded-Encrypted: i=1; AL+hErFtowDkhG58fP09DW8q24W9hXW4kP7TJKVSmqvqa6RwZXcSAYWKQ5SOC5L4iqjLh8trBpZkqogIfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+C02KBtQkhl1B92NUpnIjWEYcWHNxry1BAjDI+7SVOgJaTUICH
	08LnE+nFNuVy3yI0Iqrnhp7j5EhJAxPeg/84Jt+dnlFHtLJnmBCIwz0PdDvzlOqMAN4=
X-Gm-Gg: AYBFou3/SmsayoTxuumAqRLtTWd4QJxdmFlKdXxSyW9DbvFEQPwe4kelSAsLTF6C4c7
	JVy58Tgc2mfuhuiMISj9x85XgHIh0Le1u/WNs0Tk5ZbPs9AcvSiyEd6OGRLjolQn0o2QmIVwtGp
	VFs2ym1ckr3B0BhWGQEOVYVTYC7XLjCuJZiCtoAoCjKYjudPSettj9YB4RRyOLclRlKu3Mi1v40
	cBvdvvWxaroSpwsew1DRZNki/ZIu/xuwES8r/Ye5jSxtd1oAVvNyKVIqPy2dfDCcE3+hRgv9O/K
	ZAt2pUj99B8oOJjWtncPlKWI8zZwCSRI9GNCSBRIY1mh8kNe2glIAEsbFMNdzrj+fEUi2oqUb7a
	ZyQG4T3JrgXgcK3Jpv95hEUw+Hs1MUCI30W9SypN11Tm3H/7EjVgOOy0pBm5vl6DP3CO7wUi21p
	3eBHfH7GYNj803I7swdmCw1i7tWW5FRnE+8MFlMFQvjmokY0GTwzkdCqHtkR5xXT3ifFgr8O0AD
	XPntHyAH43TzkT7Exjz8m0MtFYU2+LLp/+9WhjCuB8WnuG7hd4T1k0cLs2G3L3BaC4SBQODlD8Z
	eLV0PnVAJgoV0AQ3P5tAlHqU9VI+5hfaswVbYD/ELUwXwhrKds2UT0jd3ab1P88FhzpjtyJXbma
	M+2uD4rRAnea6ivHdiUoq+Y8=
X-Received: by 2002:a05:600c:3b17:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4bb7da49f4emr46645265e9.35.1795009914440;
        Wed, 18 Nov 2026 05:51:54 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:80a3:e955:3785:90b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm208544775e9.10.2026.11.18.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:51:53 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 18 Nov 2026 13:51:47 +0000
Subject: [PATCH v2 3/3] thermal: samsung: acpm-tmu: add Exynos850 support
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-acpm-tmu-e850-support-v2-3-19848c0d97e5@linaro.org>
References: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
In-Reply-To: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, 
 Thomas Turner <tturner@lineageos.org>, 
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
 drivers/thermal/samsung/acpm-tmu.c | 481 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 480 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 0def0ec09084..054c99dc8250 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -5,6 +5,7 @@
  * Copyright 2026 Linaro Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/compiler.h>
@@ -27,6 +28,120 @@
 #define EXYNOS_TMU_SENSOR(i)		BIT(i)
 #define EXYNOS_TMU_SENSORS_MAX_COUNT	16
 
+/*
+ * Exynos850 TMU calibration type stored in the TRIMINFO CALIB_SEL field.
+ * Only two-point calibration needs special handling; anything else is
+ * treated as one-point calibration.
+ */
+#define EXYNOS850_TMU_CAL_TWO_POINT	1
+
+#define EXYNOS850_TMU_TRIM_TEMP_25C	25
+#define EXYNOS850_TMU_TRIM_TEMP_85C	85
+#define EXYNOS850_TMU_EFUSE_VALUE	55
+
+#define EXYNOS850_TMU_INTPEND_RISE_MASK	GENMASK(8, 0)
+#define EXYNOS850_TMU_INTPEND_FALL_MASK	GENMASK(23, 16)
+
+#define EXYNOS850_CPUCL0_SENSOR_MASK	EXYNOS_TMU_SENSOR(1)
+#define EXYNOS850_CPUCL1_SENSOR_MASK	EXYNOS_TMU_SENSOR(2)
+#define EXYNOS850_GPU_SENSOR_MASK	EXYNOS_TMU_SENSOR(3)
+
+/* Exynos850 TMU registers */
+#define EXYNOS850_TMU_REG_TRIMINFO	0x00
+#define EXYNOS850_TMU_TRIMINFO_STRIDE	0x04
+#define EXYNOS850_TMU_TRIMINFO_OFFSET(n)	\
+	(EXYNOS850_TMU_REG_TRIMINFO + (n) * EXYNOS850_TMU_TRIMINFO_STRIDE)
+
+#define EXYNOS850_TMU_REG_CONTROL	0x20
+#define EXYNOS850_TMU_REG_CONTROL1	0x24
+#define EXYNOS850_TMU_REG_COUNTER_VALUE0	0x30
+#define EXYNOS850_TMU_REG_COUNTER_VALUE1	0x34
+#define EXYNOS850_TMU_REG_AVG_CONTROL	0x38
+#define EXYNOS850_TMU_REG_TRIM0		0x3c
+
+#define EXYNOS850_TMU_REG_INTPEND0	0x118
+#define EXYNOS850_TMU_REG_INTPEND5	0x318
+#define EXYNOS850_TMU_REG_INTPEND8	0x658
+
+#define EXYNOS850_TMU_REG_INTEN0	0x110
+#define EXYNOS850_TMU_REG_INTEN5	0x310
+#define EXYNOS850_TMU_REG_INTEN8	0x650
+
+#define EXYNOS850_TMU_REG_THD0		0x50
+#define EXYNOS850_TMU_REG_THD1		0x170
+#define EXYNOS850_TMU_REG_THD8		0x450
+
+#define EXYNOS850_TMU_INT_REG_STRIDE	0x10
+#define EXYNOS850_TMU_THD_REG_STRIDE	0x20
+
+/* TRIMINFO fields */
+#define EXYNOS850_TMU_TRIMINFO_CALIB_SEL	BIT(23)
+#define EXYNOS850_TMU_TRIMINFO_25C_MASK		GENMASK(8, 0)
+#define EXYNOS850_TMU_TRIMINFO_85C_MASK		GENMASK(17, 9)
+#define EXYNOS850_TMU_TRIMINFO_BUF_VREF_SEL	GENMASK(22, 18)
+#define EXYNOS850_TMU_TRIMINFO_BUF_SLOPE_SEL	GENMASK(21, 18)
+#define EXYNOS850_TMU_TRIMINFO_AVG_MODE		GENMASK(20, 18)
+#define EXYNOS850_TMU_TRIMINFO_ANALOG_TRIM	GENMASK(21, 18)
+
+/* CONTROL fields */
+#define EXYNOS850_TMU_CONTROL_CORE_EN		BIT(0)
+#define EXYNOS850_TMU_CONTROL_BUF_SLOPE_SEL	GENMASK(11, 8)
+#define EXYNOS850_TMU_CONTROL_THERM_TRIP_EN	BIT(12)
+#define EXYNOS850_TMU_CONTROL_BUF_VREF_SEL	GENMASK(28, 24)
+
+/* CONTROL1 fields */
+#define EXYNOS850_TMU_CONTROL1_NUM_PROBE	GENMASK(19, 16)
+#define EXYNOS850_TMU_CONTROL1_LPI		BIT(10)
+
+/* AVG_CONTROL fields */
+#define EXYNOS850_TMU_AVG_CONTROL_EN		BIT(4)
+#define EXYNOS850_TMU_AVG_CONTROL_MODE		GENMASK(2, 0)
+
+/* COUNTER_VALUE0/1 fields */
+#define EXYNOS850_TMU_COUNTER_VALUE0_MASK	GENMASK(15, 0)
+#define EXYNOS850_TMU_COUNTER_VALUE1_MASK	GENMASK(31, 16)
+/* Measurement counter value recommended by the TRM */
+#define EXYNOS850_TMU_COUNTER_VALUE		0x028a
+
+/* TRIM0 fields */
+#define EXYNOS850_TMU_TRIM0_BGRI		GENMASK(23, 20)
+#define EXYNOS850_TMU_TRIM0_VREF		GENMASK(15, 12)
+#define EXYNOS850_TMU_TRIM0_VBEI		GENMASK(11, 8)
+
+/* THD and INTEN fields */
+#define EXYNOS850_TMU_THD_RISE1_OFFSET		0x0c
+#define EXYNOS850_TMU_THD_FALL1_OFFSET		\
+	(EXYNOS850_TMU_THD_RISE1_OFFSET + 0x10)
+#define EXYNOS850_TMU_THD_LEVEL1_MASK		GENMASK(24, 16)
+#define EXYNOS850_TMU_INTEN_RISE1		BIT(1)
+#define EXYNOS850_TMU_INTEN_FALL1		BIT(17)
+
+#define EXYNOS850_TMU_REG_THD(p)					\
+	((p) == 0 ? EXYNOS850_TMU_REG_THD0 :				\
+	 ((p) < 8 ?							\
+	  EXYNOS850_TMU_REG_THD1 +					\
+	  ((p) - 1) * EXYNOS850_TMU_THD_REG_STRIDE :			\
+	  EXYNOS850_TMU_REG_THD8 +					\
+	  ((p) - 8) * EXYNOS850_TMU_THD_REG_STRIDE))
+
+#define EXYNOS850_TMU_REG_INTEN(p)					\
+	((p) < 5 ?							\
+	 EXYNOS850_TMU_REG_INTEN0 + (p) * EXYNOS850_TMU_INT_REG_STRIDE : \
+	 ((p) < 8 ?							\
+	  EXYNOS850_TMU_REG_INTEN5 +					\
+	  ((p) - 5) * EXYNOS850_TMU_INT_REG_STRIDE :			\
+	  EXYNOS850_TMU_REG_INTEN8 +					\
+	  ((p) - 8) * EXYNOS850_TMU_INT_REG_STRIDE))
+
+#define EXYNOS850_TMU_REG_INTPEND(p)					\
+	((p) < 5 ?							\
+	 EXYNOS850_TMU_REG_INTPEND0 + (p) * EXYNOS850_TMU_INT_REG_STRIDE : \
+	 ((p) < 8 ?							\
+	  EXYNOS850_TMU_REG_INTPEND5 +					\
+	  ((p) - 5) * EXYNOS850_TMU_INT_REG_STRIDE :			\
+	  EXYNOS850_TMU_REG_INTPEND8 +					\
+	  ((p) - 8) * EXYNOS850_TMU_INT_REG_STRIDE))
+
 #define GS101_CPUCL2_SENSOR_MASK (EXYNOS_TMU_SENSOR(0) |	\
 				  EXYNOS_TMU_SENSOR(6) |	\
 				  EXYNOS_TMU_SENSOR(7) |	\
@@ -71,6 +186,8 @@ struct acpm_tmu_sensor {
 	struct mutex lock; /* protects sensor state */
 	enum thermal_device_mode mode;
 	bool enabled;
+
+	u16 temp_error1, temp_error2;
 };
 
 struct acpm_tmu_priv {
@@ -83,6 +200,7 @@ struct acpm_tmu_priv {
 	unsigned int mbox_chan_id;
 	unsigned int num_sensors;
 	int irq;
+	u32 cal_type;
 	struct acpm_tmu_sensor sensors[] __counted_by(num_sensors);
 };
 
@@ -94,6 +212,7 @@ struct acpm_tmu_driver_data {
 	unsigned int mbox_chan_id;
 
 	/* SoC-specific TMU routines and values */
+	u32 efuse_value;
 	int (*tz_control)(struct acpm_tmu_sensor *sensor, bool on);
 	int (*tmu_check_and_clear_irqs)(struct acpm_tmu_sensor *sensor,
 					bool *pending_irq);
@@ -142,6 +261,40 @@ static const struct regmap_config gs101_regmap_config = {
 	.max_register = GS101_REG_INTPEND(15),
 };
 
+static const struct acpm_tmu_sensor_group exynos850_sensor_groups[] = {
+	ACPM_TMU_SENSOR_GROUP(EXYNOS850_CPUCL0_SENSOR_MASK, 0),
+	ACPM_TMU_SENSOR_GROUP(EXYNOS850_CPUCL1_SENSOR_MASK, 1),
+	ACPM_TMU_SENSOR_GROUP(EXYNOS850_GPU_SENSOR_MASK, 2),
+};
+
+static const struct reg_field exynos850_reg_fields[REG_INTPEND_COUNT] = {
+	[P0_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(0), 0, 23),
+	[P1_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(1), 0, 23),
+	[P2_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(2), 0, 23),
+	[P3_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(3), 0, 23),
+	[P4_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(4), 0, 23),
+	[P5_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(5), 0, 23),
+	[P6_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(6), 0, 23),
+	[P7_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(7), 0, 23),
+	[P8_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(8), 0, 23),
+	[P9_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(9), 0, 23),
+	[P10_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(10), 0, 23),
+	[P11_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(11), 0, 23),
+	[P12_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(12), 0, 23),
+	[P13_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(13), 0, 23),
+	[P14_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(14), 0, 23),
+	[P15_INTPEND] =		REG_FIELD(EXYNOS850_TMU_REG_INTPEND(15), 0, 23),
+};
+
+static const struct regmap_config exynos850_regmap_config = {
+	.name = "exynos850_tmu_regs",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.use_relaxed_mmio = true,
+	.max_register = EXYNOS850_TMU_REG_INTPEND(15),
+};
+
 static int gs101_tz_control(struct acpm_tmu_sensor *sensor, bool on)
 {
 	struct acpm_tmu_priv *priv = sensor->priv;
@@ -158,6 +311,190 @@ static int gs101_tmu_init(struct acpm_tmu_priv *priv)
 	return handle->ops->tmu.init(handle, priv->mbox_chan_id);
 }
 
+static int exynos850_tz_control(struct acpm_tmu_sensor *sensor, bool on)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+
+	return regmap_update_bits(priv->regmap, EXYNOS850_TMU_REG_CONTROL,
+				  EXYNOS850_TMU_CONTROL_CORE_EN,
+				  on ? EXYNOS850_TMU_CONTROL_CORE_EN : 0);
+}
+
+static int exynos850_tmu_read_trim_info(struct acpm_tmu_priv *priv)
+{
+	struct regmap *regmap = priv->regmap;
+	unsigned int trim_info;
+	int i, ret;
+
+	ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(0), &trim_info);
+	if (ret)
+		return ret;
+
+	priv->cal_type = FIELD_GET(EXYNOS850_TMU_TRIMINFO_CALIB_SEL, trim_info);
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+		unsigned long mask = sensor->group->mask;
+		int t;
+
+		for_each_set_bit(t, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+			u16 temp_error1, temp_error2;
+
+			ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(t),
+					  &trim_info);
+			if (ret)
+				return ret;
+
+			temp_error1 = FIELD_GET(EXYNOS850_TMU_TRIMINFO_25C_MASK,
+						trim_info);
+			temp_error2 = FIELD_GET(EXYNOS850_TMU_TRIMINFO_85C_MASK,
+						trim_info);
+
+			if (temp_error1)
+				sensor->temp_error1 = temp_error1;
+			else
+				sensor->temp_error1 =
+					FIELD_GET(EXYNOS850_TMU_TRIMINFO_25C_MASK,
+						  priv->data->efuse_value);
+
+			if (priv->cal_type != EXYNOS850_TMU_CAL_TWO_POINT)
+				continue;
+
+			if (temp_error2)
+				sensor->temp_error2 = temp_error2;
+			else
+				sensor->temp_error2 =
+					FIELD_GET(EXYNOS850_TMU_TRIMINFO_85C_MASK,
+						  priv->data->efuse_value);
+		}
+	}
+
+	return 0;
+}
+
+static int exynos850_tmu_init(struct acpm_tmu_priv *priv)
+{
+	struct acpm_handle *handle = priv->handle;
+	struct regmap *regmap = priv->regmap;
+	unsigned int trim, t_buf_vref_sel, t_buf_slope_sel, avg_mode;
+	unsigned int t_bgri_trim, t_vref_trim, t_vbei_trim;
+	unsigned int avg_mode_val = 0;
+	u32 trim0_mask, trim0_val;
+	int ret;
+
+	ret = handle->ops->tmu.init(handle, priv->mbox_chan_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * The bootloader may have partially initialized the TMU or not
+	 * initialized it at all, so always perform the full initialization.
+	 */
+	ret = exynos850_tmu_read_trim_info(priv);
+	if (ret)
+		return ret;
+
+	/* Read TRIMINFO 0, 1, 2 settings */
+	ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(0), &trim);
+	if (ret)
+		return ret;
+	t_buf_vref_sel = FIELD_GET(EXYNOS850_TMU_TRIMINFO_BUF_VREF_SEL, trim);
+
+	ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(1), &trim);
+	if (ret)
+		return ret;
+	t_buf_slope_sel = FIELD_GET(EXYNOS850_TMU_TRIMINFO_BUF_SLOPE_SEL, trim);
+
+	ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(2), &trim);
+	if (ret)
+		return ret;
+	avg_mode = FIELD_GET(EXYNOS850_TMU_TRIMINFO_AVG_MODE, trim);
+
+	/*
+	 * Set BUF_VREF_SEL and BUF_SLOPE_SEL.
+	 * Clear THERM_TRIP_EN -- disable thermal tripping for now.
+	 * Clear CORE_EN -- TMU core off.
+	 */
+	ret = regmap_update_bits(regmap, EXYNOS850_TMU_REG_CONTROL,
+				 EXYNOS850_TMU_CONTROL_BUF_VREF_SEL |
+				 EXYNOS850_TMU_CONTROL_THERM_TRIP_EN |
+				 EXYNOS850_TMU_CONTROL_BUF_SLOPE_SEL |
+				 EXYNOS850_TMU_CONTROL_CORE_EN,
+				 FIELD_PREP(EXYNOS850_TMU_CONTROL_BUF_VREF_SEL,
+					    t_buf_vref_sel) |
+				 FIELD_PREP(EXYNOS850_TMU_CONTROL_BUF_SLOPE_SEL,
+					    t_buf_slope_sel));
+	if (ret)
+		return ret;
+
+	/*
+	 * Set NUM_PROBE equal to the number of sensors.
+	 * Disable LPI by clearing CONTROL1_LPI.
+	 */
+	ret = regmap_update_bits(regmap, EXYNOS850_TMU_REG_CONTROL1,
+				 EXYNOS850_TMU_CONTROL1_NUM_PROBE |
+				 EXYNOS850_TMU_CONTROL1_LPI,
+				 FIELD_PREP(EXYNOS850_TMU_CONTROL1_NUM_PROBE,
+					    priv->num_sensors));
+	if (ret)
+		return ret;
+
+	/* Set AVG_MODE: enable averaging if the AVG_MODE field is non-zero. */
+	if (avg_mode)
+		avg_mode_val = EXYNOS850_TMU_AVG_CONTROL_EN |
+			       FIELD_PREP(EXYNOS850_TMU_AVG_CONTROL_MODE,
+					  avg_mode);
+
+	ret = regmap_update_bits(regmap, EXYNOS850_TMU_REG_AVG_CONTROL,
+				 EXYNOS850_TMU_AVG_CONTROL_EN |
+				 EXYNOS850_TMU_AVG_CONTROL_MODE,
+				 avg_mode_val);
+	if (ret)
+		return ret;
+
+	/* Set COUNTER_VALUE 0 & 1 */
+	ret = regmap_update_bits(regmap, EXYNOS850_TMU_REG_COUNTER_VALUE0,
+				 EXYNOS850_TMU_COUNTER_VALUE0_MASK,
+				 FIELD_PREP(EXYNOS850_TMU_COUNTER_VALUE0_MASK,
+					    EXYNOS850_TMU_COUNTER_VALUE));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, EXYNOS850_TMU_REG_COUNTER_VALUE1,
+				 EXYNOS850_TMU_COUNTER_VALUE1_MASK,
+				 FIELD_PREP(EXYNOS850_TMU_COUNTER_VALUE1_MASK,
+					    EXYNOS850_TMU_COUNTER_VALUE));
+	if (ret)
+		return ret;
+
+	/* Read TRIMINFO 3, 4, 5 for BGR_I/VREF/VBE_I */
+	ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(3), &trim);
+	if (ret)
+		return ret;
+	t_bgri_trim = FIELD_GET(EXYNOS850_TMU_TRIMINFO_ANALOG_TRIM, trim);
+
+	ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(4), &trim);
+	if (ret)
+		return ret;
+	t_vref_trim = FIELD_GET(EXYNOS850_TMU_TRIMINFO_ANALOG_TRIM, trim);
+
+	ret = regmap_read(regmap, EXYNOS850_TMU_TRIMINFO_OFFSET(5), &trim);
+	if (ret)
+		return ret;
+	t_vbei_trim = FIELD_GET(EXYNOS850_TMU_TRIMINFO_ANALOG_TRIM, trim);
+
+	/* Set TRIM0 */
+	trim0_mask = EXYNOS850_TMU_TRIM0_BGRI |
+		     EXYNOS850_TMU_TRIM0_VREF |
+		     EXYNOS850_TMU_TRIM0_VBEI;
+	trim0_val = FIELD_PREP(EXYNOS850_TMU_TRIM0_BGRI, t_bgri_trim) |
+		    FIELD_PREP(EXYNOS850_TMU_TRIM0_VREF, t_vref_trim) |
+		    FIELD_PREP(EXYNOS850_TMU_TRIM0_VBEI, t_vbei_trim);
+
+	return regmap_update_bits(regmap, EXYNOS850_TMU_REG_TRIM0,
+				  trim0_mask, trim0_val);
+}
+
 static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor *sensor, bool on)
 {
 	struct acpm_tmu_priv *priv = sensor->priv;
@@ -246,6 +583,90 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int exynos850_temp_to_code(struct acpm_tmu_sensor *sensor, u8 temp)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+
+	if (priv->cal_type == EXYNOS850_TMU_CAL_TWO_POINT)
+		return (temp - EXYNOS850_TMU_TRIM_TEMP_25C) *
+		       (sensor->temp_error2 - sensor->temp_error1) /
+		       (EXYNOS850_TMU_TRIM_TEMP_85C -
+			EXYNOS850_TMU_TRIM_TEMP_25C) +
+		       sensor->temp_error1;
+
+	return temp + sensor->temp_error1 - EXYNOS850_TMU_TRIM_TEMP_25C;
+}
+
+static int exynos850_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
+					   u8 thresholds[2], u8 inten)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	unsigned long mask = sensor->group->mask;
+	bool was_enabled;
+	int ret = 0, restore_ret, i, trip_code, trip_code_low;
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
+	trip_code = exynos850_temp_to_code(sensor, thresholds[1]);
+	trip_code_low = exynos850_temp_to_code(sensor, thresholds[0]);
+
+	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+		u32 irq_en = 0;
+
+		if (inten & BIT(0)) {
+			addr = EXYNOS850_TMU_REG_THD(i) +
+			       EXYNOS850_TMU_THD_FALL1_OFFSET;
+			ret = regmap_update_bits(priv->regmap, addr,
+						 EXYNOS850_TMU_THD_LEVEL1_MASK,
+						 FIELD_PREP(EXYNOS850_TMU_THD_LEVEL1_MASK,
+							    trip_code_low));
+			if (ret)
+				goto out_restore;
+			irq_en = EXYNOS850_TMU_INTEN_FALL1;
+		}
+
+		if (inten & BIT(1)) {
+			addr = EXYNOS850_TMU_REG_THD(i) +
+			       EXYNOS850_TMU_THD_RISE1_OFFSET;
+			ret = regmap_update_bits(priv->regmap, addr,
+						 EXYNOS850_TMU_THD_LEVEL1_MASK,
+						 FIELD_PREP(EXYNOS850_TMU_THD_LEVEL1_MASK,
+							    trip_code));
+			if (ret)
+				goto out_restore;
+			irq_en |= EXYNOS850_TMU_INTEN_RISE1;
+		}
+
+		ret = regmap_update_bits(priv->regmap, EXYNOS850_TMU_REG_INTEN(i),
+					 EXYNOS850_TMU_INTEN_FALL1 |
+					 EXYNOS850_TMU_INTEN_RISE1, irq_en);
+		if (ret)
+			goto out_restore;
+	}
+
+out_restore:
+	if (was_enabled) {
+		restore_ret = acpm_tmu_op_tz_control(sensor, true);
+		if (restore_ret) {
+			dev_err(priv->dev, "Failed to restore sensor state: %d\n",
+				restore_ret);
+			if (!ret)
+				ret = restore_ret;
+		}
+	}
+
+	return ret;
+}
+
 static int gs101_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 				       u8 thresholds[2], u8 inten)
 {
@@ -390,6 +811,41 @@ static int gs101_handle_irqs(struct acpm_tmu_sensor *sensor, bool *pending_irq)
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
+				(EXYNOS850_TMU_INTPEND_RISE_MASK |
+				 EXYNOS850_TMU_INTPEND_FALL_MASK);
+			ret = regmap_field_force_write(priv->regmap_fields[i],
+						       clear_val);
+			if (ret) {
+				dev_err_ratelimited(priv->dev,
+						    "sensor %d: failed to clear IRQ: %d\n",
+						    i, ret);
+				return ret;
+			}
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
@@ -437,11 +893,28 @@ static const struct acpm_tmu_driver_data acpm_tmu_gs101 = {
 	.tmu_update_thresholds = gs101_tmu_update_thresholds,
 };
 
+static const struct acpm_tmu_driver_data acpm_tmu_exynos850 = {
+	.reg_fields = exynos850_reg_fields,
+	.regmap_config = &exynos850_regmap_config,
+	.sensor_groups = exynos850_sensor_groups,
+	.num_sensor_groups = ARRAY_SIZE(exynos850_sensor_groups),
+	.mbox_chan_id = 9,
+	.efuse_value = EXYNOS850_TMU_EFUSE_VALUE,
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
@@ -513,6 +986,13 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 	if (ret)
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
@@ -526,7 +1006,6 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		struct thermal_zone_device *tzd;
 
 		mutex_init(&sensor->lock);
-		sensor->group = &data->sensor_groups[i];
 		sensor->priv = priv;
 
 		tzd = devm_thermal_of_zone_register(dev, i, sensor,

-- 
2.53.0


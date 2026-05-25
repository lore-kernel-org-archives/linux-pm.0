Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA6381AE6
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713435; cv=none; b=MvrKZGuTEI9T0SziOl3GK7dF13bNWrfO+6Pt/b3nCQtDKekwA1vu82FAiDrRn13A79OwZXjXeqzWSUgIdzIG2GimyJdDW9GuQoRaVgs3xFRyz/Y4E8zLb6IsBglfnY4QWlYBM1PVmQJCdTok83kz2qtX0U0AlVgjvsA8uqXUIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713435; c=relaxed/simple;
	bh=RghTm9nn3Z1bLgEKIHg5Mlfb92Glx51GU4wS21jsGRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoVbGzrnB57XYhwtblI+YeZuF5ILqeOXUxrM4Ul76jTKSo8YyAxfboSkb8ck5Wzbq0Ieact6XfvOdf2xKnv+wq2DCA2LZm95WDSQT9K5hUErkY9J8xJlryKKwai90swzCur1wLE/RoyZdGxYlskZ9PepLFqnZoMEDGRMF9hXaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rLibDv0S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLibDv0S"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso6506415e9.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779713430; x=1780318230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYj5EDl/St0Ee72HRIu4/l7QlcgWHNfAnJ2QZQDj3zQ=;
        b=rLibDv0SCEOZx5Uhwj1Xc68shEK/y6sZQKjhZnaR84k45ZvpmmXEkj3R/1wB6FHAbq
         xIlWl7d0e1hu7Pagz8G/JmJ61RgjVnVjUrZjH7KGXcwY7do2PTYVgOrrl5yIUZfIuMJS
         /syKBdzr+E/GneksT7LY+AMs/rRvGXYWnr7aX+NvQlmxbk0HUkzzBQgFnb+VBn3MbbE4
         BJCyeMVzS95WDETV33TRDPiFGPu+503aZ3M4qbN7P9pZ0+oAeW20pi6bkTk1zPg5V6ax
         sc46L/dlvd+e4R6TOeq9pc6/U+RMrOyKAO6/yhkPebNUCg97XPlyfYoBoAHcGEN1khyJ
         btuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713430; x=1780318230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OYj5EDl/St0Ee72HRIu4/l7QlcgWHNfAnJ2QZQDj3zQ=;
        b=rm8WqOpMFdxXjkOVLfnRwd2sLtBOwRSEsCquu2fXSLWQfDbI7cDB1FgrXOa6KYGf9Z
         e6PVos6BQT2zX7HWB6go7A4vQLeA3IxY5b3kA0DIrnsv6OvGTIyNoEVhYDE5SEWlF+7D
         lrOs55QWi6FJL1BEA797aVNJK7MnVJDMdUSCaGjLvMlCA1bj4p/D/Edc9NCJ8Tv26BVO
         UCnJWyv5/wGUb0MmDdY7xQoI4/1yJY4C1xq55oVhUmwx6oQtdEtUgly8hu3GDQ904NUe
         ZpIEAjtdPHdIiKgfHnjUG1dDBR3vrejkbkFTVndceguy6H/NfUms/iV7N2RFMRnXnGp/
         7Riw==
X-Forwarded-Encrypted: i=1; AFNElJ9iAdG29buhj5iZKLbMCQW6r5tOV6koo+UZjvLhg5pQd7QqBdyP2jVqgWTyzmYx7tdDsEbNf7rA4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNyfg/+pDhUE6VYFChTuTfrWfl7O3uSLneFprgkYqIqUz5zbY
	yNCmn+akBRpbMlT9N6aRijA1bXr6kpFM+yBiEO49u6VfsI/S1Ey7/DZ+b9Iy5YabKgU=
X-Gm-Gg: Acq92OErR8nNRpzFpc3H0ss2XZNJtZHSOVNuxptDWl5yl1WhS0DJrzdkiYMpYIwzant
	IviNRFUMKTof369UlHSTF8aNByT4ZdhdYm+QkA2eyIUjVnfcixNIox4tu/dVNUETWOy1TEdmb71
	Gi+RIju3t7+SkX2/EYnawsNyKcAL/krPt04qY5yNWZ3QCl69d35Nz+VSIJM1RglBcDf42qNW/md
	sOHK0sJB0W5/d2ytTjjalwFTtL75BzrCIze50e08xyeS3nehX1ZczKJvqvpD1vzfiNQYeibp/bH
	JIMF4nmBOkm8OMbht4QsJqZlLKL3TLH9jcC8TRWnCEf5F6eGvc3Ubn40c+F/I1pG6NEDJXa9ioZ
	7+/qSFE0yXBSQA/9fgo6qzRY5zutui8TWNzlFysCt9usyFdfSt/DeXrRBrC+WLnW2KuqEfaNB0H
	0rrn3g6gzlarOqzyr9mx9L757pKjH4MWSREJLSILaSt9OZS3OU0l7j7mZ+CXv3z95Dr6oMnstI+
	1PzzgU=
X-Received: by 2002:a05:600c:1d0d:b0:490:601f:d788 with SMTP id 5b1f17b1804b1-490601fd8bamr99224455e9.5.1779713430082;
        Mon, 25 May 2026 05:50:30 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm241824825e9.4.2026.05.25.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:50:29 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 25 May 2026 12:50:22 +0000
Subject: [PATCH v5 2/5] thermal: samsung: Add Exynos ACPM TMU driver GS101
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-acpm-tmu-v5-2-85fde739752e@linaro.org>
References: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
In-Reply-To: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779713428; l=17724;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=RghTm9nn3Z1bLgEKIHg5Mlfb92Glx51GU4wS21jsGRw=;
 b=f/6BAEweD7+4psiV+aCDjrUIHo5QzbLFwRZWdsxLtShGCyG7hcEGUy1D3pcZFEO6/RSTpMUBN
 76G+A0a+YN6CBLQFFTazsFlxjp8tu3Q+ptML8MKEtvlZ95cyWtugMkS
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add driver for the Thermal Management Unit (TMU) managed via the Alive
Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
Google GS101 (and Exynos850, autov920, etc.).

The TMU on utilizes a hybrid management model shared between the
Application Processor (AP) and the ACPM firmware. The driver maintains
direct memory-mapped access to the TMU interrupt pending registers to
identify thermal events, while delegating functional tasks - such as
sensor initialization, threshold configuration, and temperature
acquisition - to the ACPM firmware via the ACPM IPC protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/thermal/samsung/Kconfig    |  17 ++
 drivers/thermal/samsung/Makefile   |   2 +
 drivers/thermal/samsung/acpm-tmu.c | 547 +++++++++++++++++++++++++++++++++++++
 3 files changed, 566 insertions(+)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index f4eff5a41a84..0d3ffbdc66f0 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -9,3 +9,20 @@ config EXYNOS_THERMAL
 	  the TMU, reports temperature and handles cooling action if defined.
 	  This driver uses the Exynos core thermal APIs and TMU configuration
 	  data from the supported SoCs.
+
+config EXYNOS_ACPM_THERMAL
+	tristate "Exynos ACPM thermal management unit driver"
+	depends on THERMAL_OF
+	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)
+	help
+	  Support for the Thermal Management Unit (TMU) on Samsung Exynos SoCs
+	  (such as Google GS101 and Exynos850).
+
+	  The TMU on these platforms is managed through a hybrid architecture.
+	  This driver handles direct register access for thermal interrupt status
+	  monitoring and communicates with the Alive Clock and Power Manager
+	  (ACPM) firmware via the ACPM IPC protocol for functional sensor control
+	  and configuration.
+
+	  Select this if you want to monitor device temperature and enable
+	  thermal mitigation on Samsung Exynos ACPM based devices.
diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makefile
index f139407150d2..daed80647c34 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -4,3 +4,5 @@
 #
 obj-$(CONFIG_EXYNOS_THERMAL)			+= exynos_thermal.o
 exynos_thermal-y				:= exynos_tmu.o
+obj-$(CONFIG_EXYNOS_ACPM_THERMAL)		+= exynos_acpm_thermal.o
+exynos_acpm_thermal-y				:= acpm-tmu.o
diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
new file mode 100644
index 000000000000..d4e42b23c0c1
--- /dev/null
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2019 Samsung Electronics Co., Ltd.
+ * Copyright 2025 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "../thermal_hwmon.h"
+
+#define EXYNOS_TMU_SENSOR(i)		BIT(i)
+#define EXYNOS_TMU_SENSORS_MAX_COUNT	16
+
+#define GS101_CPUCL2_SENSOR_MASK (EXYNOS_TMU_SENSOR(0) |	\
+				  EXYNOS_TMU_SENSOR(6) |	\
+				  EXYNOS_TMU_SENSOR(7) |	\
+				  EXYNOS_TMU_SENSOR(8) |	\
+				  EXYNOS_TMU_SENSOR(9))
+#define GS101_CPUCL1_SENSOR_MASK (EXYNOS_TMU_SENSOR(4) |	\
+				  EXYNOS_TMU_SENSOR(5))
+#define GS101_CPUCL0_SENSOR_MASK (EXYNOS_TMU_SENSOR(1) |	\
+				  EXYNOS_TMU_SENSOR(2))
+
+#define GS101_REG_INTPEND(i)		((i) * 0x50 + 0xf8)
+
+enum {
+	P0_INTPEND,
+	P1_INTPEND,
+	P2_INTPEND,
+	P3_INTPEND,
+	P4_INTPEND,
+	P5_INTPEND,
+	P6_INTPEND,
+	P7_INTPEND,
+	P8_INTPEND,
+	P9_INTPEND,
+	P10_INTPEND,
+	P11_INTPEND,
+	P12_INTPEND,
+	P13_INTPEND,
+	P14_INTPEND,
+	P15_INTPEND,
+	REG_INTPEND_COUNT,
+};
+
+struct acpm_tmu_sensor_group {
+	u16 mask;
+	u8 id;
+};
+
+struct acpm_tmu_sensor {
+	const struct acpm_tmu_sensor_group *group;
+	struct thermal_zone_device *tzd;
+	struct acpm_tmu_priv *priv;
+	struct mutex lock; /* protects sensor state */
+	bool enabled;
+};
+
+struct acpm_tmu_priv {
+	struct regmap_field *regmap_fields[REG_INTPEND_COUNT];
+	struct acpm_handle *handle;
+	struct device *dev;
+	struct clk *clk;
+	unsigned int mbox_chan_id;
+	unsigned int num_sensors;
+	int irq;
+	struct acpm_tmu_sensor sensors[] __counted_by(num_sensors);
+};
+
+struct acpm_tmu_driver_data {
+	const struct reg_field *reg_fields;
+	const struct acpm_tmu_sensor_group *sensor_groups;
+	unsigned int num_sensor_groups;
+	unsigned int mbox_chan_id;
+};
+
+#define ACPM_TMU_SENSOR_GROUP(_mask, _id)		\
+	{					\
+		.mask	= _mask,		\
+		.id	= _id,			\
+	}
+
+static const struct acpm_tmu_sensor_group gs101_sensor_groups[] = {
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL2_SENSOR_MASK, 0),
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL1_SENSOR_MASK, 1),
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL0_SENSOR_MASK, 2),
+};
+
+static const struct reg_field gs101_reg_fields[REG_INTPEND_COUNT] = {
+	[P0_INTPEND] = REG_FIELD(GS101_REG_INTPEND(0), 0, 31),
+	[P1_INTPEND] = REG_FIELD(GS101_REG_INTPEND(1), 0, 31),
+	[P2_INTPEND] = REG_FIELD(GS101_REG_INTPEND(2), 0, 31),
+	[P3_INTPEND] = REG_FIELD(GS101_REG_INTPEND(3), 0, 31),
+	[P4_INTPEND] = REG_FIELD(GS101_REG_INTPEND(4), 0, 31),
+	[P5_INTPEND] = REG_FIELD(GS101_REG_INTPEND(5), 0, 31),
+	[P6_INTPEND] = REG_FIELD(GS101_REG_INTPEND(6), 0, 31),
+	[P7_INTPEND] = REG_FIELD(GS101_REG_INTPEND(7), 0, 31),
+	[P8_INTPEND] = REG_FIELD(GS101_REG_INTPEND(8), 0, 31),
+	[P9_INTPEND] = REG_FIELD(GS101_REG_INTPEND(9), 0, 31),
+	[P10_INTPEND] = REG_FIELD(GS101_REG_INTPEND(10), 0, 31),
+	[P11_INTPEND] = REG_FIELD(GS101_REG_INTPEND(11), 0, 31),
+	[P12_INTPEND] = REG_FIELD(GS101_REG_INTPEND(12), 0, 31),
+	[P13_INTPEND] = REG_FIELD(GS101_REG_INTPEND(13), 0, 31),
+	[P14_INTPEND] = REG_FIELD(GS101_REG_INTPEND(14), 0, 31),
+	[P15_INTPEND] = REG_FIELD(GS101_REG_INTPEND(15), 0, 31),
+};
+
+static const struct regmap_config gs101_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.use_relaxed_mmio = true,
+	.max_register = GS101_REG_INTPEND(15),
+};
+
+static const struct acpm_tmu_driver_data acpm_tmu_gs101 = {
+	.reg_fields = gs101_reg_fields,
+	.sensor_groups = gs101_sensor_groups,
+	.num_sensor_groups = ARRAY_SIZE(gs101_sensor_groups),
+	.mbox_chan_id = 9,
+};
+
+static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor *sensor, bool on)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
+	int ret;
+
+	ret = ops->tz_control(handle, priv->mbox_chan_id, sensor->group->id,
+			      on);
+	if (ret)
+		return ret;
+
+	sensor->enabled = on;
+
+	return 0;
+}
+
+static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on)
+{
+	struct device *dev = priv->dev;
+	int i, ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+
+		/* Skip sensors that weren't found in DT */
+		if (!sensor->tzd)
+			continue;
+
+		mutex_lock(&sensor->lock);
+		ret = acpm_tmu_op_tz_control(sensor, on);
+		mutex_unlock(&sensor->lock);
+		if (ret)
+			break;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	struct acpm_tmu_priv *priv = sensor->priv;
+	struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
+	struct device *dev = priv->dev;
+	int acpm_temp, ret;
+
+	if (!sensor->enabled)
+		return -EAGAIN;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	scoped_guard(mutex, &sensor->lock) {
+		ret = ops->read_temp(handle, priv->mbox_chan_id,
+				     sensor->group->id, &acpm_temp);
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	if (ret)
+		return ret;
+
+	*temp = acpm_temp * MILLIDEGREE_PER_DEGREE;
+
+	return 0;
+}
+
+static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
+				      u8 thresholds[2], u8 inten)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
+	unsigned int mbox_chan_id = priv->mbox_chan_id;
+	u8 acpm_sensor_id = sensor->group->id;
+	bool was_enabled = sensor->enabled;
+	int ret;
+
+	guard(mutex)(&sensor->lock);
+
+	if (was_enabled) {
+		ret = acpm_tmu_op_tz_control(sensor, false);
+		if (ret)
+			return ret;
+	}
+
+	ret = ops->set_threshold(handle, mbox_chan_id, acpm_sensor_id,
+				 thresholds, 2);
+	if (ret)
+		return ret;
+
+	ret = ops->set_interrupt_enable(handle, mbox_chan_id, acpm_sensor_id,
+					inten);
+	if (ret)
+		return ret;
+
+	/* Restore based on cached state. */
+	if (was_enabled)
+		ret = acpm_tmu_op_tz_control(sensor, true);
+
+	return ret;
+}
+
+static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	struct acpm_tmu_priv *priv = sensor->priv;
+	struct device *dev = priv->dev;
+	u8 thresholds[2] = {};
+	u8 inten = 0;
+	int ret;
+
+	/* If a valid lower bound exists, set the threshold and enable its interrupt */
+	if (low > -INT_MAX) {
+		thresholds[0] = clamp_val(low / MILLIDEGREE_PER_DEGREE, 0, 255);
+		inten |= BIT(0);
+	}
+
+	/* If a valid upper bound exists, set the threshold and enable its interrupt */
+	if (high < INT_MAX) {
+		thresholds[1] = clamp_val(high / MILLIDEGREE_PER_DEGREE, 0, 255);
+		inten |= BIT(1);
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = acpm_tmu_update_thresholds(sensor, thresholds, inten);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
+	.get_temp = acpm_tmu_get_temp,
+	.set_trips = acpm_tmu_set_trips,
+};
+
+static int acpm_tmu_has_pending_irq(struct acpm_tmu_sensor *sensor,
+				    bool *pending_irq)
+{
+	struct acpm_tmu_priv *priv = sensor->priv;
+	unsigned long mask = sensor->group->mask;
+	int i, ret;
+	u32 val;
+
+	guard(mutex)(&sensor->lock);
+
+	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+		ret = regmap_field_read(priv->regmap_fields[i], &val);
+		if (ret)
+			return ret;
+
+		if (val) {
+			*pending_irq = true;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
+{
+	struct acpm_tmu_priv *priv = id;
+	struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
+	struct device *dev = priv->dev;
+	int i, ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(dev, "Failed to resume: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+		bool pending_irq = false;
+
+		if (!sensor->tzd)
+			continue;
+
+		ret = acpm_tmu_has_pending_irq(sensor, &pending_irq);
+		if (ret || !pending_irq)
+			continue;
+
+		thermal_zone_device_update(sensor->tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
+
+		scoped_guard(mutex, &sensor->lock) {
+			ret = ops->clear_tz_irq(handle, priv->mbox_chan_id,
+						sensor->group->id);
+			if (ret)
+				dev_err(priv->dev, "Sensor %d: failed to clear IRQ (%d)\n",
+					i, ret);
+		}
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return IRQ_HANDLED;
+}
+
+static const struct of_device_id acpm_tmu_match[] = {
+	{ .compatible = "google,gs101-tmu-top" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, acpm_tmu_match);
+
+static int acpm_tmu_probe(struct platform_device *pdev)
+{
+	const struct acpm_tmu_driver_data *data = &acpm_tmu_gs101;
+	struct acpm_handle *acpm_handle;
+	struct device *dev = &pdev->dev;
+	struct acpm_tmu_priv *priv;
+	struct regmap *regmap;
+	void __iomem *base;
+	int i, ret;
+
+	acpm_handle = devm_acpm_get_by_phandle(dev);
+	if (IS_ERR(acpm_handle))
+		return dev_err_probe(dev, PTR_ERR(acpm_handle),
+				     "Failed to get ACPM handle\n");
+
+	priv = devm_kzalloc(dev,
+			    struct_size(priv, sensors, data->num_sensor_groups),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->handle = acpm_handle;
+	priv->mbox_chan_id = data->mbox_chan_id;
+	priv->num_sensors = data->num_sensor_groups;
+
+	platform_set_drvdata(pdev, priv);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "Failed to ioremap resource\n");
+
+	regmap = devm_regmap_init_mmio(dev, base, &gs101_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+
+	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->regmap_fields,
+					   data->reg_fields, REG_INTPEND_COUNT);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to map syscon registers\n");
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Failed to get the clock\n");
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return dev_err_probe(dev, priv->irq, "Failed to get irq\n");
+
+	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
+					acpm_tmu_thread_fn, IRQF_ONESHOT,
+					dev_name(dev), priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to resume device\n");
+
+	ret = acpm_handle->ops->tmu.init(acpm_handle, priv->mbox_chan_id);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to init TMU\n");
+		goto err_pm_put;
+	}
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+
+		mutex_init(&sensor->lock);
+		sensor->group = &data->sensor_groups[i];
+		sensor->priv = priv;
+
+		sensor->tzd = devm_thermal_of_zone_register(dev, i, sensor,
+							    &acpm_tmu_sensor_ops);
+		if (IS_ERR(sensor->tzd)) {
+			ret = PTR_ERR(sensor->tzd);
+			if (ret == -ENODEV) {
+				sensor->tzd = NULL;
+				dev_dbg(dev, "Sensor %d not used in DT, skipping\n", i);
+				continue;
+			}
+
+			ret = dev_err_probe(dev, ret, "Failed to register sensor %d\n", i);
+			goto err_pm_put;
+		}
+
+		ret = devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
+		if (ret)
+			dev_warn(dev, "Failed to add hwmon sysfs!\n");
+	}
+
+	ret = acpm_tmu_control(priv, true);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to enable TMU\n");
+		goto err_pm_put;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_put_sync(dev);
+	return ret;
+}
+
+static void acpm_tmu_remove(struct platform_device *pdev)
+{
+	struct acpm_tmu_priv *priv = platform_get_drvdata(pdev);
+
+	/* Stop IRQ first to prevent race with thread_fn */
+	disable_irq(priv->irq);
+
+	acpm_tmu_control(priv, false);
+}
+
+static int acpm_tmu_suspend(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+	struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
+	int ret;
+
+	ret = acpm_tmu_control(priv, false);
+	if (ret)
+		return ret;
+
+	/* APB clock not required for this specific msg */
+	return ops->suspend(handle, priv->mbox_chan_id);
+}
+
+static int acpm_tmu_resume(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+	struct acpm_handle *handle = priv->handle;
+	const struct acpm_tmu_ops *ops = &handle->ops->tmu;
+	int ret;
+
+	/* APB clock not required for this specific msg */
+	ret = ops->resume(handle, priv->mbox_chan_id);
+	if (ret)
+		return ret;
+
+	return acpm_tmu_control(priv, true);
+}
+
+static int acpm_tmu_runtime_suspend(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int acpm_tmu_runtime_resume(struct device *dev)
+{
+	struct acpm_tmu_priv *priv = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(priv->clk);
+}
+
+static const struct dev_pm_ops acpm_tmu_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(acpm_tmu_suspend, acpm_tmu_resume)
+	RUNTIME_PM_OPS(acpm_tmu_runtime_suspend, acpm_tmu_runtime_resume, NULL)
+};
+
+static struct platform_driver acpm_tmu_driver = {
+	.driver = {
+		.name   = "gs-tmu",
+		.pm     = pm_ptr(&acpm_tmu_pm_ops),
+		.of_match_table = acpm_tmu_match,
+	},
+	.probe = acpm_tmu_probe,
+	.remove = acpm_tmu_remove,
+};
+module_platform_driver(acpm_tmu_driver);
+
+MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@linaro.org>");
+MODULE_DESCRIPTION("Samsung Exynos ACPM TMU Driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0.746.g67dd491aae-goog


Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE29EACD;
	Fri, 10 Apr 2026 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791957; cv=none; b=OhCQ0tP/fz0/eEep90GBI4WNs4nb3B5s88K+FlZGWHHDwkF/6qYn10b0G3DJu4+aHd1OkxfmsJtL7uHtIbB2R3/DkgmmzkhUnvjzY5J8FEa0GbdZT/wuBbm4V2y1C4QqSmoiqvJeUflN1+Rk0sJi9FrDLsYCuFFUYVkIaHuOoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791957; c=relaxed/simple;
	bh=+PHx7pqPbzF8ZyOswv9Bx4l9P5FLsl/XvWpnK62CyiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RaisJlikQhgsascAvwNMDcsEDgTCTSEVHyg6wXfmYG1rpkXXR4uhO9MhNBlnTaV4sMf+S9YPsNt651Ardc0h5dDQBNqbBAQgSX7ccTgLQUd++yEym/B5mHtbQkb0kaOlHjZ9uOeIYb0+pMV8LNH0E4W17mVXWTLtMjVwlO1BlqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Xu1QP6ze; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VXljFu9w; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xu1QP6ze";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VXljFu9w"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fsMnD5Ryxz9sPx;
	Fri, 10 Apr 2026 05:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775791952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOlwUtr5Lo6rPDWNTxAz9o0r9Z/5NyEMSsSsCcl1jvI=;
	b=Xu1QP6zeuaHFBWjyw8b0OnpzVwAC3zUkoSEwuwrozAPsp6viVYQpY/UyShsxQHY4jEeBJ3
	EzW4EuyFZT4QBwpEiFdvo1aUCQ7h1GbYr/uUMheeFrvG3O4HNhpzNMVzU9TZLSTPjuevpT
	m5ZOtT+09CO0FS8Y+huDaYXDs1wT4NreVM9eIbHOReAYx4c2F5ENu4SQ4EBeouIg0kx+L3
	R862axISgUK+/GRtqzEy7GYRuDJDrROVgaNxKUybu/UdCkxAIzULSDCirHuEmpvjV1Tpv7
	DvI3oA+WxtzHqfIHY8yKu78TP/XwHUqFnJsY+/bypV5HD5ccT1932WY1LwKOFA==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775791951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOlwUtr5Lo6rPDWNTxAz9o0r9Z/5NyEMSsSsCcl1jvI=;
	b=VXljFu9wX1bSyYdGHcon143HxpYmYyqcfj2wdjMwbY/fGrz5YWZrkIs8NsE4q+mQbaKhB+
	/rdZB/sGdVbU1NjqC/AG3li0IkWfPSKcFUV2eoEGwbseiBiWi97q8UI0v6Yp9T8QwvqAoX
	aqoqE+R4W0zAq14iNdW69H2DzMWSTtcoSXLZVilrfO8WU+lN5s6YRuCF1ZmTd9imZ7B6a/
	hQixSgtEtsTSMApzOWaDWyccC1UztIKgBSt91IReqeYD5ai4DD5sNR3yfscjRBzS5ktFKS
	JfySIfv2ImyGfnZ1I/IqF75x72NJ1f9+ZYVrj/yvJcOImZpOjmkoZg60D9cnbA==
Date: Fri, 10 Apr 2026 11:31:37 +0800
Subject: [PATCH v4 2/3] thermal: spacemit: k1: Add thermal sensor support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-k1-thermal-v1-2-12c87dd063c3@mailbox.org>
References: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
In-Reply-To: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Shuwei Wu <shuwei.wu@mailbox.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yao Zi <me@ziyao.cc>, 
 Vincent Legoll <legoll@online.fr>, Gong Shuai <gsh517025@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775791914; l=12168;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=+PHx7pqPbzF8ZyOswv9Bx4l9P5FLsl/XvWpnK62CyiE=;
 b=ndckK6Oak3t6UmewzJIBi8Ws/sirs6AhVr8kCDQgRyXjB/5NG37INYa2lTUlE6ONlccnMRKAq
 V1haxk13YSJCAAHr0B1TrrFdQ2m2ZmtvNkjifeogVXQPmSRIYomzgBo
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-META: ec1nnaekezbbmmfotswnjfhdbk8brzrx
X-MBO-RS-ID: 43500c56d9c21f4c513

The thermal sensor on K1 supports monitoring five temperature zones.
The driver registers these sensors with the thermal framework
and supports standard operations:
- Reading temperature (millidegree Celsius)
- Setting high/low thresholds for interrupts

Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
Tested-by: Gong Shuai <gsh517025@gmail.com>

---
Changes in v4:
- Add 'depends on THERMAL_OF' in drivers/thermal/spacemit/Kconfig

Changes in v3:
- Align multi-line assignments as suggested by reviewer
- Remove unnecessary variable definitions

Changes in v2:
- Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
- Move driver to drivers/thermal/spacemit/
- Add Kconfig/Makefile for spacemit and update top-level build files
- Refactor names, style, code alignment, and comments
- Simplify probe and error handling
---
 drivers/thermal/Kconfig               |   2 +
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/spacemit/Kconfig      |  19 +++
 drivers/thermal/spacemit/Makefile     |   3 +
 drivers/thermal/spacemit/k1_tsensor.c | 281 ++++++++++++++++++++++++++++++++++
 5 files changed, 306 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b10080d61860..1c4a5cd5a23e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -472,6 +472,8 @@ endmenu
 
 source "drivers/thermal/renesas/Kconfig"
 
+source "drivers/thermal/spacemit/Kconfig"
+
 source "drivers/thermal/tegra/Kconfig"
 
 config GENERIC_ADC_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index bb21e7ea7fc6..3b249195c088 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -65,6 +65,7 @@ obj-y				+= mediatek/
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
+obj-y				+= spacemit/
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
 obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
diff --git a/drivers/thermal/spacemit/Kconfig b/drivers/thermal/spacemit/Kconfig
new file mode 100644
index 000000000000..de7b5ece5af2
--- /dev/null
+++ b/drivers/thermal/spacemit/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "SpacemiT thermal drivers"
+depends on ARCH_SPACEMIT || COMPILE_TEST
+
+config SPACEMIT_K1_TSENSOR
+	tristate "SpacemiT K1 thermal sensor driver"
+	depends on THERMAL_OF
+	help
+	  This driver provides support for the thermal sensor
+	  integrated in the SpacemiT K1 SoC.
+
+	  The thermal sensor monitors temperatures for five thermal zones:
+	  soc, package, gpu, cluster0, and cluster1. It supports reporting
+	  temperature values and handling high/low threshold interrupts.
+
+	  Say Y here if you want to enable thermal monitoring on SpacemiT K1.
+	  If compiled as a module, it will be called k1_tsensor.
+
+endmenu
diff --git a/drivers/thermal/spacemit/Makefile b/drivers/thermal/spacemit/Makefile
new file mode 100644
index 000000000000..82b30741e4ec
--- /dev/null
+++ b/drivers/thermal/spacemit/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPACEMIT_K1_TSENSOR)	+= k1_tsensor.o
diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
new file mode 100644
index 000000000000..b742739e9019
--- /dev/null
+++ b/drivers/thermal/spacemit/k1_tsensor.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Thermal sensor driver for SpacemiT K1 SoC
+ *
+ * Copyright (C) 2026 Shuwei Wu <shuwei.wu@mailbox.org>
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "../thermal_hwmon.h"
+
+#define K1_TSENSOR_PCTRL_REG		0x00
+#define K1_TSENSOR_PCTRL_ENABLE		BIT(0)
+#define K1_TSENSOR_PCTRL_TEMP_MODE	BIT(3)
+#define K1_TSENSOR_PCTRL_RAW_SEL	BIT(7)
+
+#define K1_TSENSOR_PCTRL_CTUNE		GENMASK(11, 8)
+#define K1_TSENSOR_PCTRL_SW_CTRL	GENMASK(21, 18)
+#define K1_TSENSOR_PCTRL_HW_AUTO_MODE	BIT(23)
+
+#define K1_TSENSOR_EN_REG		0x08
+#define K1_TSENSOR_EN_ALL		GENMASK(MAX_SENSOR_NUMBER - 1, 0)
+
+#define K1_TSENSOR_TIME_REG		0x0C
+#define K1_TSENSOR_TIME_WAIT_REF_CNT	GENMASK(3, 0)
+#define K1_TSENSOR_TIME_ADC_CNT_RST	GENMASK(7, 4)
+#define K1_TSENSOR_TIME_FILTER_PERIOD	GENMASK(21, 20)
+#define K1_TSENSOR_TIME_MASK		GENMASK(23, 0)
+
+#define K1_TSENSOR_INT_CLR_REG		0x10
+#define K1_TSENSOR_INT_EN_REG		0x14
+#define K1_TSENSOR_INT_STA_REG		0x18
+
+#define K1_TSENSOR_INT_EN_MASK		BIT(0)
+#define K1_TSENSOR_INT_MASK(x)		(GENMASK(2, 1) << ((x) * 2))
+
+#define K1_TSENSOR_DATA_BASE_REG	0x20
+#define K1_TSENSOR_DATA_REG(x)		(K1_TSENSOR_DATA_BASE_REG + ((x) / 2) * 4)
+#define K1_TSENSOR_DATA_LOW_MASK	GENMASK(15, 0)
+#define K1_TSENSOR_DATA_HIGH_MASK	GENMASK(31, 16)
+
+#define K1_TSENSOR_THRSH_BASE_REG	0x40
+#define K1_TSENSOR_THRSH_REG(x)		(K1_TSENSOR_THRSH_BASE_REG + ((x) * 4))
+#define K1_TSENSOR_THRSH_LOW_MASK	GENMASK(15, 0)
+#define K1_TSENSOR_THRSH_HIGH_MASK	GENMASK(31, 16)
+
+#define MAX_SENSOR_NUMBER		5
+
+/* Hardware offset value required for temperature calculation */
+#define TEMPERATURE_OFFSET		278
+
+struct k1_tsensor_channel {
+	struct k1_tsensor *ts;
+	struct thermal_zone_device *tzd;
+	int id;
+};
+
+struct k1_tsensor {
+	void __iomem *base;
+	struct k1_tsensor_channel ch[MAX_SENSOR_NUMBER];
+};
+
+static void k1_tsensor_init(struct k1_tsensor *ts)
+{
+	u32 val;
+
+	/* Disable all the interrupts */
+	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
+
+	/* Configure ADC sampling time and filter period */
+	val = readl(ts->base + K1_TSENSOR_TIME_REG);
+	val &= ~K1_TSENSOR_TIME_MASK;
+	val |= K1_TSENSOR_TIME_FILTER_PERIOD |
+	       K1_TSENSOR_TIME_ADC_CNT_RST |
+	       K1_TSENSOR_TIME_WAIT_REF_CNT;
+	writel(val, ts->base + K1_TSENSOR_TIME_REG);
+
+	/*
+	 * Enable all sensors' auto mode, enable dither control,
+	 * consecutive mode, and power up sensor.
+	 */
+	val = readl(ts->base + K1_TSENSOR_PCTRL_REG);
+	val &= ~K1_TSENSOR_PCTRL_SW_CTRL;
+	val &= ~K1_TSENSOR_PCTRL_CTUNE;
+	val |= K1_TSENSOR_PCTRL_RAW_SEL |
+	       K1_TSENSOR_PCTRL_TEMP_MODE |
+	       K1_TSENSOR_PCTRL_HW_AUTO_MODE |
+	       K1_TSENSOR_PCTRL_ENABLE;
+	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
+
+	/* Enable thermal interrupt */
+	val = readl(ts->base + K1_TSENSOR_INT_EN_REG);
+	val |= K1_TSENSOR_INT_EN_MASK;
+	writel(val, ts->base + K1_TSENSOR_INT_EN_REG);
+
+	/* Enable each sensor */
+	val = readl(ts->base + K1_TSENSOR_EN_REG);
+	val |= K1_TSENSOR_EN_ALL;
+	writel(val, ts->base + K1_TSENSOR_EN_REG);
+}
+
+static void k1_tsensor_enable_irq(struct k1_tsensor_channel *ch)
+{
+	struct k1_tsensor *ts = ch->ts;
+	u32 val;
+
+	val = readl(ts->base + K1_TSENSOR_INT_CLR_REG);
+	val |= K1_TSENSOR_INT_MASK(ch->id);
+	writel(val, ts->base + K1_TSENSOR_INT_CLR_REG);
+
+	val = readl(ts->base + K1_TSENSOR_INT_EN_REG);
+	val &= ~K1_TSENSOR_INT_MASK(ch->id);
+	writel(val, ts->base + K1_TSENSOR_INT_EN_REG);
+}
+
+/*
+ * The conversion formula used is:
+ * T(m°C) = (((raw_value & mask) >> shift) - TEMPERATURE_OFFSET) * 1000
+ */
+static int k1_tsensor_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct k1_tsensor_channel *ch = thermal_zone_device_priv(tz);
+	struct k1_tsensor *ts = ch->ts;
+	u32 val;
+
+	val = readl(ts->base + K1_TSENSOR_DATA_REG(ch->id));
+	if (ch->id % 2)
+		*temp = FIELD_GET(K1_TSENSOR_DATA_HIGH_MASK, val);
+	else
+		*temp = FIELD_GET(K1_TSENSOR_DATA_LOW_MASK, val);
+
+	*temp -= TEMPERATURE_OFFSET;
+	*temp *= 1000;
+
+	return 0;
+}
+
+/*
+ * For each sensor, the hardware threshold register is 32 bits:
+ * - Lower 16 bits [15:0] configure the low threshold temperature.
+ * - Upper 16 bits [31:16] configure the high threshold temperature.
+ */
+static int k1_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct k1_tsensor_channel *ch = thermal_zone_device_priv(tz);
+	struct k1_tsensor *ts = ch->ts;
+	u32 val;
+
+	if (low >= high)
+		return -EINVAL;
+
+	if (low < 0)
+		low = 0;
+
+	high = high / 1000 + TEMPERATURE_OFFSET;
+	low = low / 1000 + TEMPERATURE_OFFSET;
+
+	val = readl(ts->base + K1_TSENSOR_THRSH_REG(ch->id));
+	val &= ~K1_TSENSOR_THRSH_HIGH_MASK;
+	val |= FIELD_PREP(K1_TSENSOR_THRSH_HIGH_MASK, high);
+
+	val &= ~K1_TSENSOR_THRSH_LOW_MASK;
+	val |= FIELD_PREP(K1_TSENSOR_THRSH_LOW_MASK, low);
+	writel(val, ts->base + K1_TSENSOR_THRSH_REG(ch->id));
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops k1_tsensor_ops = {
+	.get_temp = k1_tsensor_get_temp,
+	.set_trips = k1_tsensor_set_trips,
+};
+
+static irqreturn_t k1_tsensor_irq_thread(int irq, void *data)
+{
+	struct k1_tsensor *ts = (struct k1_tsensor *)data;
+	int mask, status, i;
+
+	status = readl(ts->base + K1_TSENSOR_INT_STA_REG);
+
+	for (i = 0; i < MAX_SENSOR_NUMBER; i++) {
+		if (status & K1_TSENSOR_INT_MASK(i)) {
+			mask = readl(ts->base + K1_TSENSOR_INT_CLR_REG);
+			mask |= K1_TSENSOR_INT_MASK(i);
+			writel(mask, ts->base + K1_TSENSOR_INT_CLR_REG);
+			thermal_zone_device_update(ts->ch[i].tzd, THERMAL_EVENT_UNSPECIFIED);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int k1_tsensor_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct k1_tsensor *ts;
+	struct reset_control *reset;
+	struct clk *clk;
+	int i, irq, ret;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ts->base))
+		return dev_err_probe(dev, PTR_ERR(ts->base), "Failed to get reg\n");
+
+	reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get/deassert reset control\n");
+
+	clk = devm_clk_get_enabled(dev, "core");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get core clock\n");
+
+	clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get bus clock\n");
+
+	k1_tsensor_init(ts);
+
+	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
+		ts->ch[i].id = i;
+		ts->ch[i].ts = ts;
+		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
+		if (IS_ERR(ts->ch[i].tzd))
+			return PTR_ERR(ts->ch[i].tzd);
+
+		/* Attach sysfs hwmon attributes for userspace monitoring */
+		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
+		if (ret)
+			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+
+		k1_tsensor_enable_irq(ts->ch + i);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					k1_tsensor_irq_thread,
+					IRQF_ONESHOT, "k1_tsensor", ts);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, ts);
+
+	return 0;
+}
+
+static const struct of_device_id k1_tsensor_dt_ids[] = {
+	{ .compatible = "spacemit,k1-tsensor" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, k1_tsensor_dt_ids);
+
+static struct platform_driver k1_tsensor_driver = {
+	.driver = {
+		.name		= "k1_tsensor",
+		.of_match_table = k1_tsensor_dt_ids,
+	},
+	.probe	= k1_tsensor_probe,
+};
+module_platform_driver(k1_tsensor_driver);
+
+MODULE_DESCRIPTION("SpacemiT K1 Thermal Sensor Driver");
+MODULE_AUTHOR("Shuwei Wu <shuwei.wu@mailbox.org>");
+MODULE_LICENSE("GPL");

-- 
2.53.0


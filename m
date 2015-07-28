From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 01/13] clk: qcom: Add support for GDSCs
Date: Tue, 28 Jul 2015 15:03:54 +0530
Message-ID: <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

GDSCs (Global Distributed Switch Controllers) are responsible for
safely collapsing and restoring power to peripherals in the SoC.
These are best modelled as power domains using genpd and given
the registers are scattered throughout the clock controller register
space, its best to have the support added through the clock driver.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/Kconfig  |   4 ++
 drivers/clk/qcom/Makefile |   1 +
 drivers/clk/qcom/gdsc.c   | 171 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h   |  46 +++++++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/clk/qcom/gdsc.c
 create mode 100644 drivers/clk/qcom/gdsc.h

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 59d1666..d3a695b 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -39,6 +39,10 @@ config IPQ_LCC_806X
 	  Say Y if you want to use audio devices such as i2s, pcm,
 	  S/PDIF, etc.
 
+config QCOM_GDSC
+	bool
+	select PM_GENERIC_DOMAINS if PM
+
 config MSM_GCC_8660
 	tristate "MSM8660 Global Clock Controller"
 	depends on COMMON_CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 50b337a..fe62523 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += reset.o
+clk-qcom-$(CONFIG_QCOM_GDSC) += gdsc.o
 
 obj-$(CONFIG_APQ_GCC_8084) += gcc-apq8084.o
 obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
new file mode 100644
index 0000000..3b11f4d
--- /dev/null
+++ b/drivers/clk/qcom/gdsc.c
@@ -0,0 +1,171 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include "gdsc.h"
+
+#define PWR_ON_MASK		BIT(31)
+#define EN_REST_WAIT_MASK	GENMASK(23, 20)
+#define EN_FEW_WAIT_MASK	GENMASK(19, 16)
+#define CLK_DIS_WAIT_MASK	GENMASK(15, 12)
+#define SW_OVERRIDE_MASK	BIT(2)
+#define HW_CONTROL_MASK		BIT(1)
+#define SW_COLLAPSE_MASK	BIT(0)
+
+/* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
+#define EN_REST_WAIT_VAL	(0x2 << 20)
+#define EN_FEW_WAIT_VAL		(0x8 << 16)
+#define CLK_DIS_WAIT_VAL	(0x2 << 12)
+
+#define TIMEOUT_US		100
+
+#define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
+
+static int gdsc_is_enabled(struct gdsc *sc)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(sc->regmap, sc->gdscr, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & PWR_ON_MASK);
+}
+
+static int gdsc_toggle_logic(struct gdsc *sc, bool en)
+{
+	int ret;
+	u32 val = en ? 0 : SW_COLLAPSE_MASK;
+	u32 check = en ? PWR_ON_MASK : 0;
+	unsigned long timeout;
+
+	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
+	if (ret)
+		return ret;
+
+	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
+	do {
+		ret = regmap_read(sc->regmap, sc->gdscr, &val);
+		if (ret)
+			return ret;
+
+		if ((val & PWR_ON_MASK) == check)
+			return 0;
+	} while (time_before(jiffies, timeout));
+
+	ret = regmap_read(sc->regmap, sc->gdscr, &val);
+	if (ret)
+		return ret;
+
+	if ((val & PWR_ON_MASK) == check)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int gdsc_enable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret;
+
+	ret = gdsc_toggle_logic(sc, true);
+	if (ret)
+		return ret;
+	/*
+	 * If clocks to this power domain were already on, they will take an
+	 * additional 4 clock cycles to re-enable after the power domain is
+	 * enabled. Delay to account for this. A delay is also needed to ensure
+	 * clocks are not enabled within 400ns of enabling power to the
+	 * memories.
+	 */
+	udelay(1);
+
+	return 0;
+}
+
+static int gdsc_disable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	return gdsc_toggle_logic(sc, false);
+}
+
+static int gdsc_init(struct gdsc *sc)
+{
+	u32 mask, val;
+	int on, ret;
+
+	/*
+	 * Disable HW trigger: collapse/restore occur based on registers writes.
+	 * Disable SW override: Use hardware state-machine for sequencing.
+	 * Configure wait time between states.
+	 */
+	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
+	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
+	val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
+	ret = regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
+	if (ret)
+		return ret;
+
+	on = gdsc_is_enabled(sc);
+	if (on < 0)
+		return on;
+
+	sc->pd.power_off = gdsc_disable;
+	sc->pd.power_on = gdsc_enable;
+	pm_genpd_init(&sc->pd, NULL, !on);
+
+	return 0;
+}
+
+int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
+		  struct regmap *regmap)
+{
+	int i, ret;
+	struct genpd_onecell_data *data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
+				     GFP_KERNEL);
+	if (!data->domains)
+		return -ENOMEM;
+
+	data->num_domains = num;
+	for (i = 0; i < num; i++) {
+		if (!scs[i])
+			continue;
+		scs[i]->regmap = regmap;
+		ret = gdsc_init(scs[i]);
+		if (ret)
+			return ret;
+		data->domains[i] = &scs[i]->pd;
+	}
+
+	return of_genpd_add_provider_onecell(dev->of_node, data);
+}
+
+void gdsc_unregister(struct device *dev)
+{
+	of_genpd_del_provider(dev->of_node);
+}
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
new file mode 100644
index 0000000..f578a0c
--- /dev/null
+++ b/drivers/clk/qcom/gdsc.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __QCOM_GDSC_H__
+#define __QCOM_GDSC_H__
+
+#include <linux/err.h>
+#include <linux/pm_domain.h>
+
+struct regmap;
+
+/**
+ * struct gdsc - Globally Distributed Switch Controller
+ * @pd: generic power domain
+ * @regmap: regmap for MMIO accesses
+ * @gdscr: gsdc control register
+ */
+struct gdsc {
+	struct generic_pm_domain	pd;
+	struct regmap			*regmap;
+	unsigned int			gdscr;
+};
+
+#ifdef CONFIG_QCOM_GDSC
+int gdsc_register(struct device *, struct gdsc **, size_t n, struct regmap *);
+void gdsc_unregister(struct device *);
+#else
+static inline int gdsc_register(struct device *d, struct gdsc **g, size_t n,
+				struct regmap *r)
+{
+	return -ENOSYS;
+}
+
+static inline void gdsc_unregister(struct device *d) {};
+#endif /* CONFIG_QCOM_GDSC */
+#endif /* __QCOM_GDSC_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

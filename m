From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 13/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
Date: Thu,  6 Aug 2015 16:07:54 +0530
Message-ID: <1438857474-20262-14-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39020 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbbHFKkV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 06:40:21 -0400
In-Reply-To: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

With CONFIG_PM disabled, turn the devices clocks on during
driver binding to the device, and turn them off when the
driver is unbound from the device. Platforms can specify
all the clocks that need to be managed in !CONFIG_PM case
using qcom_pm_add_notifier().

The use of pm_clk_add_notifier() isn't appropriate here since we need
to only manage clocks with valid power domain associations done via
DT, instead of what pm_clk_add_notifier() does, which is manage clocks
for all on SoC/off SoC devices associating all of them to a dummy power
domain instead

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  8 ++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 20965fc..afc0b15 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
@@ -303,3 +304,76 @@ void gdsc_unregister(struct device *dev)
 {
 	of_genpd_del_provider(dev->of_node);
 }
+
+#ifndef CONFIG_PM
+static void enable_clock(struct of_phandle_args *clkspec)
+{
+	struct clk *clk;
+
+	clk = of_clk_get_from_provider(clkspec);
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+}
+
+static void disable_clock(struct of_phandle_args *clkspec)
+{
+	struct clk *clk;
+
+	clk = of_clk_get_from_provider(clkspec);
+	if (!IS_ERR(clk)) {
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+	}
+}
+
+static int clk_notify(struct notifier_block *nb, unsigned long action,
+		      void *data)
+{
+	int sz, i = 0;
+	struct device *dev = data;
+	struct gdsc_notifier_block *gdsc_nb;
+	struct of_phandle_args clkspec;
+	struct device_node *np = dev->of_node;
+
+	if (!of_find_property(dev->of_node, "power-domains", &sz))
+		return 0;
+
+	gdsc_nb = container_of(nb, struct gdsc_notifier_block, nb);
+
+	if (!gdsc_nb->clock_count)
+		return 0;
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells",
+						   i, &clkspec)) {
+			if (match(clkspec.args[0], gdsc_nb->clocks,
+				  gdsc_nb->clock_count))
+				enable_clock(&clkspec);
+			i++;
+		}
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells",
+						   i, &clkspec)) {
+			if (match(clkspec.args[0], gdsc_nb->clocks,
+				  gdsc_nb->clock_count))
+				disable_clock(&clkspec);
+			i++;
+		}
+		break;
+	}
+	return 0;
+}
+
+void qcom_pm_add_notifier(struct gdsc_notifier_block *gdsc_nb)
+{
+	if (!gdsc_nb)
+		return;
+
+	gdsc_nb->nb.notifier_call = clk_notify,
+	bus_register_notifier(&platform_bus_type, &gdsc_nb->nb);
+}
+#endif
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 0b958a6..b0a36ed 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -76,4 +76,12 @@ static inline int gdsc_register(struct device *d, struct gdsc **g, size_t n,
 
 static inline void gdsc_unregister(struct device *d) {};
 #endif /* CONFIG_QCOM_GDSC */
+#ifndef CONFIG_PM
+struct gdsc_notifier_block {
+	struct notifier_block nb;
+	unsigned int	*clocks;
+	unsigned int	clock_count;
+};
+void qcom_pm_add_notifier(struct gdsc_notifier_block *);
+#endif /* !CONFIG_PM */
 #endif /* __QCOM_GDSC_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


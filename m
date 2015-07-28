From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
Date: Tue, 28 Jul 2015 15:03:57 +0530
Message-ID: <1438076046-4706-5-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57409 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbbG1JfN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 05:35:13 -0400
In-Reply-To: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

With CONFIG_PM disabled, turn the devices clocks on during
driver binding to the device, and turn them off when the
driver is unbound from the device.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 68b810a..c7f109b 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -12,10 +12,12 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
@@ -211,3 +213,72 @@ void gdsc_unregister(struct device *dev)
 {
 	of_genpd_del_provider(dev->of_node);
 }
+
+#ifndef CONFIG_PM
+struct gdsc_notifier_block {
+	struct notifier_block nb;
+	const char *con_ids[];
+};
+
+static void enable_clock(struct device *dev, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_get(dev, con_id);
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+}
+
+static void disable_clock(struct device *dev, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_get(dev, con_id);
+	if (!IS_ERR(clk)) {
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+	}
+}
+
+static int clk_notify(struct notifier_block *nb, unsigned long action,
+		      void *data)
+{
+	int sz;
+	struct device *dev = data;
+	const char **con_id;
+	struct gdsc_notifier_block *gdsc_nb;
+
+	if (!of_find_property(dev->of_node, "power-domains", &sz))
+		return 0;
+
+	gdsc_nb = container_of(nb, struct gdsc_notifier_block, nb);
+
+	if (!gdsc_nb->con_ids[0])
+		return 0;
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		for (con_id = gdsc_nb->con_ids; *con_id; con_id++)
+			enable_clock(dev, *con_id);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		for (con_id = gdsc_nb->con_ids; *con_id; con_id++)
+			disable_clock(dev, *con_id);
+		break;
+	}
+	return 0;
+}
+
+static struct gdsc_notifier_block gdsc_nb = {
+	.nb.notifier_call = clk_notify,
+	.con_ids = { NULL },
+};
+
+static __init int qcom_pm_runtime_init(void)
+{
+	return bus_register_notifier(&platform_bus_type, &gdsc_nb.nb);
+}
+core_initcall(qcom_pm_runtime_init);
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


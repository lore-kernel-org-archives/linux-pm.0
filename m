From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 03/13] clk: qcom: gdsc: Use PM clocks to control gdsc clocks
Date: Wed, 22 Jul 2015 12:40:59 +0530
Message-ID: <1437549069-29655-4-git-send-email-rnayak@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60318 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbbGVHLj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 03:11:39 -0400
In-Reply-To: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>

The devices within a gdsc power domain, quite often have additional
clocks to be turned on/off along with the power domain itself.
Once the drivers for these devices are converted to use runtime PM,
it would be possible to remove all clock handling from the drivers if
the gdsc driver can handle it.
Use PM clocks to add support for this. A list of con_ids[] specified
per gdsc would be the clocks turned on/off on every device start/stop
callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a59655b..3125809 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
+#include <linux/pm_clock.h>
 #include <linux/slab.h>
 #include "gdsc.h"
 
@@ -104,6 +105,37 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return gdsc_toggle_logic(sc, false);
 }
 
+static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
+{
+	int ret;
+	struct gdsc *sc = domain_to_gdsc(domain);
+	char **con_id, *con_ids[] = { "core", "iface", NULL };
+
+	ret = pm_clk_create(dev);
+	if (ret) {
+		dev_err(dev, "pm_clk_create failed %d\n", ret);
+		return ret;
+	}
+
+	for (con_id = con_ids; *con_id; con_id++) {
+		ret = pm_clk_add(dev, *con_id);
+		if (ret) {
+			dev_err(dev, "pm_clk_add failed %d\n", ret);
+			goto fail;
+		}
+	}
+	return 0;
+fail:
+	pm_clk_destroy(dev);
+	return ret;
+};
+
+static void gdsc_detach(struct generic_pm_domain *domain, struct device *dev)
+{
+	pm_clk_destroy(dev);
+	return;
+};
+
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -127,6 +159,9 @@ static int gdsc_init(struct gdsc *sc)
 
 	sc->pd.power_off = gdsc_disable;
 	sc->pd.power_on = gdsc_enable;
+	sc->pd.attach_dev = gdsc_attach;
+	sc->pd.detach_dev = gdsc_detach;
+	sc->pd.flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(&sc->pd, NULL, !on);
 
 	return 0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


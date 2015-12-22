From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/17] PM / OPP: Manage device clk
Date: Tue, 22 Dec 2015 15:46:08 +0530
Message-ID: <1cdc1e6a83974a3f1bb44c0af3cd32ef94542d81.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34593 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKQt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:16:49 -0500
Received: by mail-pf0-f178.google.com with SMTP id u7so57924652pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:16:48 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

OPP core has got almost everything now to manage device's OPP
transitions, the only thing left is device's clk. Get that as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 9 +++++++++
 drivers/base/power/opp/opp.h  | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 1bb09138cdae..1d1b0faa825d 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -596,6 +596,11 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
 		of_node_put(np);
 	}
 
+	/* Find clk for the device */
+	dev_opp->clk = clk_get(dev, NULL);
+	if (IS_ERR(dev_opp->clk))
+		dev_dbg(dev, "%s: Couldn't find clock\n", __func__);
+
 	dev_opp->regulator = regulator_get_optional(dev, name);
 	if (IS_ERR(dev_opp->regulator))
 		dev_info(dev, "%s: no regulator (%s) found: %ld\n", __func__,
@@ -663,6 +668,10 @@ static void _remove_device_opp(struct device_opp *dev_opp)
 	if (dev_opp->regulator_set)
 		return;
 
+	/* Release clk */
+	if (!IS_ERR(dev_opp->clk))
+		clk_put(dev_opp->clk);
+
 	regulator_put(dev_opp->regulator);
 
 	list_dev = list_first_entry(&dev_opp->dev_list, struct device_list_opp,
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index a39347d8693f..42759f025ef1 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -14,6 +14,7 @@
 #ifndef __DRIVER_OPP_H__
 #define __DRIVER_OPP_H__
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -133,6 +134,7 @@ struct device_list_opp {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @clk:	struct clk pointer
  * @regulator: Supply Regulator
  * @regulator_set: Regulator's name is explicitly set by platform.
  *
@@ -169,6 +171,7 @@ struct device_opp {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	struct clk *clk;
 	struct regulator *regulator;
 	bool regulator_set;
 
-- 
2.7.0.rc1.186.g94414c4


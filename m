From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/17] PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
Date: Tue, 22 Dec 2015 15:46:07 +0530
Message-ID: <25cb4d7e9169815448193bd93305fae31a83792c.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32809 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKQp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:16:45 -0500
Received: by mail-pf0-f171.google.com with SMTP id n128so87775298pfn.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:16:45 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

V2 bindings have better support for clock-latency and voltage-tolerance
and doesn't need special care. To use callbacks, like
dev_pm_opp_get_max_{transition|volt}_latency(), irrespective of the
bindings, the core needs to know clock-latency/voltage-tolerance for the
earlier bindings.

This patch reads clock-latency/voltage-tolerance from the device node,
irrespective of the bindings (to keep it simple) and use them only for
V1 bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 20 ++++++++++++++++++++
 drivers/base/power/opp/opp.h  |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 5746993aa71d..1bb09138cdae 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -563,6 +563,7 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	struct device_node *np;
 
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
@@ -580,6 +581,21 @@ static struct device_opp *_add_device_opp_reg(struct device *dev,
 		return NULL;
 	}
 
+	/*
+	 * Only required for backward compatibility with v1 bindings, but isn't
+	 * harmful for other cases. And so we do it unconditionally.
+	 */
+	np = of_node_get(dev->of_node);
+	if (np) {
+		u32 val;
+
+		if (!of_property_read_u32(np, "clock-latency", &val))
+			dev_opp->clock_latency_ns_max = val;
+		of_property_read_u32(np, "voltage-tolerance",
+				     &dev_opp->voltage_tolerance_v1);
+		of_node_put(np);
+	}
+
 	dev_opp->regulator = regulator_get_optional(dev, name);
 	if (IS_ERR(dev_opp->regulator))
 		dev_info(dev, "%s: no regulator (%s) found: %ld\n", __func__,
@@ -865,6 +881,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
+	unsigned long tol;
 	int ret;
 
 	/* Hold our list modification lock here */
@@ -878,7 +895,10 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 
 	/* populate the opp table */
 	new_opp->rate = freq;
+	tol = u_volt * dev_opp->voltage_tolerance_v1 / 100;
 	new_opp->u_volt = u_volt;
+	new_opp->u_volt_min = u_volt - tol;
+	new_opp->u_volt_max = u_volt + tol;
 	new_opp->available = true;
 	new_opp->dynamic = dynamic;
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 08aae35ab8e0..a39347d8693f 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -139,6 +139,8 @@ struct device_list_opp {
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
+ * @voltage_tolerance_v1: In percentage, for v1 bindings only.
+ *
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
  * meant for book keeping and private to OPP library.
@@ -157,6 +159,10 @@ struct device_opp {
 
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
+
+	/* For backward compatibility with v1 bindings */
+	unsigned int voltage_tolerance_v1;
+
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.7.0.rc1.186.g94414c4


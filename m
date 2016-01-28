From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 05/16] PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
Date: Thu, 28 Jan 2016 13:50:34 +0530
Message-ID: <66c45bfa2c883dc169076568beef82fe96b4e69c.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33484 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965196AbcA1IVJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 03:21:09 -0500
Received: by mail-pf0-f176.google.com with SMTP id x125so20092771pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2016 00:21:09 -0800 (PST)
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

V2 bindings have better support for clock-latency and voltage-tolerance
and doesn't need special care. To use callbacks, like
dev_pm_opp_get_max_{transition|volt}_latency(), irrespective of the
bindings, the core needs to know clock-latency/voltage-tolerance for the
earlier bindings.

This patch reads clock-latency/voltage-tolerance from the device node,
irrespective of the bindings (to keep it simple) and use them only for
V1 bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/core.c | 20 ++++++++++++++++++++
 drivers/base/power/opp/opp.h  |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index b0f5c72f0fc3..4fafa733a1c7 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -582,6 +582,7 @@ static struct device_opp *_add_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 	struct device_list_opp *list_dev;
+	struct device_node *np;
 
 	/* Check for existing list for 'dev' first */
 	dev_opp = _find_device_opp(dev);
@@ -604,6 +605,21 @@ static struct device_opp *_add_device_opp(struct device *dev)
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
 	srcu_init_notifier_head(&dev_opp->srcu_head);
 	INIT_LIST_HEAD(&dev_opp->opp_list);
 
@@ -861,6 +877,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
+	unsigned long tol;
 	int ret;
 
 	/* Hold our list modification lock here */
@@ -874,7 +891,10 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 
 	/* populate the opp table */
 	new_opp->rate = freq;
+	tol = u_volt * dev_opp->voltage_tolerance_v1 / 100;
 	new_opp->u_volt = u_volt;
+	new_opp->u_volt_min = u_volt - tol;
+	new_opp->u_volt_max = u_volt + tol;
 	new_opp->available = true;
 	new_opp->dynamic = dynamic;
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 416293b7da23..fe44beb404ba 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -138,6 +138,8 @@ struct device_list_opp {
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
+ * @voltage_tolerance_v1: In percentage, for v1 bindings only.
+ *
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
  * meant for book keeping and private to OPP library.
@@ -156,6 +158,10 @@ struct device_opp {
 
 	struct device_node *np;
 	unsigned long clock_latency_ns_max;
+
+	/* For backward compatibility with v1 bindings */
+	unsigned int voltage_tolerance_v1;
+
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.7.0.79.gdc08a19


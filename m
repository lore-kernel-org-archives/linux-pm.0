From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 6/9] PM / OPP: Implement dev_pm_opp_of_add_table_indexed()
Date: Wed, 26 Apr 2017 16:27:10 +0530
Message-ID: <2268452b1c6929fc5b08c34aec9a06ebd0993461.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34232 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2998900AbdDZK5o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 06:57:44 -0400
Received: by mail-pg0-f48.google.com with SMTP id v1so31218763pgv.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 03:57:44 -0700 (PDT)
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

The "operating-points-v2" property can contain a list of phandles now,
specifically for the power domain providers that provide multiple
domains.

Add support to parse that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/of.c | 50 +++++++++++++++++++++++++++++++++++++++------
 include/linux/pm_opp.h      |  6 ++++++
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 77693ba3ed55..9cdf3a848e69 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -243,14 +243,17 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
-struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+static struct device_node *_of_get_opp_desc_node_indexed(struct device *dev,
+							 int index)
 {
-	/*
-	 * There should be only ONE phandle present in "operating-points-v2"
-	 * property.
-	 */
+	/* "operating-points-v2" can be an array for power domain providers */
+	return of_parse_phandle(dev->of_node, "operating-points-v2", index);
+}
 
-	return of_parse_phandle(dev->of_node, "operating-points-v2", 0);
+/* Returns opp descriptor node for a device, caller must do of_node_put() */
+struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
+{
+	return _of_get_opp_desc_node_indexed(dev, 0);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
@@ -572,6 +575,41 @@ int dev_pm_opp_of_add_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 
+/**
+ * dev_pm_opp_of_add_table_indexed() - Initialize indexed opp table from device tree
+ * @dev:	device pointer used to lookup OPP table.
+ * @index:	Index number.
+ *
+ * Register the initial OPP table with the OPP library for given device only
+ * using the "operating-points-v2" property.
+ *
+ * Return:
+ * 0		On success OR
+ *		Duplicate OPPs (both freq and volt are same) and opp->available
+ * -EEXIST	Freq are same and volt are different OR
+ *		Duplicate OPPs (both freq and volt are same) and !opp->available
+ * -ENOMEM	Memory allocation failure
+ * -ENODEV	when 'operating-points' property is not found or is invalid data
+ *		in device node.
+ * -ENODATA	when empty 'operating-points' property is found
+ * -EINVAL	when invalid entries are found in opp-v2 table
+ */
+int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
+{
+	struct device_node *opp_np;
+	int ret;
+
+	opp_np = _of_get_opp_desc_node_indexed(dev, index);
+	if (!opp_np)
+		return -ENODEV;
+
+	ret = _of_add_opp_table_v2(dev, opp_np);
+	of_node_put(opp_np);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
+
 /* CPU device specific helpers */
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a6685b3dde26..8263d831715c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -284,6 +284,7 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
+int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
 void dev_pm_opp_of_remove_table(struct device *dev);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
@@ -295,6 +296,11 @@ static inline int dev_pm_opp_of_add_table(struct device *dev)
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
+{
+	return -ENOTSUPP;
+}
+
 static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
-- 
2.12.0.432.g71c3a4f4ba37

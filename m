From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 5/9] PM / OPP: Add support to parse "power-domain-opp" property
Date: Wed, 26 Apr 2017 16:27:09 +0530
Message-ID: <127ea4f4f4451c3ea6740c6cdde9d0cdde405075.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34220 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2998897AbdDZK5l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 06:57:41 -0400
Received: by mail-pg0-f46.google.com with SMTP id v1so31218185pgv.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 03:57:41 -0700 (PDT)
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

The devices can specify phandle to their power-domain's OPP node in
their OPP nodes under the "power-domain-opp" property. This patch
updates the OPP core to parse it.

The OPP nodes are allowed to have the "power-domain-opp" property, only
if the device node contains the "power-domains" property. The OPP nodes
aren't allowed to contain this property partially, i.e. Either all OPP
nodes in the OPP table have the "power-domain-opp" property or none of
them have it.

The QoS framework represents the request values by s32 type variables
and so we are forced to convert the 64 bit values read from DT (from the
"opp-hz" property) into s32. It shouldn't be a problem unless someone
uses real frequency values in "opp-hz" property for the power domains. A
comment is added in the code to take a note of that. We can fix that
later once we have real platforms that want it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c    | 72 +++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/debugfs.c |  3 ++
 drivers/base/power/opp/of.c      | 77 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h     | 12 +++++++
 4 files changed, 164 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index dae61720b314..dc8b7bc0061a 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -543,6 +543,62 @@ _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
 	return ret;
 }
 
+static int _update_pm_qos_request(struct device *dev,
+				  struct dev_pm_qos_request *req, int perf)
+{
+	int ret;
+
+	if (likely(dev_pm_qos_request_active(req)))
+		ret = dev_pm_qos_update_request(req, perf);
+	else
+		ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_PERFORMANCE,
+					     perf);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int _generic_set_opp_domain(struct device *dev, struct clk *clk,
+				   struct dev_pm_qos_request *req,
+				   unsigned long old_freq, unsigned long freq,
+				   int old_dfreq, int new_dfreq)
+{
+	int ret;
+
+	/* Scaling up? Scale voltage before frequency */
+	if (freq > old_freq) {
+		ret = _update_pm_qos_request(dev, req, new_dfreq);
+		if (ret)
+			return ret;
+	}
+
+	/* Change frequency */
+	ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+	if (ret)
+		goto restore_dfreq;
+
+	/* Scaling down? Scale voltage after frequency */
+	if (freq < old_freq) {
+		ret = _update_pm_qos_request(dev, req, new_dfreq);
+		if (ret)
+			goto restore_freq;
+	}
+
+	return 0;
+
+restore_freq:
+	if (_generic_set_opp_clk_only(dev, clk, freq, old_freq))
+		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
+			__func__, old_freq);
+restore_dfreq:
+	if (old_dfreq != -1)
+		_update_pm_qos_request(dev, req, old_dfreq);
+
+	return ret;
+}
+
 static int _generic_set_opp(struct dev_pm_set_opp_data *data)
 {
 	struct dev_pm_opp_supply *old_supply = data->old_opp.supplies;
@@ -663,6 +719,19 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	regulators = opp_table->regulators;
 
+	/* Need to configure power domain performance state */
+	if (opp_table->has_domain_opp) {
+		int old_dfreq = -1, new_dfreq;
+		struct dev_pm_qos_request *req = &opp_table->qos_request;
+
+		new_dfreq = opp->domain_rate;
+		if (!IS_ERR(old_opp))
+			old_dfreq = old_opp->domain_rate;
+
+		return _generic_set_opp_domain(dev, clk, req, old_freq, freq,
+					       old_dfreq, new_dfreq);
+	}
+
 	/* Only frequency scaling */
 	if (!regulators) {
 		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
@@ -808,6 +877,9 @@ static void _opp_table_kref_release(struct kref *kref)
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
 	struct opp_device *opp_dev;
 
+	if (dev_pm_qos_request_active(&opp_table->qos_request))
+		dev_pm_qos_remove_request(&opp_table->qos_request);
+
 	/* Release clk */
 	if (!IS_ERR(opp_table->clk))
 		clk_put(opp_table->clk);
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 95f433db4ac7..4b7eb379c84f 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -104,6 +104,9 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
 		return -ENOMEM;
 
+	if (!debugfs_create_u32("domain_rate", S_IRUGO, d, &opp->domain_rate))
+		return -ENOMEM;
+
 	if (!opp_debug_create_supplies(opp, opp_table, d))
 		return -ENOMEM;
 
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 779428676f63..77693ba3ed55 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -254,6 +254,70 @@ struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
+static int _parse_domain_opp(struct dev_pm_opp *opp,
+			     struct opp_table *opp_table, struct device *dev,
+			     struct device_node *np)
+{
+	struct device_node *dnp;
+	u64 rate;
+	int ret;
+
+	if (!of_find_property(np, "power-domain-opp", NULL)) {
+		if (unlikely(opp_table->has_domain_opp == 1)) {
+			dev_err(dev, "%s: Not all OPP nodes have power-domain-opp\n",
+				__func__);
+			return -EINVAL;
+		}
+
+		/* overwrite to avoid conditional statement */
+		opp_table->has_domain_opp = 0;
+		return 0;
+	}
+
+	if (unlikely(!opp_table->has_domain)) {
+		dev_err(dev, "%s: OPP node can't have power-domain-opp property without power domain\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (unlikely(!opp_table->has_domain_opp)) {
+		dev_err(dev, "%s: Not all OPP nodes have power-domain-opp\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	dnp = of_parse_phandle(np, "power-domain-opp", 0);
+	if (unlikely(!dnp)) {
+		dev_err(dev, "%s: Unable to parse phandle of power-domain-opp\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	/* Read opp-hz from domain's OPP table */
+	ret = of_property_read_u64(dnp, "opp-hz", &rate);
+	if (ret < 0) {
+		dev_err(dev, "%s: opp-hz not found in domain's node\n",
+			__func__);
+		goto put_node;
+	}
+
+	/*
+	 * The "domain_rate" field is directly passed to the QoS APIs and they
+	 * accept s32 values only. Will check this again once we have platforms
+	 * that really keep u64 values for power domains.
+	 */
+	opp->domain_rate = (int)rate;
+
+	/* overwrite to avoid conditional statement */
+	opp_table->has_domain_opp = 1;
+
+	ret = 0;
+
+put_node:
+	of_node_put(dnp);
+	return ret;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -296,6 +360,10 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 		goto free_opp;
 	}
 
+	ret = _parse_domain_opp(new_opp, opp_table, dev, np);
+	if (ret)
+		goto free_opp;
+
 	/*
 	 * Rate is defined as an unsigned long in clk API, and so casting
 	 * explicitly to its type. Must be fixed once rate is 64 bit
@@ -375,6 +443,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	if (!opp_table)
 		return -ENOMEM;
 
+	/*
+	 * Only devices with parent power-domains can have "power-domain-opp"
+	 * property.
+	 */
+	if (of_find_property(dev->of_node, "power-domains", NULL)) {
+		opp_table->has_domain = true;
+		opp_table->has_domain_opp = -1;
+	}
+
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_np, np) {
 		count++;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 166eef990599..5350eb4eedd0 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/limits.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 #include <linux/notifier.h>
 
 struct clk;
@@ -59,6 +60,7 @@ extern struct list_head opp_tables;
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @rate:	Frequency in hertz
+ * @domain_rate: Copy of domain's rate
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
@@ -77,6 +79,7 @@ struct dev_pm_opp {
 	bool turbo;
 	bool suspend;
 	unsigned long rate;
+	int domain_rate;
 
 	struct dev_pm_opp_supply *supplies;
 
@@ -137,6 +140,11 @@ enum opp_table_access {
  * @regulator_count: Number of power supply regulators
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
+ * @has_domain: True if the device node contains "power-domain" property
+ * @has_domain_opp: Can have value of 0, 1 or -1. -1 means uninitialized state,
+ * 0 means that OPP nodes don't have "power-domain-opp" property and 1 means
+ * that OPP nodes have it.
+ * @qos_request: Qos request.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -174,6 +182,10 @@ struct opp_table {
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
 
+	bool has_domain;
+	int has_domain_opp;
+	struct dev_pm_qos_request qos_request;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	char dentry_name[NAME_MAX];
-- 
2.12.0.432.g71c3a4f4ba37

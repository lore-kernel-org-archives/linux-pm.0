From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 6/7] PM / Domains: Allow domain performance states to be read from DT
Date: Fri, 24 Feb 2017 14:36:38 +0530
Message-ID: <84786c05d90e5f3c9dc41a65fe3b8ce6052a7628.1487926924.git.viresh.kumar@linaro.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35520 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdBXJOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Feb 2017 04:14:11 -0500
Received: by mail-pf0-f179.google.com with SMTP id 68so1826701pfx.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Feb 2017 01:14:11 -0800 (PST)
In-Reply-To: <cover.1487926924.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1487926924.git.viresh.kumar@linaro.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

This patch allows SoC's to define domains performance states in the DT
using the "performance-states" node in the domain provider node.

Add API to read the performance states from DT by the domain specific
drivers. Note that this information is only used by the domain specific
drivers and the power domain core doesn't need to store it for now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/domain.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  15 +++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 202effbebfd1..a7449c492990 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2251,6 +2251,107 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+/* Power domain performance state management helpers */
+static const struct of_device_id performance_state_match[] = {
+	{ .compatible = "domain-performance-state", },
+	{ }
+};
+
+static int genpd_parse_performance_state(struct genpd_performance_state *state,
+					 struct device_node *np)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &state->performance_state);
+	if (ret) {
+		pr_err(" * %s missing reg property\n", np->full_name);
+		return ret;
+	}
+
+	ret = of_property_read_variable_u32_array(np, "domain-microvolt",
+						  &state->u_volt, 1, 3);
+	if (ret >= 0)
+		return 0;
+
+	/* Property not found */
+	if (ret == -EINVAL)
+		return 0;
+
+	pr_err(" * %s Invalid domain-microvolt property\n", np->full_name);
+	return ret;
+}
+
+/**
+ * of_genpd_parse_performance_states: Return array of performance states for the
+ *				      genpd.
+ *
+ * @dn: The genpd device node
+ * @states: The pointer to which the state array will be saved.
+ * @n: The count of elements in the array returned from this function.
+ *
+ * Returns the device performance states parsed from the OF node. The memory for
+ * the states is allocated by this function and is the responsibility of the
+ * caller to free the memory after use.
+ */
+int of_genpd_parse_performance_states(struct device_node *dn,
+				struct genpd_performance_state **states, int *n)
+{
+	struct genpd_performance_state *st;
+	struct device_node *perf_np, *np;
+	int i = 0, ret, count;
+
+	perf_np = of_get_child_by_name(dn, "performance-states");
+	if (!perf_np) {
+		pr_err("performance-states node not found in %s node\n",
+		       dn->full_name);
+		return -ENODEV;
+	}
+
+	if (!of_match_node(performance_state_match, perf_np)) {
+		pr_err("performance-states node found in %s node isn't compatible\n",
+		       dn->full_name);
+		ret = -EINVAL;
+		goto put_node;
+	}
+
+	count = of_get_child_count(perf_np);
+	if (count <= 0) {
+		pr_err("performance-states node found in %s node doesn't have any child nodes\n",
+		       dn->full_name);
+		ret = -EINVAL;
+		goto put_node;
+	}
+
+	st = kcalloc(count, sizeof(*st), GFP_KERNEL);
+	if (!st) {
+		ret = -ENOMEM;
+		goto put_node;
+	}
+
+	for_each_available_child_of_node(perf_np, np) {
+		ret = genpd_parse_performance_state(&st[i++], np);
+		if (ret) {
+			pr_err("Parsing of performance state node %s failed with err %d\n",
+			       np->full_name, ret);
+			goto free_st;
+		}
+	}
+
+	of_node_put(perf_np);
+	*n = count;
+	*states = st;
+
+	return 0;
+
+free_st:
+	kfree(st);
+put_node:
+	of_node_put(perf_np);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_genpd_parse_performance_states);
+
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 83795935709e..7659ce3968c7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -44,6 +44,13 @@ struct genpd_power_state {
 	struct fwnode_handle *fwnode;
 };
 
+struct genpd_performance_state {
+	unsigned int performance_state;
+	unsigned int u_volt;
+	unsigned int u_volt_min;
+	unsigned int u_volt_max;
+};
+
 struct genpd_lock_ops;
 
 struct generic_pm_domain {
@@ -226,6 +233,8 @@ extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
 extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 extern int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n);
+extern int of_genpd_parse_performance_states(struct device_node *dn,
+			struct genpd_performance_state **states, int *n);
 
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -261,6 +270,12 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline int of_genpd_parse_performance_states(struct device_node *dn,
+			struct genpd_performance_state **states, int *n)
+{
+	return -ENODEV;
+}
+
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
-- 
2.7.1.410.g6faf27b

From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 01/14] PM / Domains: Allow domain power states to be read from DT
Date: Fri, 29 Jul 2016 15:56:12 -0600
Message-ID: <1469829385-11511-2-git-send-email-lina.iyer@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35383 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbcG2V4f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 17:56:35 -0400
Received: by mail-pa0-f54.google.com with SMTP id iw10so34512299pac.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Jul 2016 14:56:35 -0700 (PDT)
In-Reply-To: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

This patch allows domains to define idle states in the DT. SoC's can
define domain idle states in DT using the "power-states" property of the
domain provider. Calling of_pm_genpd_init() will  read the idle states
and initialize the genpd for the domain.

In addition to the entry and exit latency for idle state, also add
residency and state-param properties. A domain idling in a state is only
power effecient if it stays idle for a certain period in that state. The
residency provides this minimum time for the idle state to provide power
benefits. The state-param is a state specific u32 value that the
platform may use for that idle state.

Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Lina: Added state properties, removed state names, wakeup-latency,
added of_pm_genpd_init() API, pruned commit text]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Ulf: Moved around code to make it compile properly, rebased on top of multiple
state support,changed to use pm_genpd_init()]
---
 drivers/base/power/domain.c | 90 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   | 10 ++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a1f2aff..d3f6f5a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1253,6 +1253,88 @@ out:
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
 
+static const struct of_device_id arm_idle_state_match[] = {
+	{ .compatible = "arm,idle-state", },
+	{ }
+};
+
+static int genpd_of_get_power_state(struct genpd_power_state *genpd_state,
+				    struct device_node *state_node)
+{
+	int err = 0;
+	u32 latency;
+	u32 residency;
+	u32 entry_latency, exit_latency;
+	const struct of_device_id *match_id;
+
+	match_id = of_match_node(arm_idle_state_match, state_node);
+	if (!match_id)
+		return -EINVAL;
+
+	err = of_property_read_u32(state_node, "entry-latency-us",
+				   &entry_latency);
+	if (err) {
+		pr_debug(" * %s missing entry-latency-us property\n",
+			 state_node->full_name);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(state_node, "exit-latency-us",
+				   &exit_latency);
+	if (err) {
+		pr_debug(" * %s missing exit-latency-us property\n",
+			 state_node->full_name);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(state_node, "residency-us", &residency);
+	if (!err)
+		genpd_state->residency_ns = 1000 * residency;
+
+	latency = entry_latency + exit_latency;
+	genpd_state->power_on_latency_ns = 1000 * latency;
+	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+
+	return 0;
+}
+
+int pm_genpd_of_parse_power_states(struct generic_pm_domain *genpd)
+{
+	struct device_node *np;
+	int i, err = 0;
+
+	for (i = 0; i < GENPD_MAX_NUM_STATES; i++) {
+		np = of_parse_phandle(genpd->of_node, "domain-idle-states", i);
+		if (!np)
+			break;
+
+		err = genpd_of_get_power_state(&genpd->states[i], np);
+		if (err) {
+			pr_err
+			    ("Parsing idle state node %s failed with err %d\n",
+			     np->full_name, err);
+			err = -EINVAL;
+			break;
+		}
+		of_node_put(np);
+	}
+
+	if (err)
+		return err;
+
+	genpd->state_count = i;
+	return 0;
+}
+EXPORT_SYMBOL(pm_genpd_of_parse_power_states);
+
+static int genpd_of_parse(struct generic_pm_domain *genpd)
+{
+	if (!genpd->of_node || (genpd->state_count > 0))
+		return 0;
+
+	return pm_genpd_of_parse_power_states(genpd);
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1262,8 +1344,10 @@ EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
  * Returns 0 on successful initialization, else a negative error code.
  */
 int pm_genpd_init(struct generic_pm_domain *genpd,
-		  struct dev_power_governor *gov, bool is_off)
+		   struct dev_power_governor *gov, bool is_off)
 {
+	int ret;
+
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
@@ -1306,6 +1390,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	ret = genpd_of_parse(genpd);
+	if (ret)
+		return ret;
+
 	if (genpd->state_idx >= GENPD_MAX_NUM_STATES) {
 		pr_warn("Initial state index out of bounds.\n");
 		genpd->state_idx = GENPD_MAX_NUM_STATES - 1;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 31fec85..3ad5914 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -40,6 +40,8 @@ struct gpd_dev_ops {
 struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
+	s64 residency_ns;
+	u32 param;
 };
 
 struct generic_pm_domain {
@@ -51,6 +53,7 @@ struct generic_pm_domain {
 	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
+	struct device_node *of_node;	/* Device node of the PM domain */
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
@@ -129,7 +132,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern int pm_genpd_init(struct generic_pm_domain *genpd,
 			 struct dev_power_governor *gov, bool is_off);
-
+extern int pm_genpd_of_parse_power_states(struct generic_pm_domain *genpd);
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
 #else
@@ -168,6 +171,11 @@ static inline int pm_genpd_init(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
+static inline int pm_genpd_of_parse_power_states(
+				struct generic_pm_domain *genpd)
+{
+	return -ENODEV;
+}
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
2.7.4


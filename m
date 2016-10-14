From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 3/8] PM / Domains: Allow domain power states to be read from DT
Date: Fri, 14 Oct 2016 10:47:51 -0700
Message-ID: <1476467276-75094-4-git-send-email-lina.iyer@linaro.org>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

This patch allows domains to define idle states in the DT. SoC's can
define domain idle states in DT using the "domain-idle-states" property
of the domain provider. Add API to read the idle states from DT that can
be set in the genpd object.

This patch is based on the original patch by Marc Titinger.

Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 37ab7f1..9af75ba 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1916,6 +1916,100 @@ out:
 	return ret ? -EPROBE_DEFER : 0;
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
+
+static const struct of_device_id idle_state_match[] = {
+	{ .compatible = "arm,idle-state", },
+	{ }
+};
+
+static int genpd_parse_state(struct genpd_power_state *genpd_state,
+				    struct device_node *state_node)
+{
+	int err;
+	u32 residency;
+	u32 entry_latency, exit_latency;
+	const struct of_device_id *match_id;
+
+	match_id = of_match_node(idle_state_match, state_node);
+	if (!match_id)
+		return -EINVAL;
+
+	err = of_property_read_u32(state_node, "entry-latency-us",
+						&entry_latency);
+	if (err) {
+		pr_debug(" * %s missing entry-latency-us property\n",
+						state_node->full_name);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(state_node, "exit-latency-us",
+						&exit_latency);
+	if (err) {
+		pr_debug(" * %s missing exit-latency-us property\n",
+						state_node->full_name);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(state_node, "min-residency-us", &residency);
+	if (!err)
+		genpd_state->residency_ns = 1000 * residency;
+
+	genpd_state->power_on_latency_ns = 1000 * exit_latency;
+	genpd_state->power_off_latency_ns = 1000 * entry_latency;
+
+	return 0;
+}
+
+/**
+ * of_genpd_parse_idle_states: Return array of idle states for the genpd.
+ *
+ * @dn: The genpd device node
+ * @states: The pointer to which the state array will be saved.
+ * @n: The count of elements in the array returned from this function.
+ *
+ * Returns the device states parsed from the OF node. The memory for the states
+ * is allocated by this function and is the responsibility of the caller to
+ * free the memory after use.
+ */
+int of_genpd_parse_idle_states(struct device_node *dn,
+			struct genpd_power_state **states, int *n)
+{
+	struct genpd_power_state *st;
+	struct device_node *np;
+	int i = 0;
+	int err, ret;
+	int count;
+	struct of_phandle_iterator it;
+
+	count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
+	if (!count)
+		return -EINVAL;
+
+	st = kcalloc(count, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	/* Loop over the phandles until all the requested entry is found */
+	of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
+		np = it.node;
+		ret = genpd_parse_state(&st[i++], np);
+		if (ret) {
+			pr_err
+			("Parsing idle state node %s failed with err %d\n",
+							np->full_name, ret);
+			of_node_put(np);
+			kfree(st);
+			return ret;
+		}
+	}
+
+	*n = count;
+	*states = st;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
+
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f4492eb..b489496 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -205,6 +205,8 @@ extern int of_genpd_add_device(struct of_phandle_args *args,
 extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
 				  struct of_phandle_args *new_subdomain);
 extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
+extern int of_genpd_parse_idle_states(struct device_node *dn,
+			struct genpd_power_state **states, int *n);
 
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -234,6 +236,12 @@ static inline int of_genpd_add_subdomain(struct of_phandle_args *parent,
 	return -ENODEV;
 }
 
+static inline int of_genpd_parse_idle_states(struct device_node *dn,
+			struct genpd_power_state **states, int *n)
+{
+	return -ENODEV;
+}
+
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
-- 
2.7.4

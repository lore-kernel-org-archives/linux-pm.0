From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/10] OPP: Rename and relocate of_genpd_opp_to_performance_state()
Date: Fri, 29 Jun 2018 11:49:39 +0530
Message-ID: <9dddd2b291fcdf8eee7d95ca4346d9b3e4228e43.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The OPP core already has the performance state values for each of the
genpd's OPPs and there is no need to call the genpd callback again to
get the performance state for the case where the end device doesn't have
an OPP table and has the "required-opps" property directly in its node.

This commit renames of_get_required_opp_performance_state() as
of_get_required_opp_performance_state() and moves it to the OPP core, as
it is all about OPP stuff now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 48 ------------------------------------
 drivers/opp/of.c            | 49 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 -------
 include/linux/pm_opp.h      |  5 ++++
 4 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 15ffac081b0e..4b6acaac6ab9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2544,54 +2544,6 @@ unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
 }
 EXPORT_SYMBOL_GPL(genpd_opp_to_performance_state);
 
-/**
- * of_genpd_opp_to_performance_state- Gets performance state of device's
- * power domain corresponding to a DT node's "required-opps" property.
- *
- * @dev: Device for which the performance-state needs to be found.
- * @np: DT node where the "required-opps" property is present. This can be
- *	the device node itself (if it doesn't have an OPP table) or a node
- *	within the OPP table of a device (if device has an OPP table).
- *
- * Returns performance state corresponding to the "required-opps" property of
- * a DT node. This calls platform specific genpd->opp_to_performance_state()
- * callback to translate power domain OPP to performance state.
- *
- * Returns performance state on success and 0 on failure.
- */
-unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-					       struct device_node *np)
-{
-	struct generic_pm_domain *genpd;
-	struct dev_pm_opp *opp;
-	int state = 0;
-
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return 0;
-
-	if (unlikely(!genpd->set_performance_state))
-		return 0;
-
-	genpd_lock(genpd);
-
-	opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
-	if (IS_ERR(opp)) {
-		dev_err(dev, "Failed to find required OPP: %ld\n",
-			PTR_ERR(opp));
-		goto unlock;
-	}
-
-	state = genpd->opp_to_performance_state(genpd, opp);
-	dev_pm_opp_put(opp);
-
-unlock:
-	genpd_unlock(genpd);
-
-	return state;
-}
-EXPORT_SYMBOL_GPL(of_genpd_opp_to_performance_state);
-
 static int __init genpd_bus_init(void)
 {
 	return bus_register(&genpd_bus_type);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e1e4a58dd748..80fdeab4364a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -964,6 +964,55 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
 
+/**
+ * of_get_required_opp_performance_state() - Search for required OPP and return its performance state.
+ * @np: Node that contains the "required-opps" property.
+ * @index: Index of the phandle to parse.
+ *
+ * Returns the performance state of the OPP pointed out by the "required-opps"
+ * property at @index in @np.
+ *
+ * Return: Positive performance state on success, otherwise 0 on errors.
+ */
+unsigned int of_get_required_opp_performance_state(struct device_node *np,
+						   int index)
+{
+	struct dev_pm_opp *opp;
+	struct device_node *required_np;
+	struct opp_table *opp_table;
+	unsigned int pstate = 0;
+
+	required_np = of_parse_required_opp(np, index);
+	if (!required_np)
+		return -ENODEV;
+
+	opp_table = _get_required_opp_table(required_np);
+	if (IS_ERR(opp_table)) {
+		pr_err("%s: Failed to find required OPP table %pOF: %ld\n",
+		       __func__, np, PTR_ERR(opp_table));
+		goto put_required_np;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		if (opp->np == required_np) {
+			pstate = opp->pstate;
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+put_required_np:
+	of_node_put(required_np);
+
+	return pstate;
+}
+EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
+
 /**
  * of_dev_pm_opp_find_required_opp() - Search for required OPP.
  * @dev: The device whose OPP node is referenced by the 'np' DT node.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b3c5f1eaf16c..685f982d56e4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -235,8 +235,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
 					    struct dev_pm_opp *opp);
-unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-				struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -280,13 +278,6 @@ genpd_opp_to_performance_state(struct device *genpd_dev, struct dev_pm_opp *opp)
 	return 0;
 }
 
-static inline unsigned int
-of_genpd_opp_to_performance_state(struct device *dev,
-				  struct device_node *np)
-{
-	return 0;
-}
-
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ffdb4a78edec..6d6b1febe068 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -309,6 +309,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
+unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -351,6 +352,10 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
 }
+static inline unsigned int of_get_required_opp_performance_state(struct device_node *np, int index)
+{
+	return 0;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
2.18.0.rc1.242.g61856ae69a2c

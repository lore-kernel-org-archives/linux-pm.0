From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/9] PM / Domains: Add genpd_opp_to_performance_state()
Date: Fri, 12 Oct 2018 16:41:13 +0530
Message-ID: <ec154fa205967507c7352a2d0088346aba562ff2.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, niklas.cassel@linaro.org, rnayak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The OPP core currently stores the performance state in the consumer
device's OPP table, but that is going to change going forward and
performance state will rather be set directly in the genpd's OPP table.

For that we need to get the performance state for genpd's device
structure instead of the consumer device's structure. Add a new helper
to do that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b5714199490..2c82194d2a30 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2508,6 +2508,45 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+/**
+ * genpd_opp_to_performance_state- Gets performance state of the genpd from its OPP node.
+ *
+ * @genpd_dev: Genpd's device for which the performance-state needs to be found.
+ * @opp: struct dev_pm_opp of the OPP for which we need to find performance
+ *	state.
+ *
+ * Returns performance state encoded in the OPP of the genpd. This calls
+ * platform specific genpd->opp_to_performance_state() callback to translate
+ * power domain OPP to performance state.
+ *
+ * Returns performance state on success and 0 on failure.
+ */
+unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
+					    struct dev_pm_opp *opp)
+{
+	struct generic_pm_domain *genpd = NULL, *temp;
+	int state;
+
+	lockdep_assert_held(&gpd_list_lock);
+
+	list_for_each_entry(temp, &gpd_list, gpd_list_node) {
+		if (&temp->dev == genpd_dev) {
+			genpd = temp;
+			break;
+		}
+	}
+
+	if (unlikely(!genpd || !genpd->opp_to_performance_state))
+		return 0;
+
+	genpd_lock(genpd);
+	state = genpd->opp_to_performance_state(genpd, opp);
+	genpd_unlock(genpd);
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(genpd_opp_to_performance_state);
+
 /**
  * of_genpd_opp_to_performance_state- Gets performance state of device's
  * power domain corresponding to a DT node's "required-opps" property.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 776c546d581a..e03f300f7468 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -233,6 +233,8 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
+unsigned int genpd_opp_to_performance_state(struct device *genpd_dev,
+					    struct dev_pm_opp *opp);
 unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 				struct device_node *np);
 
@@ -274,6 +276,12 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline unsigned int
+genpd_opp_to_performance_state(struct device *genpd_dev, struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline unsigned int
 of_genpd_opp_to_performance_state(struct device *dev,
 				  struct device_node *np)
-- 
2.18.0.rc1.242.g61856ae69a2c

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/10] PM / Domains: Add genpd_opp_to_performance_state()
Date: Fri, 29 Jun 2018 11:49:37 +0530
Message-ID: <476e0a8c4bb54190f3019055b369110d0964b798.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The OPP core currently stores the performance state in the end device's
OPP structures, but that is going to change now and these values will be
set directly in the genpd's OPP structures.

For that we need to get the performance state genpd's device structure
instead of the end user's device structure. Add a new helper to do that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e9c85c96580c..15ffac081b0e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2505,6 +2505,45 @@ int of_genpd_parse_idle_states(struct device_node *dn,
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
index cb8d84090cfb..b3c5f1eaf16c 100644
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
 
@@ -272,6 +274,12 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
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

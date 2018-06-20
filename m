From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/2] PM / Domains: Rename opp_node to np
Date: Wed, 20 Jun 2018 11:45:37 +0530
Message-ID: <7511c9837569aec34c56e0a40364f2f3c16563b6.1529475153.git.viresh.kumar@linaro.org>
References: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The DT node passed here isn't necessarily an OPP node, as this routine
can also be used for cases where the "required-opps" property is present
directly in the device's node. Rename it.

This also removes a stale comment.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Updated variable name in header file as well.
- Because it was a very small change, I added Ulf's Ack as well.

 drivers/base/power/domain.c | 7 +++----
 include/linux/pm_domain.h   | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4925af5c4cf0..c298de8a8308 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2487,10 +2487,9 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
  * power domain corresponding to a DT node's "required-opps" property.
  *
  * @dev: Device for which the performance-state needs to be found.
- * @opp_node: DT node where the "required-opps" property is present. This can be
+ * @np: DT node where the "required-opps" property is present. This can be
  *	the device node itself (if it doesn't have an OPP table) or a node
  *	within the OPP table of a device (if device has an OPP table).
- * @state: Pointer to return performance state.
  *
  * Returns performance state corresponding to the "required-opps" property of
  * a DT node. This calls platform specific genpd->opp_to_performance_state()
@@ -2499,7 +2498,7 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
  * Returns performance state on success and 0 on failure.
  */
 unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-					       struct device_node *opp_node)
+					       struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
 	struct dev_pm_opp *opp;
@@ -2514,7 +2513,7 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 
 	genpd_lock(genpd);
 
-	opp = of_dev_pm_opp_find_required_opp(&genpd->dev, opp_node);
+	opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "Failed to find required OPP: %ld\n",
 			PTR_ERR(opp));
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9206a4fef9ac..e1d18ce3a310 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -234,7 +234,7 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-				struct device_node *opp_node);
+				struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -274,7 +274,7 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 
 static inline unsigned int
 of_genpd_opp_to_performance_state(struct device *dev,
-				  struct device_node *opp_node)
+				  struct device_node *np)
 {
 	return -ENODEV;
 }
-- 
2.18.0.rc1.242.g61856ae69a2c

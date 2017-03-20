From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 9/9] PM / Domain: Add support to parse domain's OPP table
Date: Mon, 20 Mar 2017 15:02:21 +0530
Message-ID: <4816e672e5f3495d87c85cda353e29df3885a0b1.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Parse the OPP table from of_genpd_add_provider_simple() by calling
dev_pm_opp_of_add_table(), if the power domain supports changing of
performance states.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 46 +++++++++++++++++++++++++++++++++++++--------
 include/linux/pm_domain.h   |  1 +
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 51d3afc0476d..8155f95b0db2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
@@ -1806,15 +1807,37 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	mutex_lock(&gpd_list_lock);
 
-	if (pm_genpd_present(genpd)) {
-		ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
-		if (!ret) {
-			genpd->provider = &np->fwnode;
-			genpd->has_provider = true;
-			genpd->dev->of_node = np;
+	if (!pm_genpd_present(genpd))
+		goto unlock;
+
+	genpd->dev.of_node = np;
+
+	/* Parse genpd OPP table */
+	if (genpd->set_performance_state) {
+		ret = dev_pm_opp_of_add_table(&genpd->dev);
+		if (ret) {
+			dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
+				ret);
+			goto unlock;
+		}
+
+		genpd->has_opp_table = true;
+	}
+
+	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
+	if (ret) {
+		if (genpd->has_opp_table) {
+			genpd->has_opp_table = false;
+			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
+
+		goto unlock;
 	}
 
+	genpd->provider = &np->fwnode;
+	genpd->has_provider = true;
+
+unlock:
 	mutex_unlock(&gpd_list_lock);
 
 	return ret;
@@ -1887,10 +1910,17 @@ void of_genpd_del_provider(struct device_node *np)
 			 * provider, set the 'has_provider' to false
 			 * so that the PM domain can be safely removed.
 			 */
-			list_for_each_entry(gpd, &gpd_list, gpd_list_node)
-				if (gpd->provider == &np->fwnode)
+			list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+				if (gpd->provider == &np->fwnode) {
 					gpd->has_provider = false;
 
+					if (!gpd->has_opp_table)
+						continue;
+
+					dev_pm_opp_of_remove_table(&gpd->dev);
+				}
+			}
+
 			list_del(&cp->link);
 			of_node_put(cp->node);
 			kfree(cp);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index d55c0112dcde..821d7cf5974b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -57,6 +57,7 @@ struct generic_pm_domain {
 	struct work_struct power_off_work;
 	struct fwnode_handle *provider;	/* Identity of the domain provider */
 	bool has_provider;
+	bool has_opp_table;
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
-- 
2.12.0.432.g71c3a4f4ba37

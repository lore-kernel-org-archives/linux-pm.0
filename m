From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 9/9] PM / Domain: Add support to parse domain's OPP table
Date: Wed, 26 Apr 2017 16:27:13 +0530
Message-ID: <c4bd28f77cd1b5d1447431bc139afea2e05ea60d.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36357 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2998906AbdDZK5z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 06:57:55 -0400
Received: by mail-pg0-f44.google.com with SMTP id t7so3631790pgt.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 03:57:54 -0700 (PDT)
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Parse the OPP table for power domains if they have their
set_performance_state() callback set.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 86 ++++++++++++++++++++++++++++++++++++---------
 include/linux/pm_domain.h   |  1 +
 2 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 85365611b258..17ba541ec3c8 100644
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
@@ -1818,15 +1819,37 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	mutex_lock(&gpd_list_lock);
 
-	if (pm_genpd_present(genpd)) {
-		ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
-		if (!ret) {
-			genpd->provider = &np->fwnode;
-			genpd->has_provider = true;
-			genpd->dev.of_node = np;
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
@@ -1841,6 +1864,7 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data)
 {
+	struct generic_pm_domain *genpd;
 	unsigned int i;
 	int ret = -EINVAL;
 
@@ -1850,14 +1874,29 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	mutex_lock(&gpd_list_lock);
 
 	for (i = 0; i < data->num_domains; i++) {
-		if (!data->domains[i])
+		genpd = data->domains[i];
+
+		if (!genpd)
 			continue;
-		if (!pm_genpd_present(data->domains[i]))
+		if (!pm_genpd_present(genpd))
 			goto error;
 
-		data->domains[i]->provider = &np->fwnode;
-		data->domains[i]->has_provider = true;
-		data->domains[i]->dev.of_node = np;
+		genpd->dev.of_node = np;
+
+		/* Parse genpd OPP table */
+		if (genpd->set_performance_state) {
+			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
+			if (ret) {
+				dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
+					i, ret);
+				goto error;
+			}
+
+			genpd->has_opp_table = true;
+		}
+
+		genpd->provider = &np->fwnode;
+		genpd->has_provider = true;
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_onecell, data);
@@ -1870,10 +1909,18 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 error:
 	while (i--) {
-		if (!data->domains[i])
+		genpd = data->domains[i];
+
+		if (!genpd)
 			continue;
-		data->domains[i]->provider = NULL;
-		data->domains[i]->has_provider = false;
+
+		genpd->provider = NULL;
+		genpd->has_provider = false;
+
+		if (genpd->has_opp_table) {
+			genpd->has_opp_table = false;
+			dev_pm_opp_of_remove_table(&genpd->dev);
+		}
 	}
 
 	mutex_unlock(&gpd_list_lock);
@@ -1900,10 +1947,17 @@ void of_genpd_del_provider(struct device_node *np)
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
index c01f12b370d2..60fc5b165b91 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -58,6 +58,7 @@ struct generic_pm_domain {
 	struct work_struct power_off_work;
 	struct fwnode_handle *provider;	/* Identity of the domain provider */
 	bool has_provider;
+	bool has_opp_table;
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
-- 
2.12.0.432.g71c3a4f4ba37

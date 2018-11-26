From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/5] PM / Domains: Save OPP table pointer in genpd
Date: Mon, 26 Nov 2018 13:40:02 +0530
Message-ID: <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, rnayak@codeaurora.org, niklas.cassel@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We will need these going forward in hotpath, i.e. from within
dev_pm_genpd_set_performance_state().

Lets fetch and save them while the OPP tables are added.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 23 +++++++++++++++++++++--
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8e554e6a82a2..0d928359b880 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1907,12 +1907,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
 				ret);
 			goto unlock;
 		}
+
+		/*
+		 * Save table for faster processing while setting performance
+		 * state.
+		 */
+		genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
+		WARN_ON(!genpd->opp_table);
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
 	if (ret) {
-		if (genpd->set_performance_state)
+		if (genpd->set_performance_state) {
+			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
+		}
 
 		goto unlock;
 	}
@@ -1965,6 +1974,13 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 					i, ret);
 				goto error;
 			}
+
+			/*
+			 * Save table for faster processing while setting
+			 * performance state.
+			 */
+			genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
+			WARN_ON(!genpd->opp_table);
 		}
 
 		genpd->provider = &np->fwnode;
@@ -1989,8 +2005,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->provider = NULL;
 		genpd->has_provider = false;
 
-		if (genpd->set_performance_state)
+		if (genpd->set_performance_state) {
+			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
+		}
 	}
 
 	mutex_unlock(&gpd_list_lock);
@@ -2024,6 +2042,7 @@ void of_genpd_del_provider(struct device_node *np)
 					if (!gpd->set_performance_state)
 						continue;
 
+					dev_pm_opp_put_opp_table(gpd->opp_table);
 					dev_pm_opp_of_remove_table(&gpd->dev);
 				}
 			}
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 642036952553..9ad101362aef 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -73,6 +73,7 @@ struct genpd_power_state {
 
 struct genpd_lock_ops;
 struct dev_pm_opp;
+struct opp_table;
 
 struct generic_pm_domain {
 	struct device dev;
@@ -94,6 +95,7 @@ struct generic_pm_domain {
 	unsigned int performance_state;	/* Aggregated max performance state */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	struct opp_table *opp_table;	/* OPP table of the genpd */
 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
 						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
-- 
2.19.1.568.g152ad8e3369a

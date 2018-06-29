From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/10] OPP: Remove of_dev_pm_opp_find_required_opp()
Date: Fri, 29 Jun 2018 11:49:40 +0530
Message-ID: <b7843b9941743f1b3462ada4b485a5f94038da09.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This isn't used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c       | 54 ------------------------------------------
 include/linux/pm_opp.h |  5 ----
 2 files changed, 59 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 80fdeab4364a..722b3142f4c6 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1013,60 +1013,6 @@ unsigned int of_get_required_opp_performance_state(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
 
-/**
- * of_dev_pm_opp_find_required_opp() - Search for required OPP.
- * @dev: The device whose OPP node is referenced by the 'np' DT node.
- * @np: Node that contains the "required-opps" property.
- *
- * Returns the OPP of the device 'dev', whose phandle is present in the "np"
- * node. Although the "required-opps" property supports having multiple
- * phandles, this helper routine only parses the very first phandle in the list.
- *
- * Return: Matching opp, else returns ERR_PTR in case of error and should be
- * handled using IS_ERR.
- *
- * The callers are required to call dev_pm_opp_put() for the returned OPP after
- * use.
- */
-struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev,
-						   struct device_node *np)
-{
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
-	struct device_node *required_np;
-	struct opp_table *opp_table;
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	required_np = of_parse_phandle(np, "required-opps", 0);
-	if (unlikely(!required_np)) {
-		dev_err(dev, "Unable to parse required-opps\n");
-		goto put_opp_table;
-	}
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->np == required_np) {
-			opp = temp_opp;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-
-	of_node_put(required_np);
-put_opp_table:
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
-}
-EXPORT_SYMBOL_GPL(of_dev_pm_opp_find_required_opp);
-
 /**
  * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
  * @opp:	opp for which DT node has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6d6b1febe068..fadf6d1bdef5 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -307,7 +307,6 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
-struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
 #else
@@ -344,10 +343,6 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
 	return NULL;
 }
 
-static inline struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np)
-{
-	return NULL;
-}
 static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
-- 
2.18.0.rc1.242.g61856ae69a2c

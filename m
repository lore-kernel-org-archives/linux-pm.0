From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/7] PM / OPP: Remove dev_pm_opp_{un}register_get_pstate_helper()
Date: Fri, 22 Dec 2017 12:56:31 +0530
Message-ID: <46a62463d9a0a04648672d5cd3a9803ad99bd36b.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

These helpers aren't used anymore, remove them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 75 --------------------------------------------------
 drivers/opp/opp.h      |  2 --
 include/linux/pm_opp.h | 10 -------
 3 files changed, 87 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6194219fb95f..9e3c40437991 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1545,81 +1545,6 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
 
-/**
- * dev_pm_opp_register_get_pstate_helper() - Register get_pstate() helper.
- * @dev: Device for which the helper is getting registered.
- * @get_pstate: Helper.
- *
- * TODO: Remove this callback after the same information is available via Device
- * Tree.
- *
- * This allows a platform to initialize the performance states of individual
- * OPPs for its devices, until we get similar information directly from DT.
- *
- * This must be called before the OPPs are initialized for the device.
- */
-struct opp_table *dev_pm_opp_register_get_pstate_helper(struct device *dev,
-		int (*get_pstate)(struct device *dev, unsigned long rate))
-{
-	struct opp_table *opp_table;
-	int ret;
-
-	if (!get_pstate)
-		return ERR_PTR(-EINVAL);
-
-	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
-
-	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = -EBUSY;
-		goto err;
-	}
-
-	/* Already have genpd_performance_state set */
-	if (WARN_ON(opp_table->genpd_performance_state)) {
-		ret = -EBUSY;
-		goto err;
-	}
-
-	opp_table->genpd_performance_state = true;
-	opp_table->get_pstate = get_pstate;
-
-	return opp_table;
-
-err:
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ERR_PTR(ret);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_register_get_pstate_helper);
-
-/**
- * dev_pm_opp_unregister_get_pstate_helper() - Releases resources blocked for
- *					   get_pstate() helper
- * @opp_table: OPP table returned from dev_pm_opp_register_get_pstate_helper().
- *
- * Release resources blocked for platform specific get_pstate() helper.
- */
-void dev_pm_opp_unregister_get_pstate_helper(struct opp_table *opp_table)
-{
-	if (!opp_table->genpd_performance_state) {
-		pr_err("%s: Doesn't have performance states set\n",
-		       __func__);
-		return;
-	}
-
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
-	opp_table->genpd_performance_state = false;
-	opp_table->get_pstate = NULL;
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_get_pstate_helper);
-
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index b181032e6938..ae99295b5382 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -140,7 +140,6 @@ enum opp_table_access {
  * @genpd_performance_state: Device's power domain support performance state.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
- * @get_pstate: Platform specific get_pstate callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -178,7 +177,6 @@ struct opp_table {
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
-	int (*get_pstate)(struct device *dev, unsigned long rate);
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 70686f434c13..528a7d9cf2ef 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -125,8 +125,6 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_register_get_pstate_helper(struct device *dev, int (*get_pstate)(struct device *dev, unsigned long rate));
-void dev_pm_opp_unregister_get_pstate_helper(struct opp_table *opp_table);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -247,14 +245,6 @@ static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device
 
 static inline void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_register_get_pstate_helper(struct device *dev,
-		int (*get_pstate)(struct device *dev, unsigned long rate))
-{
-	return ERR_PTR(-ENOTSUPP);
-}
-
-static inline void dev_pm_opp_unregister_get_pstate_helper(struct opp_table *opp_table) {}
-
 static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.15.0.194.g9af6a3dea062

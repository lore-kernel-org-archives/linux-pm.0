From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V11 3/7] OPP: Add dev_pm_opp_{un}register_get_pstate_helper()
Date: Wed, 11 Oct 2017 12:54:15 +0530
Message-ID: <0e5c4f9e8c51ac8b1226932dbcb30e31610a3ed3.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:55914 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756638AbdJKHYz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 03:24:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id b11so554486pgn.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 00:24:55 -0700 (PDT)
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

This adds the dev_pm_opp_{un}register_get_pstate_helper() helper
routines which will be used to set the get_pstate() callback for a
device. This callback will be later called internally by the OPP core to
get performance state corresponding to an OPP.

This is required temporarily until the time we have proper DT bindings
to include the performance state information.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h | 10 +++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0ce8069d6843..92fa94a6dcc1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1036,6 +1036,9 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 		return ret;
 	}
 
+	if (opp_table->get_pstate)
+		new_opp->pstate = opp_table->get_pstate(dev, new_opp->rate);
+
 	list_add(&new_opp->node, head);
 	mutex_unlock(&opp_table->lock);
 
@@ -1548,6 +1551,81 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
 
 /**
+ * dev_pm_opp_register_get_pstate_helper() - Register get_pstate() helper.
+ * @dev: Device for which the helper is getting registered.
+ * @get_pstate: Helper.
+ *
+ * TODO: Remove this callback after the same information is available via Device
+ * Tree.
+ *
+ * This allows a platform to initialize the performance states of individual
+ * OPPs for its devices, until we get similar information directly from DT.
+ *
+ * This must be called before the OPPs are initialized for the device.
+ */
+struct opp_table *dev_pm_opp_register_get_pstate_helper(struct device *dev,
+		int (*get_pstate)(struct device *dev, unsigned long rate))
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	if (!get_pstate)
+		return ERR_PTR(-EINVAL);
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* Already have genpd_performance_state set */
+	if (WARN_ON(opp_table->genpd_performance_state)) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	opp_table->genpd_performance_state = true;
+	opp_table->get_pstate = get_pstate;
+
+	return opp_table;
+
+err:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_register_get_pstate_helper);
+
+/**
+ * dev_pm_opp_unregister_get_pstate_helper() - Releases resources blocked for
+ *					   get_pstate() helper
+ * @opp_table: OPP table returned from dev_pm_opp_register_get_pstate_helper().
+ *
+ * Release resources blocked for platform specific get_pstate() helper.
+ */
+void dev_pm_opp_unregister_get_pstate_helper(struct opp_table *opp_table)
+{
+	if (!opp_table->genpd_performance_state) {
+		pr_err("%s: Doesn't have performance states set\n",
+		       __func__);
+		return;
+	}
+
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	opp_table->genpd_performance_state = false;
+	opp_table->get_pstate = NULL;
+
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_get_pstate_helper);
+
+/**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e8f767ab5814..4d00061648a3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -140,6 +140,7 @@ enum opp_table_access {
  * @genpd_performance_state: Device's power domain support performance state.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
+ * @get_pstate: Platform specific get_pstate callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -177,6 +178,7 @@ struct opp_table {
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
+	int (*get_pstate)(struct device *dev, unsigned long rate);
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 849d21dc4ca7..6c2d2e88f066 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -125,6 +125,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_register_get_pstate_helper(struct device *dev, int (*get_pstate)(struct device *dev, unsigned long rate));
+void dev_pm_opp_unregister_get_pstate_helper(struct opp_table *opp_table);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -245,6 +247,14 @@ static inline struct opp_table *dev_pm_opp_register_set_opp_helper(struct device
 
 static inline void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table) {}
 
+static inline struct opp_table *dev_pm_opp_register_get_pstate_helper(struct device *dev,
+		int (*get_pstate)(struct device *dev, unsigned long rate))
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void dev_pm_opp_unregister_get_pstate_helper(struct opp_table *opp_table) {}
+
 static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.7.4

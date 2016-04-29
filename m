From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 1/2][UPDATE] PM / OPP: add non-OF versions of dev_pm_opp_{cpumask_,}remove_table
Date: Fri, 29 Apr 2016 10:22:36 +0100
Message-ID: <1461921756-15109-1-git-send-email-sudeep.holla@arm.com>
References: <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461863237-12928-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Functions dev_pm_opp_of_{cpumask_,}remove_table removes/frees all the
static OPP entries associated with the device and/or all cpus(in case
of cpumask) that are created from DT.

However the OPP entries are populated reading from the firmware or some
different method using dev_pm_opp_add are marked dynamic and can't be
removed using above functions.

This patch adds non DT/OF versions of dev_pm_opp_{cpumask_,}remove_table
to support the above mentioned usecase.

This is in preparation to make use of the same in scpi-cpufreq.c

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/power/opp/core.c | 56 ++++++++++++++++++++++++++++++----------
 drivers/base/power/opp/cpu.c  | 59 ++++++++++++++++++++++++++++++++-----------
 include/linux/pm_opp.h        | 10 ++++++++
 3 files changed, 96 insertions(+), 29 deletions(-)

v1->v2:
	- Instead of renaming OF versions, created non-OF versions of
	  dev_pm_opp_{cpumask_,}remove_table as suggested by Viresh

This version also updates all the errors in documentation and changes
to use remove_all rather than remove_dyn.

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 433b60092972..15536d45832a 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1845,21 +1845,11 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
-#ifdef CONFIG_OF
 /**
- * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
- *				  entries
- * @dev:	device pointer used to lookup OPP table.
- *
- * Free OPPs created using static entries present in DT.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function indirectly uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
+ * Free OPPs either created using static entries present in DT or even the
+ * dynamically added entries based on remove_all param.
  */
-void dev_pm_opp_of_remove_table(struct device *dev)
+static void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp, *tmp;
@@ -1884,7 +1874,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 	if (list_is_singular(&opp_table->dev_list)) {
 		/* Free static OPPs */
 		list_for_each_entry_safe(opp, tmp, &opp_table->opp_list, node) {
-			if (!opp->dynamic)
+			if (remove_all || !opp->dynamic)
 				_opp_remove(opp_table, opp, true);
 		}
 	} else {
@@ -1894,6 +1884,44 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 unlock:
 	mutex_unlock(&opp_table_lock);
 }
+
+/**
+ * dev_pm_opp_remove_table() - Free all OPPs associated with the device
+ * @dev:	device pointer used to lookup OPP table.
+ *
+ * Free both OPPs created using static entries present in DT and the
+ * dynamically added entries.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function indirectly uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_remove_table(struct device *dev)
+{
+	_dev_pm_opp_remove_table(dev, true);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
+
+#ifdef CONFIG_OF
+/**
+ * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
+ *				  entries
+ * @dev:	device pointer used to lookup OPP table.
+ *
+ * Free OPPs created using static entries present in DT.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function indirectly uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_of_remove_table(struct device *dev)
+{
+	_dev_pm_opp_remove_table(dev, false);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 55cbf9bd8707..2dc39543d88b 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -119,20 +119,7 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-#ifdef CONFIG_OF
-/**
- * dev_pm_opp_of_cpumask_remove_table() - Removes OPP table for @cpumask
- * @cpumask:	cpumask for which OPP table needs to be removed
- *
- * This removes the OPP tables for CPUs present in the @cpumask.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Hence this function internally uses RCU updater strategy with mutex locks
- * to keep the integrity of the internal data structures. Callers should ensure
- * that this function is *NOT* called under RCU protection or in contexts where
- * mutex cannot be locked.
- */
-void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
+static void _dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask, bool of)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -147,9 +134,51 @@ void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 			continue;
 		}
 
-		dev_pm_opp_of_remove_table(cpu_dev);
+		if (of)
+			dev_pm_opp_of_remove_table(cpu_dev);
+		else
+			dev_pm_opp_remove_table(cpu_dev);
 	}
 }
+
+/**
+ * dev_pm_opp_cpumask_remove_table() - Removes OPP table for @cpumask
+ * @cpumask:	cpumask for which OPP table needs to be removed
+ *
+ * This removes the OPP tables for CPUs present in the @cpumask.
+ * This should be used to remove all the OPPs entries associated with
+ * the cpus in @cpumask.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask)
+{
+	_dev_pm_opp_cpumask_remove_table(cpumask, false);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
+
+#ifdef CONFIG_OF
+/**
+ * dev_pm_opp_of_cpumask_remove_table() - Removes OPP table for @cpumask
+ * @cpumask:	cpumask for which OPP table needs to be removed
+ *
+ * This removes the OPP tables for CPUs present in the @cpumask.
+ * This should be used only to remove static entries created from DT.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
+{
+	_dev_pm_opp_cpumask_remove_table(cpumask, true);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5b6ad31403a5..5c3781a79d31 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -66,6 +66,8 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+void dev_pm_opp_remove_table(struct device *dev);
+void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -184,6 +186,14 @@ static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_va
 	return -ENOSYS;
 }
 
+static inline void dev_pm_opp_remove_table(struct device *dev)
+{
+}
+
+static inline void dev_pm_opp_cpumask_remove_table(cpumask_var_t cpumask)
+{
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
1.9.1

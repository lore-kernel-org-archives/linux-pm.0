From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 1/2] PM / OPP: add non-OF versions of dev_pm_opp_{cpumask_,}remove_table
Date: Tue,  3 May 2016 15:05:04 +0100
Message-ID: <1462284305-32177-1-git-send-email-sudeep.holla@arm.com>
References: <1461926262-24732-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461926262-24732-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/power/opp/core.c | 58 ++++++++++++++++++++++++++++++-----------
 drivers/base/power/opp/cpu.c  | 60 ++++++++++++++++++++++++++++++++-----------
 include/linux/pm_opp.h        | 10 ++++++++
 3 files changed, 98 insertions(+), 30 deletions(-)

v3->v4:
	- Rebased on top of Arnd's patch[1] to avoid re-introducing the
	  issue addressed by that patch

v2->v3:
	- updated all the errors in documentation and changed to use
	  remove_all rather than remove_dyn(suggested by Viresh)
	- Added Viresh's ACK on both the patches
	- Rebased on linux-pm/bleeding-edge as there was a conflict

v1->v2:
	- Instead of renaming OF versions, created non-OF versions of
	  dev_pm_opp_{cpumask_,}remove_table as suggested by Viresh

[1] http://lkml.kernel.org/r/1462016049-1976580-1-git-send-email-arnd@arndb.de

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 433b60092972..9f8bf04b4dbe 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -1845,21 +1845,11 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
-#ifdef CONFIG_OF
-/**
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
+/*
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
index 8e0b6349d7d4..357781e0b791 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -119,20 +119,8 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
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
-void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
+static void
+_dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -147,9 +135,51 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
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
+void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
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
+void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
+{
+	_dev_pm_opp_cpumask_remove_table(cpumask, true);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5221d259e413..bca26157f5b6 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -67,6 +67,8 @@ void dev_pm_opp_put_regulator(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
+void dev_pm_opp_remove_table(struct device *dev);
+void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -190,6 +192,14 @@ static inline int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpu
 	return -EINVAL;
 }
 
+static inline void dev_pm_opp_remove_table(struct device *dev)
+{
+}
+
+static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
+{
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
1.9.1

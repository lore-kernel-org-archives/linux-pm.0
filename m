From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/10] PM / OPP: Add dev_pm_opp_get_sharing_cpus()
Date: Thu, 21 Apr 2016 14:28:58 +0530
Message-ID: <63f1a01a5a5a93a316ce95953efdd320a20a9cc6.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

OPP core allows a platform to mark OPP table as shared, when the
platform isn't using operating-points-v2 bindings.

And, so there should be a non DT way of finding out if the OPP table is
shared or not.

This patch adds dev_pm_opp_get_sharing_cpus(), which first tries to get
OPP sharing information from the opp-table (in case it is already marked
as shared), otherwise it uses the existing DT way of finding sharing
information.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/cpu.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h       |  6 ++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 55cbf9bd8707..9c4eb90759fb 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -329,3 +329,48 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
+
+/**
+ * dev_pm_opp_get_sharing_cpus() - Get cpumask of CPUs sharing OPPs with @cpu_dev
+ * @cpu_dev:	CPU device for which we do this operation
+ * @cpumask:	cpumask to update with information of sharing CPUs
+ *
+ * This updates the @cpumask with CPUs that are sharing OPPs with @cpu_dev.
+ *
+ * Returns -ENODEV if OPP table isn't already present.
+ *
+ * Locking: The internal opp_table and opp structures are RCU protected.
+ * Hence this function internally uses RCU updater strategy with mutex locks
+ * to keep the integrity of the internal data structures. Callers should ensure
+ * that this function is *NOT* called under RCU protection or in contexts where
+ * mutex cannot be locked.
+ */
+int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	struct opp_device *opp_dev;
+	struct opp_table *opp_table;
+	int ret = 0;
+
+	mutex_lock(&opp_table_lock);
+
+	opp_table = _find_opp_table(cpu_dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto unlock;
+	}
+
+	cpumask_clear(cpumask);
+
+	if (opp_table->shared_opp) {
+		list_for_each_entry(opp_dev, &opp_table->dev_list, node)
+			cpumask_set_cpu(opp_dev->dev->id, cpumask);
+	} else {
+		cpumask_set_cpu(cpu_dev->id, cpumask);
+	}
+
+unlock:
+	mutex_unlock(&opp_table_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_sharing_cpus);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5b6ad31403a5..d6effc931013 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -66,6 +66,7 @@ int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -184,6 +185,11 @@ static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_va
 	return -ENOSYS;
 }
 
+static inline int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+{
+	return -ENOSYS;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.7.1.410.g6faf27b

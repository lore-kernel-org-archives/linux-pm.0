From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Date: Fri,  4 Jan 2019 15:14:33 +0530
Message-ID: <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Valentin Schneider <valentin.schneider@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, quentin.perret@arm.com, dietmar.eggemann@arm.com, Douglas.Raillard@arm.com, "4 . 20" <stable@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
_dev_pm_opp_remove_table()"), dynamically created OPP aren't
automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
affects the scpi and scmi cpufreq drivers which no longer free OPPs on
failures or on invocations of the policy->exit() callback.

Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
called from these drivers instead of dev_pm_opp_cpumask_remove_table().

In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
opp_list isn't getting accessed simultaneously from other parts of the
OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
the opp_table->lock while traversing through the OPP list. And to
accomplish that, this patch also creates _opp_kref_release_unlocked()
which can be called from this new helper with the opp_table lock already
held.

Cc: 4.20 <stable@vger.kernel.org> # v4.20
Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c |  4 +--
 drivers/cpufreq/scpi-cpufreq.c |  4 +--
 drivers/opp/core.c             | 63 +++++++++++++++++++++++++++++++---
 include/linux/pm_opp.h         |  5 +++
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 50b1551ba894..c2e66528f5ee 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -176,7 +176,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_cpumask_remove_table(policy->cpus);
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 	return ret;
 }
@@ -188,7 +188,7 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
-	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 87a98ec77773..99449738faa4 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -177,7 +177,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_cpumask_remove_table(policy->cpus);
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 	return ret;
 }
@@ -190,7 +190,7 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
-	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 
 	return 0;
 }
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e5507add8f04..18f1639dbc4a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -988,11 +988,9 @@ void _opp_free(struct dev_pm_opp *opp)
 	kfree(opp);
 }
 
-static void _opp_kref_release(struct kref *kref)
+static void _opp_kref_release(struct dev_pm_opp *opp,
+			      struct opp_table *opp_table)
 {
-	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
-	struct opp_table *opp_table = opp->opp_table;
-
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
@@ -1002,7 +1000,22 @@ static void _opp_kref_release(struct kref *kref)
 	opp_debug_remove_one(opp);
 	list_del(&opp->node);
 	kfree(opp);
+}
 
+static void _opp_kref_release_unlocked(struct kref *kref)
+{
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
+
+	_opp_kref_release(opp, opp_table);
+}
+
+static void _opp_kref_release_locked(struct kref *kref)
+{
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
+
+	_opp_kref_release(opp, opp_table);
 	mutex_unlock(&opp_table->lock);
 }
 
@@ -1013,10 +1026,16 @@ void dev_pm_opp_get(struct dev_pm_opp *opp)
 
 void dev_pm_opp_put(struct dev_pm_opp *opp)
 {
-	kref_put_mutex(&opp->kref, _opp_kref_release, &opp->opp_table->lock);
+	kref_put_mutex(&opp->kref, _opp_kref_release_locked,
+		       &opp->opp_table->lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put);
 
+static void dev_pm_opp_put_unlocked(struct dev_pm_opp *opp)
+{
+	kref_put(&opp->kref, _opp_kref_release_unlocked);
+}
+
 /**
  * dev_pm_opp_remove()  - Remove an OPP from OPP table
  * @dev:	device for which we do this operation
@@ -1060,6 +1079,40 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
+/**
+ * dev_pm_opp_remove_all_dynamic() - Remove all dynamically created OPPs
+ * @dev:	device for which we do this operation
+ *
+ * This function removes all dynamically created OPPs from the opp table.
+ */
+void dev_pm_opp_remove_all_dynamic(struct device *dev)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp, *temp;
+	int count = 0;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return;
+
+	mutex_lock(&opp_table->lock);
+	list_for_each_entry_safe(opp, temp, &opp_table->opp_list, node) {
+		if (opp->dynamic) {
+			dev_pm_opp_put_unlocked(opp);
+			count++;
+		}
+	}
+	mutex_unlock(&opp_table->lock);
+
+	/* Drop the references taken by dev_pm_opp_add() */
+	while (count--)
+		dev_pm_opp_put_opp_table(opp_table);
+
+	/* Drop the reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
+
 struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 {
 	struct dev_pm_opp *opp;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0a2a88e5a383..b895f4e79868 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -108,6 +108,7 @@ void dev_pm_opp_put(struct dev_pm_opp *opp);
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
 		   unsigned long u_volt);
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
+void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
 int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
@@ -217,6 +218,10 @@ static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
 }
 
+static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
+{
+}
+
 static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
 {
 	return 0;
-- 
2.19.1.568.g152ad8e3369a

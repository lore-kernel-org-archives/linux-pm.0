From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: 'UNKNOWN' status of opp-table->shared
Date: Thu, 16 Jun 2016 12:03:33 +0530
Message-ID: <87bd097db7b673b1f75ca2086dfa76f4dfbf7f8c.1466058619.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, acourbot@nvidia.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, linux-tegra@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_get_sharing_cpus() returns 0 even in the case where the OPP
core doesn't know if the table is shared or not. It is working for most
of the platforms, as the OPP table was never created and we returned
-ENODEV then.

But in case of one of the platforms (Jetson TK1) at least, the situation
is a bit different. The OPP table is created (somehow) before
dev_pm_opp_get_sharing_cpus() is called and so we returned 0. The caller
of this routine treated that as 'CPUs don't share OPPs' and that had bad
consequences on performance.

Fix this by converting 'shared_opp' to an integer and have an extra
value when its state in undefined. dev_pm_opp_get_sharing_cpus() returns
-EINVAL now in that case, so that the caller can handle it accordingly
(cpufreq-dt considers that as 'all CPUs share the table').

Fixes: 6f707daa3833 ("PM / OPP: Add dev_pm_opp_get_sharing_cpus()")
Reported-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Alexandre,

This is untested, can you please confirm if this fixes it for you?

 drivers/base/power/opp/core.c |  3 +++
 drivers/base/power/opp/cpu.c  | 12 +++++++++---
 drivers/base/power/opp/of.c   | 10 ++++++++--
 drivers/base/power/opp/opp.h  |  5 ++++-
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 7c04c87738a6..14d212885098 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -764,6 +764,9 @@ static struct opp_table *_add_opp_table(struct device *dev)
 	/* Set regulator to a non-NULL error value */
 	opp_table->regulator = ERR_PTR(-ENXIO);
 
+	/* Set sharing information as unknown */
+	opp_table->shared_opp = OPP_TABLE_SHARED_UNKNOWN;
+
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, NULL);
 	if (IS_ERR(opp_table->clk)) {
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 83d6e7ba1a34..4ca86df8a451 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -211,7 +211,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 		}
 
 		/* Mark opp-table as multiple CPUs are sharing it now */
-		opp_table->shared_opp = true;
+		opp_table->shared_opp = OPP_TABLE_IS_SHARED;
 	}
 unlock:
 	mutex_unlock(&opp_table_lock);
@@ -227,7 +227,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
  *
  * This updates the @cpumask with CPUs that are sharing OPPs with @cpu_dev.
  *
- * Returns -ENODEV if OPP table isn't already present.
+ * Returns -ENODEV if OPP table isn't already present and -EINVAL if the OPP
+ * table's status is shared-unknown.
  *
  * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex locks
@@ -249,9 +250,14 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		goto unlock;
 	}
 
+	if (opp_table->shared_opp == OPP_TABLE_SHARED_UNKNOWN) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	cpumask_clear(cpumask);
 
-	if (opp_table->shared_opp) {
+	if (opp_table->shared_opp == OPP_TABLE_IS_SHARED) {
 		list_for_each_entry(opp_dev, &opp_table->dev_list, node)
 			cpumask_set_cpu(opp_dev->dev->id, cpumask);
 	} else {
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 94d2010558e3..83ad3a6a16f1 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -34,7 +34,10 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 			 * But the OPPs will be considered as shared only if the
 			 * OPP table contains a "opp-shared" property.
 			 */
-			return opp_table->shared_opp ? opp_table : NULL;
+			if (opp_table->shared_opp == OPP_TABLE_IS_SHARED)
+				return opp_table;
+
+			return NULL;
 		}
 	}
 
@@ -353,7 +356,10 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	}
 
 	opp_table->np = opp_np;
-	opp_table->shared_opp = of_property_read_bool(opp_np, "opp-shared");
+	if (of_property_read_bool(opp_np, "opp-shared"))
+		opp_table->shared_opp = OPP_TABLE_IS_SHARED;
+	else
+		opp_table->shared_opp = OPP_TABLE_IS_NOT_SHARED;
 
 	mutex_unlock(&opp_table_lock);
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 20f3be22e060..ffd0b54e7894 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -166,7 +166,10 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
-	bool shared_opp;
+#define OPP_TABLE_IS_NOT_SHARED		0
+#define OPP_TABLE_IS_SHARED		1
+#define OPP_TABLE_SHARED_UNKNOWN	UINT_MAX
+	unsigned int shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
 	unsigned int *supported_hw;
-- 
2.7.1.410.g6faf27b

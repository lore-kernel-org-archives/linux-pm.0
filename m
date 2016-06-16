From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] PM / OPP: 'UNKNOWN' status of opp-table->shared
Date: Thu, 16 Jun 2016 19:03:11 +0530
Message-ID: <5909c884def1438bc2da83dbcc3c6ebddc28bba0.1466083891.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34219 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbcFPNdV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 09:33:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id bz2so18349279pad.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2016 06:33:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>

dev_pm_opp_get_sharing_cpus() returns 0 even in the case where the OPP
core doesn't know if the table is shared or not. It is working for most
of the platforms, as the OPP table was never created and we returned
-ENODEV then.

But in case of one of the platforms (Jetson TK1) at least, the situation
is a bit different. The OPP table is created (somehow) before
dev_pm_opp_get_sharing_cpus() is called and so we returned 0. The caller
of this routine treated that as 'CPUs don't share OPPs' and that had bad
consequences on performance.

Fix this by creating a converting 'shared_opp' to an enum.
dev_pm_opp_get_sharing_cpus() returns -EINVAL now in case the status in
access-unknown, so that the caller can handle it accordingly (cpufreq-dt
considers that as 'all CPUs share the table').

Fixes: 6f707daa3833 ("PM / OPP: Add dev_pm_opp_get_sharing_cpus()")
Reported-and-tested-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Use enum instead of macros.
- 0 is used for unknown now, and so no need to initialize it.

 drivers/base/power/opp/cpu.c | 12 +++++++++---
 drivers/base/power/opp/of.c  | 10 ++++++++--
 drivers/base/power/opp/opp.h |  8 +++++++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 83d6e7ba1a34..8c3434bdb26d 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -211,7 +211,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
 		}
 
 		/* Mark opp-table as multiple CPUs are sharing it now */
-		opp_table->shared_opp = true;
+		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
 	}
 unlock:
 	mutex_unlock(&opp_table_lock);
@@ -227,7 +227,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
  *
  * This updates the @cpumask with CPUs that are sharing OPPs with @cpu_dev.
  *
- * Returns -ENODEV if OPP table isn't already present.
+ * Returns -ENODEV if OPP table isn't already present and -EINVAL if the OPP
+ * table's status is access-unknown.
  *
  * Locking: The internal opp_table and opp structures are RCU protected.
  * Hence this function internally uses RCU updater strategy with mutex locks
@@ -249,9 +250,14 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		goto unlock;
 	}
 
+	if (opp_table->shared_opp == OPP_TABLE_ACCESS_UNKNOWN) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	cpumask_clear(cpumask);
 
-	if (opp_table->shared_opp) {
+	if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED) {
 		list_for_each_entry(opp_dev, &opp_table->dev_list, node)
 			cpumask_set_cpu(opp_dev->dev->id, cpumask);
 	} else {
diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 94d2010558e3..1dfd3dd92624 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -34,7 +34,10 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 			 * But the OPPs will be considered as shared only if the
 			 * OPP table contains a "opp-shared" property.
 			 */
-			return opp_table->shared_opp ? opp_table : NULL;
+			if (opp_table->shared_opp == OPP_TABLE_ACCESS_SHARED)
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
+		opp_table->shared_opp = OPP_TABLE_ACCESS_SHARED;
+	else
+		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 
 	mutex_unlock(&opp_table_lock);
 
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 20f3be22e060..fabd5ca1a083 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -119,6 +119,12 @@ struct opp_device {
 #endif
 };
 
+enum opp_table_access {
+	OPP_TABLE_ACCESS_UNKNOWN = 0,
+	OPP_TABLE_ACCESS_EXCLUSIVE = 1,
+	OPP_TABLE_ACCESS_SHARED = 2,
+};
+
 /**
  * struct opp_table - Device opp structure
  * @node:	table node - contains the devices with OPPs that
@@ -166,7 +172,7 @@ struct opp_table {
 	/* For backward compatibility with v1 bindings */
 	unsigned int voltage_tolerance_v1;
 
-	bool shared_opp;
+	enum opp_table_access shared_opp;
 	struct dev_pm_opp *suspend_opp;
 
 	unsigned int *supported_hw;
-- 
2.7.1.410.g6faf27b


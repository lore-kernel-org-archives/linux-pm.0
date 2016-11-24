From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] PM / OPP: fix CPU device to be removed from OPP table in wrong
 order
Date: Thu, 24 Nov 2016 16:49:21 +0900
Message-ID: <1479973761-21225-1-git-send-email-jy0922.shim@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60165 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbcKXHsl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 02:48:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, jy0922.shim@samsung.com

The device that creates OPP table first should be removed from dev_list
of OPP table in last because it can be used by other resources
(supported_hw, prop_name, regulator), but not now. If OPP table is
shared by several CPUs, the CPU device that creates OPP table can be
removed earlier than other CPU devices.

This patch makes that the CPU device that creates OPP table is removed
last.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/base/power/opp/cpu.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 8c3434bdb26d..9d0773a237f8 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -118,9 +118,36 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
+static bool dev_pm_opp_is_removed_last(struct device *dev)
+{
+	struct opp_device *opp_dev;
+	struct opp_table *opp_table;
+	bool ret = false;
+
+	mutex_lock(&opp_table_lock);
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		goto unlock;
+
+	if (list_is_singular(&opp_table->dev_list))
+		goto unlock;
+
+	opp_dev = list_last_entry(&opp_table->dev_list, struct opp_device,
+				  node);
+	if (opp_dev->dev == dev)
+		ret = true;
+
+unlock:
+	mutex_unlock(&opp_table_lock);
+
+	return ret;
+}
+
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 {
 	struct device *cpu_dev;
+	struct device *last = NULL;
 	int cpu;
 
 	WARN_ON(cpumask_empty(cpumask));
@@ -133,11 +160,23 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 			continue;
 		}
 
+		if (!last && dev_pm_opp_is_removed_last(cpu_dev)) {
+			last = cpu_dev;
+			continue;
+		}
+
 		if (of)
 			dev_pm_opp_of_remove_table(cpu_dev);
 		else
 			dev_pm_opp_remove_table(cpu_dev);
 	}
+
+	if (last) {
+		if (of)
+			dev_pm_opp_of_remove_table(last);
+		else
+			dev_pm_opp_remove_table(last);
+	}
 }
 
 /**
-- 
1.9.1


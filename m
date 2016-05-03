From: Eric Engestrom <eric.engestrom@imgtec.com>
Subject: [PATCH] Fix CONFIG_PM_OPP without CONFIG_OF build failure
Date: Tue, 3 May 2016 14:14:38 +0100
Message-ID: <1462281278-8553-1-git-send-email-eric.engestrom@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:30723 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbcECNOh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 09:14:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rufus Hamade <rufus.hamade@imgtec.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

From: Rufus Hamade <rufus.hamade@imgtec.com>

A few `#ifdef CONFIG_OF` were missing or misplaced, resulting in a few
"unused function" warnings in core.c, and preventing the build of cpu.c
because of the redefinition of `dev_pm_opp_set_sharing_cpus()`.

Signed-off-by: Rufus Hamade <rufus.hamade@imgtec.com>
Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>
Tested-by: Eric Engestrom <eric.engestrom@imgtec.com>
---
 drivers/base/power/opp/core.c | 6 ++++++
 drivers/base/power/opp/cpu.c  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 433b600..bc5448c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -53,6 +53,7 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
 	return NULL;
 }
 
+#ifdef CONFIG_OF
 static struct opp_table *_managed_opp(const struct device_node *np)
 {
 	struct opp_table *opp_table;
@@ -72,6 +73,7 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 
 	return NULL;
 }
+#endif
 
 /**
  * _find_opp_table() - find opp_table struct using device pointer
@@ -1115,6 +1117,7 @@ static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
 	return ret;
 }
 
+#ifdef CONFIG_OF
 /* TODO: Support multiple regulators */
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			      struct opp_table *opp_table)
@@ -1191,6 +1194,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 
 	return 0;
 }
+#endif
 
 /**
  * dev_pm_opp_set_supported_hw() - Set supported platforms
@@ -1520,6 +1524,7 @@ void dev_pm_opp_put_regulator(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_regulator);
 
+#ifdef CONFIG_OF
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
@@ -1657,6 +1662,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	mutex_unlock(&opp_table_lock);
 	return ret;
 }
+#endif
 
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index ba2bdbd..8aae170 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -119,6 +119,7 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
+#ifdef CONFIG_OF
 /* Required only for V1 bindings, as v2 can manage it from DT itself */
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 {
@@ -160,7 +161,6 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
 
-#ifdef CONFIG_OF
 void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
 {
 	struct device *cpu_dev;
-- 
2.8.1


From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / OPP: pass cpumask by reference
Date: Sat, 30 Apr 2016 13:33:29 +0200
Message-ID: <1462016049-1976580-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56745 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbcD3Lef (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Apr 2016 07:34:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The new use of dev_pm_opp_set_sharing_cpus resulted in a harmless compiler
warning with CONFIG_CPUMASK_OFFSTACK=y:

drivers/cpufreq/mvebu-cpufreq.c: In function 'armada_xp_pmsu_cpufreq_init':
include/linux/cpumask.h:550:25: error: passing argument 2 of 'dev_pm_opp_set_sharing_cpus' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

The problem here is that cpumask_var_t gets passed by reference, but
by declaring a 'const cpumask_var_t' argument, only the pointer is
constant, not the actual mask. This is harmless because the function
does not actually modify the mask.

This patch changes the function prototypes for all of the related functions
to pass a 'struct cpumask *' instead of 'cpumask_var_t', matching what
most other such functions do in the kernel. This lets us mark all the
other similar functions as taking a 'const' mask where possible,
and it avoids the warning without any change in object code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 947bd567f7a5 ("mvebu: Use dev_pm_opp_set_sharing_cpus() to mark OPP tables as shared")
---
 drivers/base/power/opp/cpu.c | 10 +++++-----
 include/linux/pm_opp.h       | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 3428380dfca7..8e0b6349d7d4 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -132,7 +132,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
+void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -164,7 +164,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
+int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 {
 	struct device *cpu_dev;
 	int cpu, ret = 0;
@@ -217,7 +217,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
 	struct device_node *np, *tmp_np;
 	struct device *tcpu_dev;
@@ -288,7 +288,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
  * mutex cannot be locked.
  */
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev,
-				const cpumask_var_t cpumask)
+				const struct cpumask *cpumask)
 {
 	struct opp_device *opp_dev;
 	struct opp_table *opp_table;
@@ -346,7 +346,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
  * that this function is *NOT* called under RCU protection or in contexts where
  * mutex cannot be locked.
  */
-int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
 	struct opp_device *opp_dev;
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 15f554443b59..5221d259e413 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -65,8 +65,8 @@ void dev_pm_opp_put_prop_name(struct device *dev);
 int dev_pm_opp_set_regulator(struct device *dev, const char *name);
 void dev_pm_opp_put_regulator(struct device *dev);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
-int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const cpumask_var_t cpumask);
-int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
+int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 #else
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
@@ -180,12 +180,12 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -ENOTSUPP;
 }
 
-static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const cpumask_var_t cpumask)
+static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
 }
 
-static inline int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+static inline int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
 	return -EINVAL;
 }
@@ -195,9 +195,9 @@ static inline int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_va
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
 void dev_pm_opp_of_remove_table(struct device *dev);
-int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask);
-void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask);
-int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask);
+int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
+void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
+int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -208,16 +208,16 @@ static inline void dev_pm_opp_of_remove_table(struct device *dev)
 {
 }
 
-static inline int dev_pm_opp_of_cpumask_add_table(cpumask_var_t cpumask)
+static inline int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
 }
 
-static inline void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
+static inline void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
 }
 
-static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
+static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
 }
-- 
2.7.0


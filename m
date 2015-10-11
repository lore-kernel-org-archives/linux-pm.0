From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/5] cpufreq: remove cpufreq_sysfs_{create|remove}_file()
Date: Sun, 11 Oct 2015 22:51:12 +0530
Message-ID: <c043df8bd8f38a9ecf257c3faefc5091fc8e38cc.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

They don't do anything special now, remove the unnecessary wrapper.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 22 +++++-----------------
 include/linux/cpufreq.h   |  2 --
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index db688d18a189..2cb0e3b8170e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -880,21 +880,6 @@ static struct kobj_type ktype_cpufreq = {
 	.release	= cpufreq_sysfs_release,
 };
 
-struct kobject *cpufreq_global_kobject;
-EXPORT_SYMBOL(cpufreq_global_kobject);
-
-int cpufreq_sysfs_create_file(const struct attribute *attr)
-{
-	return sysfs_create_file(cpufreq_global_kobject, attr);
-}
-EXPORT_SYMBOL(cpufreq_sysfs_create_file);
-
-void cpufreq_sysfs_remove_file(const struct attribute *attr)
-{
-	sysfs_remove_file(cpufreq_global_kobject, attr);
-}
-EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
-
 static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
 {
 	struct device *cpu_dev;
@@ -2397,7 +2382,7 @@ static int create_boost_sysfs_file(void)
 	if (!cpufreq_driver->set_boost)
 		cpufreq_driver->set_boost = cpufreq_boost_set_sw;
 
-	ret = cpufreq_sysfs_create_file(&boost.attr);
+	ret = sysfs_create_file(cpufreq_global_kobject, &boost.attr);
 	if (ret)
 		pr_err("%s: cannot register global BOOST sysfs file\n",
 		       __func__);
@@ -2408,7 +2393,7 @@ static int create_boost_sysfs_file(void)
 static void remove_boost_sysfs_file(void)
 {
 	if (cpufreq_boost_supported())
-		cpufreq_sysfs_remove_file(&boost.attr);
+		sysfs_remove_file(cpufreq_global_kobject, &boost.attr);
 }
 
 int cpufreq_enable_boost_support(void)
@@ -2556,6 +2541,9 @@ static struct syscore_ops cpufreq_syscore_ops = {
 	.shutdown = cpufreq_suspend,
 };
 
+struct kobject *cpufreq_global_kobject;
+EXPORT_SYMBOL(cpufreq_global_kobject);
+
 static int __init cpufreq_core_init(void)
 {
 	if (cpufreq_disabled())
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 338bf0e59bb8..9623218d996a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -149,8 +149,6 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 
 /* /sys/devices/system/cpu/cpufreq: entry point for global variables */
 extern struct kobject *cpufreq_global_kobject;
-int cpufreq_sysfs_create_file(const struct attribute *attr);
-void cpufreq_sysfs_remove_file(const struct attribute *attr);
 
 #ifdef CONFIG_CPU_FREQ
 unsigned int cpufreq_get(unsigned int cpu);
-- 
2.4.0

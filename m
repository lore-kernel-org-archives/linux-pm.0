From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [RESEND PATCH] cpufreq: cpufreq: Fix coding style issues
Date: Sun, 23 Aug 2015 22:13:55 +0530
Message-ID: <1440348235-7789-1-git-send-email-falakreyaz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Muhammad Falak R Wani <falakreyaz@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch introduces a blank line after declarations, which
fix the checkpatch.pl warnings at 3 places.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8ae655c..5aea659 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -718,6 +718,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 {
 	unsigned int limit;
 	int ret;
+
 	if (cpufreq_driver->bios_limit) {
 		ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
 		if (!ret)
@@ -815,6 +816,7 @@ unlock:
 static void cpufreq_sysfs_release(struct kobject *kobj)
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
+
 	pr_debug("last reference is dropped\n");
 	complete(&policy->kobj_unregister);
 }
@@ -2129,6 +2131,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 {
 	struct cpufreq_policy *cpu_policy;
+
 	if (!policy)
 		return -EINVAL;
 
-- 
1.9.1

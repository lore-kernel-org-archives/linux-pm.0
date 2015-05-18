From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 09/14] cpufreq: add/remove sysfs links via cpufreq_add_remove_dev_symlink()
Date: Mon, 18 May 2015 10:43:32 +0530
Message-ID: <93a3bfbe26dfa1c298e21da369e6ed37fca1da34.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33206 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbERFOZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:14:25 -0400
Received: by pdbqa5 with SMTP id qa5so133391682pdb.0
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:14:24 -0700 (PDT)
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

Later patches would require us to add/remove all sysfs links together.
Create another routine cpufreq_add_remove_dev_symlink() to do that.

This is a preparatory step for the next patch and is done separately for
easier reviews.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7fc3d9294f8..b5e883f497dd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -957,25 +957,42 @@ void cpufreq_sysfs_remove_file(const struct attribute *attr)
 }
 EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 
-/* symlink affected CPUs */
-static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
+static inline int add_remove_cpu_dev_symlink(struct cpufreq_policy *policy,
+					     int cpu, bool add)
+{
+	struct device *cpu_dev;
+
+	pr_debug("%s: %s symlink for CPU: %u\n", __func__,
+		 add ? "Adding" : "Removing", cpu);
+
+	cpu_dev = get_cpu_device(cpu);
+	if (WARN_ON(!cpu_dev))
+		return 0;
+
+	if (add)
+		return sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
+					 "cpufreq");
+
+	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
+	return 0;
+}
+
+/* Add/remove symlinks for all affected CPUs */
+static int cpufreq_add_remove_dev_symlink(struct cpufreq_policy *policy,
+					  bool add)
 {
 	unsigned int j;
 	int ret = 0;
 
 	for_each_cpu(j, policy->cpus) {
-		struct device *cpu_dev;
-
 		if (j == policy->kobj_cpu)
 			continue;
 
-		pr_debug("Adding link for CPU: %u\n", j);
-		cpu_dev = get_cpu_device(j);
-		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
-					"cpufreq");
+		ret = add_remove_cpu_dev_symlink(policy, j, add);
 		if (ret)
 			break;
 	}
+
 	return ret;
 }
 
@@ -1009,7 +1026,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 			return ret;
 	}
 
-	return cpufreq_add_dev_symlink(policy);
+	return cpufreq_add_remove_dev_symlink(policy, true);
 }
 
 static void cpufreq_init_policy(struct cpufreq_policy *policy)
-- 
2.4.0


From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Rearrange cpufreq_add_dev()
Date: Thu, 07 Apr 2016 03:31:57 +0200
Message-ID: <25180596.UsWVYNr6Fj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reorganize the code in cpufreq_add_dev() to avoid using the ret
variable and reduce the indentation level in it.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1311,26 +1311,24 @@ out_free_policy:
  */
 static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
+	struct cpufreq_policy *policy;
 	unsigned cpu = dev->id;
-	int ret;
 
 	dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
 
-	if (cpu_online(cpu)) {
-		ret = cpufreq_online(cpu);
-	} else {
-		/*
-		 * A hotplug notifier will follow and we will handle it as CPU
-		 * online then.  For now, just create the sysfs link, unless
-		 * there is no policy or the link is already present.
-		 */
-		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+	if (cpu_online(cpu))
+		return cpufreq_online(cpu);
 
-		ret = policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
-			? add_cpu_dev_symlink(policy, cpu) : 0;
-	}
+	/*
+	 * A hotplug notifier will follow and we will handle it as CPU online
+	 * then.  For now, just create the sysfs link, unless there is no policy
+	 * or the link is already present.
+	 */
+	policy = per_cpu(cpufreq_cpu_data, cpu);
+	if (!policy || cpumask_test_and_set_cpu(cpu, policy->real_cpus))
+		return 0;
 
-	return ret;
+	return add_cpu_dev_symlink(policy, cpu);
 }
 
 static void cpufreq_offline(unsigned int cpu)

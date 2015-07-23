From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: Rename two functions related to CPU offline
Date: Thu, 23 Jul 2015 02:01:26 +0200
Message-ID: <12623174.AEREjEhPIr@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44042 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752867AbbGVXiq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 19:38:46 -0400
In-Reply-To: <7868353.pEStq1MJ2a@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since __cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
are about CPU offline rather than about CPU removal, rename them to
cpufreq_offline_prepare() and cpufreq_offline_finish(), respectively.

Also change their argument from a struct device pointer to a CPU
number, because they use the CPU number only internally anyway.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1376,9 +1376,8 @@ out_release_rwsem:
 	return ret;
 }
 
-static void __cpufreq_remove_dev_prepare(struct device *dev)
+static void cpufreq_offline_prepare(unsigned int cpu)
 {
-	unsigned int cpu = dev->id;
 	struct cpufreq_policy *policy;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
@@ -1423,9 +1422,8 @@ static void __cpufreq_remove_dev_prepare
 	}
 }
 
-static void __cpufreq_remove_dev_finish(struct device *dev)
+static void cpufreq_offline_finish(unsigned int cpu)
 {
-	unsigned int cpu = dev->id;
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	if (!policy) {
@@ -1467,8 +1465,8 @@ static int cpufreq_remove_dev(struct dev
 		return 0;
 
 	if (cpu_online(cpu)) {
-		__cpufreq_remove_dev_prepare(dev);
-		__cpufreq_remove_dev_finish(dev);
+		cpufreq_offline_prepare(cpu);
+		cpufreq_offline_finish(cpu);
 	}
 
 	/* sysfs links are removed only on subsys callback */
@@ -2360,11 +2358,11 @@ static int cpufreq_cpu_callback(struct n
 			break;
 
 		case CPU_DOWN_PREPARE:
-			__cpufreq_remove_dev_prepare(dev);
+			cpufreq_offline_prepare(cpu);
 			break;
 
 		case CPU_POST_DEAD:
-			__cpufreq_remove_dev_finish(dev);
+			cpufreq_offline_finish(cpu);
 			break;
 
 		case CPU_DOWN_FAILED:


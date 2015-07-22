From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Drop unnecessary arguments from two functions
Date: Wed, 22 Jul 2015 04:09:08 +0200
Message-ID: <1710735.NHMxY7dJsV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48059 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750872AbbGVBmX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 21:42:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The second sif argument of __cpufreq_remove_dev_prepare() is
never used by it, so drop it.

The second sif argument of __cpufreq_remove_dev_finish() is only
used for one check that is not necessary if the policy is freed
by cpufreq_remove_dev() itself, so make cpufreq_remove_dev() free
the policy and drop the __cpufreq_remove_dev_finish()'s second
argument too.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1421,8 +1421,7 @@ out_release_rwsem:
 	return ret;
 }
 
-static int __cpufreq_remove_dev_prepare(struct device *dev,
-					struct subsys_interface *sif)
+static int __cpufreq_remove_dev_prepare(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret = 0;
@@ -1474,8 +1473,7 @@ static int __cpufreq_remove_dev_prepare(
 	return ret;
 }
 
-static int __cpufreq_remove_dev_finish(struct device *dev,
-				       struct subsys_interface *sif)
+static int __cpufreq_remove_dev_finish(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret;
@@ -1507,10 +1505,6 @@ static int __cpufreq_remove_dev_finish(s
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
-	/* Free the policy only if the driver is getting removed. */
-	if (sif)
-		cpufreq_policy_free(policy, true);
-
 	return 0;
 }
 
@@ -1522,6 +1516,7 @@ static int __cpufreq_remove_dev_finish(s
 static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int cpu = dev->id;
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 	int ret;
 
 	/*
@@ -1530,7 +1525,6 @@ static int cpufreq_remove_dev(struct dev
 	 * link or free policy here.
 	 */
 	if (cpu_is_offline(cpu)) {
-		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 		struct cpumask mask;
 
 		if (!policy)
@@ -1547,17 +1541,18 @@ static int cpufreq_remove_dev(struct dev
 			remove_cpu_dev_symlink(policy, cpu);
 			return 0;
 		}
+	} else {
+		ret = __cpufreq_remove_dev_prepare(dev);
+		if (!ret)
+			ret = __cpufreq_remove_dev_finish(dev);
 
-		cpufreq_policy_free(policy, true);
-		return 0;
+		/* The CPU is online, so the policy cannot be inactive here. */
+		if (ret)
+			return ret;
 	}
 
-	ret = __cpufreq_remove_dev_prepare(dev, sif);
-
-	if (!ret)
-		ret = __cpufreq_remove_dev_finish(dev, sif);
-
-	return ret;
+	cpufreq_policy_free(policy, true);
+	return 0;
 }
 
 static void handle_update(struct work_struct *work)
@@ -2396,11 +2391,11 @@ static int cpufreq_cpu_callback(struct n
 			break;
 
 		case CPU_DOWN_PREPARE:
-			__cpufreq_remove_dev_prepare(dev, NULL);
+			__cpufreq_remove_dev_prepare(dev);
 			break;
 
 		case CPU_POST_DEAD:
-			__cpufreq_remove_dev_finish(dev, NULL);
+			__cpufreq_remove_dev_finish(dev);
 			break;
 
 		case CPU_DOWN_FAILED:


From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH v2 1/2] thermal: cpu_cooling: Remove cpu_dev update on policy CPU update
Date: Mon, 16 Mar 2015 12:00:50 +0000
Message-ID: <1426507251-26613-2-git-send-email-kapileshwar.singh@arm.com>
References: <1426507251-26613-1-git-send-email-kapileshwar.singh@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56221 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbbCPMBL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Mar 2015 08:01:11 -0400
In-Reply-To: <1426507251-26613-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, Javi.Merino@arm.com, Punit.Agrawal@arm.com, kapileshwar.singh@arm.com

It was initially understood that an update to the cpu_device
(cached in cpufreq_cooling_device) was required to ascertain the
correct operating point of the device on a cpufreq policy->cpu update
or creation or deletion of a cpufreq policy.
(e.g. when the existing policy CPU goes offline).

This update is not required and it is possible to ascertain the OPPs
from the leading CPU in a cpufreq domain even if the CPU is hotplugged out.

Fixes: e0128d8ab423 ("thermal: cpu_cooling: implement the power cooling device API")
Acked-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/cpu_cooling.c |   40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c4974144c787..2e15133b4793 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -199,39 +199,6 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
 
-static void update_cpu_device(int cpu)
-{
-	struct cpufreq_cooling_device *cpufreq_dev;
-
-	mutex_lock(&cooling_cpufreq_lock);
-	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
-			cpufreq_dev->cpu_dev = get_cpu_device(cpu);
-			if (!cpufreq_dev->cpu_dev) {
-				dev_warn(&cpufreq_dev->cool_dev->device,
-					"No cpu device for new policy cpu %d\n",
-					 cpu);
-			}
-			break;
-		}
-	}
-	mutex_unlock(&cooling_cpufreq_lock);
-}
-
-static void remove_cpu_device(int cpu)
-{
-	struct cpufreq_cooling_device *cpufreq_dev;
-
-	mutex_lock(&cooling_cpufreq_lock);
-	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
-			cpufreq_dev->cpu_dev = NULL;
-			break;
-		}
-	}
-	mutex_unlock(&cooling_cpufreq_lock);
-}
-
 /**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
@@ -268,13 +235,6 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		}
 		mutex_unlock(&cooling_cpufreq_lock);
 		break;
-
-	case CPUFREQ_CREATE_POLICY:
-		update_cpu_device(policy->cpu);
-		break;
-	case CPUFREQ_REMOVE_POLICY:
-		remove_cpu_device(policy->cpu);
-		break;
 	default:
 		return NOTIFY_DONE;
 	}
-- 
1.7.9.5


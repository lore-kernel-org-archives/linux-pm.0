From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH v2 2/2] thermal: cpu_cooling: Fix power calculation when CPUs are offline
Date: Mon, 16 Mar 2015 12:00:51 +0000
Message-ID: <1426507251-26613-3-git-send-email-kapileshwar.singh@arm.com>
References: <1426507251-26613-1-git-send-email-kapileshwar.singh@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56226 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbbCPMBP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Mar 2015 08:01:15 -0400
In-Reply-To: <1426507251-26613-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, Javi.Merino@arm.com, Punit.Agrawal@arm.com, kapileshwar.singh@arm.com

Ensure that the CPU for which the frequency is being requested
is online. If none of the CPUs are online the requested power is
returned as 0.

Acked-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/cpu_cooling.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 2e15133b4793..07a9629edf4b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -555,7 +555,18 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 	u32 *load_cpu = NULL;
 
-	freq = cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
+	cpu = cpumask_any_and(&cpufreq_device->allowed_cpus, cpu_online_mask);
+
+	/*
+	 * All the CPUs are offline, thus the requested power by
+	 * the cdev is 0
+	 */
+	if (cpu >= nr_cpu_ids) {
+		*power = 0;
+		return 0;
+	}
+
+	freq = cpufreq_quick_get(cpu);
 
 	if (trace_thermal_power_cpu_get_power_enabled()) {
 		u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
-- 
1.7.9.5


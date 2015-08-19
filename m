From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] thermal: cpu_cooling: Remove usage of devm functions
Date: Wed, 19 Aug 2015 11:52:19 +0530
Message-ID: <20150819062219.GA10032@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35266 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbHSGWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 02:22:24 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

In the function cpufreq_get_requested_power, the memory allocated
for load_cpu is live within the function only. And after the
allocation it is immediately freed with devm_kfree. There is no
need to allocate memory for load_cpu with devm function so replace
devm_kcalloc with kcalloc and devm_kfree with kfree.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
This patch is having one checkpatch.pl warning which suggests that
kfree(NULL) is safe. But I think leaving code with if is nice
because it reflects the fact that kcalloc was under an if. So, I
have ignored checkpatch. If maintainer wants me to go for changing
things, I am fine with it too.
---
 drivers/thermal/cpu_cooling.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 620dcd4..babf8b3 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -584,8 +584,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	if (trace_thermal_power_cpu_get_power_enabled()) {
 		u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
 
-		load_cpu = devm_kcalloc(&cdev->device, ncpus, sizeof(*load_cpu),
-					GFP_KERNEL);
+		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
 	}
 
 	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
@@ -609,7 +608,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
 	if (ret) {
 		if (load_cpu)
-			devm_kfree(&cdev->device, load_cpu);
+			kfree(load_cpu);
 		return ret;
 	}
 
@@ -618,7 +617,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 			&cpufreq_device->allowed_cpus,
 			freq, load_cpu, i, dynamic_power, static_power);
 
-		devm_kfree(&cdev->device, load_cpu);
+		kfree(load_cpu);
 	}
 
 	*power = static_power + dynamic_power;
-- 
1.9.1


From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH] drivers: thermal: cpu_cooling: fix checkpatch warning
Date: Tue, 26 Feb 2013 14:42:41 +0100
Message-ID: <1361886162-9387-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:56252 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757797Ab3BZNjh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 08:39:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>

- WARNING: Avoid CamelCase: <maskPtr>

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/thermal/cpu_cooling.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 836828e..47b7d32 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -175,8 +175,8 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 				unsigned long cooling_state)
 {
 	unsigned int cpuid, clip_freq;
-	struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
-	unsigned int cpu = cpumask_any(maskPtr);
+	struct cpumask *mask = &cpufreq_device->allowed_cpus;
+	unsigned int cpu = cpumask_any(mask);
 
 
 	/* Check if the old cooling action is same as new cooling action */
@@ -191,7 +191,7 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 	cpufreq_device->cpufreq_val = clip_freq;
 	notify_device = cpufreq_device;
 
-	for_each_cpu(cpuid, maskPtr) {
+	for_each_cpu(cpuid, mask) {
 		if (is_cpufreq_valid(cpuid))
 			cpufreq_update_policy(cpuid);
 	}
-- 
1.7.10.4


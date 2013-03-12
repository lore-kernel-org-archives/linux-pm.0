From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH V2] drivers: thermal: cpu_cooling: fix checkpatch warning
Date: Tue, 12 Mar 2013 11:47:50 +0100
Message-ID: <1363085270-22886-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-pm@vger.kernel.org

- WARNING: Avoid CamelCase: <maskPtr>

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/thermal/cpu_cooling.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 8dc44cb..be2e6b0 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -168,8 +168,8 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 				unsigned long cooling_state)
 {
 	unsigned int cpuid, clip_freq;
-	struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
-	unsigned int cpu = cpumask_any(maskPtr);
+	struct cpumask *mask = &cpufreq_device->allowed_cpus;
+	unsigned int cpu = cpumask_any(mask);
 
 
 	/* Check if the old cooling action is same as new cooling action */
@@ -184,7 +184,7 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 	cpufreq_device->cpufreq_val = clip_freq;
 	notify_device = cpufreq_device;
 
-	for_each_cpu(cpuid, maskPtr) {
+	for_each_cpu(cpuid, mask) {
 		if (is_cpufreq_valid(cpuid))
 			cpufreq_update_policy(cpuid);
 	}
@@ -235,13 +235,13 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
-	struct cpumask *maskPtr = &cpufreq_device->allowed_cpus;
+	struct cpumask *mask = &cpufreq_device->allowed_cpus;
 	unsigned int cpu;
 	struct cpufreq_frequency_table *table;
 	unsigned long count = 0;
 	int i = 0;
 
-	cpu = cpumask_any(maskPtr);
+	cpu = cpumask_any(mask);
 	table = cpufreq_frequency_get_table(cpu);
 	if (!table) {
 		*state = 0;
-- 
1.7.10.4

From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 31/34] thermal: cpu cooling: use const parameter while registering
Date: Sun,  2 Dec 2012 22:45:05 +0800
Message-ID: <1354459508-3707-31-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52515 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab2LBOp4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:56 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>

From: Eduardo Valentin <eduardo.valentin@ti.com>

There are predefined cpu_masks that are const data structures.
This patch changes the cpu cooling register function so that
those const cpu_masks can be used, without compilation warnings.

include/linux/cpumask.h

 * The following particular system cpumasks and operations manage
 * possible, present, active and online cpus.
 *
 *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
 *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
 *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
 *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
 *

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c |    2 +-
 include/linux/cpu_cooling.h   |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6f94c2c..836828e 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -313,7 +313,7 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
  */
 struct thermal_cooling_device *cpufreq_cooling_register(
-	struct cpumask *clip_cpus)
+	const struct cpumask *clip_cpus)
 {
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev = NULL;
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 8515301..b30cc79c 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -35,7 +35,7 @@
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen
  */
 struct thermal_cooling_device *cpufreq_cooling_register(
-		struct cpumask *clip_cpus);
+		const struct cpumask *clip_cpus);
 
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
@@ -44,7 +44,7 @@ struct thermal_cooling_device *cpufreq_cooling_register(
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *cpufreq_cooling_register(
-	struct cpumask *clip_cpus)
+	const struct cpumask *clip_cpus)
 {
 	return NULL;
 }
-- 
1.7.7.6


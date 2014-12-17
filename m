From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: cpu_cooling: return ERR_PTR() for !CPU_THERMAL or !THERMAL_OF
Date: Wed, 17 Dec 2014 11:11:24 +0000
Message-ID: <1418814684-16441-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51064 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaLQLLm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 06:11:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

The documentation of of_cpufreq_cooling_register() and
cpufreq_cooling_register() say that they return ERR_PTR() on error.
Accordingly, callers only check for IS_ERR().  Therefore, make them
return ERR_PTR(-ENOSYS) as is customary in the kernel when config
options are missing.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 include/linux/cpu_cooling.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index c303d383def1..bd955270d5aa 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -50,7 +50,7 @@ static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
 			    const struct cpumask *clip_cpus)
 {
-	return NULL;
+	return ERR_PTR(-ENOSYS);
 }
 #endif
 
@@ -65,13 +65,13 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq);
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus)
 {
-	return NULL;
+	return ERR_PTR(-ENOSYS);
 }
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
 			    const struct cpumask *clip_cpus)
 {
-	return NULL;
+	return ERR_PTR(-ENOSYS);
 }
 static inline
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
-- 
1.9.1


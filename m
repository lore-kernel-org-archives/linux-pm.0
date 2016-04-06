From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/13] intel_idle: Fix dangling registration on error path.
Date: Wed,  6 Apr 2016 17:00:52 -0400
Message-ID: <5d037867513fc625797e489d052ce1c874709994.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34693 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbcDFVBr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:01:47 -0400
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>

From: Richard Cochran <rcochran@linutronix.de>

In the module_init() method, if the per-CPU allocation fails, then the
active cpuidle registration is not cleaned up.  This patch fixes the
issue by attempting the allocation before registration, and then
cleaning it up again on registration failure.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5b309e5..085538a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1347,19 +1347,20 @@ static int __init intel_idle_init(void)
 	if (retval)
 		return retval;
 
+	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
+	if (intel_idle_cpuidle_devices == NULL)
+		return -ENOMEM;
+
 	intel_idle_cpuidle_driver_init();
 	retval = cpuidle_register_driver(&intel_idle_driver);
 	if (retval) {
 		struct cpuidle_driver *drv = cpuidle_get_driver();
 		printk(KERN_DEBUG PREFIX "intel_idle yielding to %s",
 			drv ? drv->name : "none");
+		free_percpu(intel_idle_cpuidle_devices);
 		return retval;
 	}
 
-	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (intel_idle_cpuidle_devices == NULL)
-		return -ENOMEM;
-
 	cpu_notifier_register_begin();
 
 	for_each_online_cpu(i) {
-- 
2.8.0.rc4.16.g56331f8


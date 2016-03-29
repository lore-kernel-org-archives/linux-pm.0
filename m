From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 05/10] intel_idle: Fix dangling registration on error path.
Date: Tue, 29 Mar 2016 15:15:57 +0200
Message-ID: <3a0f327af48507403d9ca332251e63a127efeb4b.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In the module_init() method, if the per-CPU allocation fails, then the
active cpuidle registration is not cleaned up.  This patch fixes the
issue by attempting the allocation before registration, and then
cleaning it up again on registration failure.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 4a1de3d..5dd741f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1210,19 +1210,20 @@ static int __init intel_idle_init(void)
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
2.1.4

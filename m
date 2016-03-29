From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 08/10] intel_idle: Don't overreact to a cpuidle registration failure.
Date: Tue, 29 Mar 2016 15:16:00 +0200
Message-ID: <059bd45a474fa9de072f2ef19083694dde9ab183.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The helper function, intel_idle_cpu_init, registers one new device
with the cpuidle layer.  If the registration should fail, that
function immediately calls intel_idle_cpuidle_devices_uninit() to
unregister every last CPU's device.  However, it makes no sense to do
so, when called from the hot plug notifier callback.

This patch moves the call to intel_idle_cpuidle_devices_uninit()
outside of the helper function to the one call site that actually
needs to perform the de-registrations.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ab34cd8..4418cfa 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1175,7 +1175,6 @@ static int intel_idle_cpu_init(int cpu)
 
 	if (cpuidle_register_device(dev)) {
 		pr_debug(PREFIX "cpuidle_register_device %d failed!\n", cpu);
-		intel_idle_cpuidle_devices_uninit();
 		return -EIO;
 	}
 
@@ -1219,6 +1218,7 @@ static int __init intel_idle_init(void)
 	for_each_online_cpu(i) {
 		retval = intel_idle_cpu_init(i);
 		if (retval) {
+			intel_idle_cpuidle_devices_uninit();
 			cpu_notifier_register_done();
 			cpuidle_unregister_driver(&intel_idle_driver);
 			free_percpu(intel_idle_cpuidle_devices);
-- 
2.1.4

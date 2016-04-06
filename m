From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/13] intel_idle: Don't overreact to a cpuidle registration failure.
Date: Wed,  6 Apr 2016 17:00:55 -0400
Message-ID: <11627a78142677a4cef5c0f19923e36757d3ebdb.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35618 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbcDFVBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:01:45 -0400
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>

From: Richard Cochran <rcochran@linutronix.de>

The helper function, intel_idle_cpu_init, registers one new device
with the cpuidle layer.  If the registration should fail, that
function immediately calls intel_idle_cpuidle_devices_uninit() to
unregister every last CPU's device.  However, it makes no sense to do
so, when called from the hot plug notifier callback.

This patch moves the call to intel_idle_cpuidle_devices_uninit()
outside of the helper function to the one call site that actually
needs to perform the de-registrations.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b5e92dd..807be29 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1312,7 +1312,6 @@ static int intel_idle_cpu_init(int cpu)
 
 	if (cpuidle_register_device(dev)) {
 		pr_debug(PREFIX "cpuidle_register_device %d failed!\n", cpu);
-		intel_idle_cpuidle_devices_uninit();
 		return -EIO;
 	}
 
@@ -1356,6 +1355,7 @@ static int __init intel_idle_init(void)
 	for_each_online_cpu(i) {
 		retval = intel_idle_cpu_init(i);
 		if (retval) {
+			intel_idle_cpuidle_devices_uninit();
 			cpu_notifier_register_done();
 			cpuidle_unregister_driver(&intel_idle_driver);
 			free_percpu(intel_idle_cpuidle_devices);
-- 
2.8.0.rc4.16.g56331f8


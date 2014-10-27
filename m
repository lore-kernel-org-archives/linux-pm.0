From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 31/47] x86: apm: Register with kernel power-off handler
Date: Mon, 27 Oct 2014 08:55:38 -0700
Message-ID: <1414425354-10359-32-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50196 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbaJ0P5Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:57:16 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XimfT-000cyB-LG
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:57:15 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with high priority to reflect that the original code
overwrites existing power-off handlers.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority

 arch/x86/kernel/apm_32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 5848744..a5c9066 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -219,6 +219,7 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 #include <linux/capability.h>
 #include <linux/device.h>
@@ -981,7 +982,8 @@ recalc:
  *	on their first cpu.
  */
 
-static void apm_power_off(void)
+static int apm_power_off(struct notifier_block *this, unsigned long unused1,
+			 void *unused2)
 {
 	/* Some bioses don't like being called from CPU != 0 */
 	if (apm_info.realmode_power_off) {
@@ -990,8 +992,14 @@ static void apm_power_off(void)
 	} else {
 		(void)set_system_power_state(APM_STATE_OFF);
 	}
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block apm_power_off_nb = {
+	.notifier_call = apm_power_off,
+	.priority = POWER_OFF_PRIORITY_HIGH,
+};
+
 #ifdef CONFIG_APM_DO_ENABLE
 
 /**
@@ -1847,8 +1855,11 @@ static int apm(void *unused)
 	}
 
 	/* Install our power off handler.. */
-	if (power_off)
-		pm_power_off = apm_power_off;
+	if (power_off) {
+		error = register_power_off_handler(&apm_power_off_nb);
+		if (error)
+			pr_err("apm: Failed to register power-off handler\n");
+	}
 
 	if (num_online_cpus() == 1 || smp) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
@@ -2408,9 +2419,8 @@ static void __exit apm_exit(void)
 			apm_error("disengage power management", error);
 	}
 	misc_deregister(&apm_device);
+	unregister_power_off_handler(&apm_power_off_nb);
 	remove_proc_entry("apm", NULL);
-	if (power_off)
-		pm_power_off = NULL;
 	if (kapmd_task) {
 		kthread_stop(kapmd_task);
 		kapmd_task = NULL;
-- 
1.9.1


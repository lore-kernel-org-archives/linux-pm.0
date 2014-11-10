From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 48/48] kernel: Remove pm_power_off
Date: Sun,  9 Nov 2014 17:43:05 -0800
Message-ID: <1415583785-6980-49-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39315 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbaKJBpW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Nov 2014 20:45:22 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xne2k-000XiZ-5k
	for linux-pm@vger.kernel.org; Mon, 10 Nov 2014 01:45:22 +0000
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>

No users of pm_power_off are left, so it is safe to remove the function.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- No change.
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
v2:
- poweroff -> power_off for API functions

 include/linux/pm.h               |  1 -
 kernel/power/power_off_handler.c | 13 +------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1d2298b..3bdade8 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -31,7 +31,6 @@
 /*
  * Callbacks for platform drivers to implement.
  */
-extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
 
 struct device; /* we have a circular dep with device.h */
diff --git a/kernel/power/power_off_handler.c b/kernel/power/power_off_handler.c
index d80a337..c89d47b 100644
--- a/kernel/power/power_off_handler.c
+++ b/kernel/power/power_off_handler.c
@@ -23,12 +23,6 @@
 #include <linux/types.h>
 
 /*
- * If set, calling this function will power off the system immediately.
- */
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-/*
  * List of handlers for kernel code which wants to be called
  * to power off the system.
  */
@@ -296,10 +290,6 @@ void do_kernel_power_off(void)
 	 * removed while the call chain is traversed, but we'll have to accept
 	 * that risk.
 	 */
-
-	if (pm_power_off)
-		pm_power_off();
-
 	p = rcu_dereference_raw(power_off_handler_list);
 	while (p) {
 		next_p = rcu_dereference_raw(p->next);
@@ -315,7 +305,6 @@ void do_kernel_power_off(void)
  */
 bool have_kernel_power_off(void)
 {
-	return pm_power_off != NULL ||
-			rcu_dereference_raw(power_off_handler_list) != NULL;
+	return rcu_dereference_raw(power_off_handler_list) != NULL;
 }
 EXPORT_SYMBOL(have_kernel_power_off);
-- 
1.9.1


From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 47/47] kernel: Remove pm_power_off
Date: Mon, 20 Oct 2014 21:13:03 -0700
Message-ID: <1413864783-3271-48-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34037 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbaJUEPG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:15:06 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQqf-002fnH-Tv
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:15:06 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>

No users of pm_power_off are left, so it is safe to remove the function.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: poweroff -> power_off

 include/linux/pm.h              |  1 -
 kernel/power/poweroff_handler.c | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 7e0cb36..316271d 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -31,7 +31,6 @@
 /*
  * Callbacks for platform drivers to implement.
  */
-extern void (*pm_power_off)(void);
 extern void (*pm_power_off_prepare)(void);
 
 /*
diff --git a/kernel/power/poweroff_handler.c b/kernel/power/poweroff_handler.c
index 37f0b88..d2d164e 100644
--- a/kernel/power/poweroff_handler.c
+++ b/kernel/power/poweroff_handler.c
@@ -22,12 +22,6 @@
 #include <linux/types.h>
 
 /*
- * If set, calling this function will power off the system immediately.
- */
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-/*
  *	Notifier list for kernel code which wants to be called
  *	to power off the system.
  */
@@ -242,8 +236,6 @@ EXPORT_SYMBOL(devm_register_power_off_handler);
 void do_kernel_power_off(void)
 {
 	spin_lock(&power_off_handler_lock);
-	if (pm_power_off)
-		pm_power_off();
 	raw_notifier_call_chain(&power_off_handler_list, 0, NULL);
 	spin_unlock(&power_off_handler_lock);
 }
@@ -255,6 +247,6 @@ void do_kernel_power_off(void)
  */
 bool have_kernel_power_off(void)
 {
-	return pm_power_off != NULL || power_off_handler_list.head != NULL;
+	return power_off_handler_list.head != NULL;
 }
 EXPORT_SYMBOL(have_kernel_power_off);
-- 
1.9.1


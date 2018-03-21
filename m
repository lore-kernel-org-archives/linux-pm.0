From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/2] kernel / reboot: Remove the pm_power_off_prepare hook
Date: Wed, 21 Mar 2018 19:30:17 +0800
Message-ID: <df32f53cefe604a5ae67c4b0e6eef4d5e69abc6b.1521631678.git.baolin.wang@linaro.org>
References: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
In-Reply-To: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
References: <7ff55372818461feed4b0550d5f88edce2cc7d41.1521631678.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, pavel@ucw.cz
Cc: andrew.smirnov@gmail.com, akpm@linux-foundation.org, broonie@kernel.org, arnd@arndb.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, baolin.wang@linaro.org
List-Id: linux-pm@vger.kernel.org

There are no users will prepare to power off system by 'pm_power_off_prepare'
hook, thus we can remove it now.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/pm.h |    1 -
 kernel/reboot.c    |    8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78..cff7668 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -32,7 +32,6 @@
  * Callbacks for platform drivers to implement.
  */
 extern void (*pm_power_off)(void);
-extern void (*pm_power_off_prepare)(void);
 
 struct device; /* we have a circular dep with device.h */
 #ifdef CONFIG_VT_CONSOLE_SLEEP
diff --git a/kernel/reboot.c b/kernel/reboot.c
index e4ced88..6667b63 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -44,12 +44,6 @@
 enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
 
-/*
- * If set, this is used for preparing the system to power off.
- */
-
-void (*pm_power_off_prepare)(void);
-
 /**
  *	emergency_restart - reboot the system
  *
@@ -284,8 +278,6 @@ void kernel_halt(void)
 void kernel_power_off(void)
 {
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
-	if (pm_power_off_prepare)
-		pm_power_off_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
-- 
1.7.9.5

From: Thierry Reding <thierry.reding@gmail.com>
Subject: [RFC 2/3] kernel: Wire up system power framework
Date: Mon, 30 Jan 2017 18:15:05 +0100
Message-ID: <20170130171506.3527-3-thierry.reding@gmail.com>
References: <20170130171506.3527-1-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170130171506.3527-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Instead of relying on the globally defined pm_power_off_prepare() and
pm_power_off() function pointers, use the equivalent global functions
from the system-power framework.

The system-power framework implements a fallback that relies on these
global functions in case no system power chips have been registered.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/reboot.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index bd30a973fe94..ea075e285832 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -15,6 +15,7 @@
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
+#include <linux/system-power.h>
 #include <linux/uaccess.h>
 
 /*
@@ -257,8 +258,7 @@ EXPORT_SYMBOL_GPL(kernel_halt);
 void kernel_power_off(void)
 {
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
-	if (pm_power_off_prepare)
-		pm_power_off_prepare();
+	system_power_off_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
@@ -305,10 +305,11 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	if (ret)
 		return ret;
 
-	/* Instead of trying to make the power_off code look like
-	 * halt when pm_power_off is not set do it the easy way.
+	/*
+	 * Instead of trying to make the power_off code look like halt when
+	 * power off is not supported do it the easy way.
 	 */
-	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
+	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !system_can_power_off())
 		cmd = LINUX_REBOOT_CMD_HALT;
 
 	mutex_lock(&reboot_mutex);
-- 
2.11.0

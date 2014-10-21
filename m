From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 03/47] hibernate: Call have_kernel_power_off instead of checking pm_power_off
Date: Mon, 20 Oct 2014 21:12:19 -0700
Message-ID: <1413864783-3271-4-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Poweroff handlers may now be installed with register_power_off_handler.
Use the new API function have_kernel_power_off to determine if a poweroff
handler has been installed.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- have_kernel_poweroff -> have_kernel_power_off

 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a9dfa79..69225b7 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -602,7 +602,7 @@ static void power_down(void)
 	case HIBERNATION_PLATFORM:
 		hibernation_platform_enter();
 	case HIBERNATION_SHUTDOWN:
-		if (pm_power_off)
+		if (have_kernel_power_off())
 			kernel_power_off();
 		break;
 #ifdef CONFIG_SUSPEND
-- 
1.9.1

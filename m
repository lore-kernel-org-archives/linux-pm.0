From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 03/48] hibernate: Call have_kernel_power_off instead of checking pm_power_off
Date: Sun,  9 Nov 2014 17:42:20 -0800
Message-ID: <1415583785-6980-4-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Power-off handlers may now be installed with register_power_off_handler.
Use the new API function have_kernel_power_off to determine if a power-off
handler has been installed.

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
- No change
v3:
- No change
v2:
- have_kernel_poweroff -> have_kernel_power_off

 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 1f35a34..1202cf0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -608,7 +608,7 @@ static void power_down(void)
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

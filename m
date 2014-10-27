From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 03/47] hibernate: Call have_kernel_power_off instead of checking pm_power_off
Date: Mon, 27 Oct 2014 08:55:10 -0700
Message-ID: <1414425354-10359-4-git-send-email-linux@roeck-us.net>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49902 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaJ0P4J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 11:56:09 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XimeO-000b1H-UD
	for linux-pm@vger.kernel.org; Mon, 27 Oct 2014 15:56:09 +0000
In-Reply-To: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>

Power-off handlers may now be installed with register_power_off_handler.
Use the new API function have_kernel_power_off to determine if a power-off
handler has been installed.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3:
- No change
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


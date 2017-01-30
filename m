From: Thierry Reding <thierry.reding@gmail.com>
Subject: [RFC 3/3] PM / hibernate: Wire up system-power framework
Date: Mon, 30 Jan 2017 18:15:06 +0100
Message-ID: <20170130171506.3527-4-thierry.reding@gmail.com>
References: <20170130171506.3527-1-thierry.reding@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36746 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdA3RVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 12:21:42 -0500
In-Reply-To: <20170130171506.3527-1-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the system-power framework's equivalent to test for power off
capability instead of relying on the globally defined pm_power_off()
function pointer.

The system-power framework implements a fallback that relies on this
global function in case no system power chips have been registered.

Moving this to the system-power framework allows us to eventually
remove any traces of pm_power_off() once all handlers have moved over
to the new framework.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index b26dbc48c75b..e7429ea11e9a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -30,6 +30,7 @@
 #include <linux/genhd.h>
 #include <linux/ktime.h>
 #include <trace/events/power.h>
+#include <linux/system-power.h>
 
 #include "power.h"
 
@@ -617,7 +618,7 @@ static void power_down(void)
 	case HIBERNATION_PLATFORM:
 		hibernation_platform_enter();
 	case HIBERNATION_SHUTDOWN:
-		if (pm_power_off)
+		if (system_can_power_off())
 			kernel_power_off();
 		break;
 #ifdef CONFIG_SUSPEND
-- 
2.11.0


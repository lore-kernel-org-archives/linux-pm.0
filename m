From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH RFC] PM / Hibernate: no kernel_power_off when pm_power_off NULL
Date: Thu, 20 Mar 2014 13:53:15 -0700
Message-ID: <1395348795-8554-2-git-send-email-sebastian.capella@linaro.org>
References: <1395348795-8554-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395348795-8554-1-git-send-email-sebastian.capella@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
Cc: Sebastian Capella <sebastian.capella@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Reboot logic in kernel/reboot will avoid calling kernel_power_off
when pm_power_off is null, and instead uses kernel_halt.  Change
hibernate's power_down to follow the behavior in the reboot call.

Calling the notifier twice (once for SYS_POWER_OFF and again for
SYS_HALT) causes a panic during hibernation on Kirkwood
Openblocks A6 board.

Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 kernel/power/hibernate.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 37170d4..6a278dc 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -595,7 +595,8 @@ static void power_down(void)
 	case HIBERNATION_PLATFORM:
 		hibernation_platform_enter();
 	case HIBERNATION_SHUTDOWN:
-		kernel_power_off();
+		if (pm_power_off)
+			kernel_power_off();
 		break;
 #ifdef CONFIG_SUSPEND
 	case HIBERNATION_SUSPEND:
-- 
1.7.9.5

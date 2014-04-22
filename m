From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH v2] PM / Hibernate: no kernel_power_off when pm_power_off NULL
Date: Mon, 21 Apr 2014 17:30:46 -0700
Message-ID: <1398126646-29518-1-git-send-email-sebastian.capella@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:40810 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbaDVAau (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 20:30:50 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so4287549pbc.34
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2014 17:30:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
Cc: Sebastian Capella <sebastian.capella@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

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
Cc: Russell King <linux@arm.linux.org.uk>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

---
 kernel/power/hibernate.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index f4f2073..7642932 100644
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
@@ -623,7 +624,8 @@ static void power_down(void)
 	 * corruption after resume.
 	 */
 	printk(KERN_CRIT "PM: Please power down manually\n");
-	while(1);
+	while (1)
+		cpu_relax();
 }
 
 /**
-- 
1.7.9.5


From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6/6] power/reset: restart-poweroff: Remove arm dependencies
Date: Sun, 25 Jan 2015 10:13:42 -0800
Message-ID: <1422209622-31994-6-git-send-email-linux@roeck-us.net>
References: <1422209622-31994-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52257 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbbAYSOD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 13:14:03 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFRhD-003qkg-LP
	for linux-pm@vger.kernel.org; Sun, 25 Jan 2015 18:14:03 +0000
In-Reply-To: <1422209622-31994-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org

This driver is now arm specific anymore, so there is no need to include
an arm specific include file. Also drop unnecessary depencency on ARM
from Kconfig.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/Kconfig            | 1 -
 drivers/power/reset/restart-poweroff.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4b4b910..a4fd2cb 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -104,7 +104,6 @@ config POWER_RESET_QNAP
 
 config POWER_RESET_RESTART
 	bool "Restart power-off driver"
-	depends on ARM
 	help
 	  Some boards don't actually have the ability to power off.
 	  Instead they restart, and u-boot holds the SoC until the
diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index f46f2c2..41b22c4 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -16,7 +16,6 @@
 #include <linux/of_platform.h>
 #include <linux/module.h>
 #include <linux/reboot.h>
-#include <asm/system_misc.h>
 
 static void restart_poweroff_do_poweroff(void)
 {
-- 
2.1.0


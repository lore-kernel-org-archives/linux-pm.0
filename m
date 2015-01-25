From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/6] power/reset: st-poweroff: Fix misleading Kconfig description
Date: Sun, 25 Jan 2015 12:30:44 -0800
Message-ID: <1422217845-18901-6-git-send-email-linux@roeck-us.net>
References: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45891 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbbAYUbJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 15:31:09 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFTpu-000kSL-0Q
	for linux-pm@vger.kernel.org; Sun, 25 Jan 2015 20:31:10 +0000
In-Reply-To: <1422217845-18901-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org

The st-poweroff driver does not really power off the system
but resets it, so Kconfig should not claim that the driver
would handle power-off.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4cb5744..bb81e2a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -110,10 +110,10 @@ config POWER_RESET_RESTART
 	  user presses a key. u-boot then boots into Linux.
 
 config POWER_RESET_ST
-	bool "ST restart power-off driver"
+	bool "ST restart driver"
 	depends on ARCH_STI
 	help
-	  Power off and reset support for STMicroelectronics boards.
+	  Reset support for STMicroelectronics boards.
 
 config POWER_RESET_VERSATILE
 	bool "ARM Versatile family reboot driver"
-- 
2.1.0


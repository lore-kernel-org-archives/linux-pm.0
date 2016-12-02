From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 3/5] ARM: at91: Call regulator_suspend_{begin, end}() in the platform pm ops
Date: Fri,  2 Dec 2016 14:57:14 +0100
Message-ID: <1480687036-5037-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60742 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760707AbcLBN5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 08:57:20 -0500
In-Reply-To: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Call regulator_suspend_begin() and regulator_suspend_end() in the
->begin() and ->end() PM ops to inform the regulator framework that
a suspend sequence is beginning/ending.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 65e2d5f6a1c9..699125f16356 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
 #include <linux/io.h>
 #include <linux/clk/at91_pmc.h>
 
@@ -95,7 +96,7 @@ static suspend_state_t target_state;
 static int at91_pm_begin(suspend_state_t state)
 {
 	target_state = state;
-	return 0;
+	return regulator_suspend_begin(target_state);
 }
 
 /*
@@ -240,6 +241,7 @@ static int at91_pm_enter(suspend_state_t state)
 static void at91_pm_end(void)
 {
 	target_state = PM_SUSPEND_ON;
+	regulator_suspend_end();
 }
 
 
-- 
2.7.4


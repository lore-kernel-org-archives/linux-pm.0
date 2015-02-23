From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] power: Use subdir-ccflags-* to inherit debug flag
Date: Mon, 23 Feb 2015 17:08:48 +0100
Message-ID: <1424707728-27716-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:40833 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbBWQIx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 11:08:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Use subdir-ccflags-* instead of ccflags-* to inherit the debug
settings from Kconfig when traversing subdirectories.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/power/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 36f9e0d10111f3b6..8a8ff95b99c2d11f 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -1,4 +1,4 @@
-ccflags-$(CONFIG_POWER_SUPPLY_DEBUG) := -DDEBUG
+subdir-ccflags-$(CONFIG_POWER_SUPPLY_DEBUG) := -DDEBUG
 
 power_supply-y				:= power_supply_core.o
 power_supply-$(CONFIG_SYSFS)		+= power_supply_sysfs.o
-- 
1.9.1


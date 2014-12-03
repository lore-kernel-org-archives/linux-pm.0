From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] ARM: shmobile: r8a7740: Remove restart callback
Date: Wed,  3 Dec 2014 15:17:05 +0100
Message-ID: <1417616227-6715-3-git-send-email-geert+renesas@glider.be>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:55417 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbaLCORN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 09:17:13 -0500
In-Reply-To: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Remove the restart handling hack from the r8a7740 generic multiplatform
case.

Restart on DT-based r8a7740 platforms is now handled through the restart
handler registered by the R-Mobile System Controller (SYSC) driver.

This reverts commit 1174c712afa2779f ("ARM: shmobile: r8a7740: Add
restart callback").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 79ad93dfdae4ee70..cce7cdab0524d4a0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -835,13 +835,6 @@ static void __init r8a7740_generic_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-#define RESCNT2 IOMEM(0xe6188020)
-static void r8a7740_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel(1 << 31, RESCNT2);
-}
-
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -854,7 +847,6 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.init_machine	= r8a7740_generic_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7740_boards_compat_dt,
-	.restart	= r8a7740_restart,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
-- 
1.9.1


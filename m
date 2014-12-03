From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] ARM: shmobile: sh73a0: Remove restart callback
Date: Wed,  3 Dec 2014 15:17:06 +0100
Message-ID: <1417616227-6715-4-git-send-email-geert+renesas@glider.be>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Remove the restart handling hack from the sh73a0 generic multiplatform
case.

Restart on DT-based sh73a0 platforms is now handled through the restart
handler registered by the R-Mobile System Controller (SYSC) driver.

This reverts commit cad900819fba0176 ("ARM: shmobile: sh73a0: Add
restart callback").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2ec702c51dd25050..9e5e5ebbd1af641d 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -818,13 +818,6 @@ void __init sh73a0_add_standard_devices_dt(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-#define RESCNT2 IOMEM(0xe6188020)
-static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel((1 << 31), RESCNT2);
-}
-
 static const char *sh73a0_boards_compat_dt[] __initdata = {
 	"renesas,sh73a0",
 	NULL,
@@ -836,7 +829,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_machine	= sh73a0_add_standard_devices_dt,
 	.init_late	= shmobile_init_late,
-	.restart	= sh73a0_restart,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.9.1


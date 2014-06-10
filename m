From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 16/24] ARM: s3c64xx: Leave disabling of unused pm domains to genpd
Date: Tue, 10 Jun 2014 12:51:29 +0200
Message-ID: <1402397497-26737-17-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33756 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaFJKwp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:45 -0400
Received: by mail-lb0-f181.google.com with SMTP id q8so3747956lbi.26
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:43 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Since genpd at late init, will try to disable unused domains we don't
need to handle it from machine specific code as well.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-s3c64xx/common.c        |    5 -----
 arch/arm/mach-s3c64xx/common.h        |    7 -------
 arch/arm/mach-s3c64xx/mach-anw6410.c  |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c |    1 -
 arch/arm/mach-s3c64xx/mach-hmt.c      |    1 -
 arch/arm/mach-s3c64xx/mach-mini6410.c |    1 -
 arch/arm/mach-s3c64xx/mach-ncp.c      |    1 -
 arch/arm/mach-s3c64xx/mach-real6410.c |    1 -
 arch/arm/mach-s3c64xx/mach-smartq5.c  |    1 -
 arch/arm/mach-s3c64xx/mach-smartq7.c  |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 -
 arch/arm/mach-s3c64xx/pm.c            |    7 -------
 13 files changed, 29 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 5c45aae..16547f2 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -440,8 +440,3 @@ void s3c64xx_restart(enum reboot_mode mode, const char *cmd)
 	/* if all else fails, or mode was for soft, jump to 0 */
 	soft_restart(0);
 }
-
-void __init s3c64xx_init_late(void)
-{
-	s3c64xx_pm_late_initcall();
-}
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 7043e7a..9eb8644 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -23,7 +23,6 @@ void s3c64xx_init_irq(u32 vic0, u32 vic1);
 void s3c64xx_init_io(struct map_desc *mach_desc, int size);
 
 void s3c64xx_restart(enum reboot_mode mode, const char *cmd);
-void s3c64xx_init_late(void);
 
 void s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 	unsigned long xusbxti_f, bool is_s3c6400, void __iomem *reg_base);
@@ -52,12 +51,6 @@ extern void s3c6410_map_io(void);
 #define s3c6410_init NULL
 #endif
 
-#ifdef CONFIG_PM
-int __init s3c64xx_pm_late_initcall(void);
-#else
-static inline int s3c64xx_pm_late_initcall(void) { return 0; }
-#endif
-
 #ifdef CONFIG_S3C64XX_PL080
 extern struct pl08x_platform_data s3c64xx_dma0_plat_data;
 extern struct pl08x_platform_data s3c64xx_dma1_plat_data;
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 55eb6a6..7889d2a 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -234,7 +234,6 @@ MACHINE_START(ANW6410, "A&W6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 4b0199f..5db6d01 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -858,7 +858,6 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 72cee08..cb081b9 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -278,7 +278,6 @@ MACHINE_START(HMT, "Airgoo-HMT")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 9cbc076..ab61af5 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -366,7 +366,6 @@ MACHINE_START(MINI6410, "MINI6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 67f06a9..2d540a2 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -104,7 +104,6 @@ MACHINE_START(NCP, "NCP")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index fbad2af..85fa959 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -335,7 +335,6 @@ MACHINE_START(REAL6410, "REAL6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index dec4c08..33224ab 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -156,7 +156,6 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 27b3220..fc7fece 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -172,7 +172,6 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index c85d1cb..86a660d 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -93,7 +93,6 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.init_irq	= s3c6400_init_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index c6a8b2a..48f171a 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -706,7 +706,6 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
-	.init_late	= s3c64xx_init_late,
 	.init_time	= samsung_timer_init,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 6b37694..aaf7bea 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -347,10 +347,3 @@ static __init int s3c64xx_pm_initcall(void)
 	return 0;
 }
 arch_initcall(s3c64xx_pm_initcall);
-
-int __init s3c64xx_pm_late_initcall(void)
-{
-	pm_genpd_poweroff_unused();
-
-	return 0;
-}
-- 
1.7.9.5


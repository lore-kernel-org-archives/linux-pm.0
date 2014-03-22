From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] ARM: clps711x: Switch CLPS711X subarch to use cpuidle driver
Date: Sat, 22 Mar 2014 09:44:36 +0400
Message-ID: <1395467076-29462-2-git-send-email-shc_work@mail.ru>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fallback4.mail.ru ([94.100.176.42]:38194 "EHLO
	fallback4.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaCVFpQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 22 Mar 2014 01:45:16 -0400
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
	by fallback4.mail.ru (mPOP.Fallback_MX) with ESMTP id 06ED72C630A
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2014 09:45:13 +0400 (MSK)
In-Reply-To: <1395467076-29462-1-git-send-email-shc_work@mail.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>

This patch removes old support for cpuidle and switches all current
users to use new cpuidle driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c |  1 -
 arch/arm/mach-clps711x/board-cdb89712.c |  1 -
 arch/arm/mach-clps711x/board-clep7312.c |  1 -
 arch/arm/mach-clps711x/board-edb7211.c  |  1 -
 arch/arm/mach-clps711x/board-p720t.c    |  1 -
 arch/arm/mach-clps711x/common.c         | 12 ------------
 arch/arm/mach-clps711x/common.h         |  1 -
 arch/arm/mach-clps711x/devices.c        | 10 ++++++++++
 8 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index d62ca16..45abf6b 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -266,7 +266,6 @@ MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
 	.atag_offset	= 0x20000,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= autcpu12_init,
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index e261a47..1ec378c 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -140,7 +140,6 @@ MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
 	.atag_offset	= 0x100,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= cdb89712_init,
diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index 221b9de..1f3b403 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -38,7 +38,6 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.atag_offset	= 0x0100,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.restart	= clps711x_restart,
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index 0776098..fa4580f 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -180,7 +180,6 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.fixup		= fixup_edb7211,
 	.reserve	= edb7211_reserve,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= edb7211_init,
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 67b7337..4a2ec28 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -365,7 +365,6 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.atag_offset	= 0x100,
 	.fixup		= fixup_p720t,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= p720t_init,
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index aee81fa..2a6323b 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -193,15 +193,3 @@ void clps711x_restart(enum reboot_mode mode, const char *cmd)
 {
 	soft_restart(0);
 }
-
-static void clps711x_idle(void)
-{
-	clps_writel(1, HALT);
-	asm("mov r0, r0");
-	asm("mov r0, r0");
-}
-
-void __init clps711x_init_early(void)
-{
-	arm_pm_idle = clps711x_idle;
-}
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 7489139..f881899 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -13,7 +13,6 @@ extern void clps711x_map_io(void);
 extern void clps711x_init_irq(void);
 extern void clps711x_timer_init(void);
 extern void clps711x_restart(enum reboot_mode mode, const char *cmd);
-extern void clps711x_init_early(void);
 
 /* drivers/irqchip/irq-clps711x.c */
 void clps711x_intc_init(phys_addr_t, resource_size_t);
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 2001488..0c689d3 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -14,6 +14,15 @@
 
 #include <mach/hardware.h>
 
+static const struct resource clps711x_cpuidle_res __initconst =
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + HALT, SZ_128);
+
+static void __init clps711x_add_cpuidle(void)
+{
+	platform_device_register_simple("clps711x-cpuidle", PLATFORM_DEVID_NONE,
+					&clps711x_cpuidle_res, 1);
+}
+
 static const phys_addr_t clps711x_gpios[][2] __initconst = {
 	{ PADR, PADDR },
 	{ PBDR, PBDDR },
@@ -83,6 +92,7 @@ static void __init clps711x_add_uart(void)
 
 void __init clps711x_devices_init(void)
 {
+	clps711x_add_cpuidle();
 	clps711x_add_gpio();
 	clps711x_add_syscon();
 	clps711x_add_uart();
-- 
1.8.3.2


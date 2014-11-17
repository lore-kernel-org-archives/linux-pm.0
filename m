From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: shmobile: sh73a0 legacy: Add PM domain support
Date: Mon, 17 Nov 2014 15:18:32 +0100
Message-ID: <1416233912-15709-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:44508 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbaKQOSg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 09:18:36 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add all hierarchical PM domains that exist on SH-Mobile AG5 (sh730a),
and register all platform devices to the appropriate PM domains.

Special handling is required for the following PM domains:
  - A4BC0 and A4BC1 contain the SDRAM Bus State Controllers, and thus
    should not be turned off,
  - A3SP contains the serial console, and should not be turned off if
    no_console_suspend is set,
  - A2SL contains the CPU core, and should not be turned off if the CPU
    is in use.

Note that PM domain D4 can be powered down without ill effects on s2ram
behavior, just like on SH-Mobile AP4 (sh7372), but unlike on R-Mobile A1
(r8a7740).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v5 5/8] ARM: shmobile: R-Mobile: Store SYSC base
address in rmobile_pm_domain".
However, the lines ".base = SYSC_BASE," can just be removed if the dependency
is postponed.

 arch/arm/mach-shmobile/board-kzm9g.c  |  15 ++++
 arch/arm/mach-shmobile/pm-sh73a0.c    | 131 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |  31 ++++++++
 arch/arm/mach-shmobile/sh73a0.h       |   7 ++
 4 files changed, 184 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index e9d7dd65fd76ae18..dc4b57691ffacce5 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -48,6 +48,7 @@
 #include "common.h"
 #include "intc.h"
 #include "irqs.h"
+#include "pm-rmobile.h"
 #include "sh73a0.h"
 
 /*
@@ -897,6 +898,17 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 
 static void __init kzm_init(void)
 {
+	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4LC0", &lcdc_device },
+		{ "A4MP", &fsi_device },
+		{ "A4S", &smsc_device },
+		{ "A4S", &usb_host_device },
+		{ "A3SP", &usbhs_device },
+		{ "A3SP", &mmc_device },
+		{ "A3SP", &sdhi0_device },
+		{ "A3SP", &sdhi2_device },
+	};
+
 	regulator_register_always_on(2, "fixed-1.8V", fixed1v8_power_consumers,
 				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
 	regulator_register_fixed(3, dummy_supplies, ARRAY_SIZE(dummy_supplies));
@@ -927,6 +939,9 @@ static void __init kzm_init(void)
 	sh73a0_add_standard_devices();
 	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
 
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
+
 	sh73a0_pm_init();
 }
 
diff --git a/arch/arm/mach-shmobile/pm-sh73a0.c b/arch/arm/mach-shmobile/pm-sh73a0.c
index a7e466817965e3b8..06d2d98a355a0b70 100644
--- a/arch/arm/mach-shmobile/pm-sh73a0.c
+++ b/arch/arm/mach-shmobile/pm-sh73a0.c
@@ -2,14 +2,145 @@
  * sh73a0 Power management support
  *
  *  Copyright (C) 2012 Bastian Hecht <hechtb+renesas@gmail.com>
+ *  Copyright (C) 2014 Glider bvba
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
 
+#include <linux/console.h>
+#include <linux/io.h>
 #include <linux/suspend.h>
+
 #include "common.h"
+#include "pm-rmobile.h"
+
+#define SYSC_BASE	IOMEM(0xe6180000)
+
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
+static int sh73a0_pd_a4bc_suspend(void)
+{
+	/*
+	 * The A4BC0 and A4BC1 domains contain the SDRAM Bus State Controllers
+	 * (SBSC1 and SBSC2) and therefore they should only be turned off if
+	 * SDRAM is not in use.
+	 */
+	return -EBUSY;
+}
+
+static int sh73a0_pd_a3sp_suspend(void)
+{
+	/*
+	 * Serial consoles make use of SCIF hardware located in A3SP,
+	 * keep such power domain on if "no_console_suspend" is set.
+	 */
+	return console_suspend_enabled ? 0 : -EBUSY;
+}
+
+static int sh73a0_pd_a2sl_suspend(void)
+{
+	/*
+	 * The A2SL domain contains the CPU core and therefore it should
+	 * only be turned off if the CPU is not in use.
+	 */
+	return -EBUSY;
+}
+
+static struct rmobile_pm_domain sh73a0_pm_domains[] = {
+	{
+		.genpd.name	= "C4",
+		.base		= SYSC_BASE,
+		.bit_shift	= 0,
+	}, {
+		.genpd.name	= "D4",
+		.base		= SYSC_BASE,
+		.bit_shift	= 1,
+	}, {
+		.genpd.name	= "A4BC0",
+		.base		= SYSC_BASE,
+		.bit_shift	= 4,
+		.gov		= &pm_domain_always_on_gov,
+		.suspend	= sh73a0_pd_a4bc_suspend,
+	}, {
+		.genpd.name	= "A4BC1",
+		.base		= SYSC_BASE,
+		.bit_shift	= 5,
+		.gov		= &pm_domain_always_on_gov,
+		.suspend	= sh73a0_pd_a4bc_suspend,
+	}, {
+		.genpd.name	= "A4LC0",
+		.base		= SYSC_BASE,
+		.bit_shift	= 6,
+	}, {
+		.genpd.name	= "A4LC1",
+		.base		= SYSC_BASE,
+		.bit_shift	= 7,
+	}, {
+		.genpd.name	= "A4MP",
+		.base		= SYSC_BASE,
+		.bit_shift	= 8,
+	}, {
+		.genpd.name	= "A3MP",
+		.base		= SYSC_BASE,
+		.bit_shift	= 9,
+	}, {
+		.genpd.name	= "A3VC",
+		.base		= SYSC_BASE,
+		.bit_shift	= 10,
+	}, {
+		.genpd.name	= "A4RM",
+		.base		= SYSC_BASE,
+		.bit_shift	= 12,
+	}, {
+		.genpd.name	= "A3R",
+		.base		= SYSC_BASE,
+		.bit_shift	= 13,
+	}, {
+		.genpd.name	= "A2RV",
+		.base		= SYSC_BASE,
+		.bit_shift	= 14,
+	}, {
+		.genpd.name	= "A4S",
+		.base		= SYSC_BASE,
+		.bit_shift	= 16,
+	}, {
+		.genpd.name	= "A3SP",
+		.base		= SYSC_BASE,
+		.bit_shift	= 17,
+		.gov		= &pm_domain_always_on_gov,
+		.no_debug	= true,
+		.suspend	= sh73a0_pd_a3sp_suspend,
+	}, {
+		.genpd.name	= "A3SG",
+		.base		= SYSC_BASE,
+		.bit_shift	= 18,
+	}, {
+		.genpd.name	= "A3SM",
+		.base		= SYSC_BASE,
+		.bit_shift	= 19,
+	}, {
+		.genpd.name	= "A2SL",
+		.base		= SYSC_BASE,
+		.bit_shift	= 20,
+		.gov		= &pm_domain_always_on_gov,
+		.suspend	= sh73a0_pd_a2sl_suspend,
+	}
+};
+
+void __init sh73a0_init_pm_domains(void)
+{
+	rmobile_init_domains(sh73a0_pm_domains, ARRAY_SIZE(sh73a0_pm_domains));
+	pm_genpd_add_subdomain_names("A4MP", "A3MP");
+	pm_genpd_add_subdomain_names("A4MP", "A3VC");
+	pm_genpd_add_subdomain_names("A4RM", "A3R");
+	pm_genpd_add_subdomain_names("A3R", "A2RV");
+	pm_genpd_add_subdomain_names("A4S", "A3SP");
+	pm_genpd_add_subdomain_names("A4S", "A3SG");
+	pm_genpd_add_subdomain_names("A4S", "A3SM");
+	pm_genpd_add_subdomain_names("A3SM", "A2SL");
+}
+#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
 
 #ifdef CONFIG_SUSPEND
 static int sh73a0_enter_suspend(suspend_state_t suspend_state)
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 93ebe3430bfe707a..c00ce5d404c8794c 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -39,6 +39,7 @@
 #include "dma-register.h"
 #include "intc.h"
 #include "irqs.h"
+#include "pm-rmobile.h"
 #include "sh73a0.h"
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
@@ -748,13 +749,43 @@ static struct platform_device *sh73a0_late_devices[] __initdata = {
 
 void __init sh73a0_add_standard_devices(void)
 {
+	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4MP", &mpdma0_device },
+		{ "A3R", &tmu0_device },
+		{ "A4S", &irqpin0_device },
+		{ "A4S", &irqpin1_device },
+		{ "A4S", &irqpin2_device },
+		{ "A4S", &irqpin3_device },
+		{ "A3SP", &dma0_device },
+		{ "A3SP", &i2c0_device },
+		{ "A3SP", &i2c1_device },
+		{ "A3SP", &i2c2_device },
+		{ "A3SP", &i2c3_device },
+		{ "A3SP", &ipmmu_device },
+		{ "A3SP", &scif0_device },
+		{ "A3SP", &scif1_device },
+		{ "A3SP", &scif2_device },
+		{ "A3SP", &scif3_device },
+		{ "A3SP", &scif4_device },
+		{ "A3SP", &scif5_device },
+		{ "A3SP", &scif6_device },
+		{ "A3SP", &scif7_device },
+		{ "A3SP", &scif8_device },
+	};
+
 	/* Clear software reset bit on SY-DMAC module */
 	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
 
+	sh73a0_init_pm_domains();
+
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
 			    ARRAY_SIZE(sh73a0_late_devices));
+
+	/* add devices to PM domain  */
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
 }
 
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
diff --git a/arch/arm/mach-shmobile/sh73a0.h b/arch/arm/mach-shmobile/sh73a0.h
index f037c64b14fc0767..1a68a132bd516e00 100644
--- a/arch/arm/mach-shmobile/sh73a0.h
+++ b/arch/arm/mach-shmobile/sh73a0.h
@@ -81,6 +81,13 @@ extern void sh73a0_add_standard_devices_dt(void);
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
 extern void sh73a0_pm_init(void);
+
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
+extern void sh73a0_init_pm_domains(void);
+#else
+static inline void sh73a0_init_pm_domains(void) {}
+#endif
+
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
-- 
1.9.1


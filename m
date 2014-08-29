From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 07/11] [WIP] ARM: shmobile: r8a7740/armadillo legacy: Add A4MP pm domain support
Date: Fri, 29 Aug 2014 15:50:13 +0200
Message-ID: <1409320217-13278-8-git-send-email-geert+renesas@glider.be>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the A4MP power domain, and hook up the FSI hardware block.
This domain also contains the SPU2, FMSI, and BBIF2 hardware blocks,
but these are currently not used by any driver.

FIXME: A4PM is not added, as it causes "irq 163: nobody cared" (irq 163
       is registered by sh-mobile-hdmi), either on boot, or, when trying
       to fix it using pm_domain_always_on_gov, on resume.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c            |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 735036038951..c2ac4ee51710 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1234,6 +1234,7 @@ static void __init eva_init(void)
 	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A4LC", &lcdc0_device },
 		{ "A4LC", &hdmi_lcdc_device },
+		{ "A4MP", &fsi_device },
 		{ "A4S",  &sh_eth_device },
 		{ "A3SP", &pwm_device },
 		{ "A3SP", &sdhi0_device },
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 84b94d1d96db..86b2df8b5391 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -37,6 +37,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4LC",
 		.bit_shift	= 1,
 	}, {
+//		.genpd.name	= "A4MP",
+//		.bit_shift	= 2,
+//	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
-- 
1.7.9.5


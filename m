From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 07/11] ARM: shmobile: r8a7740/armadillo legacy: Add A4MP pm domain support
Date: Thu, 23 Oct 2014 13:18:57 +0200
Message-ID: <1414063141-8856-8-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the A4MP power domain, and hook up the HDMI-Link and FSI
hardware blocks.
This domain also contains the SPU2, FMSI, and BBIF2 hardware blocks,
but these are currently not used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - Also hook up HDMI-Link, which was not documented in the datasheet as
    belonging to A4MP,
  - Really add A4MP and drop the FIXME, as a fix for the interrupt storm
    is available.
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 ++
 arch/arm/mach-shmobile/pm-r8a7740.c            | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 735036038951868d..c37d7b697a35322d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1234,6 +1234,8 @@ static void __init eva_init(void)
 	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A4LC", &lcdc0_device },
 		{ "A4LC", &hdmi_lcdc_device },
+		{ "A4MP", &hdmi_device },
+		{ "A4MP", &fsi_device },
 		{ "A4S",  &sh_eth_device },
 		{ "A3SP", &pwm_device },
 		{ "A3SP", &sdhi0_device },
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 932c2a621e81ac26..081a4f9726a0c909 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -37,6 +37,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4LC",
 		.bit_shift	= 1,
 	}, {
+		.genpd.name	= "A4MP",
+		.bit_shift	= 2,
+	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
-- 
1.9.1


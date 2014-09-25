From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 09/11] ARM: shmobile: r8a7740/armadillo legacy: Add A4R pm domain support
Date: Thu, 25 Sep 2014 18:15:40 +0200
Message-ID: <1411661742-4767-10-git-send-email-geert+renesas@glider.be>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:45298 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbaIYQPz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 12:15:55 -0400
In-Reply-To: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A4R power domain, and hook up the A3RV subdomain,
and the CEU0, TMU0, and IIC0 hardware blocks.
This domain also contains the Realtime CPU (SH-4A), Realtime CPU debug
modules, H-UDI, RT-SHwy, INTCS, RT-HPB, VIO6C, JPU, RTDMAC1/2, SSP,
MSIOF0, CMT0, ICB, DREQPAK (RT), 2DDMAC, IPMMUI, and 2DG hardware
blocks, but these are currently not used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes

 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 arch/arm/mach-shmobile/pm-r8a7740.c            | 4 ++++
 arch/arm/mach-shmobile/setup-r8a7740.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index c37d7b697a35322d..2632beaad6c838c2 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1236,6 +1236,7 @@ static void __init eva_init(void)
 		{ "A4LC", &hdmi_lcdc_device },
 		{ "A4MP", &hdmi_device },
 		{ "A4MP", &fsi_device },
+		{ "A4R",  &ceu0_device },
 		{ "A4S",  &sh_eth_device },
 		{ "A3SP", &pwm_device },
 		{ "A3SP", &sdhi0_device },
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 6697ac00eff72957..7226c3543ecdc0ea 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -43,6 +43,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "D4",
 		.bit_shift	= 3,
 	}, {
+		.genpd.name	= "A4R",
+		.bit_shift	= 5,
+	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
@@ -66,6 +69,7 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 void __init r8a7740_init_pm_domains(void)
 {
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
+	pm_genpd_add_subdomain_names("A4R", "A3RV");
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
 	pm_genpd_add_subdomain_names("A4S", "A3SG");
 }
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index dbf8a93ccc4f412d..b77c226ab891a5dd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -746,6 +746,8 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
 void __init r8a7740_add_standard_devices(void)
 {
 	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4R",  &tmu0_device },
+		{ "A4R",  &i2c0_device },
 		{ "A4S",  &irqpin0_device },
 		{ "A4S",  &irqpin1_device },
 		{ "A4S",  &irqpin2_device },
-- 
1.9.1


From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 09/11] ARM: shmobile: r8a7740/armadillo legacy: Add A4R pm domain support
Date: Fri, 29 Aug 2014 15:50:15 +0200
Message-ID: <1409320217-13278-10-git-send-email-geert+renesas@glider.be>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the A4R power domain, and hook up the A3RV subdomain,
and the CEU0, TMU0, and IIC0 hardware blocks.
This domain also contains the Realtime CPU (SH-4A), Realtime CPU debug
modules, H-UDI, RT-SHwy, INTCS, RT-HPB, VIO6C, JPU, RTDMAC1/2, SSP,
MSIOF0, CMT0, ICB, DREQPAK (RT), 2DDMAC, IPMMUI, and 2DG hardware
blocks, but these are currently not used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c            |    4 ++++
 arch/arm/mach-shmobile/setup-r8a7740.c         |    2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index c2ac4ee51710..20967dbbc1c9 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1235,6 +1235,7 @@ static void __init eva_init(void)
 		{ "A4LC", &lcdc0_device },
 		{ "A4LC", &hdmi_lcdc_device },
 		{ "A4MP", &fsi_device },
+		{ "A4R",  &ceu0_device },
 		{ "A4S",  &sh_eth_device },
 		{ "A3SP", &pwm_device },
 		{ "A3SP", &sdhi0_device },
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index cbdb87c67711..3e15143572dc 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -43,6 +43,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 //		.genpd.name	= "D4",
 //		.bit_shift	= 3,
 //	}, {
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
index dbf8a93ccc4f..b77c226ab891 100644
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
1.7.9.5


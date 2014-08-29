From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 11/11] [WIP] ARM: shmobile: r8a7740: Add A3SM pm domain support
Date: Fri, 29 Aug 2014 15:50:17 +0200
Message-ID: <1409320217-13278-12-git-send-email-geert+renesas@glider.be>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add support for the A3SM power domain, and hook it up as a subdomain of
A4S.

This domain contains the System CPU (Cortex-A9) hardware block, and thus
must be controlled by the always-on governor.

FIXME: A3SM is never powered down during s2ram, even when adding a
       .suspend method like A4S has.
       As A3SM is a subdomain of A4S, A4S is no longer powered down
       during s2ram.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7740.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index d563e623bcb5..23254c31efd9 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -61,6 +61,10 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a3sp_suspend,
 	}, {
+		.genpd.name	= "A3SM",
+		.bit_shift	= 12,
+		.gov		= &pm_domain_always_on_gov,
+	}, {
 		.genpd.name	= "A3SG",
 		.bit_shift	= 13,
 	}, {
@@ -74,6 +78,7 @@ void __init r8a7740_init_pm_domains(void)
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4R", "A3RV");
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
+	pm_genpd_add_subdomain_names("A4S", "A3SM");
 	pm_genpd_add_subdomain_names("A4S", "A3SG");
 }
 #endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
-- 
1.7.9.5


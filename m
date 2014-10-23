From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 11/11] ARM: shmobile: r8a7740: Add A3SM pm domain support
Date: Thu, 23 Oct 2014 13:19:01 +0200
Message-ID: <1414063141-8856-12-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:60286 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbaJWLTC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Oct 2014 07:19:02 -0400
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A3SM power domain, and hook it up as a subdomain of
A4S.

This domain contains the System CPU (Cortex-A9) hardware block. Hence
move the special CPU handling from A4S to A3SM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - Move special CPU domain handling from A4S to A3SM,
  - Drop FIXME about not powering down A4S, as this is expected behavior.
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 27117a8a49ad8556..ac2eecd6f5ea5d9f 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -14,10 +14,10 @@
 #include "pm-rmobile.h"
 
 #if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
-static int r8a7740_pd_a4s_suspend(void)
+static int r8a7740_pd_a3sm_suspend(void)
 {
 	/*
-	 * The A4S domain contains the CPU core and therefore it should
+	 * The A3SM domain contains the CPU core and therefore it should
 	 * only be turned off if the CPU is not in use.
 	 */
 	return -EBUSY;
@@ -63,9 +63,7 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	}, {
 		.genpd.name	= "A4S",
 		.bit_shift	= 10,
-		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
-		.suspend	= r8a7740_pd_a4s_suspend,
 	}, {
 		.genpd.name	= "A3SP",
 		.bit_shift	= 11,
@@ -73,6 +71,11 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a3sp_suspend,
 	}, {
+		.genpd.name	= "A3SM",
+		.bit_shift	= 12,
+		.gov		= &pm_domain_always_on_gov,
+		.suspend	= r8a7740_pd_a3sm_suspend,
+	}, {
 		.genpd.name	= "A3SG",
 		.bit_shift	= 13,
 	}, {
@@ -86,6 +89,7 @@ void __init r8a7740_init_pm_domains(void)
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4R", "A3RV");
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
+	pm_genpd_add_subdomain_names("A4S", "A3SM");
 	pm_genpd_add_subdomain_names("A4S", "A3SG");
 }
 #endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
-- 
1.9.1


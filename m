From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 05/11] ARM: shmobile: r8a7740: Add A3RV pm domain support
Date: Fri, 29 Aug 2014 15:50:11 +0200
Message-ID: <1409320217-13278-6-git-send-email-geert+renesas@glider.be>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:38204 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbaH2Nub (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Aug 2014 09:50:31 -0400
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A3RV power domain.
This domain contains the VPU5F and VCP1 hardware blocks, which are
currently not used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7740.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index b20dd5b37e6d..93a89329d927 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -37,6 +37,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4LC",
 		.bit_shift	= 1,
 	}, {
+		.genpd.name	= "A3RV",
+		.bit_shift	= 6,
+	}, {
 		.genpd.name	= "A4S",
 		.bit_shift	= 10,
 		.gov		= &pm_domain_always_on_gov,
-- 
1.7.9.5


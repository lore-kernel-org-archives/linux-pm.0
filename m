From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 10/11] ARM: shmobile: r8a7740: Add A4SU pm domain support
Date: Thu, 23 Oct 2014 13:19:00 +0200
Message-ID: <1414063141-8856-11-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:60166 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbaJWLTC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Oct 2014 07:19:02 -0400
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A4SU power domain.
This domain contains the USBPHY hardware block, which is currently not
used by any driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - Drop FIXME about hooking up USB platform devices, as the Armadillo
    platform code doesn't register a USB host device anyway?
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 74e6a67a28d3c336..27117a8a49ad8556 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -75,6 +75,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	}, {
 		.genpd.name	= "A3SG",
 		.bit_shift	= 13,
+	}, {
+		.genpd.name	= "A4SU",
+		.bit_shift	= 20,
 	},
 };
 
-- 
1.9.1


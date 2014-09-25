From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 02/11] ARM: shmobile: r8a7740: Add missing A4S pm domain devices
Date: Thu, 25 Sep 2014 18:15:33 +0200
Message-ID: <1411661742-4767-3-git-send-email-geert+renesas@glider.be>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:38575 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbaIYQPz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 12:15:55 -0400
In-Reply-To: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit 8459293c27bcd13a ("ARM: shmobile: r8a7740: add A4S pm domain
support") added the A4S power domain, but forgot to hook up the INTCA
hardware block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes

 arch/arm/mach-shmobile/setup-r8a7740.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 6992d4013ef013da..dbf8a93ccc4f412d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -746,6 +746,10 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
 void __init r8a7740_add_standard_devices(void)
 {
 	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4S",  &irqpin0_device },
+		{ "A4S",  &irqpin1_device },
+		{ "A4S",  &irqpin2_device },
+		{ "A4S",  &irqpin3_device },
 		{ "A3SP", &scif0_device },
 		{ "A3SP", &scif1_device },
 		{ "A3SP", &scif2_device },
-- 
1.9.1


From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 06/13] ARM: mvebu: Add a new set of registers for pmsu
Date: Thu, 13 Feb 2014 18:33:29 +0100
Message-ID: <1392312816-17657-7-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51897 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752647AbaBMReF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:05 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

The Power Management Unit Service block also controls the Coherency
Fabric subsystem. This new set of registers is needed for the CPU idle
implementation for the Armada 370/XP, it allows to enter a deep CPU
idle state where the Coherency Fabric and the L2 cache are powered
down.

This patch also adds warnings if one of the base registers set can't
be ioremapped.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index d71ef53107c4..aa5ef7439d0f 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -26,6 +26,7 @@
 
 static void __iomem *pmsu_mp_base;
 static void __iomem *pmsu_reset_base;
+static void __iomem *pmsu_fabric_base;
 
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
 #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
@@ -67,7 +68,11 @@ static int __init armada_370_xp_pmsu_init(void)
 	if (np) {
 		pr_info("Initializing Power Management Service Unit\n");
 		pmsu_mp_base = of_iomap(np, 0);
+		WARN_ON(!pmsu_mp_base);
 		pmsu_reset_base = of_iomap(np, 1);
+		WARN_ON(!pmsu_reset_base);
+		pmsu_fabric_base = of_iomap(np, 2);
+		WARN_ON(!pmsu_fabric_base);
 		of_node_put(np);
 	}
 
-- 
1.8.1.2


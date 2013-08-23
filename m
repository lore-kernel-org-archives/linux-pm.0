From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 07/12] ARM: mvebu: Add a new set of registers for pmsu
Date: Fri, 23 Aug 2013 08:53:12 +0200
Message-ID: <1377240797-4047-8-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47881 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754869Ab3HWGxl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 02:53:41 -0400
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

The Power Management Unit Service block also controls the Coherency
Fabric subsystem. This new set of registers is needed for the CPU idle
implementation for the Armada 370/XP, it allows to enter a deep CPU
idle state where the Coherency Fabric and the L2 cache are power down.

This patch also adds warnings if one of the base registers set can't
be ioremapped.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 3cc4bef..1d147fe 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -25,6 +25,7 @@
 
 static void __iomem *pmsu_mp_base;
 static void __iomem *pmsu_reset_base;
+static void __iomem *pmsu_fabric_base;
 
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
 #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
@@ -66,7 +67,11 @@ int __init armada_370_xp_pmsu_init(void)
 	if (np) {
 		pr_info("Initializing Power Management Service Unit\n");
 		pmsu_mp_base = of_iomap(np, 0);
+		WARN_ON(!pmsu_mp_base);
 		pmsu_reset_base = of_iomap(np, 1);
+		WARN_ON(!pmsu_reset_base);
+		pmsu_fabric_base = of_iomap(np, 2);
+		WARN_ON(!pmsu_fabric_base);
 	}
 
 	return 0;
-- 
1.8.1.2


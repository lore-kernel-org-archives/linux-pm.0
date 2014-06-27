From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 05/16] ARM: mvebu: Add workaround for cpuidle support for Armada 370
Date: Fri, 27 Jun 2014 15:22:46 +0200
Message-ID: <1403875377-940-6-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42073 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753157AbaF0NXz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:23:55 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On Armada 370, there is "a slow exit process from the deep idle state
due to heavy L1/L2 cache cleanup operations performed by the BootROM
software" (cf errata GL-BootROM-10). To avoid this, we replace the
restart code of the BootROM by a simple jump to the boot address. Then
the code located at this boot address will take care of the
initialization.

For this purpose, we use the common function mvebu_boot_addr_wa()
introduced in the previous commit.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 991560905ccc..cdc6d87d0b49 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -34,7 +34,6 @@
 #include <asm/tlbflush.h>
 #include "common.h"
 
-static void __iomem *pmsu_mp_base;
 
 #define PMSU_BASE_OFFSET    0x100
 #define PMSU_REG_SIZE	    0x1000
@@ -77,6 +76,9 @@ extern void ll_enable_coherency(void);
 
 extern void armada_370_xp_cpu_resume(void);
 
+static unsigned long pmsu_mp_phys_base;
+static void __iomem *pmsu_mp_base;
+
 static struct platform_device armada_xp_cpuidle_device = {
 	.name = "cpuidle-armada-370-xp",
 };
@@ -147,6 +149,8 @@ static int __init armada_370_xp_pmsu_init(void)
 		goto out;
 	}
 
+	pmsu_mp_phys_base = res.start;
+
 	pmsu_mp_base = ioremap(res.start, resource_size(&res));
 	if (!pmsu_mp_base) {
 		pr_err("unable to map registers\n");
@@ -312,6 +316,18 @@ int __init armada_370_xp_cpu_pm_init(void)
 		return 0;
 	of_node_put(np);
 
+	/*
+	 * On Armada 370, there is "a slow exit process from the deep
+	 * idle state due to heavy L1/L2 cache cleanup operations
+	 * performed by the BootROM software". To avoid this, we
+	 * replace the restart code of the bootrom by a a simple jump
+	 * to the boot address. Then the code located at this boot
+	 * address will take care of the initialization.
+	 */
+	if (of_machine_is_compatible("marvell,armada370"))
+		mvebu_boot_addr_wa(ARMADA_370_CRYPT0_ENG_ID, pmsu_mp_phys_base +
+				PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));
+
 	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
 	armada_xp_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
 	platform_device_register(&armada_xp_cpuidle_device);
-- 
1.8.1.2


From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 10/13] ARM: mvebu: Set the start address of a CPU in a separate function
Date: Thu, 13 Feb 2014 18:33:33 +0100
Message-ID: <1392312816-17657-11-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51929 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752656AbaBMReJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:09 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Setting the start (or boot) address of A CPU is no more used only
during SMP bring up, but will also be used by the CPU idle functions
or later by the CPU hot plug ones.

This commit moves it in a separate function.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index ec745d59fea8..162ae1399f2a 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -61,6 +61,12 @@ static struct of_device_id of_pmsu_table[] = {
 	{ /* end of list */ },
 };
 
+static void armada_370_xp_pmsu_set_start_addr(void *start_addr, int hw_cpu)
+{
+	writel(virt_to_phys(start_addr), pmsu_mp_base +
+		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+}
+
 #ifdef CONFIG_SMP
 int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 {
@@ -73,8 +79,7 @@ int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 
 	hw_cpu = cpu_logical_map(cpu_id);
 
-	writel(virt_to_phys(boot_addr), pmsu_mp_base +
-			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+	armada_370_xp_pmsu_set_start_addr(boot_addr, hw_cpu);
 
 	/* Release CPU from reset by clearing reset bit*/
 	reg = readl(pmsu_reset_base + PMSU_RESET_CTL_OFFSET(hw_cpu));
-- 
1.8.1.2


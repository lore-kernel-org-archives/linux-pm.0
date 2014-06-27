From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 03/16] ARM: mvebu: Add function to export the physical address of the boot register
Date: Fri, 27 Jun 2014 15:22:44 +0200
Message-ID: <1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42058 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753157AbaF0NXw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:23:52 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

In order to boot the secondary CPUs on Armada 375 Z1, we need to read
the boot address of these CPUs through a register part of the System
Controller. This done very early where MMU is not enable yet, so we
need to get the physical address of this register to use it.

In the previous version of this workaround the physical address were
hardcoded whereas depending of the Mbus configuration this address may
change.

This commit will allow to use the generic boot workaround function
with the correct address.
---
 arch/arm/mach-mvebu/common.h            |  1 +
 arch/arm/mach-mvebu/system-controller.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index b67fb7a10d8b..6ad62cf8352c 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -20,6 +20,7 @@
 void mvebu_restart(enum reboot_mode mode, const char *cmd);
 int mvebu_cpu_reset_deassert(int cpu);
 void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
+u32 mvebu_system_controller_get_phys_addr(void);
 void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
 
 void armada_xp_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 0c5524ac75b7..ae6ab543aa36 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -30,6 +30,7 @@
 #include "common.h"
 
 static void __iomem *system_controller_base;
+static u32 system_controller_phys_base;
 
 struct mvebu_system_controller {
 	u32 rstoutn_mask_offset;
@@ -109,6 +110,13 @@ void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
 	writel(virt_to_phys(boot_addr), system_controller_base +
 	       mvebu_sc->resume_boot_addr);
 }
+
+u32 mvebu_system_controller_get_phys_addr(void)
+{
+	BUG_ON(system_controller_phys_base == NULL);
+	BUG_ON(mvebu_sc->resume_boot_addr == 0);
+	return system_controller_phys_base + mvebu_sc->resume_boot_addr;
+}
 #endif
 
 static int __init mvebu_system_controller_init(void)
@@ -119,7 +127,10 @@ static int __init mvebu_system_controller_init(void)
 	np = of_find_matching_node_and_match(NULL, of_system_controller_table,
 					     &match);
 	if (np) {
+		struct resource res;
 		system_controller_base = of_iomap(np, 0);
+		of_address_to_resource(np, 0, &res);
+		system_controller_phys_base = res.start;
 		mvebu_sc = (struct mvebu_system_controller *)match->data;
 		of_node_put(np);
 	}
-- 
1.8.1.2


From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 04/17] ARM: mvebu: use the common function for Armada 375 SMP workaround
Date: Wed,  9 Jul 2014 15:40:08 +0200
Message-ID: <1404913221-17343-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47316 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756022AbaGINkf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:35 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Use the common function mvebu_setup_boot_addr_wa() introduced in the
commit "ARM: mvebu: Add a common function for the boot address work
around" instead of the dedicated version for Armada 375.

This commit also moves the workaround in the system-controller
module. Indeed the workaround on 375 is really related to setting the
boot address which is done by the system controller.

As a bonus we no longer use an harcoded value to access the register
storing the boot address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/headsmp-a9.S        | 15 ------------
 arch/arm/mach-mvebu/platsmp-a9.c        | 42 +++------------------------------
 arch/arm/mach-mvebu/system-controller.c | 31 ++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index da5bb29..be51c99 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -18,21 +18,6 @@
 #include <asm/assembler.h>
 
 	__CPUINIT
-#define CPU_RESUME_ADDR_REG 0xf10182d4
-
-.global armada_375_smp_cpu1_enable_code_start
-.global armada_375_smp_cpu1_enable_code_end
-
-armada_375_smp_cpu1_enable_code_start:
-ARM_BE8(setend	be)
-	adr     r0, 1f
-	ldr	r0, [r0]
-	ldr     r1, [r0]
-ARM_BE8(rev	r1, r1)
-	mov     pc, r1
-1:
-	.word   CPU_RESUME_ADDR_REG
-armada_375_smp_cpu1_enable_code_end:
 
 ENTRY(mvebu_cortex_a9_secondary_startup)
 ARM_BE8(setend	be)
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index 43aaf3f..47a71a9 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -20,33 +20,8 @@
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include "common.h"
-#include "mvebu-soc-id.h"
 #include "pmsu.h"
 
-#define CRYPT0_ENG_ID   41
-#define CRYPT0_ENG_ATTR 0x1
-#define SRAM_PHYS_BASE  0xFFFF0000
-
-#define BOOTROM_BASE    0xFFF00000
-#define BOOTROM_SIZE    0x100000
-
-extern unsigned char armada_375_smp_cpu1_enable_code_end;
-extern unsigned char armada_375_smp_cpu1_enable_code_start;
-
-static void armada_375_smp_cpu1_enable_wa(void)
-{
-	void __iomem *sram_virt_base;
-
-	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
-	mvebu_mbus_add_window_by_id(CRYPT0_ENG_ID, CRYPT0_ENG_ATTR,
-				SRAM_PHYS_BASE, SZ_64K);
-	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
-
-	memcpy(sram_virt_base, &armada_375_smp_cpu1_enable_code_start,
-	       &armada_375_smp_cpu1_enable_code_end
-	       - &armada_375_smp_cpu1_enable_code_start);
-}
-
 extern void mvebu_cortex_a9_secondary_startup(void);
 
 static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
@@ -63,21 +38,10 @@ static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
 	 * address.
 	 */
 	hw_cpu = cpu_logical_map(cpu);
-
-	if (of_machine_is_compatible("marvell,armada375")) {
-		u32 dev, rev;
-
-		if (mvebu_get_soc_id(&dev, &rev) == 0 &&
-		    rev == ARMADA_375_Z1_REV)
-			armada_375_smp_cpu1_enable_wa();
-
+	if (of_machine_is_compatible("marvell,armada375"))
 		mvebu_system_controller_set_cpu_boot_addr(mvebu_cortex_a9_secondary_startup);
-	}
-	else {
-		mvebu_pmsu_set_cpu_boot_addr(hw_cpu,
-					     mvebu_cortex_a9_secondary_startup);
-	}
-
+	else
+		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, mvebu_cortex_a9_secondary_startup);
 	smp_wmb();
 	ret = mvebu_cpu_reset_deassert(hw_cpu);
 	if (ret) {
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index b2b4e3d..a068cb5 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -28,8 +28,14 @@
 #include <linux/io.h>
 #include <linux/reboot.h>
 #include "common.h"
+#include "mvebu-soc-id.h"
+#include "pmsu.h"
+
+#define ARMADA_375_CRYPT0_ENG_TARGET 41
+#define ARMADA_375_CRYPT0_ENG_ATTR    1
 
 static void __iomem *system_controller_base;
+static phys_addr_t system_controller_phys_base;
 
 struct mvebu_system_controller {
 	u32 rstoutn_mask_offset;
@@ -121,10 +127,32 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev)
 }
 
 #ifdef CONFIG_SMP
+void mvebu_armada375_smp_wa_init(void)
+{
+	u32 dev, rev;
+	phys_addr_t resume_addr_reg;
+
+	if (mvebu_get_soc_id(&dev, &rev) != 0)
+		return;
+
+	if (rev != ARMADA_375_Z1_REV)
+		return;
+
+	resume_addr_reg = system_controller_phys_base +
+		mvebu_sc->resume_boot_addr;
+	mvebu_setup_boot_addr_wa(ARMADA_375_CRYPT0_ENG_TARGET,
+				 ARMADA_375_CRYPT0_ENG_ATTR,
+				 resume_addr_reg);
+}
+
 void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
 {
 	BUG_ON(system_controller_base == NULL);
 	BUG_ON(mvebu_sc->resume_boot_addr == 0);
+
+	if (of_machine_is_compatible("marvell,armada375"))
+		mvebu_armada375_smp_wa_init();
+
 	writel(virt_to_phys(boot_addr), system_controller_base +
 	       mvebu_sc->resume_boot_addr);
 }
@@ -138,7 +166,10 @@ static int __init mvebu_system_controller_init(void)
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
2.0.0


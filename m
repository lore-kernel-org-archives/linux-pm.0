From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 03/16] ARM: mvebu: add a common function for the boot address work around
Date: Wed, 23 Jul 2014 15:00:40 +0200
Message-ID: <1406120453-29291-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40681 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752767AbaGWNA7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:00:59 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

On some of the mvebu SoCs and due to internal BootROM issue, the CPU
initial jump code must be placed in the SRAM memory of the SoC. In
order to achieve this, we have to unmap the BootROM and at some
specific location where the BootROM was placed, create a dedicated
MBus window for the SRAM. This SRAM is initialized with a few
instructions of code that allows to jump to the real secondary CPU
boot address. The SRAM used is the Crypto engine one.

This work around is currently needed for booting SMP on Armada 375 Z1
and will be needed for cpuidle support on Armada 370. Instead of
duplicating the same code, this commit introduces a common function to
handle it: mvebu_setup_boot_addr_wa().

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c    | 47 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.h    |  3 +++
 arch/arm/mach-mvebu/pmsu_ll.S | 22 ++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 9e18cce..272a9c05 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mbus.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
@@ -63,6 +64,10 @@ static void __iomem *pmsu_mp_base;
 #define L2C_NFABRIC_PM_CTL		    0x4
 #define L2C_NFABRIC_PM_CTL_PWR_DOWN		BIT(20)
 
+#define SRAM_PHYS_BASE  0xFFFF0000
+#define BOOTROM_BASE    0xFFF00000
+#define BOOTROM_SIZE    0x100000
+
 extern void ll_disable_coherency(void);
 extern void ll_enable_coherency(void);
 
@@ -85,6 +90,48 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
 
+extern unsigned char mvebu_boot_wa_start;
+extern unsigned char mvebu_boot_wa_end;
+
+/*
+ * This function sets up the boot address workaround needed for SMP
+ * boot on Armada 375 Z1 and cpuidle on Armada 370. It unmaps the
+ * BootROM Mbus window, and instead remaps a crypto SRAM into which a
+ * custom piece of code is copied to replace the problematic BootROM.
+ */
+int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
+			     unsigned int crypto_eng_attribute,
+			     phys_addr_t resume_addr_reg)
+{
+	void __iomem *sram_virt_base;
+	u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
+
+	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
+	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
+				    SRAM_PHYS_BASE, SZ_64K);
+
+	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
+	if (!sram_virt_base) {
+		pr_err("Unable to map SRAM to setup the boot address WA\n");
+		return -ENOMEM;
+	}
+
+	memcpy(sram_virt_base, &mvebu_boot_wa_start, code_len);
+
+	/*
+	 * The last word of the code copied in SRAM must contain the
+	 * physical base address of the PMSU register. We
+	 * intentionally store this address in the native endianness
+	 * of the system.
+	 */
+	__raw_writel((unsigned long)resume_addr_reg,
+		     sram_virt_base + code_len - 4);
+
+	iounmap(sram_virt_base);
+
+	return 0;
+}
+
 static int __init armada_370_xp_pmsu_init(void)
 {
 	struct device_node *np;
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index 07a737c..ae50194 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -12,5 +12,8 @@
 #define __MACH_MVEBU_PMSU_H
 
 int armada_xp_boot_cpu(unsigned int cpu_id, void *phys_addr);
+int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
+                             unsigned int crypto_eng_attribute,
+                             phys_addr_t resume_addr_reg);
 
 #endif	/* __MACH_370_XP_PMSU_H */
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index fc3de68..17d7f3b 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -23,3 +23,25 @@ ARM_BE8(setend	be )			@ go BE8 if entered LE
 	b	cpu_resume
 ENDPROC(armada_370_xp_cpu_resume)
 
+.global mvebu_boot_wa_start
+.global mvebu_boot_wa_end
+
+/* The following code will be executed from SRAM */
+ENTRY(mvebu_boot_wa_start)
+mvebu_boot_wa_start:
+ARM_BE8(setend	be)
+	adr	r0, 1f
+	ldr	r0, [r0]		@ load the address of the
+					@ resume register
+	ldr	r0, [r0]		@ load the value in the
+					@ resume register
+ARM_BE8(rev	r0, r0)			@ the value is stored LE
+	mov	pc, r0			@ jump to this value
+/*
+ * the last word of this piece of code will be filled by the physical
+ * address of the boot address register just after being copied in SRAM
+ */
+1:
+	.long   .
+mvebu_boot_wa_end:
+ENDPROC(mvebu_boot_wa_end)
-- 
2.0.0


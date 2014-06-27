From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 02/16] ARM: mvebu: Add a common function for the boot address work around
Date: Fri, 27 Jun 2014 15:22:43 +0200
Message-ID: <1403875377-940-3-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42048 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752604AbaF0NXv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:23:51 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On some of the mvebu SoC and due to internal bootrom issue, CPU
initial jump code should be placed in SRAM memory of the SoC. In order
to achieve this, we have to unmap the BootROM and at some specific
location where the BootROM was place, create a specific MBus window
for the SRAM. This SRAM is initialized with a few instructions of code
that allows to jump into the real secondary CPU boot address.

This work around currently needed for booting SMP on Aramda 375 Z1 and
will be needed for cpuidle support on Armada 370. Instead of duplicate
the same code, this commit introduce a common function to handle it:
mvebu_boot_addr_wa().

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c    | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.h    |  1 +
 arch/arm/mach-mvebu/pmsu_ll.S | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 5584d35b8e88..991560905ccc 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/mbus.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
@@ -63,6 +64,14 @@ static void __iomem *pmsu_mp_base;
 #define L2C_NFABRIC_PM_CTL		    0x4
 #define L2C_NFABRIC_PM_CTL_PWR_DOWN		BIT(20)
 
+#define ARMADA_370_CRYPT0_ENG_ID	0x9
+#define CRYPT0_ENG_ATTR	0x1
+
+#define SRAM_PHYS_BASE	    0xFFFF0000
+
+#define BOOTROM_BASE    0xFFF00000
+#define BOOTROM_SIZE    0x100000
+
 extern void ll_disable_coherency(void);
 extern void ll_enable_coherency(void);
 
@@ -85,6 +94,28 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
 
+extern unsigned char mvebu_boot_wa_start;
+extern unsigned char mvebu_boot_wa_end;
+
+void mvebu_boot_addr_wa(int crypto_eng_id, u32 resume_addr_reg)
+{
+	void __iomem *sram_virt_base;
+	u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
+
+	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
+	mvebu_mbus_add_window_by_id(crypto_eng_id, CRYPT0_ENG_ATTR,
+				SRAM_PHYS_BASE, SZ_64K);
+	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
+
+
+	memcpy(sram_virt_base, &mvebu_boot_wa_start, code_len);
+	/*
+	 * The last word of the code copied in SRAM must contain the
+	 * physical base address of the PMSU register
+	 */
+	*(unsigned long *)(sram_virt_base + code_len - 4) = resume_addr_reg;
+}
+
 static int __init armada_370_xp_pmsu_init(void)
 {
 	struct device_node *np;
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index 07a737c6b95d..2d97a70c2558 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -12,5 +12,6 @@
 #define __MACH_MVEBU_PMSU_H
 
 int armada_xp_boot_cpu(unsigned int cpu_id, void *phys_addr);
+void mvebu_boot_addr_wa(int crypto_eng_id, unsigned long resume_addr_reg);
 
 #endif	/* __MACH_370_XP_PMSU_H */
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index fc3de68d8c54..3b702a16bd3d 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -23,3 +23,22 @@ ARM_BE8(setend	be )			@ go BE8 if entered LE
 	b	cpu_resume
 ENDPROC(armada_370_xp_cpu_resume)
 
+.global mvebu_boot_wa_start
+.global mvebu_boot_wa_end
+
+/* The following code will be executed from SRAM */
+ENTRY(mvebu_boot_wa_start)
+mvebu_boot_wa_start:
+/* use physical address of the boot address register register */
+	adr     r0, 1f
+	ldr     r0, [r0]
+	ldr     r0, [r0]
+	mov     pc, r0
+/*
+ * the last word of this piece of code will be filled by the physical
+ * address of the boot address register just after being copied in SRAM
+ */
+1:
+	.long   .
+mvebu_boot_wa_end:
+ENDPROC(mvebu_boot_wa_end)
-- 
1.8.1.2


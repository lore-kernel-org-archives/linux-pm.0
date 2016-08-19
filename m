From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] ARM: sa1100: move StrongARM CPU ID checks to cputype.h
Date: Fri, 19 Aug 2016 17:28:56 +0100
Message-ID: <E1bamfA-0002W7-Sb@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34961 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbcHSQ3W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 12:29:22 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Move the StrongARM CPU ID checks out of the platform's hardware.h
file into asm/cputype.h

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/cputype.h               | 21 +++++++++++++++++++++
 arch/arm/mach-sa1100/include/mach/hardware.h | 18 ------------------
 drivers/cpufreq/sa1110-cpufreq.c             |  2 +-
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 1ee94c716a7f..d6a4902a75d7 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -60,6 +60,7 @@
 	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
 
 #define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_DEC			0x44
 #define ARM_CPU_IMP_INTEL		0x69
 
 /* ARM implemented processors */
@@ -76,6 +77,17 @@
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 #define ARM_CPU_PART_MASK		0xff00fff0
 
+/* DEC implemented cores */
+#define ARM_CPU_PART_SA1100		0x4400a110
+
+/* Intel implemented cores */
+#define ARM_CPU_PART_SA1110		0x6900b110
+#define ARM_CPU_REV_SA1110_A0		0
+#define ARM_CPU_REV_SA1110_B0		4
+#define ARM_CPU_REV_SA1110_B1		5
+#define ARM_CPU_REV_SA1110_B2		6
+#define ARM_CPU_REV_SA1110_B4		8
+
 #define ARM_CPU_XSCALE_ARCH_MASK	0xe000
 #define ARM_CPU_XSCALE_ARCH_V1		0x2000
 #define ARM_CPU_XSCALE_ARCH_V2		0x4000
@@ -173,6 +185,11 @@ static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
 	return (read_cpuid_id() & 0xFF000000) >> 24;
 }
 
+static inline unsigned int __attribute_const__ read_cpuid_revision(void)
+{
+	return read_cpuid_id() & 0x0000000f;
+}
+
 /*
  * The CPU part number is meaningless without referring to the CPU
  * implementer: implementers are free to define their own part numbers
@@ -208,6 +225,10 @@ static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
 	return read_cpuid(CPUID_MPIDR);
 }
 
+/* StrongARM-11x0 CPUs */
+#define cpu_is_sa1100() (read_cpuid_part() == ARM_CPU_PART_SA1100)
+#define cpu_is_sa1110() (read_cpuid_part() == ARM_CPU_PART_SA1110)
+
 /*
  * Intel's XScale3 core supports some v6 features (supersections, L2)
  * but advertises itself as v5 as it does not support the v6 ISA.  For
diff --git a/arch/arm/mach-sa1100/include/mach/hardware.h b/arch/arm/mach-sa1100/include/mach/hardware.h
index cbedd75a9d65..55c85ce7010d 100644
--- a/arch/arm/mach-sa1100/include/mach/hardware.h
+++ b/arch/arm/mach-sa1100/include/mach/hardware.h
@@ -36,28 +36,10 @@
 #define io_v2p( x )             \
    ( (((x)&0x00ffffff) | (((x)&(0x30000000>>VIO_SHIFT))<<VIO_SHIFT)) + PIO_START )
 
-#define CPU_SA1110_A0	(0)
-#define CPU_SA1110_B0	(4)
-#define CPU_SA1110_B1	(5)
-#define CPU_SA1110_B2	(6)
-#define CPU_SA1110_B4	(8)
-
-#define CPU_SA1100_ID	(0x4401a110)
-#define CPU_SA1100_MASK	(0xfffffff0)
-#define CPU_SA1110_ID	(0x6901b110)
-#define CPU_SA1110_MASK	(0xfffffff0)
-
 #define __MREG(x)	IOMEM(io_p2v(x))
 
 #ifndef __ASSEMBLY__
 
-#include <asm/cputype.h>
-
-#define CPU_REVISION	(read_cpuid_id() & 15)
-
-#define cpu_is_sa1100()	((read_cpuid_id() & CPU_SA1100_MASK) == CPU_SA1100_ID)
-#define cpu_is_sa1110()	((read_cpuid_id() & CPU_SA1110_MASK) == CPU_SA1110_ID)
-
 # define __REG(x)	(*((volatile unsigned long __iomem *)io_p2v(x)))
 # define __PREG(x)	(io_v2p((unsigned long)&(x)))
 
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index b5befc211172..2bac9b6cfeea 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -159,7 +159,7 @@ sdram_calculate_timing(struct sdram_info *sd, u_int cpu_khz,
 	 * half speed or use delayed read latching (errata 13).
 	 */
 	if ((ns_to_cycles(sdram->tck, sd_khz) > 1) ||
-	    (CPU_REVISION < CPU_SA1110_B2 && sd_khz < 62000))
+	    (read_cpuid_revision() < ARM_CPU_REV_SA1110_B2 && sd_khz < 62000))
 		sd_khz /= 2;
 
 	sd->mdcnfg = MDCNFG & 0x007f007f;
-- 
2.1.0


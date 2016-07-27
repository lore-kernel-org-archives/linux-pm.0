From: fu.wei@linaro.org
Subject: [PATCH v11] acpi, apei, arm64: APEI initial support for aarch64.
Date: Thu, 28 Jul 2016 01:29:05 +0800
Message-ID: <1469640545-5848-1-git-send-email-fu.wei@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754160AbcG0R3i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Jul 2016 13:29:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tn@semihalf.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linaro-acpi@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, mark.rutland@arm.com, Marc.Zyngier@arm.com, lorenzo.pieralisi@arm.com, rruigrok@codeaurora.org, harba@qti.qualcomm.com, tbaicar@codeaurora.org, jcm@redhat.com, msalter@redhat.com, grant.likely@linaro.org, rrichter@cavium.com, jarkko.nikula@linux.intel.com, jon.zhixiong.zhang@gmail.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Fu Wei <fu.wei@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This commit provides APEI arch-specific bits for aarch64

Meanwhile,
(1)add a new subfunction "hest_ia32_init" for
"acpi_disable_cmcff" which is used by IA-32 Architecture
Corrected Machine Check (CMC).
(2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
a generic place.
(3)select HAVE_ACPI_APEI when EFI and ACPI is set on ARM64,
because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.

[Fu Wei: improve && upstream]

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
Changelog:
v11:https://lkml.org/lkml/2016/7
    Rebase to v4.7-0e06f5c0

v10:https://lkml.org/lkml/2016/4/14
    Fix the Alphabetical order problem in arch/arm64/Kconfig

v9: https://lkml.org/lkml/2016/4/5/522
    Improve the comment for arch_apei_flush_tlb_one.
    Using select "HAVE_ACPI_APEI if (ACPI && EFI)" to fix the EFI dependence
    problem.

v8: https://lkml.org/lkml/2016/3/29/132
    Fix a "undefined reference" bug by selecting EFI when ACPI_APEI is set
    on ARM64.

v7: https://lkml.org/lkml/2016/3/17/183
    Add comment for arch_apei_flush_tlb_one in arch/arm64/include/asm/acpi.h

v6: https://lists.linaro.org/pipermail/linaro-acpi/2016-March/006644.html
    Move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
    a generic place.
    Delete HAVE_ACPI_APEI_HEST_IA32.

v5: https://lkml.org/lkml/2015/12/10/131
    Add "HAVE_ACPI_APEI_HEST_IA32" instead of
    "#if defined(__i386__) || defined(__x86_64__)".

v4: https://lkml.org/lkml/2015/12/8/188
    Rebase to latest kernel version(4.4-rc4).
    Move arch_apei_flush_tlb_one into header file as a inline function
    Add a new subfunction "hest_ia_init" for "acpi_disable_cmcff".

v3: https://lkml.org/lkml/2015/12/3/521
    Remove "acpi_disable_cmcff" from arm64 code,
    and wrap it in hest.c by "#if defined(__i386__) || defined(__x86_64__)"

v2: https://lkml.org/lkml/2015/12/2/432
    Rebase to latest kernel version(4.4-rc3).
    Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c

v1: https://lkml.org/lkml/2015/8/14/199
    Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
    Delete arch/arm64/kernel/apei.c.
    Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".

 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/acpi.h | 16 +++++++++++++++-
 arch/x86/kernel/acpi/apei.c   |  3 ---
 drivers/acpi/apei/hest.c      | 18 +++++++++++++++---
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20d5a60..a301765 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -49,6 +49,7 @@ config ARM64
 	select GENERIC_TIME_VSYSCALL
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
+	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 5420cb0..d3d02dc 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -17,6 +17,7 @@
 
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
+#include <asm/tlbflush.h>
 
 /* Macros for consistency checks of the GICC subtable of MADT */
 #define ACPI_MADT_GICC_LENGTH	\
@@ -110,8 +111,21 @@ static inline const char *acpi_get_enable_method(int cpu)
 }
 
 #ifdef	CONFIG_ACPI_APEI
+#define acpi_disable_cmcff 1
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
-#endif
+
+/*
+ * Despite its name, this function must still broadcast the TLB
+ * invalidation in order to ensure other CPUs don't up with with junk
+ * entries as a result of speculation. Unusually, its also called in
+ * IRQ context (ghes_iounmap_irq) so if we ever need to use IPIs for
+ * TLB broadcasting, then we're in trouble here.
+ */
+static inline void arch_apei_flush_tlb_one(unsigned long addr)
+{
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
+#endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
 int arm64_acpi_numa_init(void);
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index c280df6..ea3046e 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -24,9 +24,6 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
 	struct acpi_hest_ia_corrected *cmc;
 	struct acpi_hest_ia_error_bank *mc_bank;
 
-	if (hest_hdr->type != ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
-		return 0;
-
 	cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
 	if (!cmc->enabled)
 		return 0;
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20b3fcf..792a0d9 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -123,7 +123,18 @@ EXPORT_SYMBOL_GPL(apei_hest_parse);
  */
 static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
 {
-	return arch_apei_enable_cmcff(hest_hdr, data);
+	if (hest_hdr->type != ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
+		return 0;
+
+	if (!acpi_disable_cmcff)
+		return !arch_apei_enable_cmcff(hest_hdr, data);
+
+	return 0;
+}
+
+static inline int __init hest_ia32_init(void)
+{
+	return apei_hest_parse(hest_parse_cmc, NULL);
 }
 
 struct ghes_arr {
@@ -232,8 +243,9 @@ void __init acpi_hest_init(void)
 		goto err;
 	}
 
-	if (!acpi_disable_cmcff)
-		apei_hest_parse(hest_parse_cmc, NULL);
+	rc = hest_ia32_init();
+	if (rc)
+		goto err;
 
 	if (!ghes_disable) {
 		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
-- 
2.5.5


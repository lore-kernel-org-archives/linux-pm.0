From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Do not modify perf bias performance setting by default at boot
Date: Mon, 07 Mar 2016 14:24:54 +0100
Message-ID: <5246881.PY2xISUnh1@skinner>
References: <4687430.mfM0GbdeDL@skinner> <1770444.1VxdmEr8lv@skinner> <CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43416 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbcCGNY5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Mar 2016 08:24:57 -0500
In-Reply-To: <CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>

It came out that on certain CPUs perf bias MSR has to be set to performance,
so that the CPU enters turbo states at all.

Better do not try to wrongly adjust perf bias value,
its value probably is intended by BIOS.

This is a revert of mainline git commits:
commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
commit abe48b108247e9b90b4c6739662a2e5c765ed114

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 arch/x86/kernel/cpu/common.c |   18 ------------------
 arch/x86/kernel/cpu/cpu.h    |    1 -
 arch/x86/kernel/cpu/intel.c  |   32 --------------------------------
 3 files changed, 51 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -13,7 +13,6 @@
 #include <linux/kgdb.h>
 #include <linux/smp.h>
 #include <linux/io.h>
-#include <linux/syscore_ops.h>
 
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
@@ -1489,20 +1488,3 @@ inline bool __static_cpu_has_safe(u16 bi
 	return boot_cpu_has(bit);
 }
 EXPORT_SYMBOL_GPL(__static_cpu_has_safe);
-
-static void bsp_resume(void)
-{
-	if (this_cpu->c_bsp_resume)
-		this_cpu->c_bsp_resume(&boot_cpu_data);
-}
-
-static struct syscore_ops cpu_syscore_ops = {
-	.resume		= bsp_resume,
-};
-
-static int __init init_cpu_syscore(void)
-{
-	register_syscore_ops(&cpu_syscore_ops);
-	return 0;
-}
-core_initcall(init_cpu_syscore);
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -13,7 +13,6 @@ struct cpu_dev {
 	void		(*c_init)(struct cpuinfo_x86 *);
 	void		(*c_identify)(struct cpuinfo_x86 *);
 	void		(*c_detect_tlb)(struct cpuinfo_x86 *);
-	void		(*c_bsp_resume)(struct cpuinfo_x86 *);
 	int		c_x86_vendor;
 #ifdef CONFIG_X86_32
 	/* Optional vendor specific routine to obtain the cache size. */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -372,36 +372,6 @@ static void detect_vmx_virtcap(struct cp
 	}
 }
 
-static void init_intel_energy_perf(struct cpuinfo_x86 *c)
-{
-	u64 epb;
-
-	/*
-	 * Initialize MSR_IA32_ENERGY_PERF_BIAS if not already initialized.
-	 * (x86_energy_perf_policy(8) is available to change it at run-time.)
-	 */
-	if (!cpu_has(c, X86_FEATURE_EPB))
-		return;
-
-	rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
-	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
-		return;
-
-	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
-	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
-	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
-	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
-}
-
-static void intel_bsp_resume(struct cpuinfo_x86 *c)
-{
-	/*
-	 * MSR_IA32_ENERGY_PERF_BIAS is lost across suspend/resume,
-	 * so reinitialize it properly like during bootup:
-	 */
-	init_intel_energy_perf(c);
-}
-
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
@@ -509,7 +479,6 @@ static void init_intel(struct cpuinfo_x8
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
-	init_intel_energy_perf(c);
 }
 
 #ifdef CONFIG_X86_32
@@ -764,7 +733,6 @@ static const struct cpu_dev intel_cpu_de
 	.c_detect_tlb	= intel_detect_tlb,
 	.c_early_init   = early_init_intel,
 	.c_init		= init_intel,
-	.c_bsp_resume	= intel_bsp_resume,
 	.c_x86_vendor	= X86_VENDOR_INTEL,
 };
 


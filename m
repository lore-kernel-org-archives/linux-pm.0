From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 5/6] arm64: hibernate: Identify the CPU to resume on by its MPIDR
Date: Wed, 15 Jun 2016 18:35:47 +0100
Message-ID: <1466012148-7674-6-git-send-email-james.morse@arm.com>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39185 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbcFORi5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 13:38:57 -0400
In-Reply-To: <1466012148-7674-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>

On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
kernel will assign logical id 0 to a different physical CPU.
This breaks hibernate as hibernate and resume will be attempted on different
CPUs.

Save the MPIDR of the CPU we hibernated on in the hibernate arch-header,
and provide arch_hibernation_disable_cpus() to switch to that CPU during
resume. During hibernate use disable_nonboot_cpus(), and save the MPIDR of
the CPU it selected, this ensures frozen_cpus is updated correctly.

Booting with maxcpus=1, then bringing additional CPUs up from user space may
cause us to hibernate on a CPU that isn't online during boot. In this case,
bring the CPU online.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
Change since v1:
 * Fixed Brining typo

 arch/arm64/include/asm/suspend.h |  1 +
 arch/arm64/kernel/hibernate.c    | 70 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 024d623f662e..487758882ef3 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -46,5 +46,6 @@ int swsusp_arch_suspend(void);
 int swsusp_arch_resume(void);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
+int arch_hibernation_disable_cpus(bool suspend);
 
 #endif
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 75d45c4ceb84..5f9266aeff00 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -15,6 +15,7 @@
  * License terms: GNU General Public License (GPL) version 2
  */
 #define pr_fmt(x) "hibernate: " x
+#include <linux/cpu.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
@@ -26,6 +27,7 @@
 
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
+#include <asm/cputype.h>
 #include <asm/irqflags.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
@@ -33,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/sections.h>
+#include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/virt.h>
 
@@ -59,6 +62,12 @@ extern char hibernate_el2_vectors[];
 extern char __hyp_stub_vectors[];
 
 /*
+ * The logical cpu number we should resume on, initialised to a non-cpu
+ * number.
+ */
+static int sleep_cpu = -EINVAL;
+
+/*
  * Values that may not change over hibernate/resume. We put the build number
  * and date in here so that we guarantee not to resume with a different
  * kernel.
@@ -80,6 +89,8 @@ static struct arch_hibernate_hdr {
 	 * re-configure el2.
 	 */
 	phys_addr_t	__hyp_stub_vectors;
+
+	u64		sleep_cpu_mpidr;
 } resume_hdr;
 
 static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
@@ -122,12 +133,18 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	else
 		hdr->__hyp_stub_vectors = 0;
 
+	/* Save the mpidr of the cpu we called cpu_suspend() on... */
+	hdr->sleep_cpu_mpidr = cpu_logical_map(sleep_cpu);
+	pr_info("Suspending on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
+		hdr->sleep_cpu_mpidr);
+
 	return 0;
 }
 EXPORT_SYMBOL(arch_hibernation_header_save);
 
 int arch_hibernation_header_restore(void *addr)
 {
+	int ret;
 	struct arch_hibernate_hdr_invariants invariants;
 	struct arch_hibernate_hdr *hdr = addr;
 
@@ -137,6 +154,23 @@ int arch_hibernation_header_restore(void *addr)
 		return -EINVAL;
 	}
 
+	sleep_cpu = get_logical_index(hdr->sleep_cpu_mpidr);
+	pr_info("Suspended on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
+		hdr->sleep_cpu_mpidr);
+	if (sleep_cpu < 0) {
+		pr_crit("Suspended on a CPU not known to this kernel!\n");
+		return -EINVAL;
+	}
+	if (!cpu_online(sleep_cpu)) {
+		pr_info("Suspended on a CPU that is offline! Bringing CPU up.\n");
+		ret = cpu_up(sleep_cpu);
+		if (ret) {
+			pr_err("Failed to bring suspend-CPU up!\n");
+			sleep_cpu = -EINVAL;
+			return ret;
+		}
+	}
+
 	resume_hdr = *hdr;
 
 	return 0;
@@ -233,6 +267,7 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
 		/* Clean kernel core startup/idle code to PoC*/
@@ -251,6 +286,7 @@ int swsusp_arch_suspend(void)
 		 */
 		in_suspend = 0;
 
+		sleep_cpu = -EINVAL;
 		__cpu_suspend_exit();
 	}
 
@@ -506,3 +542,37 @@ static int __init check_boot_cpu_online_init(void)
 	return 0;
 }
 core_initcall(check_boot_cpu_online_init);
+
+/* This overrides the weak version in kernel/power/hibernate.c */
+int arch_hibernation_disable_cpus(bool suspend)
+{
+	int cpu, ret;
+
+	if (suspend) {
+		/*
+		 * During hibernate we need frozen_cpus to be updated and saved.
+		 */
+		ret = disable_nonboot_cpus();
+	} else {
+		/*
+		 * Resuming from hibernate. From here, we can't race with
+		 * userspace, and don't need to update frozen_cpus.
+		 */
+		pr_info("Disabling secondary CPUs ...\n");
+
+		/* sleep_cpu must have been loaded from the arch header */
+		BUG_ON(sleep_cpu < 0);
+
+		for_each_online_cpu(cpu) {
+			if (cpu == sleep_cpu)
+				continue;
+			ret = cpu_down(cpu);
+			if (ret) {
+				pr_err("Secondary CPUs are not disabled\n");
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
-- 
2.8.0.rc3


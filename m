From: James Morse <james.morse@arm.com>
Subject: [PATCH v4 2/3] arm64: hibernate: Resume when hibernate image created on non-boot CPU
Date: Mon,  4 Jul 2016 15:52:29 +0100
Message-ID: <1467643950-11034-3-git-send-email-james.morse@arm.com>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48280 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbcGDOzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Jul 2016 10:55:25 -0400
In-Reply-To: <1467643950-11034-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Chen Yu C <yu.c.chen@intel.com>

On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
kernel will assign logical id 0 to a different physical CPU.
This breaks hibernate as hibernate and resume will be attempted on
different CPUs.

We currently forbid hibernate if CPU0 has been hotplugged out to avoid
this situation without kexec.

Save the MPIDR of the CPU we hibernated on in the hibernate arch-header,
use arch_hibernation_disable_cpus() to direct which CPU we should resume
on based on the MPIDR of the CPU we hibernated on. This allows us to
hibernate/resume on any CPU, even if the logical numbers have been
shuffled by kexec.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
This patch should be merged via the PM tree, (potentially with another user
of patch one)

Changes since v3:
 * Changed kconfig name to CONFIG_ARCH_HIBERNATION_CPU_HOOKS
 * Merged the split storing/reading/checking sleep_cpu code back into this patch

Changes since v2:
 * Storing/reading/checking sleep_cpu moved into an earlier patch
 * Moved to macro approach.
 * Added hidden ARCH_HIBERNATION_CPUHP config option.

 arch/arm64/Kconfig               |  4 +++
 arch/arm64/include/asm/suspend.h |  4 +++
 arch/arm64/kernel/hibernate.c    | 70 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a0a691d4220..e8f2d560f97f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1007,6 +1007,10 @@ config ARCH_HIBERNATION_HEADER
 	def_bool y
 	depends on HIBERNATION
 
+config ARCH_HIBERNATION_CPU_HOOKS
+	def_bool y
+	depends on HIBERNATION
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 024d623f662e..9b3e8d9bfc8c 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -47,4 +47,8 @@ int swsusp_arch_resume(void);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
 
+/* Used to resume on the CPU we hibernated on */
+int _arch_hibernation_disable_cpus(bool suspend);
+#define arch_hibernation_disable_cpus(x) _arch_hibernation_disable_cpus(x)
+
 #endif
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 21ab5df9fa76..bae45abde7a2 100644
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
@@ -34,6 +36,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/sections.h>
 #include <asm/smp.h>
+#include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/virt.h>
 
@@ -66,6 +69,12 @@ extern char hibernate_el2_vectors[];
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
@@ -87,6 +96,8 @@ static struct arch_hibernate_hdr {
 	 * re-configure el2.
 	 */
 	phys_addr_t	__hyp_stub_vectors;
+
+	u64		sleep_cpu_mpidr;
 } resume_hdr;
 
 static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
@@ -129,12 +140,18 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	else
 		hdr->__hyp_stub_vectors = 0;
 
+	/* Save the mpidr of the cpu we called cpu_suspend() on... */
+	hdr->sleep_cpu_mpidr = cpu_logical_map(sleep_cpu);
+	pr_info("Hibernating on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
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
 
@@ -144,6 +161,24 @@ int arch_hibernation_header_restore(void *addr)
 		return -EINVAL;
 	}
 
+	sleep_cpu = get_logical_index(hdr->sleep_cpu_mpidr);
+	pr_info("Hibernated on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
+		hdr->sleep_cpu_mpidr);
+	if (sleep_cpu < 0) {
+		pr_crit("Hibernated on a CPU not known to this kernel!\n");
+		sleep_cpu = -EINVAL;
+		return -EINVAL;
+	}
+	if (!cpu_online(sleep_cpu)) {
+		pr_info("Hibernated on a CPU that is offline! Bringing CPU up.\n");
+		ret = cpu_up(sleep_cpu);
+		if (ret) {
+			pr_err("Failed to bring hibernate-CPU up!\n");
+			sleep_cpu = -EINVAL;
+			return ret;
+		}
+	}
+
 	resume_hdr = *hdr;
 
 	return 0;
@@ -245,6 +280,7 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
 		/* Clean kernel to PoC for secondary core startup */
@@ -256,6 +292,7 @@ int swsusp_arch_suspend(void)
 		 */
 		in_suspend = 0;
 
+		sleep_cpu = -EINVAL;
 		__cpu_suspend_exit();
 	}
 
@@ -491,3 +528,36 @@ static int __init check_boot_cpu_online_init(void)
 	return 0;
 }
 core_initcall(check_boot_cpu_online_init);
+
+int _arch_hibernation_disable_cpus(bool suspend)
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


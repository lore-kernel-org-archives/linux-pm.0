From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 2/3] arm64: hibernate: Resume when hibernate image created on non-boot CPU
Date: Wed, 17 Aug 2016 13:50:26 +0100
Message-ID: <1471438227-8747-3-git-send-email-james.morse@arm.com>
References: <1471438227-8747-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52781 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201AbcHQMuz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Aug 2016 08:50:55 -0400
In-Reply-To: <1471438227-8747-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>

disable_nonboot_cpus() assumes that the lowest numbered online CPU is
the boot CPU, and that this is the correct CPU to run any power
management code on.

On arm64 CPU0 can be taken offline. For hibernate/resume this means we
may hibernate on a CPU other than CPU0. If the system is rebooted with
kexec 'CPU0' will be assigned to a different CPU. This complicates
hibernate/resume as now we can't trust the CPU numbers.

We currently forbid hibernate if CPU0 has been hotplugged out to avoid
this situation without kexec.

Save the MPIDR of the CPU we hibernated on in the hibernate arch-header,
use hibernate_resume_nonboot_cpu_disable() to direct which CPU we should
resume on based on the MPIDR of the CPU we hibernated on. This allows us to
hibernate/resume on any CPU, even if the logical numbers have been
shuffled by kexec.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
This patch should be merged via the same tree as patch 1.

 arch/arm64/include/asm/suspend.h |  3 +++
 arch/arm64/kernel/hibernate.c    | 51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 024d623f662e..b8a313fd7a09 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -47,4 +47,7 @@ int swsusp_arch_resume(void);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
 
+/* Used to resume on the CPU we hibernated on */
+int hibernate_resume_nonboot_cpu_disable(void);
+
 #endif
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 65d81f965e74..9fcf2fcda876 100644
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
 #include <asm/sysreg.h>
 #include <asm/virt.h>
@@ -67,6 +70,12 @@ extern char hibernate_el2_vectors[];
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
@@ -88,6 +97,8 @@ static struct arch_hibernate_hdr {
 	 * re-configure el2.
 	 */
 	phys_addr_t	__hyp_stub_vectors;
+
+	u64		sleep_cpu_mpidr;
 } resume_hdr;
 
 static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
@@ -130,12 +141,22 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	else
 		hdr->__hyp_stub_vectors = 0;
 
+	/* Save the mpidr of the cpu we called cpu_suspend() on... */
+	if (sleep_cpu < 0) {
+		pr_err("Failing to hibernate on an unkown CPU.\n");
+		return -ENODEV;
+	}
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
 
@@ -145,6 +166,24 @@ int arch_hibernation_header_restore(void *addr)
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
@@ -256,6 +295,7 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
 		/* Clean kernel to PoC for secondary core startup */
@@ -267,6 +307,7 @@ int swsusp_arch_suspend(void)
 		 */
 		in_suspend = 0;
 
+		sleep_cpu = -EINVAL;
 		__cpu_suspend_exit();
 	}
 
@@ -507,3 +548,13 @@ static int __init check_boot_cpu_online_init(void)
 	return 0;
 }
 core_initcall(check_boot_cpu_online_init);
+
+int hibernate_resume_nonboot_cpu_disable(void)
+{
+	if (sleep_cpu < 0) {
+		pr_err("Failing to resume from hibernate on an unkown CPU.\n");
+		return -ENODEV;
+	}
+
+	return freeze_secondary_cpus(sleep_cpu);
+}
-- 
2.8.0.rc3


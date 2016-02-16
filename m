From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 05/15] arm64: kvm: allows kvm cpu hotplug
Date: Tue, 16 Feb 2016 15:49:17 +0000
Message-ID: <1455637767-31561-6-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54471 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289AbcBPPvg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Feb 2016 10:51:36 -0500
In-Reply-To: <1455637767-31561-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

The current kvm implementation on arm64 does cpu-specific initialization
at system boot, and has no way to gracefully shutdown a core in terms of
kvm. This prevents kexec from rebooting the system at EL2.

This patch adds a cpu tear-down function and also puts an existing cpu-init
code into a separate function, kvm_arch_hardware_disable() and
kvm_arch_hardware_enable() respectively.
We don't need the arm64 specific cpu hotplug hook any more.

Since this patch modifies common code between arm and arm64, one stub
definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
compilation errors.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
[Moved __kvm_hyp_reset() to use kvm_call_hyp(), instead of having its own
 dedicated entry point in el1_sync. Added some comments and a tlbi.]
Signed-off-by: James Morse <james.morse@arm.com>
---
This patch comes from v13 of kexec

 arch/arm/include/asm/kvm_host.h   | 10 +++-
 arch/arm/include/asm/kvm_mmu.h    |  1 +
 arch/arm/kvm/arm.c                | 98 ++++++++++++++++++++++++---------------
 arch/arm/kvm/mmu.c                |  5 ++
 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/include/asm/kvm_mmu.h  | 20 ++++++++
 arch/arm64/kvm/hyp-init.S         | 42 +++++++++++++++++
 7 files changed, 137 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index f9f27792d8ed..8af531d64771 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -220,6 +220,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start)
+{
+	/*
+	 * TODO
+	 * kvm_call_reset(boot_pgd_ptr, phys_idmap_start);
+	 */
+}
+
 static inline int kvm_arch_dev_ioctl_check_extension(long ext)
 {
 	return 0;
@@ -232,7 +241,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index a520b7987a29..4fd9ddb48c0f 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -66,6 +66,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 975da6cfbf59..ee1bee7884a1 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -16,7 +16,6 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
-#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -65,6 +64,8 @@ static DEFINE_SPINLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
+static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -89,11 +90,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
 	return &kvm_arm_running_vcpu;
 }
 
-int kvm_arch_hardware_enable(void)
-{
-	return 0;
-}
-
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
@@ -585,7 +581,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		/*
 		 * Re-check atomic conditions
 		 */
-		if (signal_pending(current)) {
+		if (unlikely(!__this_cpu_read(kvm_arm_hardware_enabled))) {
+			/* cpu has been torn down */
+			ret = 0;
+			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
+			run->fail_entry.hardware_entry_failure_reason
+					= (u64)-ENOEXEC;
+		} else if (signal_pending(current)) {
 			ret = -EINTR;
 			run->exit_reason = KVM_EXIT_INTR;
 		}
@@ -967,7 +969,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
-static void cpu_init_hyp_mode(void *dummy)
+static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t boot_pgd_ptr;
 	phys_addr_t pgd_ptr;
@@ -989,36 +991,61 @@ static void cpu_init_hyp_mode(void *dummy)
 	kvm_arm_init_debug();
 }
 
-static int hyp_init_cpu_notify(struct notifier_block *self,
-			       unsigned long action, void *cpu)
+static void cpu_reset_hyp_mode(void)
 {
-	switch (action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
-		if (__hyp_get_vectors() == hyp_default_vectors)
-			cpu_init_hyp_mode(NULL);
-		break;
+	phys_addr_t boot_pgd_ptr;
+	phys_addr_t phys_idmap_start;
+
+	boot_pgd_ptr = kvm_mmu_get_boot_httbr();
+	phys_idmap_start = kvm_get_idmap_start();
+
+	__cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start);
+}
+
+int kvm_arch_hardware_enable(void)
+{
+	if (!__this_cpu_read(kvm_arm_hardware_enabled)) {
+		cpu_init_hyp_mode();
+		__this_cpu_write(kvm_arm_hardware_enabled, 1);
 	}
 
-	return NOTIFY_OK;
+	return 0;
 }
 
-static struct notifier_block hyp_init_cpu_nb = {
-	.notifier_call = hyp_init_cpu_notify,
-};
+void kvm_arch_hardware_disable(void)
+{
+	if (!__this_cpu_read(kvm_arm_hardware_enabled))
+		return;
+
+	cpu_reset_hyp_mode();
+	__this_cpu_write(kvm_arm_hardware_enabled, 0);
+}
 
 #ifdef CONFIG_CPU_PM
 static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT &&
-	    __hyp_get_vectors() == hyp_default_vectors) {
-		cpu_init_hyp_mode(NULL);
+	/*
+	 * kvm_arm_hardware_enabled is left with its old value over
+	 * PM_ENTER->PM_EXIT. It is used to indicate PM_EXIT should
+	 * re-enable hyp.
+	 */
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			cpu_reset_hyp_mode();
+
+		return NOTIFY_OK;
+	case CPU_PM_EXIT:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			cpu_init_hyp_mode();
+
 		return NOTIFY_OK;
-	}
 
-	return NOTIFY_DONE;
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 static struct notifier_block hyp_init_cpu_pm_nb = {
@@ -1124,14 +1151,20 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Execute the init code on each CPU.
+	 * Init this CPU temporarily to execute kvm_hyp_call()
+	 * during kvm_vgic_hyp_init().
 	 */
-	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
+	preempt_disable();
+	cpu_init_hyp_mode();
 
 	/*
 	 * Init HYP view of VGIC
 	 */
 	err = kvm_vgic_hyp_init();
+
+	cpu_reset_hyp_mode();
+	preempt_enable();
+
 	switch (err) {
 	case 0:
 		vgic_present = true;
@@ -1215,26 +1248,15 @@ int kvm_arch_init(void *opaque)
 		}
 	}
 
-	cpu_notifier_register_begin();
-
 	err = init_hyp_mode();
 	if (err)
 		goto out_err;
 
-	err = __register_cpu_notifier(&hyp_init_cpu_nb);
-	if (err) {
-		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
-		goto out_err;
-	}
-
-	cpu_notifier_register_done();
-
 	hyp_cpu_pm_init();
 
 	kvm_coproc_table_init();
 	return 0;
 out_err:
-	cpu_notifier_register_done();
 	return err;
 }
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index aba61fd3697a..7a3aed62499a 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1643,6 +1643,11 @@ phys_addr_t kvm_get_idmap_vector(void)
 	return hyp_idmap_vector;
 }
 
+phys_addr_t kvm_get_idmap_start(void)
+{
+	return hyp_idmap_start;
+}
+
 int kvm_mmu_init(void)
 {
 	int err;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e3d67ff8798b..cdf49ce6c1ea 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -332,7 +332,6 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		       hyp_stack_ptr, vector_ptr);
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 736433912a1e..1be7703f9de6 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -99,6 +99,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
@@ -310,5 +311,24 @@ static inline unsigned int kvm_get_vmid_bits(void)
 	return (cpuid_feature_extract_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
 }
 
+void __kvm_hyp_reset(phys_addr_t boot_pgd_ptr, phys_addr_t phys_idmap_start);
+
+/*
+ * Call reset code, and switch back to stub hyp vectors. We need to execute
+ * __kvm_hyp_reset() from the trampoline page, we calculate its address here,
+ * and pass it without kimage_voffset translation.
+ */
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start)
+{
+	unsigned long trampoline_hyp_reset;
+
+	trampoline_hyp_reset = TRAMPOLINE_VA +
+			       ((unsigned long)__kvm_hyp_reset & ~PAGE_MASK);
+
+	__kvm_call_hyp((void *)trampoline_hyp_reset,
+		       boot_pgd_ptr, phys_idmap_start);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index dc6335a7353e..d20d86c7f9d8 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -150,6 +150,48 @@ merged:
 	eret
 ENDPROC(__kvm_hyp_init)
 
+	/*
+	 * x0: HYP boot pgd
+	 * x1: HYP phys_idmap_start
+	 */
+ENTRY(__kvm_hyp_reset)
+	/*
+	 * Retrieve lr from the stack (pushed by el1_sync()), so we can eret
+	 * from here.
+	 */
+	ldp	lr, xzr, [sp], #16
+
+	/* We're in trampoline code in VA, switch back to boot page tables */
+	msr	ttbr0_el2, x0
+	isb
+
+	/* Ensure the PA branch doesn't find a stale tlb entry. */
+	tlbi	alle2
+	dsb	sy
+
+	/* Branch into PA space */
+	adr	x0, 1f
+	bfi	x1, x0, #0, #PAGE_SHIFT
+	br	x1
+
+	/* We're now in idmap, disable MMU */
+1:	mrs	x0, sctlr_el2
+	ldr	x1, =SCTLR_ELx_FLAGS
+	bic	x0, x0, x1		// Clear SCTL_M and etc
+	msr	sctlr_el2, x0
+	isb
+
+	/* Invalidate the old TLBs */
+	tlbi	alle2
+	dsb	sy
+
+	/* Install stub vectors */
+	adr_l	x0, __hyp_stub_vectors
+	msr	vbar_el2, x0
+
+	eret
+ENDPROC(__kvm_hyp_reset)
+
 	.ltorg
 
 	.popsection
-- 
2.6.2


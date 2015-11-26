From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 04/10] arm64: kvm: allows kvm cpu hotplug
Date: Thu, 26 Nov 2015 17:32:42 +0000
Message-ID: <1448559168-8363-5-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46256 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbbKZReE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 12:34:04 -0500
In-Reply-To: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

The current kvm implementation on arm64 does cpu-specific initialization
at system boot, and has no way to gracefully shutdown a core in terms of
kvm. This prevents, especially, kexec from rebooting the system on a boot
core in EL2.

This patch adds a cpu tear-down function and also puts an existing cpu-init
code into a separate function, kvm_arch_hardware_disable() and
kvm_arch_hardware_enable() respectively.
We don't need arm64-specific cpu hotplug hook any more.

Since this patch modifies common part of code between arm and arm64, one
stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
compiling errors.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 10 ++++-
 arch/arm/include/asm/kvm_mmu.h    |  1 +
 arch/arm/kvm/arm.c                | 79 ++++++++++++++++++---------------------
 arch/arm/kvm/mmu.c                |  5 +++
 arch/arm64/include/asm/kvm_host.h | 16 +++++++-
 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 arch/arm64/include/asm/virt.h     |  9 +++++
 arch/arm64/kvm/hyp-init.S         | 33 ++++++++++++++++
 arch/arm64/kvm/hyp.S              | 32 ++++++++++++++--
 9 files changed, 138 insertions(+), 48 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 6692982c9b57..924276571658 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -214,6 +214,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
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
@@ -226,7 +235,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 405aa1883307..dc6fadfd0407 100644
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
index eab83b2435b8..a5d9d74f5c75 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -16,7 +16,6 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
-#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -61,6 +60,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
 static DEFINE_SPINLOCK(kvm_vmid_lock);
 
+static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
+
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
 	BUG_ON(preemptible());
@@ -85,11 +86,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
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
@@ -959,7 +955,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
-static void cpu_init_hyp_mode(void *dummy)
+int kvm_arch_hardware_enable(void)
 {
 	phys_addr_t boot_pgd_ptr;
 	phys_addr_t pgd_ptr;
@@ -967,6 +963,9 @@ static void cpu_init_hyp_mode(void *dummy)
 	unsigned long stack_page;
 	unsigned long vector_ptr;
 
+	if (__hyp_get_vectors() != hyp_default_vectors)
+		return 0;
+
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors(kvm_get_idmap_vector());
 
@@ -979,38 +978,50 @@ static void cpu_init_hyp_mode(void *dummy)
 	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
 
 	kvm_arm_init_debug();
+
+	return 0;
 }
 
-static int hyp_init_cpu_notify(struct notifier_block *self,
-			       unsigned long action, void *cpu)
+void kvm_arch_hardware_disable(void)
 {
-	switch (action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
-		if (__hyp_get_vectors() == hyp_default_vectors)
-			cpu_init_hyp_mode(NULL);
-		break;
-	}
+	phys_addr_t boot_pgd_ptr;
+	phys_addr_t phys_idmap_start;
 
-	return NOTIFY_OK;
-}
+	if (__hyp_get_vectors() == hyp_default_vectors)
+		return;
 
-static struct notifier_block hyp_init_cpu_nb = {
-	.notifier_call = hyp_init_cpu_notify,
-};
+	boot_pgd_ptr = kvm_mmu_get_boot_httbr();
+	phys_idmap_start = kvm_get_idmap_start();
+
+	__cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start);
+}
 
 #ifdef CONFIG_CPU_PM
 static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
 				    unsigned long cmd,
 				    void *v)
 {
-	if (cmd == CPU_PM_EXIT &&
-	    __hyp_get_vectors() == hyp_default_vectors) {
-		cpu_init_hyp_mode(NULL);
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (__hyp_get_vectors() != hyp_default_vectors)
+			__this_cpu_write(kvm_arm_hardware_enabled, 1);
+		else
+			__this_cpu_write(kvm_arm_hardware_enabled, 0);
+		/*
+		 * don't call kvm_arch_hardware_disable() in case of
+		 * CPU_PM_ENTER because it does't actually save any state.
+		 */
+
+		return NOTIFY_OK;
+	case CPU_PM_EXIT:
+		if (__this_cpu_read(kvm_arm_hardware_enabled))
+			kvm_arch_hardware_enable();
+
 		return NOTIFY_OK;
-	}
 
-	return NOTIFY_DONE;
+	default:
+		return NOTIFY_DONE;
+	}
 }
 
 static struct notifier_block hyp_init_cpu_pm_nb = {
@@ -1108,11 +1119,6 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Execute the init code on each CPU.
-	 */
-	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
-
-	/*
 	 * Init HYP view of VGIC
 	 */
 	err = kvm_vgic_hyp_init();
@@ -1186,26 +1192,15 @@ int kvm_arch_init(void *opaque)
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
index 6984342da13d..69b4a33d232d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1644,6 +1644,11 @@ phys_addr_t kvm_get_idmap_vector(void)
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
index a35ce7266aac..0b540f852ec1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -223,6 +223,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 u64 kvm_call_hyp(void *hypfn, ...);
+void kvm_call_reset(phys_addr_t boot_pgd_ptr, phys_addr_t phys_idmap_start);
 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
@@ -247,7 +248,20 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
 		     hyp_stack_ptr, vector_ptr);
 }
 
-static inline void kvm_arch_hardware_disable(void) {}
+static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
+					phys_addr_t phys_idmap_start)
+{
+	/*
+	 * Call reset code, and switch back to stub hyp vectors.
+	 */
+	kvm_call_reset(boot_pgd_ptr, phys_idmap_start);
+}
+
+struct vgic_sr_vectors {
+	void	*save_vgic;
+	void	*restore_vgic;
+};
+
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 61505676d085..ff5a08777e11 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -98,6 +98,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_mmu_get_boot_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
+phys_addr_t kvm_get_idmap_start(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 30700961f28c..bca79f90178c 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -58,9 +58,18 @@
 
 #define HVC_CALL_FUNC 3
 
+/*
+ * HVC_RESET_CPU - Reset cpu in EL2 to initial state.
+ *
+ * @x0: entry address in trampoline code in va
+ * @x1: identical mapping page table in pa
+ */
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
+#define HVC_RESET_CPU 4
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 2e67a4872c51..192516332e47 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -139,6 +139,39 @@ merged:
 	eret
 ENDPROC(__kvm_hyp_init)
 
+	/*
+	 * x0: HYP boot pgd
+	 * x1: HYP phys_idmap_start
+	 */
+ENTRY(__kvm_hyp_reset)
+	/* We're in trampoline code in VA, switch back to boot page tables */
+	msr	ttbr0_el2, x0
+	isb
+
+	/* Invalidate the old TLBs */
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
+	ldr	x1, =SCTLR_EL2_FLAGS
+	bic	x0, x0, x1		// Clear SCTL_M and etc
+	msr	sctlr_el2, x0
+	isb
+
+	/* Install stub vectors */
+	adrp	x0, __hyp_stub_vectors
+	add	x0, x0, #:lo12:__hyp_stub_vectors
+	msr	vbar_el2, x0
+
+	eret
+ENDPROC(__kvm_hyp_reset)
+
 	.ltorg
 
 	.popsection
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 1bef8db4a13d..aca11d6b996e 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -939,6 +939,11 @@ ENTRY(kvm_call_hyp)
 	ret
 ENDPROC(kvm_call_hyp)
 
+ENTRY(kvm_call_reset)
+	hvc	#HVC_RESET_CPU
+	ret
+ENDPROC(kvm_call_reset)
+
 .macro invalid_vector	label, target
 	.align	2
 \label:
@@ -982,10 +987,27 @@ el1_sync:					// Guest trapped into EL2
 	cmp	x18, #HVC_GET_VECTORS
 	b.ne	1f
 	mrs	x0, vbar_el2
-	b	2f
-
-1:	/* Default to HVC_CALL_HYP. */
+	b	do_eret
 
+	/* jump into trampoline code */
+1:	cmp	x18, #HVC_RESET_CPU
+	b.ne	2f
+	/*
+	 * Entry point is:
+	 *	TRAMPOLINE_VA
+	 *	+ (__kvm_hyp_reset - (__hyp_idmap_text_start & PAGE_MASK))
+	 */
+	adrp	x2, __kvm_hyp_reset
+	add	x2, x2, #:lo12:__kvm_hyp_reset
+	adrp	x3, __hyp_idmap_text_start
+	add	x3, x3, #:lo12:__hyp_idmap_text_start
+	and	x3, x3, PAGE_MASK
+	sub	x2, x2, x3
+	ldr	x3, =TRAMPOLINE_VA
+	add	x2, x2, x3
+	br	x2				// no return
+
+2:	/* Default to HVC_CALL_HYP. */
 	push	lr, xzr
 
 	/*
@@ -999,7 +1021,9 @@ el1_sync:					// Guest trapped into EL2
 	blr	lr
 
 	pop	lr, xzr
-2:	eret
+
+do_eret:
+	eret
 
 el1_trap:
 	/*
-- 
2.6.2


From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 07/10] x86/cpufeature: Remove cpu_has_apic
Date: Mon,  4 Apr 2016 22:25:00 +0200
Message-ID: <1459801503-15600-8-git-send-email-bp@alien8.de>
References: <1459801503-15600-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1459801503-15600-1-git-send-email-bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: X86 ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, oprofile-list-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>

Signed-off-by: Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
Cc: oprofile-list-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 arch/x86/events/core.c                   |  2 +-
 arch/x86/include/asm/cpufeature.h        |  1 -
 arch/x86/include/asm/irq_work.h          |  2 +-
 arch/x86/kernel/acpi/boot.c              |  8 ++++----
 arch/x86/kernel/apic/apic.c              | 20 ++++++++++----------
 arch/x86/kernel/apic/apic_noop.c         |  4 ++--
 arch/x86/kernel/apic/io_apic.c           |  2 +-
 arch/x86/kernel/apic/ipi.c               |  2 +-
 arch/x86/kernel/apic/vector.c            |  2 +-
 arch/x86/kernel/cpu/amd.c                |  4 ++--
 arch/x86/kernel/cpu/intel.c              |  2 +-
 arch/x86/kernel/cpu/mcheck/mce_intel.c   |  2 +-
 arch/x86/kernel/cpu/mcheck/therm_throt.c |  2 +-
 arch/x86/kernel/devicetree.c             |  2 +-
 arch/x86/kernel/smpboot.c                |  2 +-
 arch/x86/oprofile/nmi_int.c              |  2 +-
 arch/x86/pci/xen.c                       |  2 +-
 drivers/cpufreq/longhaul.c               |  2 +-
 drivers/iommu/irq_remapping.c            |  2 +-
 19 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 041e442a3e28..54c17455600e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1518,7 +1518,7 @@ x86_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu)
 
 static void __init pmu_check_apic(void)
 {
-	if (cpu_has_apic)
+	if (boot_cpu_has(X86_FEATURE_APIC))
 		return;
 
 	x86_pmu.apic = 0;
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 8f58cd215f6d..c532961c7439 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -118,7 +118,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
 } while (0)
 
-#define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
 #define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
 #define cpu_has_xsave		boot_cpu_has(X86_FEATURE_XSAVE)
 #define cpu_has_xsaves		boot_cpu_has(X86_FEATURE_XSAVES)
diff --git a/arch/x86/include/asm/irq_work.h b/arch/x86/include/asm/irq_work.h
index d0afb05c84fc..f70604125286 100644
--- a/arch/x86/include/asm/irq_work.h
+++ b/arch/x86/include/asm/irq_work.h
@@ -5,7 +5,7 @@
 
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return cpu_has_apic;
+	return boot_cpu_has(X86_FEATURE_APIC);
 }
 
 #endif /* _ASM_IRQ_WORK_H */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8c2f1ef6ca23..2522e564269e 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -136,7 +136,7 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 {
 	struct acpi_table_madt *madt = NULL;
 
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -EINVAL;
 
 	madt = (struct acpi_table_madt *)table;
@@ -951,7 +951,7 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 {
 	int count;
 
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
 
 	/*
@@ -979,7 +979,7 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	int ret;
 	struct acpi_subtable_proc madt_proc[2];
 
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
 
 	/*
@@ -1125,7 +1125,7 @@ static int __init acpi_parse_madt_ioapic_entries(void)
 	if (acpi_disabled || acpi_noirq)
 		return -ENODEV;
 
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
 
 	/*
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 0b6509f1a4fe..60078a67d7e3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1085,7 +1085,7 @@ void lapic_shutdown(void)
 {
 	unsigned long flags;
 
-	if (!cpu_has_apic && !apic_from_smp_config())
+	if (!boot_cpu_has(X86_FEATURE_APIC) && !apic_from_smp_config())
 		return;
 
 	local_irq_save(flags);
@@ -1134,7 +1134,7 @@ void __init init_bsp_APIC(void)
 	 * Don't do the setup now if we have a SMP BIOS as the
 	 * through-I/O-APIC virtual wire mode might be active.
 	 */
-	if (smp_found_config || !cpu_has_apic)
+	if (smp_found_config || !boot_cpu_has(X86_FEATURE_APIC))
 		return;
 
 	/*
@@ -1445,7 +1445,7 @@ static void __x2apic_disable(void)
 {
 	u64 msr;
 
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return;
 
 	rdmsrl(MSR_IA32_APICBASE, msr);
@@ -1632,7 +1632,7 @@ void __init enable_IR_x2apic(void)
  */
 static int __init detect_init_APIC(void)
 {
-	if (!cpu_has_apic) {
+	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		pr_info("No local APIC present\n");
 		return -1;
 	}
@@ -1711,14 +1711,14 @@ static int __init detect_init_APIC(void)
 		goto no_apic;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
-		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
+		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
 			break;
 		goto no_apic;
 	default:
 		goto no_apic;
 	}
 
-	if (!cpu_has_apic) {
+	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		/*
 		 * Over-ride BIOS and try to enable the local APIC only if
 		 * "lapic" specified.
@@ -2233,19 +2233,19 @@ int __init APIC_init_uniprocessor(void)
 		return -1;
 	}
 #ifdef CONFIG_X86_64
-	if (!cpu_has_apic) {
+	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		disable_apic = 1;
 		pr_info("Apic disabled by BIOS\n");
 		return -1;
 	}
 #else
-	if (!smp_found_config && !cpu_has_apic)
+	if (!smp_found_config && !boot_cpu_has(X86_FEATURE_APIC))
 		return -1;
 
 	/*
 	 * Complain if the BIOS pretends there is one.
 	 */
-	if (!cpu_has_apic &&
+	if (!boot_cpu_has(X86_FEATURE_APIC) &&
 	    APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
 		pr_err("BIOS bug, local APIC 0x%x not detected!...\n",
 			boot_cpu_physical_apicid);
@@ -2426,7 +2426,7 @@ static void apic_pm_activate(void)
 static int __init init_lapic_sysfs(void)
 {
 	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
-	if (cpu_has_apic)
+	if (boot_cpu_has(X86_FEATURE_APIC))
 		register_syscore_ops(&lapic_syscore_ops);
 
 	return 0;
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 331a7a07c48f..13d19ed58514 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -100,13 +100,13 @@ static void noop_vector_allocation_domain(int cpu, struct cpumask *retmask,
 
 static u32 noop_apic_read(u32 reg)
 {
-	WARN_ON_ONCE((cpu_has_apic && !disable_apic));
+	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !disable_apic);
 	return 0;
 }
 
 static void noop_apic_write(u32 reg, u32 v)
 {
-	WARN_ON_ONCE(cpu_has_apic && !disable_apic);
+	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !disable_apic);
 }
 
 struct apic apic_noop = {
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index fdb0fbfb1197..84e33ff5a6d5 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1454,7 +1454,7 @@ void native_disable_io_apic(void)
 		ioapic_write_entry(ioapic_i8259.apic, ioapic_i8259.pin, entry);
 	}
 
-	if (cpu_has_apic || apic_from_smp_config())
+	if (boot_cpu_has(X86_FEATURE_APIC) || apic_from_smp_config())
 		disconnect_bsp_APIC(ioapic_i8259.pin != -1);
 }
 
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 28bde88b0085..2a0f225afebd 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -230,7 +230,7 @@ int safe_smp_processor_id(void)
 {
 	int apicid, cpuid;
 
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
 
 	apicid = hard_smp_processor_id();
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index ad59d70bcb1a..26d3ccc63e40 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -943,7 +943,7 @@ static int __init print_ICs(void)
 	print_PIC();
 
 	/* don't print out if apic is not there */
-	if (!cpu_has_apic && !apic_from_smp_config())
+	if (!boot_cpu_has(X86_FEATURE_APIC) && !apic_from_smp_config())
 		return 0;
 
 	print_local_APICs(show_lapic);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2fec875392cc..140eb4351a7b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -565,9 +565,9 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	 * can safely set X86_FEATURE_EXTD_APICID unconditionally for families
 	 * after 16h.
 	 */
-	if (cpu_has_apic && c->x86 > 0x16) {
+	if (boot_cpu_has(X86_FEATURE_APIC) && c->x86 > 0x16) {
 		set_cpu_cap(c, X86_FEATURE_EXTD_APICID);
-	} else if (cpu_has_apic && c->x86 >= 0xf) {
+	} else if (boot_cpu_has(X86_FEATURE_APIC) && c->x86 >= 0xf) {
 		/* check CPU config space for extended APIC ID */
 		unsigned int val;
 		val = read_pci_config(0, 24, 0, 0x68);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f71a34944b56..1d5582259b20 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -281,7 +281,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * integrated APIC (see 11AP erratum in "Pentium Processor
 	 * Specification Update").
 	 */
-	if (cpu_has_apic && (c->x86<<8 | c->x86_model<<4) == 0x520 &&
+	if (boot_cpu_has(X86_FEATURE_APIC) && (c->x86<<8 | c->x86_model<<4) == 0x520 &&
 	    (c->x86_mask < 0x6 || c->x86_mask == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c b/arch/x86/kernel/cpu/mcheck/mce_intel.c
index 1e8bb6c94f14..1defb8ea882c 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
@@ -84,7 +84,7 @@ static int cmci_supported(int *banks)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
-	if (!cpu_has_apic || lapic_get_maxlvt() < 6)
+	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 	*banks = min_t(unsigned, MAX_NR_BANKS, cap & 0xff);
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index ac780cad3b86..6b9dc4d18ccc 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -450,7 +450,7 @@ asmlinkage __visible void smp_trace_thermal_interrupt(struct pt_regs *regs)
 /* Thermal monitoring depends on APIC, ACPI and clock modulation */
 static int intel_thermal_supported(struct cpuinfo_x86 *c)
 {
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
 	if (!cpu_has(c, X86_FEATURE_ACPI) || !cpu_has(c, X86_FEATURE_ACC))
 		return 0;
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 1f4acd68b98b..3fe45f84ced4 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -151,7 +151,7 @@ static void __init dtb_lapic_setup(void)
 		return;
 
 	/* Did the boot loader setup the local APIC ? */
-	if (!cpu_has_apic) {
+	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		if (apic_force_enable(r.start))
 			return;
 	}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a2065d3b3b39..1fe4130b14d9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1231,7 +1231,7 @@ static int __init smp_sanity_check(unsigned max_cpus)
 	 * If we couldn't find a local APIC, then get out of here now!
 	 */
 	if (APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid]) &&
-	    !cpu_has_apic) {
+	    !boot_cpu_has(X86_FEATURE_APIC)) {
 		if (!disable_apic) {
 			pr_err("BIOS bug, local APIC #%d not detected!...\n",
 				boot_cpu_physical_apicid);
diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index 25171e9595f7..28c04123b6dd 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -700,7 +700,7 @@ int __init op_nmi_init(struct oprofile_operations *ops)
 	char *cpu_type = NULL;
 	int ret = 0;
 
-	if (!cpu_has_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
 
 	if (force_cpu_type == timer)
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index beac4dfdade6..4bd08b0fc8ea 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -445,7 +445,7 @@ void __init xen_msi_init(void)
 		uint32_t eax = cpuid_eax(xen_cpuid_base() + 4);
 
 		if (((eax & XEN_HVM_CPUID_X2APIC_VIRT) && x2apic_mode) ||
-		    ((eax & XEN_HVM_CPUID_APIC_ACCESS_VIRT) && cpu_has_apic))
+		    ((eax & XEN_HVM_CPUID_APIC_ACCESS_VIRT) && boot_cpu_has(X86_FEATURE_APIC)))
 			return;
 	}
 
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 0f6b229afcb9..247bfa8eaddb 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -945,7 +945,7 @@ static int __init longhaul_init(void)
 	}
 #endif
 #ifdef CONFIG_X86_IO_APIC
-	if (cpu_has_apic) {
+	if (boot_cpu_has(X86_FEATURE_APIC)) {
 		printk(KERN_ERR PFX "APIC detected. Longhaul is currently "
 				"broken in this configuration.\n");
 		return -ENODEV;
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 8adaaeae3268..49721b4e1975 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -36,7 +36,7 @@ static void irq_remapping_disable_io_apic(void)
 	 * As this gets called during crash dump, keep this simple for
 	 * now.
 	 */
-	if (cpu_has_apic || apic_from_smp_config())
+	if (boot_cpu_has(X86_FEATURE_APIC) || apic_from_smp_config())
 		disconnect_bsp_APIC(0);
 }
 
-- 
2.7.3

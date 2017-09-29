From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC hack dont apply] intel_idle: support running within a VM
Date: Sat, 30 Sep 2017 01:01:12 +0300
Message-ID: <20170930005046-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Yang Zhang <yang.zhang.wz@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, wanpeng.li@hotmail.com, pbonzini@redhat.com, tglx@linutronix.de, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, peterz@infradead.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

intel idle driver does not DTRT when running within a VM:
when going into a deep power state, the right thing to
do is to exit to hypervisor rather than to keep polling
within guest using mwait.

Currently the solution is just to exit to hypervisor each time we go
idle - this is why kvm does not expose the mwait leaf to guests even
when it allows guests to do mwait.

But that's not ideal - it seems better to use the idle driver to guess
when will the next interrupt arrive. If that will happen soon, we are
better off doing mwait within guest.

How soon will have to be determined by e.g. how much does
an exit cost.  I plan to pass some flags host to guest to
address above issues, but for performance experiments
it's enough to just add some command line flags.

The patch below is very gross, I've thrown it together quickly so we
can have a discussion about this approach as compared to
changing the scheduler. If someone has the cycles to try some
tuning/performance comparisons, that would be very much appreciated.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c2ae819..6fa58ad 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -65,8 +65,10 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <linux/kvm_para.h>
 
 #define INTEL_IDLE_VERSION "0.4.1"
+#define PREFIX "intel_idle: "
 
 static struct cpuidle_driver intel_idle_driver = {
 	.name = "intel_idle",
@@ -94,6 +96,7 @@ struct idle_cpu {
 };
 
 static const struct idle_cpu *icpu;
+static struct idle_cpu icpus;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
@@ -119,6 +122,49 @@ static struct cpuidle_state *cpuidle_state_table;
 #define flg2MWAIT(flags) (((flags) >> 24) & 0xFF)
 #define MWAIT2flg(eax) ((eax & 0xFF) << 24)
 
+static int intel_halt(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int index)
+{
+	printk_once(KERN_ERR "safe_halt started\n");
+	safe_halt();
+	printk_once(KERN_ERR "safe_halt done\n");
+	return index;
+}
+
+static int kvm_halt_target_residency = 400; /* Halt above this target residency */
+module_param(kvm_halt_target_residency, int, 0444);
+static int kvm_halt_native = 0; /* Use native mwait substates */
+module_param(kvm_halt_native, int, 0444);
+static int kvm_pv_mwait = 0; /* Whether to do mwait within KVM */
+module_param(kvm_pv_mwait, int, 0444);
+
+static struct cpuidle_state kvm_halt_cstate = {
+	.name = "HALT-KVM",
+	.desc = "HALT",
+	.flags = MWAIT2flg(0x10),
+	.exit_latency = 0,
+	.target_residency = 0,
+	.enter = &intel_halt,
+};
+
+static struct cpuidle_state kvm_cstates[] = {
+	{
+		.name = "C1-NHM",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 3,
+		.target_residency = 6,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "HALT-KVM",
+		.desc = "HALT",
+		.flags = MWAIT2flg(0x10),
+		.exit_latency = 30,
+		.target_residency = 399,
+		.enter = &intel_halt, }
+};
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -927,8 +973,11 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
 		tick_broadcast_enter();
 
+	printk_once(KERN_ERR "mwait_idle_with_hints started\n");
 	mwait_idle_with_hints(eax, ecx);
 
+	printk_once(KERN_ERR "mwait_idle_with_hints done\n");
+
 	if (!(lapic_timer_reliable_states & (1 << (cstate))))
 		tick_broadcast_exit();
 
@@ -989,6 +1038,11 @@ static const struct idle_cpu idle_cpu_tangier = {
 	.state_table = tangier_cstates,
 };
 
+static const struct idle_cpu idle_cpu_kvm = {
+	.state_table = kvm_cstates,
+};
+
+
 static const struct idle_cpu idle_cpu_lincroft = {
 	.state_table = atom_cstates,
 	.auto_demotion_disable_flags = ATM_LNC_C6_AUTO_DEMOTE,
@@ -1061,7 +1115,7 @@ static const struct idle_cpu idle_cpu_dnv = {
 };
 
 #define ICPU(model, cpu) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&cpu }
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_NEHALEM_EP,		idle_cpu_nehalem),
@@ -1115,6 +1169,7 @@ static int __init intel_idle_probe(void)
 		pr_debug("disabled\n");
 		return -EPERM;
 	}
+	pr_err(PREFIX "enabled\n");
 
 	id = x86_match_cpu(intel_idle_ids);
 	if (!id) {
@@ -1125,19 +1180,39 @@ static int __init intel_idle_probe(void)
 		return -ENODEV;
 	}
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return -ENODEV;
+	icpus = *(struct idle_cpu *)id->driver_data;
+
+	if (kvm_pv_mwait) {
+
+		if (!kvm_halt_native)
+			icpus = idle_cpu_kvm;
+
+		pr_debug(PREFIX "MWAIT enabled by KVM\n");
+		mwait_substates = 0x1;
+		/*
+		 * these MSRs do not work on kvm maybe they should?
+		 * more likely we need to poke at CPUID before using MSRs
+		 */
+		icpus.auto_demotion_disable_flags = 0;
+		icpus.disable_promotion_to_c1e = 0;
+	} else {
+		if (!cpu_has(&boot_cpu_data, X86_FEATURE_MWAIT))
+			return -ENODEV;
+
+		if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
+			return -ENODEV;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
+		cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
-	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
-	    !mwait_substates)
+		if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
+		    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
+		    !mwait_substates)
 			return -ENODEV;
 
-	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
+		pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
+	}
 
-	icpu = (const struct idle_cpu *)id->driver_data;
+	icpu = &icpus;
 	cpuidle_state_table = icpu->state_table;
 
 	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
@@ -1340,6 +1415,11 @@ static void __init intel_idle_cpuidle_driver_init(void)
 		    (cpuidle_state_table[cstate].enter_freeze == NULL))
 			break;
 
+		if (kvm_pv_mwait &&
+		    cpuidle_state_table[cstate].target_residency >=
+		    kvm_halt_target_residency)
+			break;
+
 		if (cstate + 1 > max_cstate) {
 			pr_info("max_cstate %d reached\n", max_cstate);
 			break;
@@ -1353,7 +1433,7 @@ static void __init intel_idle_cpuidle_driver_init(void)
 					& MWAIT_SUBSTATE_MASK;
 
 		/* if NO sub-states for this state in CPUID, skip it */
-		if (num_substates == 0)
+		if (num_substates == 0 && !kvm_pv_mwait)
 			continue;
 
 		/* if state marked as disabled, skip it */
@@ -1375,6 +1455,20 @@ static void __init intel_idle_cpuidle_driver_init(void)
 		drv->state_count += 1;
 	}
 
+	if (kvm_halt_native && kvm_pv_mwait) {
+		drv->states[drv->state_count] =	/* structure copy */
+			kvm_halt_cstate;
+		drv->states[drv->state_count].exit_latency =
+			drv->state_count > 1 ?
+			drv->states[drv->state_count - 1].exit_latency + 1 : 1;
+		drv->states[drv->state_count].target_residency =
+			kvm_halt_target_residency;
+
+		drv->state_count += 1;
+	}
+
+	printk(KERN_ERR "detected states: %d\n\n",  drv->state_count);
+
 	if (icpu->byt_auto_demotion_disable_flag) {
 		wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
 		wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
@@ -1452,7 +1546,8 @@ static int __init intel_idle_init(void)
 		goto init_driver_fail;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
+	if (boot_cpu_has(X86_FEATURE_ARAT) ||	/* Always Reliable APIC Timer */
+	    kvm_para_available())
 		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
 
 	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
> -- 
> 1.8.3.1

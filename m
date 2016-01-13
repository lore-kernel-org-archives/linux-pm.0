From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Tue, 12 Jan 2016 17:11:23 -0800
Message-ID: <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Reduce remote CPU calls for MSR access by combining read
modify write into one function. Also optimize search for active CPU on
package.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 77 +++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 48747c2..b34d6a6 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -263,7 +263,11 @@ static struct rapl_package *find_package_by_id(int id)
 /* caller to ensure CPU hotplug lock is held */
 static int find_active_cpu_on_package(int package_id)
 {
-	int i;
+	/* try to avoid remote cpu call, use raw since we are preemptible */
+	int i = raw_smp_processor_id();
+
+	if (topology_physical_package_id(i) == package_id)
+		return i;
 
 	for_each_online_cpu(i) {
 		if (topology_physical_package_id(i) == package_id)
@@ -805,30 +809,18 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
 			unsigned long long value)
 {
-	u64 msr_val;
-	u32 msr;
 	struct rapl_primitive_info *rp = &rpi[prim];
 	int cpu;
+	u64 bits;
 
 	cpu = find_active_cpu_on_package(rd->package_id);
 	if (cpu < 0)
 		return cpu;
-	msr = rd->msrs[rp->id];
-	if (rdmsrl_safe_on_cpu(cpu, msr, &msr_val)) {
-		dev_dbg(&rd->power_zone.dev,
-			"failed to read msr 0x%x on cpu %d\n", msr, cpu);
-		return -EIO;
-	}
-	value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
-	msr_val &= ~rp->mask;
-	msr_val |= value << rp->shift;
-	if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
-		dev_dbg(&rd->power_zone.dev,
-			"failed to write msr 0x%x on cpu %d\n", msr, cpu);
-		return -EIO;
-	}
 
-	return 0;
+	bits = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
+	bits |= bits << rp->shift;
+
+	return rmwmsrl_safe_on_cpu(cpu, rd->msrs[rp->id], rp->mask, bits);
 }
 
 /*
@@ -893,6 +885,21 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	return 0;
 }
 
+static void power_limit_irq_save_cpu(void *info)
+{
+	u32 l, h = 0;
+	struct rapl_package *rp = (struct rapl_package *)info;
+
+	/* save the state of PLN irq mask bit before disabling it */
+	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
+	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
+		rp->power_limit_irq = l & PACKAGE_THERM_INT_PLN_ENABLE;
+		rp->power_limit_irq |= PACKAGE_PLN_INT_SAVED;
+	}
+	l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+}
+
 
 /* REVISIT:
  * When package power limit is set artificially low by RAPL, LVT
@@ -906,7 +913,6 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 
 static void package_power_limit_irq_save(int package_id)
 {
-	u32 l, h = 0;
 	int cpu;
 	struct rapl_package *rp;
 
@@ -920,20 +926,27 @@ static void package_power_limit_irq_save(int package_id)
 	cpu = find_active_cpu_on_package(package_id);
 	if (cpu < 0)
 		return;
-	/* save the state of PLN irq mask bit before disabling it */
-	rdmsr_safe_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
-	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
-		rp->power_limit_irq = l & PACKAGE_THERM_INT_PLN_ENABLE;
-		rp->power_limit_irq |= PACKAGE_PLN_INT_SAVED;
-	}
-	l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
-	wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	smp_call_function_single(cpu, power_limit_irq_save_cpu, rp, 1);
+}
+
+static void power_limit_irq_restore_cpu(void *info)
+{
+	u32 l, h = 0;
+	struct rapl_package *rp = (struct rapl_package *)info;
+
+	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
+
+	if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
+		l |= PACKAGE_THERM_INT_PLN_ENABLE;
+	else
+		l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+
+	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
 }
 
 /* restore per package power limit interrupt enable state */
 static void package_power_limit_irq_restore(int package_id)
 {
-	u32 l, h;
 	int cpu;
 	struct rapl_package *rp;
 
@@ -951,14 +964,8 @@ static void package_power_limit_irq_restore(int package_id)
 	/* irq enable state not saved, nothing to restore */
 	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
 		return;
-	rdmsr_safe_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
-
-	if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
-		l |= PACKAGE_THERM_INT_PLN_ENABLE;
-	else
-		l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	smp_call_function_single(cpu, power_limit_irq_restore_cpu, rp, 1);
 }
 
 static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
-- 
1.9.1

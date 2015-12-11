From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] powercap/rapl: reduce ipi calls
Date: Fri, 11 Dec 2015 14:40:37 -0800
Message-ID: <1449873637-24300-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28346 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792AbbLKWlt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Dec 2015 17:41:49 -0500
In-Reply-To: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Reduce remote CPU calls for MSR access by combining read
modify write into one function.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 71 ++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index cc97f08..4fe1627 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -805,30 +805,18 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
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
@@ -893,6 +881,21 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
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
@@ -906,7 +909,6 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 
 static void package_power_limit_irq_save(int package_id)
 {
-	u32 l, h = 0;
 	int cpu;
 	struct rapl_package *rp;
 
@@ -920,20 +922,27 @@ static void package_power_limit_irq_save(int package_id)
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
 
@@ -951,14 +960,8 @@ static void package_power_limit_irq_restore(int package_id)
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


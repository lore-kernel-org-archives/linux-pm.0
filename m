From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/22 v2] cpufreq/acpi-cpufreq: drop rdmsr_on_cpus() usage
Date: Mon, 28 Nov 2016 10:52:03 +0100
Message-ID: <20161128095203.ls4wovz5taos7qxf@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-3-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45295 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbcK1JwH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 04:52:07 -0500
Content-Disposition: inline
In-Reply-To: <20161126231350.10321-3-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, tglx@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

The online / pre_down callback is invoked on the target CPU since commit
1cf4f629d9d2 ("cpu/hotplug: Move online calls to hotplugged cpu") which means
for the hotplug callback we can use rmdsrl() instead of rdmsr_on_cpus().

This leaves us with set_boost() as the only user which still needs to
read/write the MSR on different CPUs. There is no point in doing that
update on all cpus with the read modify write magic via per cpu data. We
simply can issue a function call on all online CPUs which also means that we
need half that many IPIs.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: rebase ontop of the previous patch.

 drivers/cpufreq/acpi-cpufreq.c |   59 +++++++++++++----------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -84,7 +84,6 @@ static inline struct acpi_processor_perf
 static struct cpufreq_driver acpi_cpufreq_driver;
 
 static unsigned int acpi_pstate_strict;
-static struct msr __percpu *msrs;
 
 static bool boost_state(unsigned int cpu)
 {
@@ -104,11 +103,10 @@ static bool boost_state(unsigned int cpu
 	return false;
 }
 
-static void boost_set_msrs(bool enable, const struct cpumask *cpumask)
+static int boost_set_msr(bool enable)
 {
-	u32 cpu;
 	u32 msr_addr;
-	u64 msr_mask;
+	u64 msr_mask, val;
 
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_INTEL:
@@ -120,26 +118,31 @@ static void boost_set_msrs(bool enable,
 		msr_mask = MSR_K7_HWCR_CPB_DIS;
 		break;
 	default:
-		return;
+		return -EINVAL;
 	}
 
-	rdmsr_on_cpus(cpumask, msr_addr, msrs);
+	rdmsrl(msr_addr, val);
 
-	for_each_cpu(cpu, cpumask) {
-		struct msr *reg = per_cpu_ptr(msrs, cpu);
-		if (enable)
-			reg->q &= ~msr_mask;
-		else
-			reg->q |= msr_mask;
-	}
+	if (enable)
+		val &= ~msr_mask;
+	else
+		val |= msr_mask;
 
-	wrmsr_on_cpus(cpumask, msr_addr, msrs);
+	wrmsrl(msr_addr, val);
+	return 0;
+}
+
+static void boost_set_msr_each(void *p_en)
+{
+	bool enable = (bool) p_en;
+
+	boost_set_msr(enable);
 }
 
 static int set_boost(int val)
 {
 	get_online_cpus();
-	boost_set_msrs(val, cpu_online_mask);
+	on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
 	put_online_cpus();
 	pr_debug("Core Boosting %sabled.\n", val ? "en" : "dis");
 
@@ -538,29 +541,20 @@ static void free_acpi_perf_data(void)
 
 static int cpufreq_boost_online(unsigned int cpu)
 {
-	const struct cpumask *cpumask;
-
-	cpumask = get_cpu_mask(cpu);
 	/*
 	 * On the CPU_UP path we simply keep the boost-disable flag
 	 * in sync with the current global state.
 	 */
-	boost_set_msrs(acpi_cpufreq_driver.boost_enabled, cpumask);
-	return 0;
+	return boost_set_msr(acpi_cpufreq_driver.boost_enabled);
 }
 
 static int cpufreq_boost_down_prep(unsigned int cpu)
 {
-	const struct cpumask *cpumask;
-
-	cpumask = get_cpu_mask(cpu);
-
 	/*
 	 * Clear the boost-disable bit on the CPU_DOWN path so that
 	 * this cpu cannot block the remaining ones from boosting.
 	 */
-	boost_set_msrs(1, cpumask);
-	return 0;
+	return boost_set_msr(1);
 }
 
 /*
@@ -918,11 +912,6 @@ static void __init acpi_cpufreq_boost_in
 	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)))
 		return;
 
-	msrs = msrs_alloc();
-
-	if (!msrs)
-		return;
-
 	acpi_cpufreq_driver.set_boost = set_boost;
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
 
@@ -934,8 +923,6 @@ static void __init acpi_cpufreq_boost_in
 				cpufreq_boost_online, cpufreq_boost_down_prep);
 	if (ret < 0) {
 		pr_err("acpi_cpufreq: failed to register hotplug callbacks\n");
-		msrs_free(msrs);
-		msrs = NULL;
 		return;
 	}
 	acpi_cpufreq_online = ret;
@@ -943,14 +930,8 @@ static void __init acpi_cpufreq_boost_in
 
 static void acpi_cpufreq_boost_exit(void)
 {
-	if (!msrs)
-		return;
-
 	if (acpi_cpufreq_online >= 0)
 		cpuhp_remove_state_nocalls(acpi_cpufreq_online);
-
-	msrs_free(msrs);
-	msrs = NULL;
 }
 
 static int __init acpi_cpufreq_init(void)

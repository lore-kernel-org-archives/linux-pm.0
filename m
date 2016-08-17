From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 1/3] cpu/hotplug: Allow suspend/resume CPU to be specified
Date: Wed, 17 Aug 2016 13:50:25 +0100
Message-ID: <1471438227-8747-2-git-send-email-james.morse@arm.com>
References: <1471438227-8747-1-git-send-email-james.morse@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471438227-8747-1-git-send-email-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

disable_nonboot_cpus() assumes that the lowest numbered online CPU is
the boot CPU, and that this is the correct CPU to run any power
management code on.

On x86 this is always correct, as CPU0 cannot (easily) by taken offline.

On arm64 CPU0 can be taken offline. For hibernate/resume this means we
may hibernate on a CPU other than CPU0. If the system is rebooted with
kexec 'CPU0' will be assigned to a different physical CPU. This
complicates hibernate/resume as now we can't trust the CPU numbers.
Arch code can find the correct physical CPU, and ensure it is online
before resume from hibernate begins, but also needs to influence
disable_nonboot_cpus()s choice of CPU.

Rename disable_nonboot_cpus() as freeze_secondary_cpus() and add an
argument indicating which CPU should be left standing. Follow the logic
in migrate_to_reboot_cpu() to use the lowest numbered online CPU if the
requested CPU is not online.
Add disable_nonboot_cpus() as an inline function that has the existing
behaviour.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
An alternative is to provide two functions calling a common function,
but this would mean spilling the cpu_maps_update_begin() into these two.

 include/linux/cpu.h | 6 +++++-
 kernel/cpu.c        | 9 +++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 797d9c8e9a1b..ad4f1f33a74e 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -228,7 +228,11 @@ static inline void cpu_hotplug_done(void) {}
 #endif		/* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_PM_SLEEP_SMP
-extern int disable_nonboot_cpus(void);
+extern int freeze_secondary_cpus(int primary);
+static inline int disable_nonboot_cpus(void)
+{
+	return freeze_secondary_cpus(0);
+}
 extern void enable_nonboot_cpus(void);
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 341bf80f80bd..ebbf027dd4a1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1024,12 +1024,13 @@ EXPORT_SYMBOL_GPL(cpu_up);
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-int disable_nonboot_cpus(void)
+int freeze_secondary_cpus(int primary)
 {
-	int cpu, first_cpu, error = 0;
+	int cpu, error = 0;
 
 	cpu_maps_update_begin();
-	first_cpu = cpumask_first(cpu_online_mask);
+	if (!cpu_online(primary))
+		primary = cpumask_first(cpu_online_mask);
 	/*
 	 * We take down all of the non-boot CPUs in one shot to avoid races
 	 * with the userspace trying to use the CPU hotplug at the same time
@@ -1038,7 +1039,7 @@ int disable_nonboot_cpus(void)
 
 	pr_info("Disabling non-boot CPUs ...\n");
 	for_each_online_cpu(cpu) {
-		if (cpu == first_cpu)
+		if (cpu == primary)
 			continue;
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
 		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
-- 
2.8.0.rc3

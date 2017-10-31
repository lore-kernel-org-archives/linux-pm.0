From: Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 1/3][RFC/RFT] PM / sleep: Introduce a flag to identify the enable_nonboot_cpus stage
Date: Tue, 31 Oct 2017 17:58:19 +0800
Message-ID: <1fb567e68f522a51cc447f79becafe773b697246.1509438899.git.yu.c.chen@intel.com>
References: <cover.1509438899.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509438899.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

A new flag is introduced to indicate that, we are in the process of
running enable_nonboot_cpus() to bring the APs up. This flag is to
prepare for the use of MTRR sync later.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/cpu.h | 2 ++
 kernel/cpu.c        | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index ca73bc1563f4..f0759d837919 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -133,9 +133,11 @@ static inline int disable_nonboot_cpus(void)
 	return freeze_secondary_cpus(0);
 }
 extern void enable_nonboot_cpus(void);
+extern bool in_enable_nonboot_cpus(void);
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
+static inline bool in_enable_nonboot_cpus(void) { return false; }
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
 void cpu_startup_entry(enum cpuhp_state state);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 04892a82f6ac..071dcae8b0fb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1077,6 +1077,12 @@ EXPORT_SYMBOL_GPL(cpu_up);
 
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
+static bool enable_nonboot_cpus_run;
+
+bool in_enable_nonboot_cpus(void)
+{
+	return enable_nonboot_cpus_run;
+}
 
 int freeze_secondary_cpus(int primary)
 {
@@ -1143,6 +1149,7 @@ void enable_nonboot_cpus(void)
 	pr_info("Enabling non-boot CPUs ...\n");
 
 	arch_enable_nonboot_cpus_begin();
+	enable_nonboot_cpus_run = true;
 
 	for_each_cpu(cpu, frozen_cpus) {
 		trace_suspend_resume(TPS("CPU_ON"), cpu, true);
@@ -1155,6 +1162,7 @@ void enable_nonboot_cpus(void)
 		pr_warn("Error taking CPU%d up: %d\n", cpu, error);
 	}
 
+	enable_nonboot_cpus_run = false;
 	arch_enable_nonboot_cpus_end();
 
 	cpumask_clear(frozen_cpus);
-- 
2.13.5

From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH] sched/x86: Change CONFIG_SCHED_ITMT to CONFIG_SCHED_MC_PRIO
Date: Tue, 29 Nov 2016 10:43:27 -0800
Message-ID: <2b2ee29d93e3f162922d72d0165a1405864fbb23.1480444902.git.tim.c.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Update CONFIG_SCHED_ITMT for Intel Turbo Boost Max Technology 3.0
to CONFIG_SCHED_MC_PRIO.  This makes the configuration extensible
in future to other architectures that wish to similarly establish CPU
core priorities support in the scheduler.

The description in Kconfig is updated to reflect this change with
added details for better clarity.  The configuration is explicitly
defaulted to be on for cpus that have this feature.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/Kconfig                | 22 ++++++++++++++++------
 arch/x86/include/asm/topology.h |  6 +++---
 arch/x86/kernel/Makefile        |  2 +-
 drivers/acpi/bus.c              |  2 +-
 drivers/cpufreq/Kconfig.x86     |  2 +-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 25950f0..715c1f3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -939,14 +939,24 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
-config SCHED_ITMT
-	bool "Intel Turbo Boost Max Technology (ITMT) scheduler support"
+config SCHED_MC_PRIO
+	bool "CPU core priorities scheduler support"
 	depends on SCHED_MC && CPU_SUP_INTEL && X86_INTEL_PSTATE
+	default y
 	---help---
-	  ITMT enabled scheduler support improves the CPU scheduler's decision
-	  to move tasks to cpu core that can be boosted to a higher frequency
-	  than others. It will have better performance at a cost of slightly
-	  increased overhead in task migrations. If unsure say N here.
+	   Intel Turbo Boost Max Technology 3.0 enabled CPUs have a
+	   core ordering determined at manufacturing time, which allows
+	   certain cores to reach higher turbo frequencies (when running
+	   single threaded workloads) than others.
+
+	   Enabling this kernel feature teaches the scheduler about
+	   the TBM3 (aka ITMT) priority order of the CPU cores and adjusts the
+	   scheduler's CPU selection logic accordingly, so that higher
+	   overall system performance can be achieved.
+
+	   This feature will have no effect on CPUs without this feature.
+
+	   If unsure say Y here.
 
 source "kernel/Kconfig.preempt"
 
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 4813df5..6358a85 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -148,7 +148,7 @@ void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
 extern bool x86_topology_update;
 
-#ifdef CONFIG_SCHED_ITMT
+#ifdef CONFIG_SCHED_MC_PRIO
 #include <asm/percpu.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
@@ -163,7 +163,7 @@ int sched_set_itmt_support(void);
 /* Interface to notify scheduler that system revokes ITMT support */
 void sched_clear_itmt_support(void);
 
-#else /* CONFIG_SCHED_ITMT */
+#else /* CONFIG_SCHED_MC_PRIO */
 
 #define sysctl_sched_itmt_enabled	0
 static inline void sched_set_itmt_core_prio(int prio, int core_cpu)
@@ -176,6 +176,6 @@ static inline int sched_set_itmt_support(void)
 static inline void sched_clear_itmt_support(void)
 {
 }
-#endif /* CONFIG_SCHED_ITMT */
+#endif /* CONFIG_SCHED_MC_PRIO */
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index bbd0ebc..05110c1 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -123,7 +123,7 @@ obj-$(CONFIG_EFI)			+= sysfb_efi.o
 
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
-obj-$(CONFIG_SCHED_ITMT)		+= itmt.o
+obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 
 ifdef CONFIG_FRAME_POINTER
 obj-y					+= unwind_frame.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 806db0d..5cbefd7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -338,7 +338,7 @@ static void acpi_bus_osc_support(void)
 	}
 #endif
 
-	if (IS_ENABLED(CONFIG_SCHED_ITMT))
+	if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
 
 	if (!ghes_disable)
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index c6d273b..35f7182 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -6,7 +6,7 @@ config X86_INTEL_PSTATE
        bool "Intel P state control"
        depends on X86
        select ACPI_PROCESSOR if ACPI
-       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_ITMT
+       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
        help
           This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
-- 
2.5.5


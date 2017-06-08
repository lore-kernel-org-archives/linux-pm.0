From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 3/6] arm: wire frequency-invariant accounting support up to the task scheduler
Date: Thu,  8 Jun 2017 08:55:10 +0100
Message-ID: <20170608075513.12475-4-dietmar.eggemann@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
changed the wiring which now has to be done by associating
arch_scale_freq_capacity with the actual implementation provided
by the architecture.

Define arch_scale_freq_capacity to use the arch_topology "driver"
function topology_get_freq_scale() for the task scheduler's
frequency-invariant accounting instead of the default
arch_scale_freq_capacity() in kernel/sched/sched.h.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/include/asm/topology.h | 5 +++++
 arch/arm/kernel/topology.c      | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 370f7a732900..a56a9e24f4c0 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -24,6 +24,11 @@ void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 
+#include <linux/arch_topology.h>
+
+/* Replace task scheduler's default frequency-invariant accounting */
+#define arch_scale_freq_capacity topology_get_freq_scale
+
 #else
 
 static inline void init_cpu_topology(void) { }
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index bf949a763dbe..2c47a76c67b0 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -11,7 +11,6 @@
  * for more details.
  */
 
-#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-- 
2.11.0

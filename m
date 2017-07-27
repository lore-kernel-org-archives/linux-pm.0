From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 08/10] arm: wire cpu-invariant accounting support up to the task scheduler
Date: Thu, 27 Jul 2017 20:33:10 +0100
Message-ID: <20170727193312.9849-9-dietmar.eggemann@arm.com>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Commit 8cd5601c5060 ("sched/fair: Convert arch_scale_cpu_capacity() from
weak function to #define") changed the wiring which now has to be done
by associating arch_scale_cpu_capacity with the actual implementation
provided by the architecture.

Define arch_scale_cpu_capacity to use the arch_topology "driver"
function topology_get_cpu_scale() for the task scheduler's cpu-invariant
accounting instead of the default arch_scale_cpu_capacity() in
kernel/sched/sched.h.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Reviewed-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index a56a9e24f4c0..b713e7223bc4 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -29,6 +29,9 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_capacity topology_get_freq_scale
 
+/* Replace task scheduler's default cpu-invariant accounting */
+#define arch_scale_cpu_capacity topology_get_cpu_scale
+
 #else
 
 static inline void init_cpu_topology(void) { }
-- 
2.11.0

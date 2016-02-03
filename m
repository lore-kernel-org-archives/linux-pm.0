From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v3 1/6] ARM: initialize cpu_scale to its default
Date: Wed,  3 Feb 2016 11:59:54 +0000
Message-ID: <1454500799-18451-2-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Instead of looping through all cpus calling set_capacity_scale, we can
initialise cpu_scale per-cpu variables to SCHED_CAPACITY_SCALE with their
definition.

Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 08b7847..ec279d1 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -40,7 +40,7 @@
  * to run the rebalance_domains for all idle cores and the cpu_capacity can be
  * updated during this sequence.
  */
-static DEFINE_PER_CPU(unsigned long, cpu_scale);
+static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
@@ -306,8 +306,6 @@ void __init init_cpu_topology(void)
 		cpu_topo->socket_id = -1;
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_clear(&cpu_topo->thread_sibling);
-
-		set_capacity_scale(cpu, SCHED_CAPACITY_SCALE);
 	}
 	smp_wmb();
 
-- 
2.7.0

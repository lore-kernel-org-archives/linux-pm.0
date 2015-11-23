From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 5/8] arm64: parse cpu capacity from DT
Date: Mon, 23 Nov 2015 14:28:38 +0000
Message-ID: <1448288921-30307-6-git-send-email-juri.lelli@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

With the introduction of cpu capacity bindings, CPU capacities can now be
extracted from DT. Add parsing of such information at boot time. Also,
store such information using per CPU variables, as we do for arm.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Brown <broonie@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm64/kernel/topology.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 694f6de..4423cc5 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -23,6 +23,45 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
+static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
+
+static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
+{
+	per_cpu(cpu_scale, cpu) = capacity;
+}
+
+static u32 capacity_scale = SCHED_CAPACITY_SCALE;
+
+static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+{
+	int ret;
+	u32 cpu_capacity;
+
+	ret = of_property_read_u32(cpu_node,
+				   "capacity",
+				   &cpu_capacity);
+	if (!ret) {
+		u64 capacity;
+
+		/*
+		 * Enforce capacity <= capacity-scale.
+		 */
+		cpu_capacity = cpu_capacity <= capacity_scale ? cpu_capacity :
+			capacity_scale;
+		capacity = (cpu_capacity << SCHED_CAPACITY_SHIFT) /
+			capacity_scale;
+
+		set_capacity_scale(cpu, capacity);
+		pr_info("CPU%d: DT cpu_capacity %lu\n",
+			cpu, arch_scale_cpu_capacity(NULL, cpu));
+	}
+}
+
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	struct device_node *cpu_node;
@@ -34,6 +73,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 
 	for_each_possible_cpu(cpu) {
 		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
+			parse_cpu_capacity(cpu_node, cpu);
 			of_node_put(cpu_node);
 			return cpu;
 		}
@@ -173,6 +213,12 @@ static int __init parse_dt_topology(void)
 		return 0;
 	}
 
+	if (!of_property_read_u32(cn, "capacity-scale", &capacity_scale))
+		pr_info("DT cpus capacity-scale %u\n", capacity_scale);
+	else
+		pr_debug("DT cpus capacity-scale not found: assuming %u\n",
+			capacity_scale);
+
 	/*
 	 * When topology is provided cpu-map is essentially a root
 	 * cluster with restricted subnodes.
-- 
2.2.2

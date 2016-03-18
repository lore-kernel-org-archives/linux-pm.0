From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v4 5/8] arm64: parse cpu capacity from DT
Date: Fri, 18 Mar 2016 14:24:11 +0000
Message-ID: <1458311054-13524-6-git-send-email-juri.lelli@arm.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, juri.lelli@arm.com, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, Mark Brown <broonie@linaro.org>, will.deacon@arm.com, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

With the introduction of cpu capacity bindings, CPU capacities can now be
extracted from DT. Add parsing of such information at boot time. Also,
store such information using per CPU variables, as we do for arm.

Caveat: the information provided by this patch will start to be used in
the future, by properly defining arch_scale_cpu_capacity().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Brown <broonie@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---

 Changes from v1:
  - normalize w.r.t. highest capacity found in DT
  - bailout conditions (all-or-nothing)
---
 arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 694f6de..69229b3 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -19,10 +19,82 @@
 #include <linux/nodemask.h>
 #include <linux/of.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 
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
+static u32 capacity_scale;
+static u32 *raw_capacity;
+static bool cap_parsing_failed;
+
+static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+{
+	int ret;
+	u32 cpu_capacity;
+
+	if (cap_parsing_failed)
+		return;
+
+	ret = of_property_read_u32(cpu_node,
+				   "capacity",
+				   &cpu_capacity);
+	if (!ret) {
+		if (!raw_capacity) {
+			raw_capacity = kzalloc(sizeof(*raw_capacity) *
+					num_possible_cpus(), GFP_KERNEL);
+			if (!raw_capacity) {
+				pr_err("cpu_capacity: failed to allocate memory"
+				       " for raw capacities\n");
+				cap_parsing_failed = true;
+				return;
+			}
+		}
+		capacity_scale = max(cpu_capacity, capacity_scale);
+		raw_capacity[cpu] = cpu_capacity;
+		pr_debug("cpu_capacity: %s cpu_capacity=%u (raw)\n",
+			cpu_node->full_name, raw_capacity[cpu]);
+	} else {
+		pr_err("cpu_capacity: missing %s raw capacity "
+		       "(fallback to 1024 for all CPUs)\n",
+				cpu_node->full_name);
+		cap_parsing_failed = true;
+		kfree(raw_capacity);
+	}
+}
+
+static void __init normalize_cpu_capacity(void)
+{
+	u64 capacity;
+	int cpu;
+
+	if (cap_parsing_failed)
+		return;
+
+	pr_info("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	for_each_possible_cpu(cpu) {
+		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
+			/ capacity_scale;
+		set_capacity_scale(cpu, capacity);
+		pr_info("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, arch_scale_cpu_capacity(NULL, cpu));
+	}
+
+	kfree(raw_capacity);
+}
+
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	struct device_node *cpu_node;
@@ -34,6 +106,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 
 	for_each_possible_cpu(cpu) {
 		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
+			parse_cpu_capacity(cpu_node, cpu);
 			of_node_put(cpu_node);
 			return cpu;
 		}
@@ -185,6 +258,8 @@ static int __init parse_dt_topology(void)
 	if (ret != 0)
 		goto out_map;
 
+	normalize_cpu_capacity();
+
 	/*
 	 * Check that all cores are in the topology; the SMP code will
 	 * only mark cores described in the DT as possible.
-- 
2.7.0

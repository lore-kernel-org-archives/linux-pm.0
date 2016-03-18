From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v4 3/8] arm: parse cpu capacity from DT
Date: Fri, 18 Mar 2016 14:24:09 +0000
Message-ID: <1458311054-13524-4-git-send-email-juri.lelli@arm.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

With the introduction of cpu capacity bindings, CPU capacities can now be
extracted from DT. Add parsing of such information at boot time. We keep
code that can produce same information, based on different DT properties
and hard-coded values, as fall-back for backward compatibility.

Caveat: the information provided by this patch will start to be used in
the future, by properly defining arch_scale_cpu_capacity().

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---

 Changes from v1:
  - normalize w.r.t. highest capacity found in DT
  - bailout conditions (all-or-nothing)
---
 arch/arm/kernel/topology.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ec279d1..53c13c1 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -78,6 +78,67 @@ static unsigned long *__cpu_capacity;
 #define cpu_capacity(cpu)	__cpu_capacity[cpu]
 
 static unsigned long middle_capacity = 1;
+static bool cap_from_dt = true;
+static u32 *raw_capacity;
+static bool cap_parsing_failed;
+static u32 capacity_scale;
+
+static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+{
+	int ret = 1;
+	u32 cpu_capacity;
+
+	if (cap_parsing_failed)
+		return !ret;
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
+				return !ret;
+			}
+		}
+		capacity_scale = max(cpu_capacity, capacity_scale);
+		raw_capacity[cpu] = cpu_capacity;
+		pr_debug("cpu_capacity: %s cpu_capacity=%u (raw)\n",
+			cpu_node->full_name, raw_capacity[cpu]);
+	} else {
+		pr_err("cpu_capacity: missing %s raw capacity "
+		       "(fallback to 1024 for all CPUs)\n",
+		       cpu_node->full_name);
+		cap_parsing_failed = true;
+		kfree(raw_capacity);
+	}
+
+	return !ret;
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
 
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
@@ -99,6 +160,12 @@ static void __init parse_dt_topology(void)
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	cn = of_find_node_by_path("/cpus");
+	if (!cn) {
+		pr_err("No CPU information found in DT\n");
+		return;
+	}
+
 	for_each_possible_cpu(cpu) {
 		const u32 *rate;
 		int len;
@@ -110,6 +177,13 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
+		if (parse_cpu_capacity(cn, cpu)) {
+			of_node_put(cn);
+			continue;
+		}
+
+		cap_from_dt = false;
+
 		for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
 			if (of_device_is_compatible(cn, cpu_eff->compatible))
 				break;
@@ -151,6 +225,8 @@ static void __init parse_dt_topology(void)
 		middle_capacity = ((max_capacity / 3)
 				>> (SCHED_CAPACITY_SHIFT-1)) + 1;
 
+	if (cap_from_dt && !cap_parsing_failed)
+		normalize_cpu_capacity();
 }
 
 /*
@@ -160,7 +236,7 @@ static void __init parse_dt_topology(void)
  */
 static void update_cpu_capacity(unsigned int cpu)
 {
-	if (!cpu_capacity(cpu))
+	if (!cpu_capacity(cpu) || cap_from_dt)
 		return;
 
 	set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
-- 
2.7.0

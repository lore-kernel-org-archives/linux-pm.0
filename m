From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v2 9/9] arm, arm64,
 drivers: add a prefix to drivers arch_topology interfaces
Date: Thu,  9 Feb 2017 09:25:25 +0000
Message-ID: <20170209092525.6654-10-juri.lelli@arm.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170209092525.6654-1-juri.lelli@arm.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, juri.lelli@arm.com, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Now that some functions that deal with arch topology information live
under drivers, there is a clash of naming that might create confusion.

Tidy things up by creating a drivers namespace for interfaces used by
arch code; achieve this by prepending a 'atd_' (arch topology driver)
prefix to driver interfaces.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c    |  8 ++++----
 arch/arm64/kernel/topology.c  |  4 ++--
 drivers/base/arch_topology.c  | 20 ++++++++++----------
 include/linux/arch_topology.h |  8 ++++----
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 1855632105a4..a33e0891fee2 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -110,7 +110,7 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
-		if (parse_cpu_capacity(cn, cpu)) {
+		if (atd_parse_cpu_capacity(cn, cpu)) {
 			of_node_put(cn);
 			continue;
 		}
@@ -159,7 +159,7 @@ static void __init parse_dt_topology(void)
 				>> (SCHED_CAPACITY_SHIFT-1)) + 1;
 
 	if (cap_from_dt)
-		normalize_cpu_capacity();
+		atd_normalize_cpu_capacity();
 }
 
 /*
@@ -172,10 +172,10 @@ static void update_cpu_capacity(unsigned int cpu)
 	if (!cpu_capacity(cpu) || cap_from_dt)
 		return;
 
-	set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
+	atd_set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	pr_info("CPU%u: update cpu_capacity %lu\n",
-		cpu, arch_scale_cpu_capacity(NULL, cpu));
+		cpu, atd_scale_cpu_capacity(NULL, cpu));
 }
 
 #else
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 6d2af4d9479f..1f6b34b6b359 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -38,7 +38,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 
 	for_each_possible_cpu(cpu) {
 		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
-			parse_cpu_capacity(cpu_node, cpu);
+			atd_parse_cpu_capacity(cpu_node, cpu);
 			of_node_put(cpu_node);
 			return cpu;
 		}
@@ -190,7 +190,7 @@ static int __init parse_dt_topology(void)
 	if (ret != 0)
 		goto out_map;
 
-	normalize_cpu_capacity();
+	atd_normalize_cpu_capacity();
 
 	/*
 	 * Check that all cores are in the topology; the SMP code will
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 409a8bb613f2..5c20280bb746 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -22,12 +22,12 @@
 static DEFINE_MUTEX(cpu_scale_mutex);
 static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+unsigned long atd_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
 
-void set_capacity_scale(unsigned int cpu, unsigned long capacity)
+void atd_set_capacity_scale(unsigned int cpu, unsigned long capacity)
 {
 	per_cpu(cpu_scale, cpu) = capacity;
 }
@@ -39,7 +39,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
 	return sprintf(buf, "%lu\n",
-			arch_scale_cpu_capacity(NULL, cpu->dev.id));
+			atd_scale_cpu_capacity(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
@@ -61,7 +61,7 @@ static ssize_t cpu_capacity_store(struct device *dev,
 
 		mutex_lock(&cpu_scale_mutex);
 		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
-			set_capacity_scale(i, new_capacity);
+			atd_set_capacity_scale(i, new_capacity);
 		mutex_unlock(&cpu_scale_mutex);
 	}
 
@@ -93,7 +93,7 @@ u32 capacity_scale;
 u32 *raw_capacity;
 static bool cap_parsing_failed;
 
-void normalize_cpu_capacity(void)
+void atd_normalize_cpu_capacity(void)
 {
 	u64 capacity;
 	int cpu;
@@ -108,14 +108,14 @@ void normalize_cpu_capacity(void)
 			 cpu, raw_capacity[cpu]);
 		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
 			/ capacity_scale;
-		set_capacity_scale(cpu, capacity);
+		atd_set_capacity_scale(cpu, capacity);
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
-			cpu, arch_scale_cpu_capacity(NULL, cpu));
+			cpu, atd_scale_cpu_capacity(NULL, cpu));
 	}
 	mutex_unlock(&cpu_scale_mutex);
 }
 
-int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+int __init atd_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
 	int ret = 1;
 	u32 cpu_capacity;
@@ -180,12 +180,12 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 			       cpus_to_visit,
 			       policy->related_cpus);
 		for_each_cpu(cpu, policy->related_cpus) {
-			raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
+			raw_capacity[cpu] = atd_scale_cpu_capacity(NULL, cpu) *
 					    policy->cpuinfo.max_freq / 1000UL;
 			capacity_scale = max(raw_capacity[cpu], capacity_scale);
 		}
 		if (cpumask_empty(cpus_to_visit)) {
-			normalize_cpu_capacity();
+			atd_normalize_cpu_capacity();
 			kfree(raw_capacity);
 			pr_debug("cpu_capacity: parsing done\n");
 			cap_parsing_done = true;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 4edae9fe8cdd..e25458d7ee9a 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -4,14 +4,14 @@
 #ifndef _LINUX_ARCH_TOPOLOGY_H_
 #define _LINUX_ARCH_TOPOLOGY_H_
 
-void normalize_cpu_capacity(void);
+void atd_normalize_cpu_capacity(void);
 
 struct device_node;
-int parse_cpu_capacity(struct device_node *cpu_node, int cpu);
+int atd_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 struct sched_domain;
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
+unsigned long atd_scale_cpu_capacity(struct sched_domain *sd, int cpu);
 
-void set_capacity_scale(unsigned int cpu, unsigned long capacity);
+void atd_set_capacity_scale(unsigned int cpu, unsigned long capacity);
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.10.0

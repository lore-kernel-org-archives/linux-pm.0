From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v2 8/9] arm,arm64,drivers: move externs in a new header file
Date: Thu,  9 Feb 2017 09:25:24 +0000
Message-ID: <20170209092525.6654-9-juri.lelli@arm.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170209092525.6654-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

Create a new header file (include/linux/arch_topology.h) and put there
declarations of interfaces used by arm, arm64 and drivers code.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c    |  7 +------
 arch/arm64/kernel/topology.c  |  4 +---
 drivers/base/arch_topology.c  |  1 +
 include/linux/arch_topology.h | 17 +++++++++++++++++
 4 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/arch_topology.h

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 5d4679a5418b..1855632105a4 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
@@ -44,10 +45,6 @@
  * updated during this sequence.
  */
 
-extern unsigned long
-arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
-extern void set_capacity_scale(unsigned int cpu, unsigned long capacity);
-
 #ifdef CONFIG_OF
 struct cpu_efficiency {
 	const char *compatible;
@@ -75,8 +72,6 @@ static unsigned long *__cpu_capacity;
 
 static unsigned long middle_capacity = 1;
 static bool cap_from_dt = true;
-extern void normalize_cpu_capacity(void);
-extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index deb5ebc1bdfe..6d2af4d9479f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -26,9 +27,6 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-extern void normalize_cpu_capacity(void);
-extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
-
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	struct device_node *cpu_node;
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c75fa5ab732b..409a8bb613f2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
new file mode 100644
index 000000000000..4edae9fe8cdd
--- /dev/null
+++ b/include/linux/arch_topology.h
@@ -0,0 +1,17 @@
+/*
+ * include/linux/arch_topology.h - arch specific cpu topology information
+ */
+#ifndef _LINUX_ARCH_TOPOLOGY_H_
+#define _LINUX_ARCH_TOPOLOGY_H_
+
+void normalize_cpu_capacity(void);
+
+struct device_node;
+int parse_cpu_capacity(struct device_node *cpu_node, int cpu);
+
+struct sched_domain;
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
+
+void set_capacity_scale(unsigned int cpu, unsigned long capacity);
+
+#endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.10.0

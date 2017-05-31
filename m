From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v5 6/7] arm,arm64,drivers: move externs in a new header file
Date: Wed, 31 May 2017 17:59:30 +0100
Message-ID: <20170531165931.6945-7-juri.lelli@arm.com>
References: <20170531165931.6945-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531165931.6945-1-juri.lelli@arm.com>
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

Create a new header file (include/linux/arch_topology.h) and put there
declarations of interfaces used by arm, arm64 and drivers code.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/topology.c    |  7 +------
 arch/arm64/kernel/topology.c  |  4 +---
 drivers/base/arch_topology.c  |  1 +
 include/linux/arch_topology.h | 17 +++++++++++++++++
 4 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/arch_topology.h

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 1e35a3265ddf..557be4f1d2d7 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
@@ -45,10 +46,6 @@
  * updated during this sequence.
  */
 
-extern unsigned long
-arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
-extern void set_capacity_scale(unsigned int cpu, unsigned long capacity);
-
 #ifdef CONFIG_OF
 struct cpu_efficiency {
 	const char *compatible;
@@ -76,8 +73,6 @@ static unsigned long *__cpu_capacity;
 
 static unsigned long middle_capacity = 1;
 static bool cap_from_dt = true;
-extern void normalize_cpu_capacity(void);
-extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7e1f6f75185b..255230c3e835 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -27,9 +28,6 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-extern void normalize_cpu_capacity(void);
-extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
-
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	struct device_node *cpu_node;
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index acf99372c5cf..76c19aa0d82f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -13,6 +13,7 @@
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
2.11.0

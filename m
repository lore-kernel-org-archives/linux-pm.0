From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v6 8/8] arm64: add sysfs cpu_capacity attribute
Date: Tue, 19 Jul 2016 13:40:48 +0100
Message-ID: <1468932048-31635-9-git-send-email-juri.lelli@arm.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Add a sysfs cpu_capacity attribute with which it is possible to read and
write (thus over-writing default values) CPUs capacity. This might be
useful in situations where values needs changing after boot.

The new attribute shows up as:

 /sys/devices/system/cpu/cpu*/cpu_capacity

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---

Changes from v5:
  - add mutex to protect cpu_scale (as pointed out by Morten off-line)
---
 arch/arm64/kernel/topology.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7c99600af48d..770f05dd53cc 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -26,6 +26,7 @@
 #include <asm/topology.h>
 
 static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+static DEFINE_MUTEX(cpu_scale_mutex);
 
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
@@ -37,6 +38,76 @@ static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+#ifdef CONFIG_PROC_SYSCTL
+#include <asm/cpu.h>
+#include <linux/string.h>
+static ssize_t show_cpu_capacity(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+	ssize_t rc;
+	int cpunum = cpu->dev.id;
+	unsigned long capacity = arch_scale_cpu_capacity(NULL, cpunum);
+
+	rc = sprintf(buf, "%lu\n", capacity);
+
+	return rc;
+}
+
+static ssize_t store_cpu_capacity(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t count)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+	int this_cpu = cpu->dev.id, i;
+	unsigned long new_capacity;
+	ssize_t ret;
+
+	if (count) {
+		char *p = (char *) buf;
+
+		ret = kstrtoul(p, 0, &new_capacity);
+		if (ret)
+			return ret;
+		if (new_capacity > SCHED_CAPACITY_SCALE)
+			return -EINVAL;
+
+		mutex_lock(&cpu_scale_mutex);
+		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
+			set_capacity_scale(i, new_capacity);
+		mutex_unlock(&cpu_scale_mutex);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(cpu_capacity,
+		   0644,
+		   show_cpu_capacity,
+		   store_cpu_capacity);
+
+static int register_cpu_capacity_sysctl(void)
+{
+	int i;
+	struct device *cpu;
+
+	for_each_possible_cpu(i) {
+		cpu = get_cpu_device(i);
+		if (!cpu) {
+			pr_err("%s: too early to get CPU%d device!\n",
+			       __func__, i);
+			continue;
+		}
+		device_create_file(cpu, &dev_attr_cpu_capacity);
+	}
+
+	return 0;
+}
+late_initcall(register_cpu_capacity_sysctl);
+#endif
+
 static u32 capacity_scale;
 static u32 *raw_capacity;
 static bool cap_parsing_failed;
@@ -87,6 +158,7 @@ static void normalize_cpu_capacity(void)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	mutex_lock(&cpu_scale_mutex);
 	for_each_possible_cpu(cpu) {
 		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
 			 cpu, raw_capacity[cpu]);
@@ -96,6 +168,7 @@ static void normalize_cpu_capacity(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, arch_scale_cpu_capacity(NULL, cpu));
 	}
+	mutex_unlock(&cpu_scale_mutex);
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.7.0

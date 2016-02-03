From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v3 5/6] arm: add sysfs cpu_capacity attribute
Date: Wed,  3 Feb 2016 11:59:58 +0000
Message-ID: <1454500799-18451-6-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Add a sysfs cpu_capacity attribute with which it is possible to read and
write (thus over-writing default values) CPUs capacity. This might be
useful in situation where there is no way to get proper default values
at boot time.

The new attribute shows up as:

 /sys/devices/system/cpu/cpu*/cpu_capacity

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 7d7fc2c..9ffba65 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -57,6 +57,74 @@ bool arch_wants_init_cpu_capacity(void)
 	return true;
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
+		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
+			set_capacity_scale(i, new_capacity);
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
 #ifdef CONFIG_OF
 struct cpu_efficiency {
 	const char *compatible;
-- 
2.7.0

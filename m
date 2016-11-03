From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v7 REPOST 9/9] arm64: add sysfs cpu_capacity attribute
Date: Thu, 3 Nov 2016 05:40:18 +0000
Message-ID: <20161103054018.GC16920@e106622-lin>
References: <20161017154650.18779-1-juri.lelli@arm.com>
 <20161017154650.18779-10-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbcKCFkC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Nov 2016 01:40:02 -0400
Content-Disposition: inline
In-Reply-To: <20161017154650.18779-10-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org

Hi,

small update to be in sync with Russell's comments on arm correspoding
patch.

On 17/10/16 16:46, Juri Lelli wrote:
> Add a sysfs cpu_capacity attribute with which it is possible to read and
> write (thus over-writing default values) CPUs capacity. This might be
> useful in situations where values needs changing after boot.
> 
> The new attribute shows up as:
> 
>  /sys/devices/system/cpu/cpu*/cpu_capacity
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
> 
> Changes from v5:
>   - add mutex to protect cpu_scale (as pointed out by Morten off-line)

--->8---
>From 17684f3db6d74342da424997badcb3714a1a9e63 Mon Sep 17 00:00:00 2001
From: Juri Lelli <juri.lelli@arm.com>
Date: Wed, 14 Oct 2015 12:02:05 +0100
Subject: [PATCH v7.1 9/9] arm64: add sysfs cpu_capacity attribute

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

Changes from v7:
  - include files moved at top of file
  - show_cpu_capacity simplified to less lines of code
  - unnecessary cast removed in store_cpu_capacity
  - use DEVICE_ATTR_RW() instead of DEVICE_ATTR()
  - use subsys_initcall instead of late_initcall
---
 arch/arm64/kernel/topology.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b75b0ba2e113..23e9e13bd2aa 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -20,12 +20,15 @@
 #include <linux/of.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/cpufreq.h>
 
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
 static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+static DEFINE_MUTEX(cpu_scale_mutex);
 
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
@@ -37,6 +40,65 @@ static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+#ifdef CONFIG_PROC_SYSCTL
+static ssize_t cpu_capacity_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+
+	return sprintf(buf, "%lu\n",
+			arch_scale_cpu_capacity(NULL, cpu->dev.id));
+}
+
+static ssize_t cpu_capacity_store(struct device *dev,
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
+		ret = kstrtoul(buf, 0, &new_capacity);
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
+static DEVICE_ATTR_RW(cpu_capacity);
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
+subsys_initcall(register_cpu_capacity_sysctl);
+#endif
+
 static u32 capacity_scale;
 static u32 *raw_capacity;
 static bool cap_parsing_failed;
@@ -87,6 +149,7 @@ static void normalize_cpu_capacity(void)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	mutex_lock(&cpu_scale_mutex);
 	for_each_possible_cpu(cpu) {
 		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
 			 cpu, raw_capacity[cpu]);
@@ -96,6 +159,7 @@ static void normalize_cpu_capacity(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, arch_scale_cpu_capacity(NULL, cpu));
 	}
+	mutex_unlock(&cpu_scale_mutex);
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.10.0


From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 REPOST 8/9] arm: add sysfs cpu_capacity attribute
Date: Thu, 3 Nov 2016 05:29:02 +0000
Message-ID: <20161103052842.GA16920@e106622-lin>
References: <20161017154650.18779-1-juri.lelli@arm.com>
 <20161017154650.18779-9-juri.lelli@arm.com>
 <20161030204551.GM1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161030204551.GM1041-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

apologies for the delay in replying, but I'm attending Linux Plumbers
this week.

On 30/10/16 20:45, Russell King - ARM Linux wrote:
> On Mon, Oct 17, 2016 at 04:46:49PM +0100, Juri Lelli wrote:
> > +#ifdef CONFIG_PROC_SYSCTL
> > +#include <asm/cpu.h>
> > +#include <linux/string.h>
> 
> Include files at the top of the file please.  No need to ifdef them.
> They're sorted alphabetically, so new additions should be alphabetical.
> (That's a general rule - if something is already alphabetical, do not
> make it non-alphabetical.)
> 
> > +static ssize_t show_cpu_capacity(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> > +	ssize_t rc;
> > +	int cpunum = cpu->dev.id;
> > +	unsigned long capacity = arch_scale_cpu_capacity(NULL, cpunum);
> > +
> > +	rc = sprintf(buf, "%lu\n", capacity);
> > +
> > +	return rc;
> 
> Way too many lines for such a simple function.  This can be simplified
> to just:
> 
> 	struct cpu *cpu = container_of(dev, struct cpu, dev);
> 
> 	return sprintf(buf, "%lu\n", arch_scale_cpu_capacity(NULL, cpu->dev.id);
> 
> If you don't like the last line ending on column 79, then feel free to
> break it across two lines after the format string.
> 
> > +}
> > +
> > +static ssize_t store_cpu_capacity(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf,
> > +				  size_t count)
> > +{
> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> > +	int this_cpu = cpu->dev.id, i;
> > +	unsigned long new_capacity;
> > +	ssize_t ret;
> > +
> > +	if (count) {
> > +		char *p = (char *) buf;
> > +
> > +		ret = kstrtoul(p, 0, &new_capacity);
> 
> Unnecessary cast - kstrtoul takes a const char pointer, and in any case
> it's really bad form to cast away the "const-ness" of any pointer.  So,
> just:
> 
> 	if (count) {
> 		ret = kstrtoul(buf, 0, &new_capacity);
> 
> should work just fine.
> 
> > +		if (ret)
> > +			return ret;
> > +		if (new_capacity > SCHED_CAPACITY_SCALE)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&cpu_scale_mutex);
> > +		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
> > +			set_capacity_scale(i, new_capacity);
> > +		mutex_unlock(&cpu_scale_mutex);
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR(cpu_capacity,
> > +		   0644,
> > +		   show_cpu_capacity,
> > +		   store_cpu_capacity);
> 
> There's a move to use the named DEVICE_ATTR_RW() for this kind of thing,
> it'll want the functions named xxx_show() and xxx_store().  I see
> there's some recent patches to do this conversion across the kernel, so
> this should probably be done before submission.
> 
> > +
> > +static int register_cpu_capacity_sysctl(void)
> > +{
> > +	int i;
> > +	struct device *cpu;
> > +
> > +	for_each_possible_cpu(i) {
> > +		cpu = get_cpu_device(i);
> > +		if (!cpu) {
> > +			pr_err("%s: too early to get CPU%d device!\n",
> > +			       __func__, i);
> > +			continue;
> > +		}
> > +		device_create_file(cpu, &dev_attr_cpu_capacity);
> > +	}
> > +
> > +	return 0;
> > +}
> > +late_initcall(register_cpu_capacity_sysctl);
> 
> Hmm, this is really weird.  topology_init() in arch/arm/kernel/setup.c
> is where these devices get created, and they're created at
> subsys_initcall() time.  By that point, the list of possible CPUs has
> to be static, it's not going to change.  I don't see why this has to be
> done at late_initcall() - and since topology.c will be linked after
> setup.c, I don't see why it shouldn't be at subsys_initcall() level to
> follow on after topology_init().
> 

I should have addressed your comments with the updated version below. If
it looks good to you I'll superseed the old version with this new one.

Best,

- Juri

--->8---
>From 14c0f21d403ad47843896eecc042334d4e0ed8dd Mon Sep 17 00:00:00 2001
From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Date: Thu, 15 Oct 2015 13:53:37 +0100
Subject: [PATCH v7.1 8/9] arm: add sysfs cpu_capacity attribute

Add a sysfs cpu_capacity attribute with which it is possible to read and
write (thus over-writing default values) CPUs capacity. This might be
useful in situations where values needs changing after boot.

The new attribute shows up as:

 /sys/devices/system/cpu/cpu*/cpu_capacity

Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
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
 arch/arm/kernel/topology.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index aa63287d9a10..ebf47d91b804 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -22,7 +22,9 @@
 #include <linux/of.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
@@ -42,6 +44,7 @@
  * updated during this sequence.
  */
 static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+static DEFINE_MUTEX(cpu_scale_mutex);
 
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
@@ -53,6 +56,65 @@ static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
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
 #ifdef CONFIG_OF
 struct cpu_efficiency {
 	const char *compatible;
@@ -132,6 +194,7 @@ static void normalize_cpu_capacity(void)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	mutex_lock(&cpu_scale_mutex);
 	for_each_possible_cpu(cpu) {
 		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
 			/ capacity_scale;
@@ -139,6 +202,7 @@ static void normalize_cpu_capacity(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, arch_scale_cpu_capacity(NULL, cpu));
 	}
+	mutex_unlock(&cpu_scale_mutex);
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

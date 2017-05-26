From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 8/8] arm,arm64,drivers: add a prefix to drivers
 arch_topology interfaces
Date: Fri, 26 May 2017 11:10:32 +0100
Message-ID: <20170526101032.2t2xn5wrfenimu5w@e106622-lin>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-9-juri.lelli@arm.com>
 <20170525131802.GE16244@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170525131802.GE16244-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 25/05/17 15:18, Greg KH wrote:
> On Thu, Apr 20, 2017 at 03:43:16PM +0100, Juri Lelli wrote:
> > Now that some functions that deal with arch topology information live
> > under drivers, there is a clash of naming that might create confusion.
> > 
> > Tidy things up by creating a drivers namespace for interfaces used by
> > arch code; achieve this by prepending a 'atd_' (arch topology driver)
> > prefix to driver interfaces.
> 
> No one knows, nor will they ever remember, what "atd_" means :(
> 
> Naming is hard, I know, here's my suggestion:
> 
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index 4edae9fe8cdd..e25458d7ee9a 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -4,14 +4,14 @@
> >  #ifndef _LINUX_ARCH_TOPOLOGY_H_
> >  #define _LINUX_ARCH_TOPOLOGY_H_
> >  
> > -void normalize_cpu_capacity(void);
> > +void atd_normalize_cpu_capacity(void);
> 
> arch_cpu_normalize_capacity();
> or
> cpu_normalize_capacity();
> 
> Why do you care if this is "arch" or not, of course it's arch-specific
> in a way, right?
> 
> >  
> >  struct device_node;
> > -int parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> > +int atd_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> 
> cpu_parse_capacity();
> 
> >  struct sched_domain;
> > -unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> > +unsigned long atd_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> 
> cpu_scale_capacity();
> 
> > -void set_capacity_scale(unsigned int cpu, unsigned long capacity);
> > +void atd_set_capacity_scale(unsigned int cpu, unsigned long capacity);
> 
> wait, where did the cpu go?  This doesn't make much sense, these are all
> "capacity" issues, right?  If so, then these should be:
> 	capacity_normalize_cpu()
> 	capacity_parse_cpu()
> 	capacity_scale_cpu()
> 	capacity_set_scale()
> 
> But this is all really topology stuff, right?  Why use "capacity" at
> all:
> 	topology_normalize_cpu()
> 	topology_parse_cpu()
> 	topology_scale_cpu()
> 	topology_set_scale()
> ?
> 
> It's always best to put the "subsystem" name first, we have a bad
> history of getting this wrong in the past by putting the verb first, not
> the noun.
> 

topology_ works for me. However, I'd keep "capacity" in the names, as we
might need to topology_normalize_cpu_somethingelse() (etc.) in the
future?

Updated patch follows. I kept Catalin and Russell's acks as I only
renamed the functions, please shout if that's not OK.

Greg, if you are fine with this approach, do you still want a complete
v5 of the set or can you pick this up?

Thanks,

- Juri

--->8---
>From 56cc1d184bff0e14809ec83043e7a2179a05ccdf Mon Sep 17 00:00:00 2001
From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Date: Wed, 1 Feb 2017 18:46:54 +0000
Subject: [PATCH 8/8] arm,arm64,drivers: add a prefix to drivers arch_topology
 interfaces

Now that some functions that deal with arch topology information live
under drivers, there is a clash of naming that might create confusion.

Tidy things up by creating a topology namespace for interfaces used by
arch code; achieve this by prepending a 'topology_' prefix to driver
interfaces.

Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Acked-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Acked-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/kernel/topology.c    |  8 ++++----
 arch/arm64/kernel/topology.c  |  4 ++--
 drivers/base/arch_topology.c  | 20 ++++++++++----------
 include/linux/arch_topology.h |  8 ++++----
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 557be4f1d2d7..dad8ca071133 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -111,7 +111,7 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
-		if (parse_cpu_capacity(cn, cpu)) {
+		if (topology_parse_cpu_capacity(cn, cpu)) {
 			of_node_put(cn);
 			continue;
 		}
@@ -160,7 +160,7 @@ static void __init parse_dt_topology(void)
 				>> (SCHED_CAPACITY_SHIFT-1)) + 1;
 
 	if (cap_from_dt)
-		normalize_cpu_capacity();
+		topology_normalize_cpu_capacity();
 }
 
 /*
@@ -173,10 +173,10 @@ static void update_cpu_capacity(unsigned int cpu)
 	if (!cpu_capacity(cpu) || cap_from_dt)
 		return;
 
-	set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
+	topology_set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	pr_info("CPU%u: update cpu_capacity %lu\n",
-		cpu, arch_scale_cpu_capacity(NULL, cpu));
+		cpu, topology_scale_cpu_capacity(NULL, cpu));
 }
 
 #else
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 255230c3e835..7290ee26e535 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -39,7 +39,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 
 	for_each_possible_cpu(cpu) {
 		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
-			parse_cpu_capacity(cpu_node, cpu);
+			topology_parse_cpu_capacity(cpu_node, cpu);
 			of_node_put(cpu_node);
 			return cpu;
 		}
@@ -191,7 +191,7 @@ static int __init parse_dt_topology(void)
 	if (ret != 0)
 		goto out_map;
 
-	normalize_cpu_capacity();
+	topology_normalize_cpu_capacity();
 
 	/*
 	 * Check that all cores are in the topology; the SMP code will
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 76c19aa0d82f..2012de4f2ed7 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -25,12 +25,12 @@
 static DEFINE_MUTEX(cpu_scale_mutex);
 static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
 
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+unsigned long topology_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
 
-void set_capacity_scale(unsigned int cpu, unsigned long capacity)
+void topology_set_capacity_scale(unsigned int cpu, unsigned long capacity)
 {
 	per_cpu(cpu_scale, cpu) = capacity;
 }
@@ -42,7 +42,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
 	return sprintf(buf, "%lu\n",
-			arch_scale_cpu_capacity(NULL, cpu->dev.id));
+			topology_scale_cpu_capacity(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
@@ -67,7 +67,7 @@ static ssize_t cpu_capacity_store(struct device *dev,
 
 	mutex_lock(&cpu_scale_mutex);
 	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
-		set_capacity_scale(i, new_capacity);
+		topology_set_capacity_scale(i, new_capacity);
 	mutex_unlock(&cpu_scale_mutex);
 
 	return count;
@@ -98,7 +98,7 @@ static u32 capacity_scale;
 static u32 *raw_capacity;
 static bool cap_parsing_failed;
 
-void normalize_cpu_capacity(void)
+void topology_normalize_cpu_capacity(void)
 {
 	u64 capacity;
 	int cpu;
@@ -113,14 +113,14 @@ void normalize_cpu_capacity(void)
 			 cpu, raw_capacity[cpu]);
 		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
 			/ capacity_scale;
-		set_capacity_scale(cpu, capacity);
+		topology_set_capacity_scale(cpu, capacity);
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
-			cpu, arch_scale_cpu_capacity(NULL, cpu));
+			cpu, topology_scale_cpu_capacity(NULL, cpu));
 	}
 	mutex_unlock(&cpu_scale_mutex);
 }
 
-int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
 	int ret = 1;
 	u32 cpu_capacity;
@@ -185,12 +185,12 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 			       cpus_to_visit,
 			       policy->related_cpus);
 		for_each_cpu(cpu, policy->related_cpus) {
-			raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
+			raw_capacity[cpu] = topology_scale_cpu_capacity(NULL, cpu) *
 					    policy->cpuinfo.max_freq / 1000UL;
 			capacity_scale = max(raw_capacity[cpu], capacity_scale);
 		}
 		if (cpumask_empty(cpus_to_visit)) {
-			normalize_cpu_capacity();
+			topology_normalize_cpu_capacity();
 			kfree(raw_capacity);
 			pr_debug("cpu_capacity: parsing done\n");
 			cap_parsing_done = true;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 4edae9fe8cdd..553afafe0f8a 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -4,14 +4,14 @@
 #ifndef _LINUX_ARCH_TOPOLOGY_H_
 #define _LINUX_ARCH_TOPOLOGY_H_
 
-void normalize_cpu_capacity(void);
+void topology_normalize_cpu_capacity(void);
 
 struct device_node;
-int parse_cpu_capacity(struct device_node *cpu_node, int cpu);
+int topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 struct sched_domain;
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
+unsigned long topology_scale_cpu_capacity(struct sched_domain *sd, int cpu);
 
-void set_capacity_scale(unsigned int cpu, unsigned long capacity);
+void topology_set_capacity_scale(unsigned int cpu, unsigned long capacity);
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

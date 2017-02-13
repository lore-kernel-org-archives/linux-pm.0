From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v2 6/9] arm, arm64: factorize common cpu capacity default
 code
Date: Mon, 13 Feb 2017 15:09:31 +0000
Message-ID: <20170213150918.GE3432@e106622-lin>
References: <20170209092525.6654-1-juri.lelli@arm.com>
 <20170209092525.6654-7-juri.lelli@arm.com>
 <20170210142857.GA18321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170210142857.GA18321@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

On 10/02/17 15:28, Greg KH wrote:
> On Thu, Feb 09, 2017 at 09:25:22AM +0000, Juri Lelli wrote:
> > arm and arm64 share lot of code relative to parsing CPU capacity
> > information from DT, using that information for appropriate scaling and
> > exposing a sysfs interface for chaging such values at runtime.
> > 
> > Factorize such code in a common place (driver/base/arch_topology.c) in
> > preparation for further additions.
> > 
> > Suggested-by: Will Deacon <will.deacon@arm.com>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> > 
> > Changes from v1:
> >  - keep the original GPLv2 header
> > ---
> >  arch/arm/Kconfig             |   1 +
> >  arch/arm/kernel/topology.c   | 213 ++------------------------------------
> >  arch/arm64/Kconfig           |   1 +
> >  arch/arm64/kernel/topology.c | 219 +--------------------------------------
> >  drivers/base/Kconfig         |   8 ++
> >  drivers/base/Makefile        |   1 +
> >  drivers/base/arch_topology.c | 237 +++++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 257 insertions(+), 423 deletions(-)
> >  create mode 100644 drivers/base/arch_topology.c
> 
> Ah, so you want _me_ to maintain this, ok, I better review it...
> 

This has been suggested as a possible way to stop replicating code between arm
and arm64 (and possibly other archs in the future). Are you in principle OK
with it?

Thanks a lot for your comments, please find my answers below.

> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -339,4 +339,12 @@ config CMA_ALIGNMENT
> >  
> >  endif
> >  
> > +config GENERIC_ARCH_TOPOLOGY
> > +	bool
> > +	help
> > +	  Enable support for architectures common topology code: e.g., parsing
> > +	  CPU capacity information from DT, usage of such information for
> > +	  appropriate scaling, sysfs interface for changing capacity values at
> > +          runtime.
> 
> Mix of spaces and tabs :(
> 

Argh. :(

> > +
> >  endmenu
> > diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> > index f2816f6ff76a..397e5c344e6a 100644
> > --- a/drivers/base/Makefile
> > +++ b/drivers/base/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_SOC_BUS) += soc.o
> >  obj-$(CONFIG_PINCTRL) += pinctrl.o
> >  obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
> >  obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
> > +obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> >  
> >  obj-y			+= test/
> >  
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > new file mode 100644
> > index 000000000000..c1dd430adad2
> > --- /dev/null
> > +++ b/drivers/base/arch_topology.c
> > @@ -0,0 +1,237 @@
> > +/*
> > + * driver/base/arch_topology.c - Arch specific cpu topology information
> 
> No need to keep the filename in the file, you know what it is called :)
> 

OK, removed.

> > + *
> > + * Copyright (C) 2016, ARM Ltd.
> > + * Written by: Juri Lelli, ARM Ltd.
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> 
> So, v2 only?  Please be specific.  Even better yet, use a SPDX header if
> you want to, those are always nice.
> 

Yes, v2 only.

  * for more details.                                                                                                                                                                                                                    
+ *                                                                                                                                                                                                                                      
+ * Released under the GPLv2 only.                                                                                                                                                                                                       
+ * SPDX-License-Identifier: GPL-2.0 

Would do, right?

> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/cpu.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/device.h>
> > +#include <linux/of.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/topology.h>
> > +
> > +static DEFINE_MUTEX(cpu_scale_mutex);
> > +static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> > +
> > +unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> 
> Why do you have sd here?  You never use it:
> 
> > +{
> > +	return per_cpu(cpu_scale, cpu);
> 
> See?  What am I missing?
> 

This is how this function is defined in kernel/sched/sched.h:

#ifndef arch_scale_cpu_capacity
static __always_inline
unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
{
	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
		return sd->smt_gain / sd->span_weight;

	return SCHED_CAPACITY_SCALE;
}
#endif

and in this case the sd argument is used: there is a call site in fair.c
that passes a non NULL sd, updated_cpu_capacity().

A following set of patches will re-define the function so that the
drivers one gets used by the kernel (only arm and arm64 will currently
want this), with something like this in arch code

#define arch_scale_cpu_capacity atd_scale_cpu_capacity

Please note that last patch of this set renames this function atd_scale_
cpu_capacity, to (hopefully) make this approach more clear.

Does it make more sense to you?

> > +}
> > +
> > +void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> > +{
> > +	per_cpu(cpu_scale, cpu) = capacity;
> > +}
> > +
> > +static ssize_t cpu_capacity_show(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> > +
> > +	return sprintf(buf, "%lu\n",
> > +			arch_scale_cpu_capacity(NULL, cpu->dev.id));
> > +}
> > +
> > +static ssize_t cpu_capacity_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf,
> > +				  size_t count)
> > +{
> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> > +	int this_cpu = cpu->dev.id, i;
> 
> new line for:
> 	int i;
> please.
> 

Sure.

> > +	unsigned long new_capacity;
> > +	ssize_t ret;
> > +
> > +	if (count) {
> 
> 	if (!count)
> 		return 0;
> 
> then you can get on with the rest of the logic.  Don't indent if you
> don't have to.
> 

Right.

> > +		ret = kstrtoul(buf, 0, &new_capacity);
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
> 
> No documentation for these sysfs file?  Not good :(
> 

Patch 2/9 introduces some documentation. There is already more in
Documentation/devicetree/bindings/arm/cpu-capacity.txt.

Do you think I should improve further?

> > +
> > +static DEVICE_ATTR_RW(cpu_capacity);
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
> 
> What is this going to help with?
> 

Not much I guess, I can remove it.

> > +			continue;
> > +		}
> > +		device_create_file(cpu, &dev_attr_cpu_capacity);
> 
> You realize you just raced userspace, right?  Why do it this way and not
> register the files when the CPU device is created/removed?
> 

Humm, my intention for doing it this way is that I'd like to make all
the code dealing with cpu_capacity confined in a single place (this
file), without the need to modify other files.

> > +	}
> > +
> > +	return 0;
> > +}
> > +subsys_initcall(register_cpu_capacity_sysctl);

AFAIU, for both arm and arm64 CPU device is registered with a
subsys_initcall(topology_init), so I'm doing the same. Other archs seem to do
similar things. Could you explain a little more why this is a problem?

> > +
> > +u32 capacity_scale;
> > +u32 *raw_capacity;
> > +bool cap_parsing_failed;
> 
> globals?  really?  That's bold :(
> 

Yeah, ugly. However, patch 7/9 is making cap_parsing_failed static. The other
two can be made static already, I should have done that in the first place. :(

BTW, with this set I'm trying to incrementally fix things (after moving code in
the new place), does it look reasonable to you or would you prefer to squash
intermediate steps?

> > +
> > +void normalize_cpu_capacity(void)
> 
> naming is hard, but try to put a good, descriptive, prefix on everything
> you are exporting in the same file, the same prefix.
> 
> cpu_capacity_normalize()?
> cpu_capacity_register_sysctl()?
> 
> and so on.
> 
> > +{
> > +	u64 capacity;
> > +	int cpu;
> > +
> > +	if (!raw_capacity || cap_parsing_failed)
> > +		return;
> > +
> > +	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
> > +	mutex_lock(&cpu_scale_mutex);
> > +	for_each_possible_cpu(cpu) {
> > +		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
> > +			 cpu, raw_capacity[cpu]);
> > +		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
> > +			/ capacity_scale;
> > +		set_capacity_scale(cpu, capacity);
> > +		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
> > +			cpu, arch_scale_cpu_capacity(NULL, cpu));
> > +	}
> > +	mutex_unlock(&cpu_scale_mutex);
> > +}
> > +
> > +int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> 
> cpu_capacity_parse()?
> 

OK, I'll try to fix the naming as you suggest. Thanks!

Best,

- Juri

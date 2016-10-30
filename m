From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 REPOST 8/9] arm: add sysfs cpu_capacity attribute
Date: Sun, 30 Oct 2016 20:45:51 +0000
Message-ID: <20161030204551.GM1041@n2100.armlinux.org.uk>
References: <20161017154650.18779-1-juri.lelli@arm.com>
 <20161017154650.18779-9-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47522 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbcJ3UqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Oct 2016 16:46:02 -0400
Content-Disposition: inline
In-Reply-To: <20161017154650.18779-9-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org

On Mon, Oct 17, 2016 at 04:46:49PM +0100, Juri Lelli wrote:
> +#ifdef CONFIG_PROC_SYSCTL
> +#include <asm/cpu.h>
> +#include <linux/string.h>

Include files at the top of the file please.  No need to ifdef them.
They're sorted alphabetically, so new additions should be alphabetical.
(That's a general rule - if something is already alphabetical, do not
make it non-alphabetical.)

> +static ssize_t show_cpu_capacity(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +	ssize_t rc;
> +	int cpunum = cpu->dev.id;
> +	unsigned long capacity = arch_scale_cpu_capacity(NULL, cpunum);
> +
> +	rc = sprintf(buf, "%lu\n", capacity);
> +
> +	return rc;

Way too many lines for such a simple function.  This can be simplified
to just:

	struct cpu *cpu = container_of(dev, struct cpu, dev);

	return sprintf(buf, "%lu\n", arch_scale_cpu_capacity(NULL, cpu->dev.id);

If you don't like the last line ending on column 79, then feel free to
break it across two lines after the format string.

> +}
> +
> +static ssize_t store_cpu_capacity(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t count)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +	int this_cpu = cpu->dev.id, i;
> +	unsigned long new_capacity;
> +	ssize_t ret;
> +
> +	if (count) {
> +		char *p = (char *) buf;
> +
> +		ret = kstrtoul(p, 0, &new_capacity);

Unnecessary cast - kstrtoul takes a const char pointer, and in any case
it's really bad form to cast away the "const-ness" of any pointer.  So,
just:

	if (count) {
		ret = kstrtoul(buf, 0, &new_capacity);

should work just fine.

> +		if (ret)
> +			return ret;
> +		if (new_capacity > SCHED_CAPACITY_SCALE)
> +			return -EINVAL;
> +
> +		mutex_lock(&cpu_scale_mutex);
> +		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
> +			set_capacity_scale(i, new_capacity);
> +		mutex_unlock(&cpu_scale_mutex);
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(cpu_capacity,
> +		   0644,
> +		   show_cpu_capacity,
> +		   store_cpu_capacity);

There's a move to use the named DEVICE_ATTR_RW() for this kind of thing,
it'll want the functions named xxx_show() and xxx_store().  I see
there's some recent patches to do this conversion across the kernel, so
this should probably be done before submission.

> +
> +static int register_cpu_capacity_sysctl(void)
> +{
> +	int i;
> +	struct device *cpu;
> +
> +	for_each_possible_cpu(i) {
> +		cpu = get_cpu_device(i);
> +		if (!cpu) {
> +			pr_err("%s: too early to get CPU%d device!\n",
> +			       __func__, i);
> +			continue;
> +		}
> +		device_create_file(cpu, &dev_attr_cpu_capacity);
> +	}
> +
> +	return 0;
> +}
> +late_initcall(register_cpu_capacity_sysctl);

Hmm, this is really weird.  topology_init() in arch/arm/kernel/setup.c
is where these devices get created, and they're created at
subsys_initcall() time.  By that point, the list of possible CPUs has
to be static, it's not going to change.  I don't see why this has to be
done at late_initcall() - and since topology.c will be linked after
setup.c, I don't see why it shouldn't be at subsys_initcall() level to
follow on after topology_init().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

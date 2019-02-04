From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH] drivers core: cpu: add hotplug callback to update
 cpu_dev state to resumed
Date: Mon, 4 Feb 2019 15:37:20 +0000
Message-ID: <20190204153720.GA24131@e107155-lin>
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com>
 <20190125150906.27614-1-sudeep.holla@arm.com>
 <2397404.eE4apdlqQK@aspire.rjw.lan>
 <20190131160559.GA32759@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131160559.GA32759@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Steve Longerbeam <steve_longerbeam@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2019 at 04:05:59PM +0000, Sudeep Holla wrote:
> On Thu, Jan 31, 2019 at 12:48:49AM +0100, Rafael J. Wysocki wrote:
> > On Friday, January 25, 2019 4:09:06 PM CET Sudeep Holla wrote:
> > > The sysfs for the cpu caches are managed by adding devices with cpu
> > > as the parent in cpu_device_create() when secondary cpu is brought
> > > onlin. Generally when the secondary CPUs are hotplugged back is as part
> > > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > > hotplug state machine while the cpu device associated with that CPU is
> > > not yet ready to be resumed as the device_resume() call happens bit later.
> > > It's not really needed to set the flag is_prepared for cpu devices are
> > > they are mostly pseudo device and hotplug framework deals with state
> > > machine and not managed through the cpu device.
> > >
> > > This often results in annoying warning when resuming:
> > > Enabling non-boot CPUs ...
> > > CPU1: Booted secondary processor
> > >  cache: parent cpu1 should not be sleeping
> > > CPU1 is up
> > > CPU2: Booted secondary processor
> > >  cache: parent cpu2 should not be sleeping
> > > CPU2 is up
> > > .... and so on.
> > >
> > > Just fix the warning by updating the device state quite early.
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Reported-by: Jisheng Zhang <jszhang@marvell.com>
> > > Reported-by: Steve Longerbeam <slongerbeam@gmail.com>
> > > Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/base/cpu.c         | 20 +++++++++++++++++++-
> > >  include/linux/cpuhotplug.h |  1 +
> > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > Hi Rafael,
> > >
> > > This is getting reported for quite some time. Let me know if you have
> > > better solution to fix this harmless yet annoying warnings during system
> > > resume.
> >
> > I'd rather have a flag in struct dev_pm_info that will cause the message to
> > be suppressed if set.
> >
> > It could be used for other purposes too then in princple (like skipping the
> > creation of empty "power" attr groups in sysfs for devices that don't
> > need them etc.).
> >
> Thanks for the suggestion. I did quick hack and came up with something
> below. I wanted to run through you once before I materialise it into
> a formal patch to check if I understood your suggestion correctly.
> We can move no_pm_required outside dev_pm_info struct and rename with
> any better names.
>

Sorry for the nag, since the title has RFC, thought there are chances of
this getting lost. Let me know if the below idea aligns with your suggestion ?

Regards,
Sudeep
> -->8
> 
> diff --git i/drivers/base/cpu.c w/drivers/base/cpu.c
> index eb9443d5bae1..b61f9772ed33 100644
> --- i/drivers/base/cpu.c
> +++ w/drivers/base/cpu.c
> @@ -379,6 +379,7 @@ int register_cpu(struct cpu *cpu, int num)
>  	cpu->dev.bus->uevent = cpu_uevent;
>  #endif
>  	cpu->dev.groups = common_cpu_attr_groups;
> +	cpu->dev.power.no_pm_required = true;
>  	if (cpu->hotpluggable)
>  		cpu->dev.groups = hotplugable_cpu_attr_groups;
>  	error = device_register(&cpu->dev);
> @@ -427,6 +428,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
>  	dev->parent = parent;
>  	dev->groups = groups;
>  	dev->release = device_create_release;
> +	dev->power.no_pm_required = true;
>  	dev_set_drvdata(dev, drvdata);
>  
>  	retval = kobject_set_name_vargs(&dev->kobj, fmt, args);
> diff --git i/drivers/base/power/main.c w/drivers/base/power/main.c
> index 0992e67e862b..ed1b133f73db 100644
> --- i/drivers/base/power/main.c
> +++ w/drivers/base/power/main.c
> @@ -124,6 +124,8 @@ void device_pm_unlock(void)
>   */
>  void device_pm_add(struct device *dev)
>  {
> +	if (dev->power.no_pm_required)
> +		return;
>  	pr_debug("PM: Adding info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>  	device_pm_check_callbacks(dev);
> @@ -142,6 +144,8 @@ void device_pm_add(struct device *dev)
>   */
>  void device_pm_remove(struct device *dev)
>  {
> +	if (dev->power.no_pm_required)
> +		return;
>  	pr_debug("PM: Removing info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>  	complete_all(&dev->power.completion);
> diff --git i/drivers/base/power/sysfs.c w/drivers/base/power/sysfs.c
> index d713738ce796..54c1bfec396e 100644
> --- i/drivers/base/power/sysfs.c
> +++ w/drivers/base/power/sysfs.c
> @@ -648,6 +648,9 @@ int dpm_sysfs_add(struct device *dev)
>  {
>  	int rc;
>  
> +	if (dev->power.no_pm_required)
> +		return 0;
> +
>  	rc = sysfs_create_group(&dev->kobj, &pm_attr_group);
>  	if (rc)
>  		return rc;
> diff --git i/include/linux/pm.h w/include/linux/pm.h
> index 0bd9de116826..300ab9f0b858 100644
> --- i/include/linux/pm.h
> +++ w/include/linux/pm.h
> @@ -592,6 +592,7 @@ struct dev_pm_info {
>  	bool			is_suspended:1;	/* Ditto */
>  	bool			is_noirq_suspended:1;
>  	bool			is_late_suspended:1;
> +	bool			no_pm_required:1;
>  	bool			early_init:1;	/* Owned by the PM core */
>  	bool			direct_complete:1;	/* Owned by the PM core */
>  	u32			driver_flags;

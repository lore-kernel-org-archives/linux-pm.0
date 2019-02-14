From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management
 in device/driver model
Date: Thu, 14 Feb 2019 11:16:09 +0000
Message-ID: <20190214111609.GC28361@e107155-lin>
References: <20190213120137.23354-1-sudeep.holla@arm.com>
 <CAJZ5v0gg7H9G_HrvLhf9k26maYUR+_EpE8DDQ7NPh58HMRH3Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gg7H9G_HrvLhf9k26maYUR+_EpE8DDQ7NPh58HMRH3Ew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jisheng Zhang <jszhang@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Steve Longerbeam <slongerbeam@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 13, 2019 at 11:17:47PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 13, 2019 at 1:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > All device objects in the driver model contain fields that control the
> > handling of various power management activities. However, it's not
> > always useful. There are few instances where pseudo devices are added
> > to the model just to take advantage of many other features like
> > kobjects, udev events, and so on. One such example is cpu devices and
> > their caches.
> >
> > The sysfs for the cpu caches are managed by adding devices with cpu
> > as the parent in cpu_device_create() when secondary cpu is brought
> > online. Generally when the secondary CPUs are hotplugged back in as part
> > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > hotplug state machine while the cpu device associated with that CPU is
> > not yet ready to be resumed as the device_resume() call happens bit
> > later. It's not really needed to set the flag is_prepared for cpu
> > devices as they are mostly pseudo device and hotplug framework deals
> > with state machine and not managed through the cpu device.
> >
> > This often results in annoying warning when resuming:
> > Enabling non-boot CPUs ...
> > CPU1: Booted secondary processor
> >  cache: parent cpu1 should not be sleeping
> > CPU1 is up
> > CPU2: Booted secondary processor
> >  cache: parent cpu2 should not be sleeping
> > CPU2 is up
> > .... and so on.
> >
> > So in order to fix these kind of errors, we could just completely avoid
> > doing any power management related initialisations and operations if
> > they are not used by these devices.
> >
> > Lets add no_pm_required flags to indicate that the device doesn't
> > require any sort of pm activities and all of them can be completely
> > skipped. We can use the same flag to also avoid adding not used *power*
> > sysfs entries for these devices. For now, lets use this for cpu cache
> > devices.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/base/cpu.c         |  1 +
> >  drivers/base/power/main.c  |  7 +++++++
> >  drivers/base/power/sysfs.c |  4 ++++
> >  include/linux/device.h     | 10 ++++++++++
> >  include/linux/pm.h         |  1 +
> >  5 files changed, 23 insertions(+)
> >
> > v1->v2:
> >         - dropped setting the flag for cpu devices, for now just cpu caches
> >          will make use of this new flag.
> >
> > RFC->v1:
> >         - dropped the idea of adding cpu hotplug callback to deal just
> >           with cpu devices, instead add a new flag in the device pm_info
> >           structure
> >
> > [RFC] : https://marc.info/?l=linux-pm&m=154842896407904&w=2
> > [v1] : https://marc.info/?l=linux-pm&m=154946578717730&w=2
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index eb9443d5bae1..6ce93a52bf3f 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -427,6 +427,7 @@ __cpu_device_create(struct device *parent, void *drvdata,
> >         dev->parent = parent;
> >         dev->groups = groups;
> >         dev->release = device_create_release;
> > +       device_set_pm_not_required(dev);
> >         dev_set_drvdata(dev, drvdata);
> >
> >         retval = kobject_set_name_vargs(&dev->kobj, fmt, args);
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 0992e67e862b..2a29c3d4e240 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -124,6 +124,10 @@ void device_pm_unlock(void)
> >   */
> >  void device_pm_add(struct device *dev)
> >  {
> > +       /* No need to create pm sysfs if explicitly specified as not required */
>
> Is this really about sysfs?
>

Nope, copy-paste from dpm_sysfs_add, will drop it.

> > +       if (device_pm_not_required(dev))
>
> Should power.disable_depth be bumped up here or while setting the "no PM" flag?
>

OK, I missed that.

Also I did have extra check in dpm_sysfs_remove but dropped it as redundant.
Based on Eugeniu report, I need to add it back.

[...]

> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 0bd9de116826..300ab9f0b858 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -592,6 +592,7 @@ struct dev_pm_info {
> >         bool                    is_suspended:1; /* Ditto */
> >         bool                    is_noirq_suspended:1;
> >         bool                    is_late_suspended:1;
> > +       bool                    no_pm_required:1;
>
> Maybe call it "no_pm"?
>
Sure.

--
Regards,
Sudeep

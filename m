From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management
 in device/driver model
Date: Thu, 14 Feb 2019 12:05:09 +0000
Message-ID: <20190214120509.GA28292@e107155-lin>
References: <20190213120137.23354-1-sudeep.holla@arm.com>
 <CAJZ5v0gg7H9G_HrvLhf9k26maYUR+_EpE8DDQ7NPh58HMRH3Ew@mail.gmail.com>
 <20190214111609.GC28361@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214111609.GC28361@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jisheng Zhang <jszhang@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Steve Longerbeam <slongerbeam@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 14, 2019 at 11:16:09AM +0000, Sudeep Holla wrote:
> On Wed, Feb 13, 2019 at 11:17:47PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 13, 2019 at 1:01 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 0992e67e862b..2a29c3d4e240 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -124,6 +124,10 @@ void device_pm_unlock(void)
> > >   */
> > >  void device_pm_add(struct device *dev)
> > >  {
> > > +       /* No need to create pm sysfs if explicitly specified as not required */
> >
> > Is this really about sysfs?
> >
>
> Nope, copy-paste from dpm_sysfs_add, will drop it.
>
> > > +       if (device_pm_not_required(dev))
> >
> > Should power.disable_depth be bumped up here or while setting the "no PM" flag?
> >
>
> OK, I missed that.
>

Looking at it,
1. We can't set it when we set "no PM" flag as pm_runtime_init called later
   initialise it to 1
2. We can bump it here, but I see it's usage self contained in runtime.c
   and may look odd to access it here.

More basic question is should we really need to bump it to 2 as its
initialised to 1 in runtime_init.

--
Regards,
Sudeep

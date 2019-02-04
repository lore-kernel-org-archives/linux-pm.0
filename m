From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] drivers core: cpu: add hotplug callback to update
 cpu_dev state to resumed
Date: Mon, 4 Feb 2019 16:44:21 +0100
Message-ID: <20190204154421.GA14330@kroah.com>
References: <20190125130701.GA855@vmlxhi-102.adit-jv.com>
 <20190125150906.27614-1-sudeep.holla@arm.com>
 <2397404.eE4apdlqQK@aspire.rjw.lan>
 <20190131160559.GA32759@e107155-lin>
 <20190204153720.GA24131@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204153720.GA24131@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Steve Longerbeam <steve_longerbeam@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Joshua Frkuska <joshua_frkuska@mentor.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 04, 2019 at 03:37:20PM +0000, Sudeep Holla wrote:
> On Thu, Jan 31, 2019 at 04:05:59PM +0000, Sudeep Holla wrote:
> > On Thu, Jan 31, 2019 at 12:48:49AM +0100, Rafael J. Wysocki wrote:
> > > On Friday, January 25, 2019 4:09:06 PM CET Sudeep Holla wrote:
> > > > The sysfs for the cpu caches are managed by adding devices with cpu
> > > > as the parent in cpu_device_create() when secondary cpu is brought
> > > > onlin. Generally when the secondary CPUs are hotplugged back is as part
> > > > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > > > hotplug state machine while the cpu device associated with that CPU is
> > > > not yet ready to be resumed as the device_resume() call happens bit later.
> > > > It's not really needed to set the flag is_prepared for cpu devices are
> > > > they are mostly pseudo device and hotplug framework deals with state
> > > > machine and not managed through the cpu device.
> > > >
> > > > This often results in annoying warning when resuming:
> > > > Enabling non-boot CPUs ...
> > > > CPU1: Booted secondary processor
> > > >  cache: parent cpu1 should not be sleeping
> > > > CPU1 is up
> > > > CPU2: Booted secondary processor
> > > >  cache: parent cpu2 should not be sleeping
> > > > CPU2 is up
> > > > .... and so on.
> > > >
> > > > Just fix the warning by updating the device state quite early.
> > > >
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Reported-by: Jisheng Zhang <jszhang@marvell.com>
> > > > Reported-by: Steve Longerbeam <slongerbeam@gmail.com>
> > > > Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/base/cpu.c         | 20 +++++++++++++++++++-
> > > >  include/linux/cpuhotplug.h |  1 +
> > > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > > >
> > > > Hi Rafael,
> > > >
> > > > This is getting reported for quite some time. Let me know if you have
> > > > better solution to fix this harmless yet annoying warnings during system
> > > > resume.
> > >
> > > I'd rather have a flag in struct dev_pm_info that will cause the message to
> > > be suppressed if set.
> > >
> > > It could be used for other purposes too then in princple (like skipping the
> > > creation of empty "power" attr groups in sysfs for devices that don't
> > > need them etc.).
> > >
> > Thanks for the suggestion. I did quick hack and came up with something
> > below. I wanted to run through you once before I materialise it into
> > a formal patch to check if I understood your suggestion correctly.
> > We can move no_pm_required outside dev_pm_info struct and rename with
> > any better names.
> >
> 
> Sorry for the nag, since the title has RFC, thought there are chances of
> this getting lost. Let me know if the below idea aligns with your suggestion ?

Personally, I ignore RFC patches unless I'm accidentally interested in
them, as it shows that the author doesn't feel good enough to propose
them as a real solution :)

But that's just me...

thanks,

greg k-h

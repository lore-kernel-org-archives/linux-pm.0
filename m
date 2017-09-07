From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] PM: Using runtime PM callbacks for system suspend/resume
Date: Thu, 07 Sep 2017 12:48:33 +0200
Message-ID: <2938821.IWU2Kxf5Jd@aspire.rjw.lan>
References: <5559236.6K256zbtpK@aspire.rjw.lan> <CAPDyKFqb2hXgdqaz-whXcqDRy-F=cHqM7SEV9iWPQUEvaaoYHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqb2hXgdqaz-whXcqDRy-F=cHqM7SEV9iWPQUEvaaoYHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 7, 2017 8:56:07 AM CEST Ulf Hansson wrote:
> On 7 September 2017 at 00:14, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Hi,
> >
> > It occurred to me earlier today that it should be possible to modify the
> > PM core to get the functionality of pm_runtime_force_suspend/resume() from it
> > in a somewhat nicer way which should be possible to extend to middle layers
> > (bus types, PM domains etc).
> >
> > Say we have a flag telling the PM core to use the runtime PM path at the
> > late suspend and early resume stages of system suspend/resume directly if
> > it can't find "proper" callbacks for that.  It is called DPM_FLAG_USE_RPM in
> > the prototype patch below.
> >
> > The idea is to set only ->runtime_suspend and ->runtime_resume in the driver's
> > dev_pm_ops and then set that flag in ->probe and be done.  If the core sees
> > the flag and doesn't see any "original" system sleep callbacks at the stages
> > in question, it will automatically switch over to the runtime PM path and
> > leave the device alone if it is already runtime-suspended.
> >
> > One nice thing about it is that it will happen at the core level and not in
> > a driver callback, so all of the concerns regarding layering violations are
> > simply not relevant any more.  Also, at least in principle, it should be
> > possible to extend this to middle layers that need to do some non-trivial PM
> > handling, simply by making them look at that flag and honor in the same way
> > as the core does that.  This way drivers may still be able to reuse their
> > runtime PM stuff for handling system sleep transitions even if the middle
> > layers they need to work with have different things to do for runtime PM
> > and system suspend/resume.  Even modifying *all* middle layers in the tree to
> > do take DPM_FLAG_USE_RPM into accout if set is not out of the question as far
> > as I'm concerned.
> >
> > On top of this it should be possible to add the optimization allowing devices
> > to stay suspended after system resume even if they were not suspended before.
> > IMO it is better to add a separate flag for enabling it in case some drivers
> > don't want it, though.
> >
> > So the below is just the core part and mostly a prototype to illustrate the
> > idea, but at this point it looks promising to me.
> >
> > Comments?  Concerns?
> 
> Yes, a couple so far.
> 
> 1) I like the overall idea, which means the PM core gets the knowledge
> of what to do, based on some instructions by the driver. Yeah, it's a
> great idea I think.
> 2) We need also a way to allow drivers to deal with additional
> operations during system suspend (and resume etc), besides making it
> possible to re-use the RPM callbacks to put the device into a low
> power state. Could we allow the system sleep callbacks to be present
> as well when using this flag?

Yes, we could.  It's perfectly fine to do that with the patch I posted.

One can even provide ->suspend_late or ->resume_early and set this flag
even though that wouldn't make a lot of sense. :-)

> Let's bring up this also at LPC next week, we can make it a part of
> the ACPI slot, if needed.

Agreed, and we will.

Thanks,
Rafael

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 1/3] PM / sleep: Move runtime PM barrier invocation to device_prepare()
Date: Tue, 13 May 2014 17:07:12 +0200
Message-ID: <2132869.H2tFu0p7Mg@vostro.rjw.lan>
References: <4649019.is79p6EySp@vostro.rjw.lan> <2578127.8G0jVZIWmC@vostro.rjw.lan> <CAPDyKFrOwWzL5uFHQoYXWkATAUW6=u8Dxwm6y3Q3CWfD4Ru=Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50875 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759892AbaEMOu1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 May 2014 10:50:27 -0400
In-Reply-To: <CAPDyKFrOwWzL5uFHQoYXWkATAUW6=u8Dxwm6y3Q3CWfD4Ru=Qw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On Tuesday, May 13, 2014 12:59:43 PM Ulf Hansson wrote:
> On 13 May 2014 12:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, May 13, 2014 11:16:34 AM Ulf Hansson wrote:
> >> On 13 May 2014 03:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >
> >> > Move the invocation of the runtime PM barrier during system suspend
> >> > (or hibernation) from __device_suspend() to device_prepare() to make
> >> > all runtime PM transitions in progress complete before executing
> >> > ->prepare() callbacks for devices.
> >> >
> >> > That will allow those callbacks to check if devices are runtime
> >> > suspended in a non-racy way.
> >> >
> >> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> > ---
> >> >  drivers/base/power/main.c |   31 +++++++++++++------------------
> >> >  1 file changed, 13 insertions(+), 18 deletions(-)
> >> >
> >> > Index: linux-pm/drivers/base/power/main.c
> >> > ===================================================================
> >> > --- linux-pm.orig/drivers/base/power/main.c
> >> > +++ linux-pm/drivers/base/power/main.c
> >> > @@ -1312,24 +1312,7 @@ static int __device_suspend(struct devic
> >> >
> >> >         dpm_wait_for_children(dev, async);
> >> >
> >> > -       if (async_error)
> >> > -               goto Complete;
> >> > -
> >> > -       /*
> >> > -        * If a device configured to wake up the system from sleep states
> >> > -        * has been suspended at run time and there's a resume request pending
> >> > -        * for it, this is equivalent to the device signaling wakeup, so the
> >> > -        * system suspend operation should be aborted.
> >> > -        */
> >> > -       if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
> >> > -               pm_wakeup_event(dev, 0);
> >> > -
> >> > -       if (pm_wakeup_pending()) {
> >> > -               async_error = -EBUSY;
> >> > -               goto Complete;
> >> > -       }
> >>
> >> I suppose you went a bit too far here!?
> >>
> >> We can still have wakeup pending at this point, and thus we should
> >> bail out, right?
> >
> > That pm_wakeup_pending() is part of the barrier handling, so ->
> >
> >> > -
> >> > -       if (dev->power.syscore)
> >> > +       if (async_error || dev->power.syscore)
> >> >                 goto Complete;
> >> >
> >> >         dpm_watchdog_set(&wd, dev);
> >> > @@ -1500,6 +1483,18 @@ static int device_prepare(struct device
> >> >          */
> >> >         pm_runtime_get_noresume(dev);
> >> >
> >> > +       /*
> >> > +        * If a device configured to wake up the system from sleep states
> >> > +        * has been suspended at run time and there's a resume request pending
> >> > +        * for it, this is equivalent to the device signaling wakeup, so the
> >> > +        * system suspend operation should be aborted.
> >> > +        */
> >> > +       if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
> >> > +               pm_wakeup_event(dev, 0);
> >> > +
> >> > +       if (pm_wakeup_pending())
> >> > +               return -EBUSY;
> >> > +
> >
> > -> it is done here now.
> >
> > I don't see why it would be still necessary in __device_suspend().
> 
> Can't we have wakeup configured for !CONFIG_PM_RUNTIME case?
> pm_runtime_barrier() won't handle those scenarios, right?

The pm_wakeup_pending() is in effect for CONFIG_PM_RUNTIME unset too.

> Similar check for pm_wakeup_pending() is done at
> __device_suspend_noirq, __device_suspend_late - I assumed it was
> because of the same reasons.

Hmm, OK.  I'll leave it in __device_suspend() too, then.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

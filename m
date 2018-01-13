From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Sat, 13 Jan 2018 01:41:33 +0100
Message-ID: <13807543.DoUSWU9Hf5@aspire.rjw.lan>
References: <4928977.5hd79RbQlp@aspire.rjw.lan> <1952050.gHGtV5tzZn@aspire.rjw.lan> <CAPDyKFrg8FWCU7DSEEDk5-a9WQVtMdr6qoRijK5-T+oKjG0A0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:62915 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeAMAmt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 19:42:49 -0500
In-Reply-To: <CAPDyKFrg8FWCU7DSEEDk5-a9WQVtMdr6qoRijK5-T+oKjG0A0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>

On Friday, January 12, 2018 2:59:38 PM CET Ulf Hansson wrote:
> On 12 January 2018 at 14:12, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > One of the limitations of pm_runtime_force_suspend/resume() is that
> > if a parent driver wants to use these functions, all of its child
> > drivers generally have to do that too because of the parent usage
> > counter manipulations necessary to get the correct state of the parent
> > during system-wide transitions to the working state (system resume).
> > However, that limitation turns out to be artificial, so remove it.
> 
> According to my comment on the other thread, this stands true in case
> the child is managed by runtime PM as well.

What do you mean by "managed by runtime PM"?

> Otherwise this looks good to me.
> 
> >
> > Namely, pm_runtime_force_suspend() only needs to update the children
> > counter of its parent (if there's is a parent) when the device can
> > stay in suspend after the subsequent system resume transition, as
> > that counter is correct already otherwise.  Now, if the parent's
> > children counter is not updated, it is not necessary to increment
> > the parent's usage counter in that case any more, as long as the
> > children counters of devices are checked along with their usage
> > counters in order to decide whether or not the devices may be left
> > in suspend after the subsequent system resume transition.
> >
> > Accordingly, modify pm_runtime_force_suspend() to only call
> > pm_runtime_set_suspended() for devices whose usage and children
> > counters are at the "no references" level (the runtime PM status
> > of the device needs to be updated to "suspended" anyway in case
> > this function is called once again for the same device during the
> > transition under way), drop the parent usage counter incrementation
> > from it and update pm_runtime_force_resume() to compensate for these
> > changes.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/runtime.c |   74 +++++++++++++++++++------------------------
> >  1 file changed, 34 insertions(+), 40 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -1613,17 +1613,28 @@ void pm_runtime_drop_link(struct device
> >         spin_unlock_irq(&dev->power.lock);
> >  }
> >
> > +static bool pm_runtime_need_not_resume(struct device *dev)
> > +{
> > +       return atomic_read(&dev->power.usage_count) <= 1 &&
> > +               atomic_read(&dev->power.child_count) == 0;
> 
> How about adding an additional patch on top taking into account the
> ignore_children flag and folding that into the series, kind of as you
> also suggested?

I will do that, no worries.

> My point is, we might as well take the opportunity to fix this right
> away, don't you think?

OK, I'll send a patch on top of this series.

Thanks,
Rafael

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 24 Nov 2016 06:27:47 -0800
Message-ID: <20161124142747.GL4082@atomide.com>
References: <CAJZ5v0gAFmsZ3_YSG1VBzi=K-GTn+SnUj3K3mJ5Su1gCpiB3jQ@mail.gmail.com>
 <20161111163147.GC7138@atomide.com>
 <CAJZ5v0jkwHnCPhdm6XAgiWz2=X1SPbfHVHZtZ-ONsp2OL0d-4w@mail.gmail.com>
 <20161111222911.GL7138@atomide.com>
 <20161111223234.GM7138@atomide.com>
 <CAJZ5v0gjcRyZHoj9YTpw1aKjFqH9mTZFH=ERvj2-FV_7ZnqjgA@mail.gmail.com>
 <20161112001917.GN7138@atomide.com>
 <CAJZ5v0ivMWZ2c8MphWcyz_S=tNgUyUihcP4=Y4Mz_uw7iZ6dMA@mail.gmail.com>
 <20161118201823.GX4082@atomide.com>
 <CAJZ5v0ggv2Z9rOiwWan2=urcfTooG1_CeALdo=TN4b0tJGEHdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ggv2Z9rOiwWan2=urcfTooG1_CeALdo=TN4b0tJGEHdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki <rafael@kernel.org> [161123 14:37]:
> On Fri, Nov 18, 2016 at 9:18 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Rafael J. Wysocki <rafael@kernel.org> [161111 16:35]:
> >> However, my understanding is that the current code actually works for
> >> runtime PM just fine.
> >
> > Hmm well I just noticed that for drivers not using autosuspend it can be
> > flakey, see the patch below. That probably explains some mysteries people
> > are seeing with wakeirqs.
> >
> > Do you have any better ideas for setting wirq->active on the first
> > rpm_suspend()?
> 
> You could change dedicated_irq into status and have three values for
> it: INVALID, ALLOCATED and IN_USE.
> 
> dev_pm_set_dedicated_wake_irq() would make it ALLOCATED and
> dev_pm_check_wake_irq() would change it into IN_USE.  In turn,
> dev_pm_enable/disable_wake_irq() would only touch it if it is IN_USE
> and dev_pm_clear_wake_irq() would free it if it is not INVALID.

OK sounds good to me.

> > +static inline void dev_pm_check_wake_irq(struct device *dev)
> > +{
> > +       struct wake_irq *wirq = dev->power.wakeirq;
> > +
> > +       if (!wirq)
> > +               return;
> > +
> > +       if (unlikely(!wirq->active)) {
> > +               wirq->active = true;
> > +               wmb();  /* ensure dev_pm_enable_wake_irq() sees active */
> 
> smp_wmb()?
> 
> Also, do we have a corresponding barrier on the reader side?

Will check thanks.

> I wonder if it would make sense to fold dev_pm_check_wake_irq() into
> dev_pm_enable_wake_irq()?

I was thinking that too but then bus or device itself won't be
able to manage the wakeirq if needed.

Let me check if we could easily add something to initialize things
like dev_pm_manage_wake_irq() and dev_pm_dont_manage_wake_irq().
That means we need to update the drivers using it, but then we don't
need to add extra checks to the idle path and can let bus or
drivers mange the wakeirq if necessary.

Regards,

Tony

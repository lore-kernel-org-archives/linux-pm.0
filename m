From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 11 Nov 2016 14:32:35 -0800
Message-ID: <20161111223234.GM7138@atomide.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com>
 <CAJZ5v0gAFmsZ3_YSG1VBzi=K-GTn+SnUj3K3mJ5Su1gCpiB3jQ@mail.gmail.com>
 <20161111163147.GC7138@atomide.com>
 <CAJZ5v0jkwHnCPhdm6XAgiWz2=X1SPbfHVHZtZ-ONsp2OL0d-4w@mail.gmail.com>
 <20161111222911.GL7138@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:59482 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934727AbcKKWck (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 17:32:40 -0500
Content-Disposition: inline
In-Reply-To: <20161111222911.GL7138@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [161111 14:29]:
> * Rafael J. Wysocki <rafael@kernel.org> [161111 13:33]:
> > On Fri, Nov 11, 2016 at 5:31 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Rafael J. Wysocki <rafael@kernel.org> [161110 16:06]:
> > >> On Thu, Nov 10, 2016 at 7:49 PM, Brian Norris <briannorris@chromium.org> wrote:
> > >> > On Thu, Nov 10, 2016 at 10:13:55AM -0800, Dmitry Torokhov wrote:
> > >> >> On Thu, Nov 10, 2016 at 10:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> > >> >> > It's important that user space can figure out what device woke the
> > >> >> > system from suspend -- e.g., for debugging, or for implementing
> > >> >> > conditional wake behavior. Dedicated wakeup IRQs don't currently do
> > >> >> > that.
> > >> >> >
> > >> >> > Let's report the event (pm_wakeup_event()) and also allow drivers to
> > >> >> > synchronize with these events in their resume path (hence, disable_irq()
> > >> >> > instead of disable_irq_nosync()).
> > >> >>
> > >> >> Hmm, dev_pm_disable_wake_irq() is called from
> > >> >> rpm_suspend()/rpm_resume() that take dev->power.lock spinlock and
> > >> >> disable interrupts. Dropping _nosync() feels dangerous.
> > >> >
> > >> > Indeed. So how do you suggest we get sane wakeup reports? Every device
> > >> > or bus that's going to use the dedicated wake APIs has to
> > >> > synchronize_irq() [1] in their resume() routine? Seems like an odd
> > >> > implementation detail to have to remember (and therefore most drivers
> > >> > will get it wrong).
> > >> >
> > >> > Brian
> > >> >
> > >> > [1] Or maybe at least create a helper API that will extract the
> > >> > dedicated wake IRQ number and do the synchronize_irq() for us, so
> > >> > drivers don't have to stash this separately (or poke at
> > >> > dev->power.wakeirq->irq) for no good reason.
> > >>
> > >> Well, in the first place, can anyone please refresh my memory on why
> > >> it is necessary to call dev_pm_disable_wake_irq() under power.lock?
> > >
> > > I guess no other reason except we need to manage the wakeirq
> > > for rpm_callback(). So we dev_pm_enable_wake_irq() before
> > > rpm_callback() in rpm_suspend(), then disable on resume.
> > 
> > But we drop the lock in rpm_callback(), so can't it be moved to where
> > the callback is invoked?
> 
> Then we're back to patching all the drivers again, no?

Sorry I misunderstood, yeah that should work if rpm_callback() drops
the lock.

Somehow I remembered we're calling the consumer callback function
directly :)

Regards,

Tony

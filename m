From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Fri, 11 Nov 2016 08:47:54 -0800
Message-ID: <20161111164753.GD7138@atomide.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com>
 <20161110204911.GK27724@atomide.com>
 <20161110213038.GA108490@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110213038.GA108490@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

* Brian Norris <briannorris@chromium.org> [161110 13:30]:
> On Thu, Nov 10, 2016 at 01:49:11PM -0700, Tony Lindgren wrote:
> > * Brian Norris <briannorris@chromium.org> [161110 11:49]:
> > > On Thu, Nov 10, 2016 at 10:13:55AM -0800, Dmitry Torokhov wrote:
> > > > On Thu, Nov 10, 2016 at 10:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> > > > > It's important that user space can figure out what device woke the
> > > > > system from suspend -- e.g., for debugging, or for implementing
> > > > > conditional wake behavior. Dedicated wakeup IRQs don't currently do
> > > > > that.
> > > > >
> > > > > Let's report the event (pm_wakeup_event()) and also allow drivers to
> > > > > synchronize with these events in their resume path (hence, disable_irq()
> > > > > instead of disable_irq_nosync()).
> > > > 
> > > > Hmm, dev_pm_disable_wake_irq() is called from
> > > > rpm_suspend()/rpm_resume() that take dev->power.lock spinlock and
> > > > disable interrupts. Dropping _nosync() feels dangerous.
> > > 
> > > Indeed. So how do you suggest we get sane wakeup reports?
> > 
> > __pm_wakeup_event() ?
> 
> That's not the difficult part. (This patch already uses
> pm_wakeup_event() correctly. It's in the ISR, and it doesn't get nested
> within any other lock-holding code, so it should use the non-underscore
> version, which grabs the lock.)

OK, right it's the disable_wake_irq() that takes the lock.

> The difficult part is guaranteeing that the wake IRQ gets reported at
> the appropriate time. It seems highly unlikely that a threaded IRQ like
> this would take longer than the time for devices to resume, but it's not
> guaranteed. So the question is where/when/how we call synchronize_irq().

Yeah OK.

FYI, the wake up time can be really long as in tens of milliseconds
in some cases when enabling regulator(s) and before the state is
restored. Then not using threaded IRQ for the wakeirq will lead
into extra troubles as that assumes that the consumer devices has
pm_runtime_irq_safe() set. And having pm_runtime_irq_safe() will
lead into extra issues in the driver as it permanently blocks the
consume parent device PM.

But sounds like the threaded IRQ is not your concern and you mostly
care about getting the right time for the wake up interrupt.
The wakeup interrupt controller knows something happened earlier,
so maybe it could report that time if queried somehow?

Regards,

Tony

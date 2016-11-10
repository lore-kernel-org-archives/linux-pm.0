From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 10 Nov 2016 13:49:11 -0700
Message-ID: <20161110204911.GK27724@atomide.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110184910.GA135921@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

* Brian Norris <briannorris@chromium.org> [161110 11:49]:
> On Thu, Nov 10, 2016 at 10:13:55AM -0800, Dmitry Torokhov wrote:
> > On Thu, Nov 10, 2016 at 10:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> > > It's important that user space can figure out what device woke the
> > > system from suspend -- e.g., for debugging, or for implementing
> > > conditional wake behavior. Dedicated wakeup IRQs don't currently do
> > > that.
> > >
> > > Let's report the event (pm_wakeup_event()) and also allow drivers to
> > > synchronize with these events in their resume path (hence, disable_irq()
> > > instead of disable_irq_nosync()).
> > 
> > Hmm, dev_pm_disable_wake_irq() is called from
> > rpm_suspend()/rpm_resume() that take dev->power.lock spinlock and
> > disable interrupts. Dropping _nosync() feels dangerous.
> 
> Indeed. So how do you suggest we get sane wakeup reports?

__pm_wakeup_event() ?

Tony

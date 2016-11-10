From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 10 Nov 2016 13:30:39 -0800
Message-ID: <20161110213038.GA108490@google.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
 <20161110184910.GA135921@google.com>
 <20161110204911.GK27724@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34055 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964803AbcKJVam (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 16:30:42 -0500
Received: by mail-pf0-f180.google.com with SMTP id n85so152500323pfi.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 13:30:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161110204911.GK27724@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Nov 10, 2016 at 01:49:11PM -0700, Tony Lindgren wrote:
> * Brian Norris <briannorris@chromium.org> [161110 11:49]:
> > On Thu, Nov 10, 2016 at 10:13:55AM -0800, Dmitry Torokhov wrote:
> > > On Thu, Nov 10, 2016 at 10:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> > > > It's important that user space can figure out what device woke the
> > > > system from suspend -- e.g., for debugging, or for implementing
> > > > conditional wake behavior. Dedicated wakeup IRQs don't currently do
> > > > that.
> > > >
> > > > Let's report the event (pm_wakeup_event()) and also allow drivers to
> > > > synchronize with these events in their resume path (hence, disable_irq()
> > > > instead of disable_irq_nosync()).
> > > 
> > > Hmm, dev_pm_disable_wake_irq() is called from
> > > rpm_suspend()/rpm_resume() that take dev->power.lock spinlock and
> > > disable interrupts. Dropping _nosync() feels dangerous.
> > 
> > Indeed. So how do you suggest we get sane wakeup reports?
> 
> __pm_wakeup_event() ?

That's not the difficult part. (This patch already uses
pm_wakeup_event() correctly. It's in the ISR, and it doesn't get nested
within any other lock-holding code, so it should use the non-underscore
version, which grabs the lock.)

The difficult part is guaranteeing that the wake IRQ gets reported at
the appropriate time. It seems highly unlikely that a threaded IRQ like
this would take longer than the time for devices to resume, but it's not
guaranteed. So the question is where/when/how we call synchronize_irq().

Brian

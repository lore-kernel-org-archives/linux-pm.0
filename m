From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 10 Nov 2016 10:49:10 -0800
Message-ID: <20161110184910.GA135921@google.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
 <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34482 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933704AbcKJStO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 13:49:14 -0500
Received: by mail-pf0-f181.google.com with SMTP id n85so150629098pfi.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 10:49:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Thu, Nov 10, 2016 at 10:13:55AM -0800, Dmitry Torokhov wrote:
> On Thu, Nov 10, 2016 at 10:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> > It's important that user space can figure out what device woke the
> > system from suspend -- e.g., for debugging, or for implementing
> > conditional wake behavior. Dedicated wakeup IRQs don't currently do
> > that.
> >
> > Let's report the event (pm_wakeup_event()) and also allow drivers to
> > synchronize with these events in their resume path (hence, disable_irq()
> > instead of disable_irq_nosync()).
> 
> Hmm, dev_pm_disable_wake_irq() is called from
> rpm_suspend()/rpm_resume() that take dev->power.lock spinlock and
> disable interrupts. Dropping _nosync() feels dangerous.

Indeed. So how do you suggest we get sane wakeup reports? Every device
or bus that's going to use the dedicated wake APIs has to
synchronize_irq() [1] in their resume() routine? Seems like an odd
implementation detail to have to remember (and therefore most drivers
will get it wrong).

Brian

[1] Or maybe at least create a helper API that will extract the
dedicated wake IRQ number and do the synchronize_irq() for us, so
drivers don't have to stash this separately (or poke at
dev->power.wakeirq->irq) for no good reason.

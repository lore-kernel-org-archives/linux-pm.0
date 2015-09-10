From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V7] Report interrupt that caused system wakeup
Date: Fri, 11 Sep 2015 00:21:13 +0200
Message-ID: <1528855.hS8haWgnGz@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509101501480.1422-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43992 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751042AbbIJVxU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 17:53:20 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509101501480.1422-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On Thursday, September 10, 2015 03:15:24 PM Alan Stern wrote:
> On Thu, 10 Sep 2015, Alexandra Yates wrote:
> 
> > Hi Alan,
> > 
> > On 09/10/2015 07:14 AM, Alan Stern wrote:
> > > On Wed, 9 Sep 2015, Alexandra Yates wrote:
> > >
> > >> This feature reports which IRQ cause the system to wakeup from sleep last
> > >> time it was suspended.
> > > I thought you said V7 of this patch was written based on the feedback I
> > > provided.  Obviously that is not true.
> > Yes, that was the intention.
> > > This feature does NOT report which IRQ caused the system to wake up
> > > from sleep the last time it was suspended!  All it does is report one
> > > of the IRQs which have occurred since the last time the system started
> > > a sleep transition.

It doesn't do that.  It reports one of the IRQs that were armed for system
wakeup and have occurred since suspend_device_irqs() was last called (and
obviously before the subsequent resume_device_irqs() which clears the
"armed for system wakeup" flag).

> > I'm not sure why you say this, please elaborate further.
> > 
> > The way I understand the code and proposed solution is that when
> > the system goes into freeze mode, at that point wakeup_irq is set to 0.
> 
> I'm not sure what you mean by "freeze mode".  Do you mean that all the 
> user processes have been frozen?
> 
> > Once the system sees an interrupt at wakeup from freeze. wakeup_irq is 
> > set to
> > the irq_number that caused the wakeup.  This path of code is protected 
> > by spin lock,
> 
> The spin lock doesn't help if multiple IRQs have already been raised.  
> How do you know which one caused the system to wake up?

Actually, we don't, which is a good point.

However, the purpose of this mechanism is mostly debugging spurious wakeup
events and recording just the first wakeup interrupt we see should be
sufficient for that.

Spurious wakeup interrupts that always come it along with legitimate ones
are not really so much interesting from that angle. :-)

> > which should protect the code path from other IRQs that came after the 
> > first IRQ.
> 
> Why so?  Waking up from sleep is a slow procedure; there is time for
> several IRQs to be asserted before the system is ready to handle any of
> them.  How do you know the first IRQ to be handled is the one that 
> caused the wake up?

> > This is only set once. When other IRQs come and the wakeup_irq is set 
> > then the code
> > doesn't store them.
> 
> What if the system entered freeze mode but then returned to normal 
> operation without ever going to sleep, because an IRQ occurred first?  
> Wouldn't you then store that IRQ?

If the IRQ has been armed for system wakeup, that counts as a wakeup from
sleep.

> But that IRQ did not cause the system to wake up, because the system
> never went to sleep.

I guess we should just say in the changelog and the documentation that we
report that first wakeup interrupt we've seen in the last cycle (which may
not be the first one that really occured in some cases).

Thanks,
Rafael


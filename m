From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V7] Report interrupt that caused system wakeup
Date: Fri, 11 Sep 2015 10:07:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509111005490.1667-100000@iolanthe.rowland.org>
References: <1528855.hS8haWgnGz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49449 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752667AbbIKOHn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 10:07:43 -0400
In-Reply-To: <1528855.hS8haWgnGz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On Fri, 11 Sep 2015, Rafael J. Wysocki wrote:

> > The spin lock doesn't help if multiple IRQs have already been raised.  
> > How do you know which one caused the system to wake up?
> 
> Actually, we don't, which is a good point.
> 
> However, the purpose of this mechanism is mostly debugging spurious wakeup
> events and recording just the first wakeup interrupt we see should be
> sufficient for that.
> 
> Spurious wakeup interrupts that always come it along with legitimate ones
> are not really so much interesting from that angle. :-)
> 
> > > which should protect the code path from other IRQs that came after the 
> > > first IRQ.
> > 
> > Why so?  Waking up from sleep is a slow procedure; there is time for
> > several IRQs to be asserted before the system is ready to handle any of
> > them.  How do you know the first IRQ to be handled is the one that 
> > caused the wake up?
> 
> > > This is only set once. When other IRQs come and the wakeup_irq is set 
> > > then the code
> > > doesn't store them.
> > 
> > What if the system entered freeze mode but then returned to normal 
> > operation without ever going to sleep, because an IRQ occurred first?  
> > Wouldn't you then store that IRQ?
> 
> If the IRQ has been armed for system wakeup, that counts as a wakeup from
> sleep.
> 
> > But that IRQ did not cause the system to wake up, because the system
> > never went to sleep.
> 
> I guess we should just say in the changelog and the documentation that we
> report that first wakeup interrupt we've seen in the last cycle (which may
> not be the first one that really occured in some cases).

The patch itself is perfectly okay, as far as I can tell.  I just
didn't like the description, because it made claims that generally
aren't true.  The new description in the V8 submission is a lot better.

Alan Stern


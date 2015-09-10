From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V7] Report interrupt that caused system wakeup
Date: Thu, 10 Sep 2015 15:15:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509101501480.1422-100000@iolanthe.rowland.org>
References: <55F1CF07.8070505@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55008 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752847AbbIJTP0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 15:15:26 -0400
In-Reply-To: <55F1CF07.8070505@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net

On Thu, 10 Sep 2015, Alexandra Yates wrote:

> Hi Alan,
> 
> On 09/10/2015 07:14 AM, Alan Stern wrote:
> > On Wed, 9 Sep 2015, Alexandra Yates wrote:
> >
> >> This feature reports which IRQ cause the system to wakeup from sleep last
> >> time it was suspended.
> > I thought you said V7 of this patch was written based on the feedback I
> > provided.  Obviously that is not true.
> Yes, that was the intention.
> > This feature does NOT report which IRQ caused the system to wake up
> > from sleep the last time it was suspended!  All it does is report one
> > of the IRQs which have occurred since the last time the system started
> > a sleep transition.
> I'm not sure why you say this, please elaborate further.
> 
> The way I understand the code and proposed solution is that when
> the system goes into freeze mode, at that point wakeup_irq is set to 0.

I'm not sure what you mean by "freeze mode".  Do you mean that all the 
user processes have been frozen?

> Once the system sees an interrupt at wakeup from freeze. wakeup_irq is 
> set to
> the irq_number that caused the wakeup.  This path of code is protected 
> by spin lock,

The spin lock doesn't help if multiple IRQs have already been raised.  
How do you know which one caused the system to wake up?

> which should protect the code path from other IRQs that came after the 
> first IRQ.

Why so?  Waking up from sleep is a slow procedure; there is time for
several IRQs to be asserted before the system is ready to handle any of
them.  How do you know the first IRQ to be handled is the one that 
caused the wake up?

> This is only set once. When other IRQs come and the wakeup_irq is set 
> then the code
> doesn't store them.

What if the system entered freeze mode but then returned to normal 
operation without ever going to sleep, because an IRQ occurred first?  
Wouldn't you then store that IRQ?  But that IRQ did not cause the 
system to wake up, because the system never went to sleep.

Alan Stern


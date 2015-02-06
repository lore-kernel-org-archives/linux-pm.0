From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Update] Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Fri, 6 Feb 2015 19:29:22 +0100
Message-ID: <20150206182922.GN24151@twins.programming.kicks-ass.net>
References: <54866625.8010406@linux.intel.com>
 <alpine.DEB.2.11.1501260946390.5526@nanos>
 <16564156.c5NBzjJuA3@vostro.rjw.lan>
 <2439333.L8nfGI3YZp@vostro.rjw.lan>
 <20150206161454.GQ21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35452 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758564AbbBFS33 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Feb 2015 13:29:29 -0500
Content-Disposition: inline
In-Reply-To: <20150206161454.GQ21418@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Feb 06, 2015 at 05:14:54PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 06, 2015 at 02:20:13AM +0100, Rafael J. Wysocki wrote:
> >  void freeze_wake(void)
> >  {
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&suspend_freeze_lock, flags);
> > +	if (suspend_freeze_state > FREEZE_STATE_NONE) {
> > +		suspend_freeze_state = FREEZE_STATE_WAKE;
> > +		wake_up(&suspend_freeze_wait_head);
> > +	}
> > +	spin_unlock_irqrestore(&suspend_freeze_lock, flags);
> >  }
> 
> 
> > +static void enter_freeze_proper(struct cpuidle_driver *drv,
> > +				struct cpuidle_device *dev, int index)
> > +{
> > +	tick_freeze();
> > +	drv->states[index].enter_freeze(dev, drv, index);
> > +	/*
> > +	 * timekeeping_resume() that will be called by tick_unfreeze() for the
> > +	 * last CPU executing it calls functions containing RCU read-side
> > +	 * critical sections, so tell RCU about that.
> > +	 */
> > +	RCU_NONIDLE(tick_unfreeze());
> > +}
> 
> So I'm a wee bit confused; if we use an enter_freeze() state that keeps
> interrupts disabled; who is going to call the freeze_wake() thing?

Ah, I think I see, so we wake up, keep the interrupt pending, re-enable
the tick and time and everybody, then re-enable interrupts, take the
interrupt and go around the idle loop to find we need a reschedule etc..

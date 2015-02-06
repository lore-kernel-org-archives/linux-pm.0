From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update] Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Fri, 06 Feb 2015 23:36:12 +0100
Message-ID: <1684745.qMDN6HIHc8@vostro.rjw.lan>
References: <54866625.8010406@linux.intel.com> <20150206161454.GQ21418@twins.programming.kicks-ass.net> <20150206182922.GN24151@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150206182922.GN24151@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 06, 2015 07:29:22 PM Peter Zijlstra wrote:
> On Fri, Feb 06, 2015 at 05:14:54PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 06, 2015 at 02:20:13AM +0100, Rafael J. Wysocki wrote:
> > >  void freeze_wake(void)
> > >  {
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&suspend_freeze_lock, flags);
> > > +	if (suspend_freeze_state > FREEZE_STATE_NONE) {
> > > +		suspend_freeze_state = FREEZE_STATE_WAKE;
> > > +		wake_up(&suspend_freeze_wait_head);
> > > +	}
> > > +	spin_unlock_irqrestore(&suspend_freeze_lock, flags);
> > >  }
> > 
> > 
> > > +static void enter_freeze_proper(struct cpuidle_driver *drv,
> > > +				struct cpuidle_device *dev, int index)
> > > +{
> > > +	tick_freeze();
> > > +	drv->states[index].enter_freeze(dev, drv, index);
> > > +	/*
> > > +	 * timekeeping_resume() that will be called by tick_unfreeze() for the
> > > +	 * last CPU executing it calls functions containing RCU read-side
> > > +	 * critical sections, so tell RCU about that.
> > > +	 */
> > > +	RCU_NONIDLE(tick_unfreeze());
> > > +}
> > 
> > So I'm a wee bit confused; if we use an enter_freeze() state that keeps
> > interrupts disabled; who is going to call the freeze_wake() thing?
> 
> Ah, I think I see, so we wake up, keep the interrupt pending, re-enable
> the tick and time and everybody, then re-enable interrupts, take the
> interrupt and go around the idle loop to find we need a reschedule etc..

Exactly.

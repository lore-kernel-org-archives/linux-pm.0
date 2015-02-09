From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update 2x] Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Tue, 10 Feb 2015 00:57:43 +0100
Message-ID: <1642165.PhpflFaKUn@vostro.rjw.lan>
References: <54866625.8010406@linux.intel.com> <8924978.aOrU4231JI@vostro.rjw.lan> <20150209154408.GV5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55940 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932911AbbBIXel (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 18:34:41 -0500
In-Reply-To: <20150209154408.GV5029@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Monday, February 09, 2015 04:44:08 PM Peter Zijlstra wrote:
> On Mon, Feb 09, 2015 at 03:54:22AM +0100, Rafael J. Wysocki wrote:
> > Complete patch with that modification is appended.  In the next few days I'm
> > going to split it into smaller parts and send along with cpuidle driver
> > patches implementing ->enter_freeze.
> > 
> > Please let me know what you think.
> 
> > @@ -104,6 +105,21 @@ static void cpuidle_idle_call(void)
> >  	rcu_idle_enter();
> >  
> >  	/*
> > +	 * Suspend-to-idle ("freeze") is a system state in which all user space
> > +	 * has been frozen, all I/O devices have been suspended and the only
> > +	 * activity happens here and in iterrupts (if any).  In that case bypass
> > +	 * the cpuidle governor and go stratight for the deepest idle state
> > +	 * available.  Possibly also suspend the local tick and the entire
> > +	 * timekeeping to prevent timer interrupts from kicking us out of idle
> > +	 * until a proper wakeup interrupt happens.
> > +	 */
> > +	if (idle_should_freeze()) {
> > +		cpuidle_enter_freeze();
> > +		local_irq_enable();
> > +		goto exit_idle;
> > +	}
> > +
> > +	/*
> >  	 * Ask the cpuidle framework to choose a convenient idle state.
> >  	 * Fall back to the default arch idle method on errors.
> >  	 */
> 
> I was hoping to not have to put that into the regular idle path; say
> maybe share a single special branch with the play-dead call. People seem
> to start complaining about the total amount of time it takes to just
> 'run' the idle path.

Well, this check really only replaces one in cpuidle_select() and another
one in cpuidle_reflect() and they both are called from the idle path, so
that's a net gain rather. :-)

> Now I don't think we can do that, because we need the
> arch_cpu_idle_enter() nonsense for the one but not the other; also all
> this really only makes sense in the cpuidle context, so nothing to be
> done about that.

Agreed.

> In any case, you could make that:
> 
> static inline bool idle_should_freeze(void)
> {
> 	return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
> }
> 
> which should help a bit I suppose.

Won't hurt at least.

> > +static void enter_freeze_proper(struct cpuidle_driver *drv,
> > +                               struct cpuidle_device *dev, int index)
> > +{
> > +       tick_freeze();
> > +       drv->states[index].enter_freeze(dev, drv, index);
> 
> This is slightly different from cpuidle_enter() in that it does not
> consider the coupled states nonsense, is that on purpose? And if so,
> does that want a comment?

Yes, it is on purpose and the reason why is because the coupled thing re-enables
interrupts (unconditionally).  [And it contains a comment about that which does
not make sense to me now that I read it.]

I can add a comment about that, though.

> > +       /*
> > +        * timekeeping_resume() that will be called by tick_unfreeze() for the
> > +        * last CPU executing it calls functions containing RCU read-side
> > +        * critical sections, so tell RCU about that.
> > +        */
> > +       RCU_NONIDLE(tick_unfreeze());
> > +}
> 
> 
> But over all it looks fine to me.

Cool, thanks!


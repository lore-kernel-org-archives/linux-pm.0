From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during	suspend-resume
Date: Mon, 23 Feb 2009 18:16:30 +0100
Message-ID: <20090223171630.GA28651__46063.0257068717$1235409657$gmane$org@elte.hu>
References: <200902221837.49396.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
	<20090223083645.GA9582@elte.hu> <200902231229.58743.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902231229.58743.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > > +void suspend_device_irqs(void)
> > > +{
> > > +	struct irq_desc *desc;
> > > +	int irq;
> > > +
> > > +	for_each_irq_desc(irq, desc) {
> > > +		unsigned long flags;
> > > +
> > > +		spin_lock_irqsave(&desc->lock, flags);
> > > +
> > > +		if (!desc->depth && desc->action
> > > +		    && !(desc->action->flags & IRQF_TIMER)) {
> > > +			desc->depth++;
> > > +			desc->status |= IRQ_DISABLED | IRQ_SUSPENDED;
> > > +			desc->chip->disable(irq);
> > > +		}
> > > +
> > > +		spin_unlock_irqrestore(&desc->lock, flags);
> > > +	}
> > > +
> > > +	for_each_irq_desc(irq, desc) {
> > > +		if (desc->status & IRQ_SUSPENDED)
> > > +			synchronize_irq(irq);
> > > +	}
> > 
> > Optimization/code-flow nit: a possibility might be to do a 
> > single loop, i.e. i think it's safe to couple the 
> > disable+sync bits [as in 99.99% of the cases there will be 
> > no in-execution irq handlers when we execute this.]
> 
> Well, Linus suggested to do it in a separate loop.  I'm fine 
> with both ways.

Linus, do you have a strong opinion about which variant we 
should use?

The two approaches are not completely equivalent, the variant 
suggested by Linus is a bit more 'atomic' - in that it first 
turns off everything, then looks for everything that needs to be 
synchronized.

OTOH, it _shouldnt_ make much of a difference on a correctly 
working system - we ought to be able to disable the irqs one by 
one and wait on any pending ones on the spot. Maybe if there was 
some implicit dependency between irq sources it would be more 
robust to do Linus's version.

Dunno ... no strong feelings either way.

	Ingo

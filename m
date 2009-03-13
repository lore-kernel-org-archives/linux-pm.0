From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update,
	rev. 6] Re: [PATCH 1/10] PM: Rework handling of interrupts during
	suspend-resume (rev. 5)
Date: Fri, 13 Mar 2009 22:56:50 +0100
Message-ID: <200903132256.51522.rjw__30086.5045319826$1236981745$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903122243.27452.rjw@sisk.pl>
	<alpine.LFD.2.00.0903132052240.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903132052240.29264@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 13 March 2009, Thomas Gleixner wrote:
> On Thu, 12 Mar 2009, Rafael J. Wysocki wrote:
> > +/**
> > + * suspend_device_irqs - disable all currently enabled interrupt lines
> > + *
> > + * During system-wide suspend or hibernation device interrupts need to be
> > + * disabled at the chip level and this function is provided for this purpose.
> > + * It disables all interrupt lines that are enabled at the moment and sets the
> > + * IRQ_SUSPENDED flag for them.
> > + */
> > +void suspend_device_irqs(void)
> > +{
> > +	struct irq_desc *desc;
> > +	int irq;
> > +
> > +	for_each_irq_desc(irq, desc) {
> > +		unsigned long flags;
> > +
> > +		spin_lock_irqsave(&desc->lock, flags);
> > +		__disable_irq(desc, irq, true);
> > +		spin_unlock_irqrestore(&desc->lock, flags);
> 
> Can we move the locking into __disable_irq ?

Well, yes, but (see below)

> > +	}
> > +
> > +	for_each_irq_desc(irq, desc)
> > +		if (desc->status & IRQ_SUSPENDED)
> > +			synchronize_irq(irq);
> > +}
> > +EXPORT_SYMBOL_GPL(suspend_device_irqs);
> > +
> > +/**
> > + * resume_device_irqs - enable interrupt lines disabled by suspend_device_irqs()
> > + *
> > + * Enable all interrupt lines previously disabled by suspend_device_irqs() that
> > + * have the IRQ_SUSPENDED flag set.
> > + */
> > +void resume_device_irqs(void)
> > +{
> > +	struct irq_desc *desc;
> > +	int irq;
> > +
> > +	for_each_irq_desc(irq, desc) {
> > +		unsigned long flags;
> > +
> > +		if (!(desc->status & IRQ_SUSPENDED))
> > +			continue;
> > +
> > +		spin_lock_irqsave(&desc->lock, flags);
> > +		__enable_irq(desc, irq, true);
> > +		spin_unlock_irqrestore(&desc->lock, flags);
> 
> Ditto

No, because of __setup_irq().

Thanks,
Rafael

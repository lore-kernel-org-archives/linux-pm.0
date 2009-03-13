From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [update,
 rev. 6] Re: [PATCH 1/10] PM: Rework handling of interrupts during
 suspend-resume (rev. 5)
Date: Fri, 13 Mar 2009 20:55:13 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903132052240.29264__14804.0258362473$1236974472$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112342440.29264@localhost.localdomain>
	<200903121436.21504.rjw@sisk.pl> <200903122243.27452.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903122243.27452.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Mar 2009, Rafael J. Wysocki wrote:
> +/**
> + * suspend_device_irqs - disable all currently enabled interrupt lines
> + *
> + * During system-wide suspend or hibernation device interrupts need to be
> + * disabled at the chip level and this function is provided for this purpose.
> + * It disables all interrupt lines that are enabled at the moment and sets the
> + * IRQ_SUSPENDED flag for them.
> + */
> +void suspend_device_irqs(void)
> +{
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	for_each_irq_desc(irq, desc) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&desc->lock, flags);
> +		__disable_irq(desc, irq, true);
> +		spin_unlock_irqrestore(&desc->lock, flags);

Can we move the locking into __disable_irq ?

> +	}
> +
> +	for_each_irq_desc(irq, desc)
> +		if (desc->status & IRQ_SUSPENDED)
> +			synchronize_irq(irq);
> +}
> +EXPORT_SYMBOL_GPL(suspend_device_irqs);
> +
> +/**
> + * resume_device_irqs - enable interrupt lines disabled by suspend_device_irqs()
> + *
> + * Enable all interrupt lines previously disabled by suspend_device_irqs() that
> + * have the IRQ_SUSPENDED flag set.
> + */
> +void resume_device_irqs(void)
> +{
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	for_each_irq_desc(irq, desc) {
> +		unsigned long flags;
> +
> +		if (!(desc->status & IRQ_SUSPENDED))
> +			continue;
> +
> +		spin_lock_irqsave(&desc->lock, flags);
> +		__enable_irq(desc, irq, true);
> +		spin_unlock_irqrestore(&desc->lock, flags);

Ditto

Thanks,

	tglx

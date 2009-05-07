From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] genirq: ensure IRQs are lazy disabled before
	suspend
Date: Thu, 7 May 2009 13:15:48 +0200
Message-ID: <20090507111548.GH28398__16095.8825181753$1241695094$gmane$org@elte.hu>
References: <1241655468-5750-1-git-send-email-khilman@deeprootsystems.com>
	<1241655468-5750-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1241655468-5750-2-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Kevin Hilman <khilman@deeprootsystems.com> wrote:

> In commit 76d2160147f43f982dfe881404cfde9fd0a9da21, the default
> behavior of disable_irq() was changed to delay the disable until it is
> next handled.
> 
> However, this leaves open the possibility that the system can go into
> suspend with an interrupt enabled.  For example, if a driver calls
> disable_irq() in its suspend_hook (for example, to prevent that device
> IRQ from causing a system wakeup) there's now a possibility that the
> system is suspended before the lazy disable happens.
> 
> The result is an unwanted wakeup from suspend if the IRQ is capable of
> waking the system (common on embedded SoCs.)
> 
> This patch ensures that the lazy disable is done, and masked by
> the irq_chip before the system goes into suspend.
> 
> Note that even though __disable_irq() also calls irq_chip->disable, it
> is quite common for the irq_chip not to provide a disable hook in
> which case the IRQ is never masked/disabled in hardware before going
> into suspend.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  kernel/irq/manage.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2734eca..5d2cc1c 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -190,6 +190,11 @@ void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)
>  		if (!desc->action || (desc->action->flags & IRQF_TIMER))
>  			return;
>  		desc->status |= IRQ_SUSPENDED;
> +
> +		/* Lazy disable: handles case where lazy disable in
> +		 * handler doesn't happen before suspend. */
> +		if (desc->status & IRQ_DISABLED)
> +			desc->chip->mask(irq);

Please look at the rest of the file and follow the multi-line 
comment style that is used in the 29 multi-line comment instances 
there. (which is also what Documentation/CodingStyle specifies)

	Ingo

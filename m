From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] powermac: proper sleep management
Date: Fri, 09 Nov 2007 10:19:16 +1100
Message-ID: <1194563956.6561.20.camel@pasglop>
References: <1194523729.6294.18.camel@johannes.berg>
	<47336035.4020609@freescale.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47336035.4020609@freescale.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Johannes Berg <johannes@sipsolutions.net>, David Woodhouse <dwmw2@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Thu, 2007-11-08 at 13:15 -0600, Scott Wood wrote:
> Johannes Berg wrote:
> > +/*
> > + * overrides the weak arch_suspend_disable_irqs in kernel/power/main.c
> > + *
> > + * XXX: Once Scott Wood's patch is merged, this needs to use the ppc_md
> > + *	hooks that patch adds!
> > + */
> > +void arch_suspend_disable_irqs(void)
> > +{
> > +#ifdef CONFIG_PMAC_BACKLIGHT
> > +	/* Tell backlight code not to muck around with the chip anymore */
> > +	pmu_backlight_set_sleep(1);
> > +#endif
>  > +
> > +	/* Call platform functions marked "on sleep" */
> > +	pmac_pfunc_i2c_suspend();
> > +	pmac_pfunc_base_suspend();
> 
> Shouldn't these be done from suspend methods of the relevant drivers?
> I don't understand why this needs to go in the disable IRQ hook.

The pmac_pfunc thing is low level platform stuff, no driver involved
there, this is the right place to do it.

As for the backlight bits, that could indeed be moved around I suppose,
I'd keep it there for now and look at cleaning the PMU driver
suspend/resume path in a second step.

Ben.

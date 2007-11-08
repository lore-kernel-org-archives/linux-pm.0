From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] powermac: proper sleep management
Date: Thu, 08 Nov 2007 13:15:01 -0600
Message-ID: <47336035.4020609__8663.63428435779$1194556493$gmane$org@freescale.com>
References: <1194523729.6294.18.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194523729.6294.18.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm <linux-pm@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

Johannes Berg wrote:
> +/*
> + * overrides the weak arch_suspend_disable_irqs in kernel/power/main.c
> + *
> + * XXX: Once Scott Wood's patch is merged, this needs to use the ppc_md
> + *	hooks that patch adds!
> + */
> +void arch_suspend_disable_irqs(void)
> +{
> +#ifdef CONFIG_PMAC_BACKLIGHT
> +	/* Tell backlight code not to muck around with the chip anymore */
> +	pmu_backlight_set_sleep(1);
> +#endif
 > +
> +	/* Call platform functions marked "on sleep" */
> +	pmac_pfunc_i2c_suspend();
> +	pmac_pfunc_base_suspend();

Shouldn't these be done from suspend methods of the relevant drivers?
I don't understand why this needs to go in the disable IRQ hook.

-Scott

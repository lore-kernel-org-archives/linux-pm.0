From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] irq: Track the interrupt timings
Date: Mon, 22 Feb 2016 20:18:19 +0530
Message-ID: <56CB1FB3.2000007@linux.vnet.ibm.com>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On 02/16/2016 09:13 PM, Daniel Lezcano wrote:
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 0ccd028..577686b 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -174,6 +174,9 @@ static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
>  	if (alloc_masks(desc, gfp, node))
>  		goto err_kstat;
> 
> +	if (alloc_timings(desc))
> +		goto err_mask;
> +
>  	raw_spin_lock_init(&desc->lock);
>  	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
>  	init_rcu_head(&desc->rcu);
> @@ -182,6 +185,8 @@ static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
> 
>  	return desc;
> 
> +err_mask:
> +	free_masks(desc);
>  err_kstat:
>  	free_percpu(desc->kstat_irqs);
>  err_desc:
> @@ -220,6 +225,11 @@ static void free_desc(unsigned int irq)
>  	 * the child interrupts.
>  	 */
>  	call_rcu(&desc->rcu, delayed_free_desc);
> +
> +	free_timings(desc);
> +	free_masks(desc);
> +	free_percpu(desc->kstat_irqs);
> +	kfree(desc);
>  }

I think this is a rebase error. If I am not wrong, instead of this you
need to add free_timings(desc) to delayed_free_desc.

Thanks,
Shreyas

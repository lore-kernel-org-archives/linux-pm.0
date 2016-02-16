From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH V3 1/2] irq: Track the interrupt timings
Date: Tue, 16 Feb 2016 11:45:37 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1602161145070.13632@knanqh.ubzr>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35815 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbcBPQpl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 11:45:41 -0500
Received: by mail-qg0-f50.google.com with SMTP id y89so137550201qge.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2016 08:45:40 -0800 (PST)
In-Reply-To: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Tue, 16 Feb 2016, Daniel Lezcano wrote:

> The interrupt framework gives a lot of information about each interrupt.
> It does not keep track of when those interrupts occur though.
> 
> This patch provides a mean to record the elapsed time between successive
> interrupt occurrences in a per-IRQ per-CPU circular buffer to help with
> the prediction of the next occurrence using a statistical model.
> 
> A new function is added to browse the different interrupts and retrieve the
> timing information stored in it.
> 
> A static key will be introduced when the irq prediction is switched on at
> runtime in order to reduce an overhead near to zero when the kernel is not
> using it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>



> ---
>  include/linux/interrupt.h |  17 +++++++
>  include/linux/irqdesc.h   |   4 ++
>  kernel/irq/Kconfig        |   3 ++
>  kernel/irq/Makefile       |   1 +
>  kernel/irq/handle.c       |   2 +
>  kernel/irq/internals.h    |  42 ++++++++++++++++++
>  kernel/irq/irqdesc.c      |  10 +++++
>  kernel/irq/manage.c       |   3 ++
>  kernel/irq/timings.c      | 110 ++++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 192 insertions(+)
>  create mode 100644 kernel/irq/timings.c
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 0e95fcc..f053596 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -665,6 +665,23 @@ static inline void init_irq_proc(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_IRQ_TIMINGS
> +
> +#define IRQ_TIMINGS_SHIFT	2
> +#define IRQ_TIMINGS_SIZE	(1 << IRQ_TIMINGS_SHIFT)
> +#define IRQ_TIMINGS_MASK	(IRQ_TIMINGS_SIZE - 1)
> +
> +struct irq_timings {
> +	u32 values[IRQ_TIMINGS_SIZE];	/* our circular buffer */
> +	u64 sum;			/* sum of values */
> +	u64 timestamp;			/* latest timestamp */
> +	unsigned int w_index;		/* current buffer index */
> +};
> +
> +struct irq_timings *irqtiming_get_next(int *irq);
> +
> +#endif
> +
>  struct seq_file;
>  int show_interrupts(struct seq_file *p, void *v);
>  int arch_show_interrupts(struct seq_file *p, int prec);
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index dcca77c..f4e29b2 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -12,6 +12,7 @@ struct proc_dir_entry;
>  struct module;
>  struct irq_desc;
>  struct irq_domain;
> +struct irq_timings;
>  struct pt_regs;
>  
>  /**
> @@ -51,6 +52,9 @@ struct irq_desc {
>  	struct irq_data		irq_data;
>  	unsigned int __percpu	*kstat_irqs;
>  	irq_flow_handler_t	handle_irq;
> +#ifdef CONFIG_IRQ_TIMINGS
> +	struct irq_timings __percpu *timings;
> +#endif
>  #ifdef CONFIG_IRQ_PREFLOW_FASTEOI
>  	irq_preflow_handler_t	preflow_handler;
>  #endif
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 3b48dab..392c9f5 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -77,6 +77,9 @@ config GENERIC_MSI_IRQ_DOMAIN
>  config HANDLE_DOMAIN_IRQ
>  	bool
>  
> +config IRQ_TIMINGS
> +	bool
> +
>  config IRQ_DOMAIN_DEBUG
>  	bool "Expose hardware/virtual IRQ mapping via debugfs"
>  	depends on IRQ_DOMAIN && DEBUG_FS
> diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> index 2fc9cbd..9c6d3e8 100644
> --- a/kernel/irq/Makefile
> +++ b/kernel/irq/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
>  obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
>  obj-$(CONFIG_PM_SLEEP) += pm.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
> +obj-$(CONFIG_IRQ_TIMINGS) += timings.o
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index a15b548..cd37536 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -138,6 +138,8 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
>  	unsigned int flags = 0, irq = desc->irq_data.irq;
>  	struct irqaction *action;
>  
> +	handle_timings(desc);
> +
>  	for_each_action_of_desc(desc, action) {
>  		irqreturn_t res;
>  
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index eab521fc..3d100af 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -56,6 +56,7 @@ enum {
>  	IRQS_WAITING		= 0x00000080,
>  	IRQS_PENDING		= 0x00000200,
>  	IRQS_SUSPENDED		= 0x00000800,
> +	IRQS_TIMINGS		= 0x00001000,
>  };
>  
>  #include "debug.h"
> @@ -218,3 +219,44 @@ irq_pm_install_action(struct irq_desc *desc, struct irqaction *action) { }
>  static inline void
>  irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action) { }
>  #endif
> +
> +#ifdef CONFIG_IRQ_TIMINGS
> +static inline int alloc_timings(struct irq_desc *desc)
> +{
> +	desc->timings = alloc_percpu(struct irq_timings);
> +	if (!desc->timings)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline void free_timings(struct irq_desc *desc)
> +{
> +	free_percpu(desc->timings);
> +}
> +
> +static inline void remove_timings(struct irq_desc *desc)
> +{
> +	desc->istate &= ~IRQS_TIMINGS;
> +}
> +
> +static inline void setup_timings(struct irq_desc *desc, struct irqaction *act)
> +{
> +	/*
> +	 * Timers are deterministic, so no need to do any measurement
> +	 * on them.
> +	 */
> +	if (act->flags & __IRQF_TIMER)
> +		return;
> +
> +	desc->istate |= IRQS_TIMINGS;
> +}
> +extern void handle_timings(struct irq_desc *desc);
> +#else
> +static inline int alloc_timings(struct irq_desc *desc) { return 0; }
> +static inline void free_timings(struct irq_desc *desc) {}
> +static inline void handle_timings(struct irq_desc *desc) {}
> +static inline void remove_timings(struct irq_desc *desc) {}
> +static inline void setup_timings(struct irq_desc *desc,
> +				 struct irqaction *act) {};
> +#endif
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
>  
>  static int alloc_descs(unsigned int start, unsigned int cnt, int node,
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 3ddd229..132c2d7 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1343,6 +1343,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  		__enable_irq(desc);
>  	}
>  
> +	setup_timings(desc, new);
> +
>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>  
>  	/*
> @@ -1465,6 +1467,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
>  		irq_settings_clr_disable_unlazy(desc);
>  		irq_shutdown(desc);
>  		irq_release_resources(desc);
> +		remove_timings(desc);
>  	}
>  
>  #ifdef CONFIG_SMP
> diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
> new file mode 100644
> index 0000000..95976fa0
> --- /dev/null
> +++ b/kernel/irq/timings.c
> @@ -0,0 +1,110 @@
> +/*
> + * linux/kernel/irq/timings.c
> + *
> + * Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + */
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/percpu.h>
> +
> +#include "internals.h"
> +
> +/**
> + * handle_timings - stores an irq timing  when an interrupt occurs
> + *
> + * @desc: the irq descriptor
> + *
> + * For all interruptions with their IRQS_TIMINGS flag set, the function
> + * computes the time interval between two interrupt events and store it
> + * in a circular buffer.
> + */
> +void handle_timings(struct irq_desc *desc)
> +{
> +	struct irq_timings *timings;
> +	u64 prev, now, diff;
> +
> +	if (!(desc->istate & IRQS_TIMINGS))
> +		return;
> +
> +	timings = this_cpu_ptr(desc->timings);
> +	now = local_clock();
> +	prev = timings->timestamp;
> +	timings->timestamp = now;
> +
> +	/*
> +	 * If it is the first interrupt of the series, we can't
> +	 * compute an interval, just store the timestamp and exit.
> +	 */
> +	if (unlikely(!prev))
> +		return;
> +
> +	diff = now - prev;
> +
> +	/*
> +	 * microsec (actually 1024th of a milisec) precision is good
> +	 * enough for our purpose.
> +	 */
> +	diff >>= 10;
> +
> +	/*
> +	 * There is no point to store intervals from interrupts more
> +	 * than ~1 second apart. Furthermore that increases the risk
> +	 * of overflowing our variance computation. Reset all values
> +	 * in that case. Otherwise we know the magnitude of diff is
> +	 * well within 32 bits.
> +	 */
> +	if (unlikely(diff > USEC_PER_SEC)) {
> +		memset(timings, 0, sizeof(*timings));
> +		timings->timestamp = now;
> +		return;
> +	}
> +
> +	/* The oldest value corresponds to the next index. */
> +	timings->w_index = (timings->w_index + 1) & IRQ_TIMINGS_MASK;
> +
> +	/*
> +	 * Remove the oldest value from the summing. If this is the
> +	 * first time we go through this array slot, the previous
> +	 * value will be zero and we won't substract anything from the
> +	 * current sum. Hence this code relies on a zero-ed structure.
> +	 */
> +	timings->sum -= timings->values[timings->w_index];
> +	timings->values[timings->w_index] = diff;
> +	timings->sum += diff;
> +}
> +
> +/**
> + * irqtiming_get_next - return the next irq timing
> + *
> + * @int: an integer representing the interrupt number
> + *
> + * Returns a struct irq_timings, NULL if we reach the end of the
> + * interrupts list.
> + */
> +struct irq_timings *irqtiming_get_next(int *irq)
> +{
> +	struct irq_desc *desc;
> +	int next;
> +
> +again:
> +	/* Do a racy lookup of the next allocated irq */
> +	next = irq_get_next_irq(*irq);
> +	if (next >= nr_irqs)
> +		return NULL;
> +
> +	*irq = next + 1;
> +
> +	/*
> +	 * Now lookup the descriptor. It's RCU protected. This
> +	 * descriptor might belong to an uninteresting interrupt or
> +	 * one that is not measured. Look for the next interrupt in
> +	 * that case.
> +	 */
> +	desc = irq_to_desc(next);
> +	if (!desc || !(desc->istate & IRQS_TIMINGS))
> +		goto again;
> +
> +	return this_cpu_ptr(desc->timings);
> +}
> -- 
> 1.9.1
> 
> 

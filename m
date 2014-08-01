From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] [PATCH 1/3] irq: Allow multiple clients to register for
 irq affinity notification
Date: Fri, 01 Aug 2014 16:48:13 +0200
Message-ID: <53DBA8AD.5020605@linaro.org>
References: <1406307334-8288-1-git-send-email-lina.iyer@linaro.org> <1406307334-8288-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:43850 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaHAOsR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 10:48:17 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so4502183wes.15
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 07:48:13 -0700 (PDT)
In-Reply-To: <1406307334-8288-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org
Cc: linus.walleij@linaro.org, arnd.bergmann@linaro.org, rjw@rjwysocki.net, tglx@linutronix.de

On 07/25/2014 06:55 PM, Lina Iyer wrote:
> The current implementation allows only a single notification callback
> whenever the IRQ's SMP affinity is changed. Adding a second notificat=
ion
> punts the existing notifier function out of registration.
>
> Add a list of notifiers, allowing multiple clients to register for ir=
q
> affinity notifications.

As commented before, you should explain why this is needed.

Perhaps, if the patchset is inverted that will be easier to introduce.

1. per cpu pm_qos (code changes to prepare the new features but with th=
e=20
same functionalities)

2. irq affinity change notification

3. new pm_qos requests

I am not a big fan for using the lists, there isn't another solution ?

> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>   drivers/infiniband/hw/qib/qib_iba7322.c |  4 +-
>   include/linux/interrupt.h               | 12 ++++-
>   include/linux/irq.h                     |  1 +
>   include/linux/irqdesc.h                 |  6 ++-
>   kernel/irq/irqdesc.c                    |  1 +
>   kernel/irq/manage.c                     | 77 ++++++++++++++++++++--=
-----------
>   lib/cpu_rmap.c                          |  2 +-
>   7 files changed, 66 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infini=
band/hw/qib/qib_iba7322.c
> index a7eb325..62cb77d 100644
> --- a/drivers/infiniband/hw/qib/qib_iba7322.c
> +++ b/drivers/infiniband/hw/qib/qib_iba7322.c
> @@ -3345,9 +3345,7 @@ static void reset_dca_notifier(struct qib_devda=
ta *dd, struct qib_msix_entry *m)
>   		"Disabling notifier on HCA %d irq %d\n",
>   		dd->unit,
>   		m->msix.vector);
> -	irq_set_affinity_notifier(
> -		m->msix.vector,
> -		NULL);
> +	irq_release_affinity_notifier(m->notifier);
>   	m->notifier =3D NULL;
>   }
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 698ad05..c1e227c 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -203,7 +203,7 @@ static inline int check_wakeup_irqs(void) { retur=
n 0; }
>    * struct irq_affinity_notify - context for notification of IRQ aff=
inity changes
>    * @irq:		Interrupt to which notification applies
>    * @kref:		Reference count, for internal use
> - * @work:		Work item, for internal use
> + * @list:		Add to the notifier list, for internal use
>    * @notify:		Function to be called on change.  This will be
>    *			called in process context.
>    * @release:		Function to be called on release.  This will be
> @@ -214,7 +214,7 @@ static inline int check_wakeup_irqs(void) { retur=
n 0; }
>   struct irq_affinity_notify {
>   	unsigned int irq;
>   	struct kref kref;
> -	struct work_struct work;
> +	struct list_head list;
>   	void (*notify)(struct irq_affinity_notify *, const cpumask_t *mask=
);
>   	void (*release)(struct kref *ref);
>   };
> @@ -265,6 +265,8 @@ extern int irq_set_affinity_hint(unsigned int irq=
, const struct cpumask *m);
>   extern int
>   irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_not=
ify *notify);
>
> +extern int
> +irq_release_affinity_notifier(struct irq_affinity_notify *notify);
>   #else /* CONFIG_SMP */
>
>   static inline int irq_set_affinity(unsigned int irq, const struct c=
pumask *m)
> @@ -295,6 +297,12 @@ irq_set_affinity_notifier(unsigned int irq, stru=
ct irq_affinity_notify *notify)
>   {
>   	return 0;
>   }
> +
> +static inline int
> +irq_release_affinity_notifier(struct irq_affinity_notify *notify)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_SMP */
>
>   /*
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 62af592..2634a48 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -20,6 +20,7 @@
>   #include <linux/errno.h>
>   #include <linux/topology.h>
>   #include <linux/wait.h>
> +#include <linux/list.h>
>
>   #include <asm/irq.h>
>   #include <asm/ptrace.h>
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index 472c021..db3509e 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -31,7 +31,8 @@ struct irq_desc;
>    * @threads_handled_last: comparator field for deferred spurious de=
tection of theraded handlers
>    * @lock:		locking for SMP
>    * @affinity_hint:	hint to user space for preferred irq affinity
> - * @affinity_notify:	context for notification of affinity changes
> + * @affinity_notify:	list of notification clients for affinity chang=
es
> + * @affinity_work:	Work queue for handling affinity change notificat=
ions
>    * @pending_mask:	pending rebalanced interrupts
>    * @threads_oneshot:	bitfield to handle shared oneshot threads
>    * @threads_active:	number of irqaction threads currently running
> @@ -60,7 +61,8 @@ struct irq_desc {
>   	struct cpumask		*percpu_enabled;
>   #ifdef CONFIG_SMP
>   	const struct cpumask	*affinity_hint;
> -	struct irq_affinity_notify *affinity_notify;
> +	struct list_head	affinity_notify;
> +	struct work_struct	affinity_work;
>   #ifdef CONFIG_GENERIC_PENDING_IRQ
>   	cpumask_var_t		pending_mask;
>   #endif
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 1487a12..c95e1f3 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -91,6 +91,7 @@ static void desc_set_defaults(unsigned int irq, str=
uct irq_desc *desc, int node,
>   	for_each_possible_cpu(cpu)
>   		*per_cpu_ptr(desc->kstat_irqs, cpu) =3D 0;
>   	desc_smp_init(desc, node);
> +	INIT_LIST_HEAD(&desc->affinity_notify);
>   }
>
>   int nr_irqs =3D NR_IRQS;
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 88657d7..cd7fc48 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -209,10 +209,9 @@ int irq_set_affinity_locked(struct irq_data *dat=
a, const struct cpumask *mask,
>   		irq_copy_pending(desc, mask);
>   	}
>
> -	if (desc->affinity_notify) {
> -		kref_get(&desc->affinity_notify->kref);
> -		schedule_work(&desc->affinity_notify->work);
> -	}

Could you explain the kref change ?

> +	if (!list_empty(&desc->affinity_notify))
> +		schedule_work(&desc->affinity_work);
> +
>   	irqd_set(data, IRQD_AFFINITY_SET);
>
>   	return ret;
> @@ -248,14 +247,14 @@ EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
>
>   static void irq_affinity_notify(struct work_struct *work)
>   {
> -	struct irq_affinity_notify *notify =3D
> -		container_of(work, struct irq_affinity_notify, work);
> -	struct irq_desc *desc =3D irq_to_desc(notify->irq);
> +	struct irq_desc *desc =3D
> +			container_of(work, struct irq_desc, affinity_work);

Could you put cleanups in separate patches ? This is not directly=20
related to the change of this patch.

>   	cpumask_var_t cpumask;
>   	unsigned long flags;
> +	struct irq_affinity_notify *notify;
>
>   	if (!desc || !alloc_cpumask_var(&cpumask, GFP_KERNEL))
> -		goto out;
> +		return;
>
>   	raw_spin_lock_irqsave(&desc->lock, flags);
>   	if (irq_move_pending(&desc->irq_data))
> @@ -264,11 +263,20 @@ static void irq_affinity_notify(struct work_str=
uct *work)
>   		cpumask_copy(cpumask, desc->irq_data.affinity);
>   	raw_spin_unlock_irqrestore(&desc->lock, flags);
>
> -	notify->notify(notify, cpumask);
> +	list_for_each_entry(notify, &desc->affinity_notify, list) {
> +		/**
> +		 * Check and get the kref only if the kref has not been
> +		 * released by now. Its possible that the reference count
> +		 * is already 0, we dont want to notify those if they are
> +		 * already released.
> +		 */
> +		if (!kref_get_unless_zero(&notify->kref))
> +			continue;
> +		notify->notify(notify, cpumask);
> +		kref_put(&notify->kref, notify->release);
> +	}
>
>   	free_cpumask_var(cpumask);
> -out:
> -	kref_put(&notify->kref, notify->release);
>   }
>
>   /**
> @@ -286,8 +294,6 @@ int
>   irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_not=
ify *notify)
>   {
>   	struct irq_desc *desc =3D irq_to_desc(irq);
> -	struct irq_affinity_notify *old_notify;
> -	unsigned long flags;
>
>   	/* The release function is promised process context */
>   	might_sleep();
> @@ -295,25 +301,37 @@ irq_set_affinity_notifier(unsigned int irq, str=
uct irq_affinity_notify *notify)
>   	if (!desc)
>   		return -EINVAL;
>
> -	/* Complete initialisation of *notify */
> -	if (notify) {
> -		notify->irq =3D irq;
> -		kref_init(&notify->kref);
> -		INIT_WORK(&notify->work, irq_affinity_notify);
> +	if (!notify) {
> +		WARN("%s called with NULL notifier - use irq_release_affinity_noti=
fier function instead.\n",
> +				__func__);
> +		return -EINVAL;
>   	}
>
> -	raw_spin_lock_irqsave(&desc->lock, flags);
> -	old_notify =3D desc->affinity_notify;
> -	desc->affinity_notify =3D notify;
> -	raw_spin_unlock_irqrestore(&desc->lock, flags);
> -
> -	if (old_notify)
> -		kref_put(&old_notify->kref, old_notify->release);
> +	notify->irq =3D irq;
> +	kref_init(&notify->kref);
> +	INIT_LIST_HEAD(&notify->list);
> +	list_add(&desc->affinity_notify, &notify->list);

Is this race free ? It is possible there are two callers of the=20
irq_set_affinity_notifier or=20
irq_set_affinity_notifier/irq_release_affinity_notifier, no ?

>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(irq_set_affinity_notifier);
>
> +/**
> + *	irq_release_affinity_notifier - Remove us from notifications
> + *	@notify: Context for notification
> + */
> +int irq_release_affinity_notifier(struct irq_affinity_notify *notify=
)
> +{
> +	if (!notify)
> +		return -EINVAL;
> +
> +	list_del(&notify->list);
> +	kref_put(&notify->kref, notify->release);

Same comment as above.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(irq_release_affinity_notifier);
> +
>   #ifndef CONFIG_AUTO_IRQ_AFFINITY
>   /*
>    * Generic version of the affinity autoselector.
> @@ -348,6 +366,8 @@ setup_affinity(unsigned int irq, struct irq_desc =
*desc, struct cpumask *mask)
>   		if (cpumask_intersects(mask, nodemask))
>   			cpumask_and(mask, mask, nodemask);
>   	}
> +	INIT_LIST_HEAD(&desc->affinity_notify);
> +	INIT_WORK(&desc->affinity_work, irq_affinity_notify);
>   	irq_do_set_affinity(&desc->irq_data, mask, false);
>   	return 0;
>   }
> @@ -1414,14 +1434,13 @@ EXPORT_SYMBOL_GPL(remove_irq);
>   void free_irq(unsigned int irq, void *dev_id)
>   {
>   	struct irq_desc *desc =3D irq_to_desc(irq);
> +	struct irq_affinity_notify *notify;
>
>   	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
>   		return;
>
> -#ifdef CONFIG_SMP
> -	if (WARN_ON(desc->affinity_notify))
> -		desc->affinity_notify =3D NULL;
> -#endif
> +	list_for_each_entry(notify, &desc->affinity_notify, list)
> +		kref_put(&notify->kref, notify->release);

Same comment as above and probably you should keep the warning.

>   	chip_bus_lock(desc);
>   	kfree(__free_irq(irq, dev_id));
> diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
> index 4f134d8..0c8da50 100644
> --- a/lib/cpu_rmap.c
> +++ b/lib/cpu_rmap.c
> @@ -235,7 +235,7 @@ void free_irq_cpu_rmap(struct cpu_rmap *rmap)
>
>   	for (index =3D 0; index < rmap->used; index++) {
>   		glue =3D rmap->obj[index];
> -		irq_set_affinity_notifier(glue->notify.irq, NULL);
> +		irq_release_affinity_notifier(&glue->notify);
>   	}
>
>   	cpu_rmap_put(rmap);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


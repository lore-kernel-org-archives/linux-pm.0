From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] [PATCH 3/3] QoS: Enhance framework to support cpu/irq specific
 QoS requests
Date: Fri, 01 Aug 2014 17:58:39 +0200
Message-ID: <53DBB92F.60602@linaro.org>
References: <1406307334-8288-1-git-send-email-lina.iyer@linaro.org> <1406307334-8288-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:50504 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaHAP6l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 11:58:41 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so4593998wev.12
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 08:58:40 -0700 (PDT)
In-Reply-To: <1406307334-8288-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org
Cc: linus.walleij@linaro.org, arnd.bergmann@linaro.org, rjw@rjwysocki.net, tglx@linutronix.de, Praveen Chidambaram <pchidamb@codeaurora.org>

On 07/25/2014 06:55 PM, Lina Iyer wrote:
> QoS request for CPU_DMA_LATENCY can be better optimized if the reques=
t
> can be set only for the required cpus and not all cpus. This helps sa=
ve
> power on other cores, while still gauranteeing the quality of service=
=2E
>
> Enhance the QoS constraints data structures to support target value f=
or
> each core. Requests specify if the QoS is applicable to all cores
> (default) or to a selective subset of the cores or to a core(s), that
> the IRQ is affine to.
>
> QoS requests that need to track an IRQ can be set to apply only on th=
e
> cpus to which the IRQ's smp_affinity attribute is set to. The QoS
> framework will automatically track IRQ migration between the cores. T=
he
> QoS is updated to be applied only to the core(s) that the IRQ has bee=
n
> migrated to.
>
> Idle and interested drivers can request a PM QoS value for a constrai=
nt
> across all cpus, or a specific cpu or a set of cpus. Separate APIs ha=
ve
> been added to request for individual cpu or a cpumask.  The default
> behaviour of PM QoS is maintained i.e, requests that do not specify a
> type of the request will continue to be effected on all cores.  Reque=
sts
> that want to specify an affinity of cpu(s) or an irq, can modify the =
PM
> QoS request data structures by specifying the type of the request and
> either the mask of the cpus or the IRQ number depending on the type.
> Updating the request does not reset the type of the request.
>
> The userspace sysfs interface does not support CPU/IRQ affinity.
>
> Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>   Documentation/power/pm_qos_interface.txt |  18 ++++
>   include/linux/pm_qos.h                   |  16 +++
>   kernel/power/qos.c                       | 170 ++++++++++++++++++++=
+++++++++++
>   3 files changed, 204 insertions(+)
>
> diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation=
/power/pm_qos_interface.txt
> index a5da5c7..32b864d 100644
> --- a/Documentation/power/pm_qos_interface.txt
> +++ b/Documentation/power/pm_qos_interface.txt
> @@ -41,6 +41,17 @@ registered notifiers are called only if the target=
 value is now different.
>   Clients of pm_qos need to save the returned handle for future use i=
n other
>   pm_qos API functions.
>
> +The handle is a pm_qos_request object. By default the request object=
 sets the
> +request type to PM_QOS_REQ_ALL_CORES, in which case, the PM QoS requ=
est
> +applies to all cores. However, the driver can also specify a request=
 type to
> +be either of
> +        PM_QOS_REQ_ALL_CORES,
> +        PM_QOS_REQ_AFFINE_CORES,
> +        PM_QOS_REQ_AFFINE_IRQ,
> +
> +Specify the cpumask when type is set to PM_QOS_REQ_AFFINE_CORES and =
specify
> +the IRQ number with PM_QOS_REQ_AFFINE_IRQ.
> +
>   void pm_qos_update_request(handle, new_target_value):
>   Will update the list element pointed to by the handle with the new =
target value
>   and recompute the new aggregated target, calling the notification t=
ree if the
> @@ -54,6 +65,13 @@ the request.
>   int pm_qos_request(param_class):
>   Returns the aggregated value for a given PM QoS class.
>
> +int pm_qos_request_for_cpu(param_class, cpu):
> +Returns the aggregated value for a given PM QoS class for the specif=
ied cpu.
> +
> +int pm_qos_request_for_cpumask(param_class, cpumask):
> +Returns the aggregated value for a given PM QoS class for the specif=
ied
> +cpumask.
> +

You can get rid of 'pm_qos_request_for_cpu' because that will be easy t=
o=20
call 'pm_qos_request_for_cpumask' with cpumask_of(cpu).

IMO, you should split this patch into several. First bring per cpu=20
without adding new apis and then bring one by one the different changes=
=2E

>   int pm_qos_request_active(handle):
>   Returns if the request is still active, i.e. it has not been remove=
d from a
>   PM QoS class constraints list.
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index e1b763d..05d7c46 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -9,6 +9,8 @@
>   #include <linux/miscdevice.h>
>   #include <linux/device.h>
>   #include <linux/workqueue.h>
> +#include <linux/cpumask.h>
> +#include <linux/interrupt.h>
>
>   enum {
>   	PM_QOS_RESERVED =3D 0,
> @@ -40,7 +42,18 @@ enum pm_qos_flags_status {
>   #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
>   #define PM_QOS_FLAG_REMOTE_WAKEUP	(1 << 1)
>
> +enum pm_qos_req_type {
> +	PM_QOS_REQ_ALL_CORES =3D 0,
> +	PM_QOS_REQ_AFFINE_CORES,
> +	PM_QOS_REQ_AFFINE_IRQ,
> +};
> +
>   struct pm_qos_request {
> +	enum pm_qos_req_type type;
> +	struct cpumask cpus_affine;
> +	uint32_t irq;
> +	/* Internal structure members */
> +	struct irq_affinity_notify irq_notify;
>   	struct plist_node node;
>   	int pm_qos_class;
>   	struct delayed_work work; /* for pm_qos_update_request_timeout */
> @@ -80,6 +93,7 @@ enum pm_qos_type {
>   struct pm_qos_constraints {
>   	struct plist_head list;
>   	s32 target_value;	/* Do not change to 64 bit */
> +	s32 target_per_cpu[NR_CPUS];
>   	s32 default_value;
>   	s32 no_constraint_value;
>   	enum pm_qos_type type;
> @@ -127,6 +141,8 @@ void pm_qos_update_request_timeout(struct pm_qos_=
request *req,
>   void pm_qos_remove_request(struct pm_qos_request *req);
>
>   int pm_qos_request(int pm_qos_class);
> +int pm_qos_request_for_cpu(int pm_qos_class, int cpu);
> +int pm_qos_request_for_cpumask(int pm_qos_class, struct cpumask *mas=
k);
>   int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *no=
tifier);
>   int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block =
*notifier);
>   int pm_qos_request_active(struct pm_qos_request *req);
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index d0b9c0f..92d8521 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -41,6 +41,9 @@
>   #include <linux/platform_device.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/delay.h>
>
>   #include <linux/uaccess.h>
>   #include <linux/export.h>
> @@ -65,6 +68,8 @@ static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier)=
;
>   static struct pm_qos_constraints cpu_dma_constraints =3D {
>   	.list =3D PLIST_HEAD_INIT(cpu_dma_constraints.list),
>   	.target_value =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
> +	.target_per_cpu =3D { [0 ... (NR_CPUS - 1)] =3D
> +				PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE },
>   	.default_value =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>   	.no_constraint_value =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>   	.type =3D PM_QOS_MIN,
> @@ -79,6 +84,8 @@ static BLOCKING_NOTIFIER_HEAD(network_lat_notifier)=
;
>   static struct pm_qos_constraints network_lat_constraints =3D {
>   	.list =3D PLIST_HEAD_INIT(network_lat_constraints.list),
>   	.target_value =3D PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> +	.target_per_cpu =3D { [0 ... (NR_CPUS - 1)] =3D
> +				PM_QOS_NETWORK_LAT_DEFAULT_VALUE },
>   	.default_value =3D PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
>   	.no_constraint_value =3D PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
>   	.type =3D PM_QOS_MIN,
> @@ -94,6 +101,8 @@ static BLOCKING_NOTIFIER_HEAD(network_throughput_n=
otifier);
>   static struct pm_qos_constraints network_tput_constraints =3D {
>   	.list =3D PLIST_HEAD_INIT(network_tput_constraints.list),
>   	.target_value =3D PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> +	.target_per_cpu =3D { [0 ... (NR_CPUS - 1)] =3D
> +				PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE },
>   	.default_value =3D PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>   	.no_constraint_value =3D PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>   	.type =3D PM_QOS_MAX,
> @@ -157,6 +166,34 @@ static inline void pm_qos_set_value(struct pm_qo=
s_constraints *c, s32 value)
>   	c->target_value =3D value;
>   }

Wouldn't make sense to create a per_cpu variable pm qos constraints=20
instead of creating an array of cpus ?

> +static inline void pm_qos_set_value_for_cpus(struct pm_qos_constrain=
ts *c)
> +{
> +	struct pm_qos_request *req =3D NULL;
> +	int cpu;
> +	s32 qos_val[NR_CPUS] =3D { [0 ... (NR_CPUS - 1)] =3D c->default_val=
ue };

The kernel stack size is small, IIRC, 2xPAGE_SIZE. NR_CPUS could be big=
=20
(1024). That may lead to a stack overflow on some systems.

> +
> +	plist_for_each_entry(req, &c->list, node) {
> +		for_each_cpu(cpu, &req->cpus_affine) {
> +			switch (c->type) {
> +			case PM_QOS_MIN:
> +				if (qos_val[cpu] > req->node.prio)
> +					qos_val[cpu] =3D req->node.prio;
> +				break;
> +			case PM_QOS_MAX:
> +				if (req->node.prio > qos_val[cpu])
> +					qos_val[cpu] =3D req->node.prio;
> +				break;
> +			default:
> +				BUG();
> +				break;
> +			}
> +		}
> +	}
> +
> +	for_each_possible_cpu(cpu)
> +		c->target_per_cpu[cpu] =3D qos_val[cpu];
> +}
> +
>   /**
>    * pm_qos_update_target - manages the constraints list and calls th=
e notifiers
>    *  if needed
> @@ -206,6 +243,7 @@ int pm_qos_update_target(struct pm_qos_constraint=
s *c,
>
>   	curr_value =3D pm_qos_get_value(c);
>   	pm_qos_set_value(c, curr_value);
> +	pm_qos_set_value_for_cpus(c);
>
>   	spin_unlock_irqrestore(&pm_qos_lock, flags);
>
> @@ -298,6 +336,44 @@ int pm_qos_request(int pm_qos_class)
>   }
>   EXPORT_SYMBOL_GPL(pm_qos_request);
>
> +int pm_qos_request_for_cpu(int pm_qos_class, int cpu)
> +{
> +	return pm_qos_array[pm_qos_class]->constraints->target_per_cpu[cpu]=
;
> +}
> +EXPORT_SYMBOL(pm_qos_request_for_cpu);
> +
> +int pm_qos_request_for_cpumask(int pm_qos_class, struct cpumask *mas=
k)
> +{
> +	unsigned long irqflags;
> +	int cpu;
> +	struct pm_qos_constraints *c =3D NULL;
> +	int val;
> +
> +	spin_lock_irqsave(&pm_qos_lock, irqflags);
> +	c =3D pm_qos_array[pm_qos_class]->constraints;
> +	val =3D c->default_value;
> +
> +	for_each_cpu(cpu, mask) {
> +		switch (c->type) {
> +		case PM_QOS_MIN:
> +			if (c->target_per_cpu[cpu] < val)
> +				val =3D c->target_per_cpu[cpu];
> +			break;
> +		case PM_QOS_MAX:
> +			if (c->target_per_cpu[cpu] > val)
> +				val =3D c->target_per_cpu[cpu];
> +			break;
> +		default:
> +			BUG();
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&pm_qos_lock, irqflags);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(pm_qos_request_for_cpumask);
> +
>   int pm_qos_request_active(struct pm_qos_request *req)
>   {
>   	return req->pm_qos_class !=3D 0;
> @@ -330,6 +406,35 @@ static void pm_qos_work_fn(struct work_struct *w=
ork)
>   	__pm_qos_update_request(req, PM_QOS_DEFAULT_VALUE);
>   }
>
> +static void pm_qos_irq_release(struct kref *ref)
> +{
> +	unsigned long flags;
> +	struct irq_affinity_notify *notify =3D container_of(ref,
> +			struct irq_affinity_notify, kref);
> +	struct pm_qos_request *req =3D container_of(notify,
> +			struct pm_qos_request, irq_notify);
> +
> +	spin_lock_irqsave(&pm_qos_lock, flags);
> +	cpumask_clear(&req->cpus_affine);
> +	spin_unlock_irqrestore(&pm_qos_lock, flags);
> +}
> +
> +static void pm_qos_irq_notify(struct irq_affinity_notify *notify,
> +		const cpumask_t *mask)
> +{
> +	unsigned long flags;
> +	struct pm_qos_request *req =3D container_of(notify,
> +			struct pm_qos_request, irq_notify);
> +	struct pm_qos_constraints *c =3D
> +		pm_qos_array[req->pm_qos_class]->constraints;
> +
> +	spin_lock_irqsave(&pm_qos_lock, flags);
> +	cpumask_copy(&req->cpus_affine, mask);
> +	spin_unlock_irqrestore(&pm_qos_lock, flags);
> +
> +	pm_qos_update_target(c, req, PM_QOS_UPDATE_REQ, req->node.prio);
> +}
> +
>   /**
>    * pm_qos_add_request - inserts new qos request into the list
>    * @req: pointer to a preallocated handle
> @@ -353,6 +458,51 @@ void pm_qos_add_request(struct pm_qos_request *r=
eq,
>   		WARN(1, KERN_ERR "pm_qos_add_request() called for already added r=
equest\n");
>   		return;
>   	}
> +
> +	switch (req->type) {
> +	case PM_QOS_REQ_AFFINE_CORES:
> +		if (cpumask_empty(&req->cpus_affine)) {
> +			req->type =3D PM_QOS_REQ_ALL_CORES;
> +			cpumask_setall(&req->cpus_affine);
> +			WARN(1, KERN_ERR "Affine cores not set for request with affinity =
flag\n");
> +		}
> +		break;
> +
> +	case PM_QOS_REQ_AFFINE_IRQ:
> +		if (irq_can_set_affinity(req->irq)) {
> +			int ret =3D 0;
> +			struct irq_desc *desc =3D irq_to_desc(req->irq);
> +			struct cpumask *mask =3D desc->irq_data.affinity;
> +
> +			/* Get the current affinity */
> +			cpumask_copy(&req->cpus_affine, mask);
> +			req->irq_notify.irq =3D req->irq;
> +			req->irq_notify.notify =3D pm_qos_irq_notify;
> +			req->irq_notify.release =3D pm_qos_irq_release;
> +
> +			ret =3D irq_set_affinity_notifier(req->irq,
> +					&req->irq_notify);
> +			if (ret) {
> +				WARN(1, KERN_ERR "IRQ affinity notify set failed\n");
> +				req->type =3D PM_QOS_REQ_ALL_CORES;
> +				cpumask_setall(&req->cpus_affine);
> +			}
> +		} else {
> +			req->type =3D PM_QOS_REQ_ALL_CORES;
> +			cpumask_setall(&req->cpus_affine);
> +			WARN(1, KERN_ERR "IRQ-%d not set for request with affinity flag\n=
",
> +					req->irq);
> +		}
> +		break;
> +
> +	default:
> +		WARN(1, KERN_ERR "Unknown request type %d\n", req->type);
> +		/* fall through */
> +	case PM_QOS_REQ_ALL_CORES:
> +		cpumask_setall(&req->cpus_affine);
> +		break;
> +	}
> +
>   	req->pm_qos_class =3D pm_qos_class;
>   	INIT_DELAYED_WORK(&req->work, pm_qos_work_fn);
>   	trace_pm_qos_add_request(pm_qos_class, value);
> @@ -426,10 +576,16 @@ void pm_qos_update_request_timeout(struct pm_qo=
s_request *req, s32 new_value,
>    */
>   void pm_qos_remove_request(struct pm_qos_request *req)
>   {
> +	int count =3D 10;
> +
>   	if (!req) /*guard against callers passing in null */
>   		return;
>   		/* silent return to keep pcm code cleaner */
>
> +	/* Remove ourselves from the irq notification */
> +	if (req->type =3D=3D PM_QOS_REQ_AFFINE_IRQ)
> +		irq_release_affinity_notifier(&req->irq_notify);
> +
>   	if (!pm_qos_request_active(req)) {
>   		WARN(1, KERN_ERR "pm_qos_remove_request() called for unknown obje=
ct\n");
>   		return;
> @@ -441,6 +597,20 @@ void pm_qos_remove_request(struct pm_qos_request=
 *req)
>   	pm_qos_update_target(pm_qos_array[req->pm_qos_class]->constraints,
>   			     req, PM_QOS_REMOVE_REQ,
>   			     PM_QOS_DEFAULT_VALUE);
> +
> +	/**
> +	 * The 'release' callback of the notifier would not be called unles=
s
> +	 * there are no active users of the irq_notify object, i.e, kref co=
unt
> +	 * is non-zero. This could happen if there is an active 'notify'
> +	 * callback happening while the pm_qos_remove request is called. Wa=
it
> +	 * until the release callback clears the cpus_affine mask.
> +	 */
> +	if (req->type =3D=3D PM_QOS_REQ_AFFINE_IRQ) {
> +		while (!cpumask_empty(&req->cpus_affine) && count--)
> +			msleep(50);
> +		BUG_ON(!count);
> +	}

You shouldn't use this approach but a locking mechanism.

>   	memset(req, 0, sizeof(*req));
>   }
>   EXPORT_SYMBOL_GPL(pm_qos_remove_request);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


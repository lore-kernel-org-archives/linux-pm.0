From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH v2 2/4] QoS: Enhance framework to support per-cpu PM QoS
 request
Date: Fri, 15 Aug 2014 13:37:32 +0100
Message-ID: <20140815123732.GB2753@e104805>
References: <1407945689-18494-1-git-send-email-lina.iyer@linaro.org>
 <1407945689-18494-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:60483 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaHOMhj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Aug 2014 08:37:39 -0400
In-Reply-To: <1407945689-18494-3-git-send-email-lina.iyer@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Praveen Chidambaram <pchidamb@codeaurora.org>

Hi Lina, some minor nits,

On Wed, Aug 13, 2014 at 05:01:27PM +0100, Lina Iyer wrote:
> QoS request can be better optimized if the request can be set only for
> the required cpus and not all cpus. This helps save power on other
> cores, while still gauranteeing the quality of service on the desired

                     guaranteeing

> cores.
> 
> Add a new enumeration to specify the PM QoS request type. The enums help
> specify what is the intended target cpu of the request.
> 
> Enhance the QoS constraints data structures to support target value for
> each core. Requests specify if the QoS is applicable to all cores
> (default) or to a selective subset of the cores or to a core(s).
> 
> Idle and interested drivers can request a PM QoS value for a constraint
> across all cpus, or a specific cpu or a set of cpus. Separate APIs have
> been added to request for individual cpu or a cpumask.  The default
> behaviour of PM QoS is maintained i.e, requests that do not specify a
> type of the request will continue to be effected on all cores.
> 
> The userspace sysfs interface does not support setting cpumask of a PM
> QoS request.
> 
> Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/power/pm_qos_interface.txt |  16 +++++
>  include/linux/pm_qos.h                   |  13 ++++
>  kernel/power/qos.c                       | 102 +++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
> 
[...]
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index d0b9c0f..27f84a2 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -65,6 +65,8 @@ static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
>  static struct pm_qos_constraints cpu_dma_constraints = {
>  	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list),
>  	.target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
> +	.target_per_cpu = { [0 ... (NR_CPUS - 1)] =
> +				PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE },
>  	.default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>  	.no_constraint_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>  	.type = PM_QOS_MIN,
> @@ -79,6 +81,8 @@ static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
>  static struct pm_qos_constraints network_lat_constraints = {
>  	.list = PLIST_HEAD_INIT(network_lat_constraints.list),
>  	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> +	.target_per_cpu = { [0 ... (NR_CPUS - 1)] =
> +				PM_QOS_NETWORK_LAT_DEFAULT_VALUE },
>  	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
>  	.no_constraint_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
>  	.type = PM_QOS_MIN,
> @@ -94,6 +98,8 @@ static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
>  static struct pm_qos_constraints network_tput_constraints = {
>  	.list = PLIST_HEAD_INIT(network_tput_constraints.list),
>  	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> +	.target_per_cpu = { [0 ... (NR_CPUS - 1)] =
> +				PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE },
>  	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>  	.no_constraint_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>  	.type = PM_QOS_MAX,
> @@ -157,6 +163,43 @@ static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
>  	c->target_value = value;
>  }
>  
> +static inline void pm_qos_set_value_for_cpus(struct pm_qos_constraints *c)
> +{
> +	struct pm_qos_request *req = NULL;
> +	int cpu;
> +	s32 *qos_val;
> +
> +	qos_val = kcalloc(NR_CPUS, sizeof(*qos_val), GFP_KERNEL);
> +	if (!qos_val) {
> +		WARN("%s: No memory for PM QoS\n", __func__);
> +		return;
> +	}
> +
> +	for_each_possible_cpu(cpu)
> +		qos_val[cpu] = c->default_value;
> +
> +	plist_for_each_entry(req, &c->list, node) {
> +		for_each_cpu(cpu, &req->cpus_affine) {
> +			switch (c->type) {
> +			case PM_QOS_MIN:
> +				if (qos_val[cpu] > req->node.prio)
> +					qos_val[cpu] = req->node.prio;
> +				break;
> +			case PM_QOS_MAX:
> +				if (req->node.prio > qos_val[cpu])
> +					qos_val[cpu] = req->node.prio;
> +				break;
> +			default:
> +				BUG();
> +				break;
> +			}
> +		}
> +	}
> +
> +	for_each_possible_cpu(cpu)
> +		c->target_per_cpu[cpu] = qos_val[cpu];
> +}
> +
>  /**
>   * pm_qos_update_target - manages the constraints list and calls the notifiers
>   *  if needed
> @@ -206,6 +249,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c,
>  
>  	curr_value = pm_qos_get_value(c);
>  	pm_qos_set_value(c, curr_value);
> +	pm_qos_set_value_for_cpus(c);
>  
>  	spin_unlock_irqrestore(&pm_qos_lock, flags);
>  
> @@ -298,6 +342,44 @@ int pm_qos_request(int pm_qos_class)
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_request);
>  
> +int pm_qos_request_for_cpu(int pm_qos_class, int cpu)
> +{
> +	return pm_qos_array[pm_qos_class]->constraints->target_per_cpu[cpu];
> +}
> +EXPORT_SYMBOL(pm_qos_request_for_cpu);
> +
> +int pm_qos_request_for_cpumask(int pm_qos_class, struct cpumask *mask)
> +{
> +	unsigned long irqflags;
> +	int cpu;
> +	struct pm_qos_constraints *c = NULL;
> +	int val;
> +
> +	spin_lock_irqsave(&pm_qos_lock, irqflags);
> +	c = pm_qos_array[pm_qos_class]->constraints;
> +	val = c->default_value;
> +
> +	for_each_cpu(cpu, mask) {
> +		switch (c->type) {
> +		case PM_QOS_MIN:
> +			if (c->target_per_cpu[cpu] < val)
> +				val = c->target_per_cpu[cpu];
> +			break;
> +		case PM_QOS_MAX:
> +			if (c->target_per_cpu[cpu] > val)
> +				val = c->target_per_cpu[cpu];
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
>  int pm_qos_request_active(struct pm_qos_request *req)
>  {
>  	return req->pm_qos_class != 0;
> @@ -353,6 +435,24 @@ void pm_qos_add_request(struct pm_qos_request *req,
>  		WARN(1, KERN_ERR "pm_qos_add_request() called for already added request\n");
>  		return;
>  	}
> +
> +	switch (req->type) {
> +	case PM_QOS_REQ_AFFINE_CORES:
> +		if (cpumask_empty(&req->cpus_affine)) {
> +			req->type = PM_QOS_REQ_ALL_CORES;
> +			cpumask_setall(&req->cpus_affine);
> +			WARN(1, KERN_ERR "Affine cores not set for request with affinity flag\n");
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
>  	req->pm_qos_class = pm_qos_class;
>  	INIT_DELAYED_WORK(&req->work, pm_qos_work_fn);
>  	trace_pm_qos_add_request(pm_qos_class, value);
> @@ -426,6 +526,7 @@ void pm_qos_update_request_timeout(struct pm_qos_request *req, s32 new_value,
>   */
>  void pm_qos_remove_request(struct pm_qos_request *req)
>  {
> +

Unnecessary newline added.

>  	if (!req) /*guard against callers passing in null */
>  		return;
>  		/* silent return to keep pcm code cleaner */
> @@ -441,6 +542,7 @@ void pm_qos_remove_request(struct pm_qos_request *req)
>  	pm_qos_update_target(pm_qos_array[req->pm_qos_class]->constraints,
>  			     req, PM_QOS_REMOVE_REQ,
>  			     PM_QOS_DEFAULT_VALUE);
> +

ditto.  Cheers,
Javi

>  	memset(req, 0, sizeof(*req));
>  }
>  EXPORT_SYMBOL_GPL(pm_qos_remove_request);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


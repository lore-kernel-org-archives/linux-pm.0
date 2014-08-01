From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC] [PATCH 3/3] QoS: Enhance framework to support cpu/irq
 specific QoS requests
Date: Fri, 1 Aug 2014 11:11:31 -0600 (MDT)
Message-ID: <alpine.OSX.2.03.1408011103100.59887@ilina-mac.local>
References: <1406307334-8288-1-git-send-email-lina.iyer@linaro.org> <1406307334-8288-4-git-send-email-lina.iyer@linaro.org> <53DBB92F.60602@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:45399 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaHARLf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 13:11:35 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5873172pdj.40
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 10:11:34 -0700 (PDT)
In-Reply-To: <53DBB92F.60602@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org, linus.walleij@linaro.org, arnd.bergmann@linaro.org, rjw@rjwysocki.net, tglx@linutronix.de, Praveen Chidambaram <pchidamb@codeaurora.org>

On Fri, 1 Aug 2014, Daniel Lezcano wrote:

> On 07/25/2014 06:55 PM, Lina Iyer wrote:
>> +int pm_qos_request_for_cpumask(param_class, cpumask):
>> +Returns the aggregated value for a given PM QoS class for the specified
>> +cpumask.
>> +
>
> You can get rid of 'pm_qos_request_for_cpu' because that will be easy to call 
> 'pm_qos_request_for_cpumask' with cpumask_of(cpu).
Sure, but pm_qos_request_for_cpu() returns without locking which the 
-for_cpu_mask() cannot. Is that still desirable?

>
> IMO, you should split this patch into several. First bring per cpu without 
> adding new apis and then bring one by one the different changes.
Will do.

>>   	.no_constraint_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>>   	.type = PM_QOS_MAX,
>> @@ -157,6 +166,34 @@ static inline void pm_qos_set_value(struct 
>> pm_qos_constraints *c, s32 value)
>>   	c->target_value = value;
>>   }
>
> Wouldn't make sense to create a per_cpu variable pm qos constraints instead 
> of creating an array of cpus ?
Sure. But we most likely would not access it from the respective cpu. But 
can be done.

>
>> +static inline void pm_qos_set_value_for_cpus(struct pm_qos_constraints *c)
>> +{
>> +	struct pm_qos_request *req = NULL;
>> +	int cpu;
>> +	s32 qos_val[NR_CPUS] = { [0 ... (NR_CPUS - 1)] = c->default_value };
>
> The kernel stack size is small, IIRC, 2xPAGE_SIZE. NR_CPUS could be big 
> (1024). That may lead to a stack overflow on some systems.
>
Good point. I will allocate this.

>> +	 * there are no active users of the irq_notify object, i.e, kref 
>> count
>> +	 * is non-zero. This could happen if there is an active 'notify'
>> +	 * callback happening while the pm_qos_remove request is called. Wait
>> +	 * until the release callback clears the cpus_affine mask.
>> +	 */
>> +	if (req->type == PM_QOS_REQ_AFFINE_IRQ) {
>> +		while (!cpumask_empty(&req->cpus_affine) && count--)
>> +			msleep(50);
>> +		BUG_ON(!count);
>> +	}
>
> You shouldn't use this approach but a locking mechanism.
>
Okay, will change.


From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 2/4] QoS: Enhance framework to support per-cpu PM QoS
 request
Date: Mon, 18 Aug 2014 18:34:05 -0600
Message-ID: <20140819003405.GB52513@ilina-mac.local>
References: <1407945689-18494-1-git-send-email-lina.iyer@linaro.org>
 <1407945689-18494-3-git-send-email-lina.iyer@linaro.org>
 <7h4mx9wdxe.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48765 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbaHSAeJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 20:34:09 -0400
Received: by mail-ie0-f178.google.com with SMTP id rd18so267563iec.23
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 17:34:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7h4mx9wdxe.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: daniel.lezcano@linaro.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, tglx@linutronix.de, rjw@rjwysocki.net, Praveen Chidambaram <pchidamb@codeaurora.org>

On Mon, Aug 18, 2014 at 04:55:41PM -0700, Kevin Hilman wrote:
>Hi Lina,
>
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> QoS request can be better optimized if the request can be set only for
>> the required cpus and not all cpus. This helps save power on other
>> cores, while still gauranteeing the quality of service on the desired
>> cores.
>>
>> Add a new enumeration to specify the PM QoS request type. The enums help
>> specify what is the intended target cpu of the request.
>>
>> Enhance the QoS constraints data structures to support target value for
>> each core. Requests specify if the QoS is applicable to all cores
>> (default) or to a selective subset of the cores or to a core(s).
>>
>> Idle and interested drivers can request a PM QoS value for a constraint
>> across all cpus, or a specific cpu or a set of cpus. Separate APIs have
>> been added to request for individual cpu or a cpumask.  The default
>> behaviour of PM QoS is maintained i.e, requests that do not specify a
>> type of the request will continue to be effected on all cores.
>>
>> The userspace sysfs interface does not support setting cpumask of a PM
>> QoS request.
>>
>> Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
>I agree this is a needed feature.  I didn't study it in detail yet, but
>after a quick glance, it looks like a good approach.
>
>However, I did start to wonder how this will behave in the context of
>the hotplug.  For example, what if a constraint is setup with a cpumask,
>then one of those CPUs is hotplugged away.
>
Thanks for bringing it up. I forgot to mention this in the series, but
well, it can be addressed.

When a core is hotplugged, the IRQ migrates to the next online in the
smp_affinity. The QoS code would work in the hotplug case as well, with
a simple change. The current code does not send affinity_notifications
correctly because of a direct call to irq_chip->irq_set_affinity()
instead of calling the generic irq affinity api.

This is the simple change that needs to be made. I will submit a patch
for that.

In arm64/kernel/irq.c 

-       c = irq_data_get_irq_chip(d);
-       if (!c->irq_set_affinity)
-               pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-       else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
-               cpumask_copy(d->affinity, affinity);
-
-       return ret;
+       return __irq_set_affinity_locked(d, affinity) == 0;



>Kevin

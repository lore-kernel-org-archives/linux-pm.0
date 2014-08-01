From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC] [PATCH 1/3] irq: Allow multiple clients to register for
 irq affinity notification
Date: Fri, 01 Aug 2014 09:26:43 -0600
Message-ID: <53DBB1B3.1050909@linaro.org>
References: <1406307334-8288-1-git-send-email-lina.iyer@linaro.org> <1406307334-8288-2-git-send-email-lina.iyer@linaro.org> <53DBA8AD.5020605@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:47936 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaHAP0q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 11:26:46 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so5718179pdj.36
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 08:26:46 -0700 (PDT)
In-Reply-To: <53DBA8AD.5020605@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linus.walleij@linaro.org, arnd.bergmann@linaro.org, rjw@rjwysocki.net, tglx@linutronix.de, linux-pm@vger.kernel.org

On Fri Aug  1 08:48:13 2014, Daniel Lezcano wrote:
> As commented before, you should explain why this is needed.
>
> Perhaps, if the patchset is inverted that will be easier to introduce.
>
> 1. per cpu pm_qos (code changes to prepare the new features but with
> the same functionalities)
>
> 2. irq affinity change notification
>
> 3. new pm_qos requests
>
> I am not a big fan for using the lists, there isn't another solution ?
I will reorganize the patches. Even in the absence of the PM QoS 
changes, the IRQ affinity notifier changes makes sense, just to break 
the assumption that there could possibly be only one notifier callback.

I will see what other framework suits better than the list here. Its 
very easy to reuse existing data structure with lists.


>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 88657d7..cd7fc48 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -209,10 +209,9 @@ int irq_set_affinity_locked(struct irq_data
>> *data, const struct cpumask *mask,
>>           irq_copy_pending(desc, mask);
>>       }
>>
>> -    if (desc->affinity_notify) {
>> -        kref_get(&desc->affinity_notify->kref);
>> -        schedule_work(&desc->affinity_notify->work);
>> -    }
>
> Could you explain the kref change ?
Since there was only one possible notification object, the notifier 
object had a kref, that would help release the notifier object if 
another object register or the IRQ desc went away. The kref object also 
helped the case, where a work was scheduled to notify and the driver 
tried to de-register the notification.
I have not changed the place of the kref.
But since, there could be multiple notifications sent out, doing a 
kref_get before schedule does not make much sense. Which object do we 
use to do a kref_get()? Hence the kref_get_unless_zero(), which ensures 
that I notify only the drivers that still have a registered (kref count 
 > 0) notifier callback.

>
>> +    if (!list_empty(&desc->affinity_notify))
>> +        schedule_work(&desc->affinity_work);
>> +
>>       irqd_set(data, IRQD_AFFINITY_SET);
>>
>>       return ret;
>> @@ -248,14 +247,14 @@ EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
>>
>>   static void irq_affinity_notify(struct work_struct *work)
>>   {
>> -    struct irq_affinity_notify *notify =
>> -        container_of(work, struct irq_affinity_notify, work);
>> -    struct irq_desc *desc = irq_to_desc(notify->irq);
>> +    struct irq_desc *desc =
>> +            container_of(work, struct irq_desc, affinity_work);
>
> Could you put cleanups in separate patches ? This is not directly
> related to the change of this patch.
It is directly related to this patch. The current code uses a single 
irq_affinity_notify object, so it can get a notify object from the 
parent of the work object and thereby the irq_desc object from the irq 
number. I had to use another way to get the same irq_desc object.


>> -    if (old_notify)
>> -        kref_put(&old_notify->kref, old_notify->release);
>> +    notify->irq = irq;
>> +    kref_init(&notify->kref);
>> +    INIT_LIST_HEAD(&notify->list);
>> +    list_add(&desc->affinity_notify, &notify->list);
>
> Is this race free ? It is possible there are two callers of the
> irq_set_affinity_notifier or
> irq_set_affinity_notifier/irq_release_affinity_notifier, no ?
Hmm... You are right. May need a lock around the list.


>> +    list_del(&notify->list);
>> +    kref_put(&notify->kref, notify->release);
>
> Same comment as above.
Lock may be needed.

>> -#endif
>> +    list_for_each_entry(notify, &desc->affinity_notify, list)
>> +        kref_put(&notify->kref, notify->release);
>
> Same comment as above and probably you should keep the warning.
Okay.


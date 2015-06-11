From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 2/3] PM / Domains: Support atomic PM domains
Date: Thu, 11 Jun 2015 23:13:09 +0200
Message-ID: <CAPDyKFp=cEXnroiMPbXs9YVtiuZKBP38Qow3fcVU8LTcZCoEFg@mail.gmail.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
	<1433456946-53296-3-git-send-email-lina.iyer@linaro.org>
	<CAPDyKFqqQS+-0guT4+vZ9Y38ztxPeEgENLy_yqFts09z0ZwgJA@mail.gmail.com>
	<20150611194709.GD1103@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33966 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbbFKVNJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 17:13:09 -0400
Received: by qkhp85 with SMTP id p85so1210763qkh.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 14:13:09 -0700 (PDT)
In-Reply-To: <20150611194709.GD1103@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>

[...]

>>> @@ -387,7 +452,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain
>>> *genpd)
>>>                         return -EBUSY;
>>>
>>>                 if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
>>> -                   || pdd->dev->power.irq_safe))
>>> +                       || (pdd->dev->power.irq_safe &&
>>> !genpd->irq_safe)))
>>
>>
>> This deserves a comment in the code.
>>
> This check should simplify to
>                 if (!pm_runtime_suspended(pdd->dev))
>
> The other connditions seem unnecessary just to determine if the devices are
> suspended.
>
> Do you see any problem with that?

I am not sure, need to think a bit more about it. Anyway, I wouldn't
do the "simplification" in $subject patch, since it's a related to
different topic.

[...]

>>> @@ -478,12 +543,8 @@ static int pm_genpd_runtime_suspend(struct device
>>> *dev)
>>>         if (IS_ERR(genpd))
>>>                 return -EINVAL;
>>>
>>> -       /*
>>> -        * We can't allow to power off the PM domain if it holds an
>>> irq_safe
>>> -        * device. That's beacuse we use mutexes to protect data while
>>> power
>>> -        * off and on the PM domain, thus we can't execute in atomic
>>> context.
>>> -        */
>>> -       if (dev->power.irq_safe)
>>> +       /* We can't allow to power off a domain that is also not irq
>>> safe. */
>>
>>
>> I wouldn't mind to keep some more pieces of the earlier comment, since
>> it explains a bit more of the *why*. Could you try to rephrase this
>> comment in that regard?
>>
>>> +       if (dev->power.irq_safe && !genpd->irq_safe)
>>
>>
>> This looks correct...
>>
> Apparently not the best place to check this. We should still allow
> runtime suspend of the device, irrespective of whether the domain is IRQ
> safe or not and this check here is incorrect.

You are absolutely correct!

That change is actually done as a part of the patch I posted [1],
which $subject patch is based upon.

Earlier we could only invoke the ->stop|start() callbacks for an IRQ
safe device. According to the changes made in [1], we are now able to
also invoke the ->runtime_suspend|resume() callbacks. Yet another
positive "side effect". I will cook a v4 and post a new version to fix
this.

>
>>>                 return -EBUSY;
>>>
>>>         stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
>>> @@ -500,11 +561,19 @@ static int pm_genpd_runtime_suspend(struct device
>>> *dev)
>>>                 return ret;
>>>         }
>>>
>>> -       mutex_lock(&genpd->lock);
>>> +       /*
>>> +        * If power.irq_safe is set, this routine will be run with
>>> interrupts
>>> +        * off, so suspend only if the power domain is irq_safe.
>>> +        */
>>> +       if (dev->power.irq_safe && !genpd->irq_safe)
>>> +               return 0;
>>
>>
>> ... but this doesn't. You have already returned -EBUSY above for this
>> case.
>>
> This is probably more appropriate, as we want to skip locking the
> domain, because it may be in atomic context and the domain may use
> mutexes to lock.

Yep.

>
> I feel like, we miss out an opportunity here to power off the domain, if
> device is IRQ safe while the domain is not, but the function is called
> from a process context. I am not sure how to check that correctly, yet.

You may be able to power off the PM domain for some cases, yes. But...
if you do that, how would you then be able to power on the PM domain
from atomic context via pm_genpd_runtime_resume()?

[...]

[1]
http://www.spinics.net/lists/arm-kernel/msg424994.html

Kind regards
Uffe

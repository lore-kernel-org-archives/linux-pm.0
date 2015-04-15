From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH 1/2] [RFC] PM / Domains: add multiple states
Date: Wed, 15 Apr 2015 14:30:44 +0200
Message-ID: <552E59F4.4080008@baylibre.com>
References: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>	<1428507725-12205-2-git-send-email-ahaslam@baylibre.com>	<CAPDyKFoSvY=G7PQ5EnacTDfmuxYw398A0h_TV--6E9exXJv-cg@mail.gmail.com>	<552B9BAD.9050809@baylibre.com> <CAPDyKFrjzF0cmvCXo7PqJ6zhLJ+DPBimtekvANDzoZgLRbuS-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36907 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbbDOMas (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 08:30:48 -0400
Received: by widdi4 with SMTP id di4so58298066wid.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2015 05:30:47 -0700 (PDT)
In-Reply-To: <CAPDyKFrjzF0cmvCXo7PqJ6zhLJ+DPBimtekvANDzoZgLRbuS-Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>

Hi Uffe,

>>
>> The idea is to add support to platforms where a power domain can be put into
>> intermediate low power modes (retention), and not just on or off. context
>> may be lost for only a subset of registers depending on how deep the
>> retantion state is. Also the wakeup/sleep latency
>> would differ. a  device constraint may not allow for a domain to go to off,
>> but it may allow a Retention state.
>
> These registers you are talking about, are those coupled with the PM
> domain and/or the actual devices within the PM domain?
>
> Normally, save/restore of device's registers are handled from
> driver's/subsystem's (bus) runtime PM callbacks and not from the PM
> domain. That's why I wonder about the details.

They are coupled with the devices. maybe a conceptual question, but i 
think each platform can choose to implement/use certain device registers 
with retention flip flops, which may not be the case for all platforms 
that use the same device and driver. in this case, save and restore 
becomes a platform issue and not a driver's?

if platforms define the low power states of a power domain, and they
define what context is lost, i guess its hard to know from a cross 
platform driver what is lost and what should be restored.

Maybe its easier if drivers would just test if the context is lost
and restore all context if it is.

>
>>
>> I tested the patch using a dummy driver that would register several devices,
>> and genpds, some of them would be subdomains, so that i could test if the
>> most restrictive constraint on a genpd was respected.
>> in my case these callbacks are not doing anything.
>>
>>
>>>
>>>>           .dev_ops.save_state = dev_callback_save,
>>>>           .dev_ops.restore_state = dev_callback_restore,
>>>
>>>
>>> ...and some more information about these as well, please.
>>
>>
>> im not sure i understood these functions correctly.
>>
>> my thought is that the arch would implement these functions to
>> save/restore the registers it needs for a given power domain.
>> i added an extra argument to save and restore so the implementation
>> would use this information to decide what is needed to save and restore.
>
> As default genpd assigns these callbacks to
> pm_genpd_default_save|restore_state().
>
> This is a simplified description of what they do:
>
> When all devices within a PM domain is "idle" (no runtime PM reference
> count exists for any device within the PM domain),
> pm_genpd_default_save() will be invoked to have it walk the hierarchy
> of the runtime PM suspend callbacks. The one picked, will then have to
> deal with saving register context and other necessary operations to
> put the device into low power state.
>
> Vice verse happens for pm_genpd_default_restore_state().
>
>>
>> again these were on my dummy driver, so they are not
>> doing anything, in my case.
>>
>
>   [...]
>
>>>> +static int pm_genpd_default_restore_state(struct device *dev, int state)
>>>
>>>
>>> Why change this?
>>
>>
>>
>> so that the driver can save or not context depending on what state is beeing
>> entered. also, there may be a subset of registers to save. but again, im not
>> sure this was the intended purpose of these functions.
>> i could not find examples of someone that uses them.
>
> Then I first think you need to consider how to propagate this state to
> the driver, because there are no way of doing that today.


How about if the genpd state had a flag "state_looses_context", defined 
in by the platform. and runtime_pm a flag such as "is_context_lost".

then, when genpd tries to go into one of the state that looses context, 
it would set the runtime_pm flag for each device.

the device/bus could then query this flag on their resume callback
to execute or not the restore.


i guess we would have to  save context always, and restore only if 
context was lost", otherwise if genpd tries to go to a state that looses 
context and the context was not saved, the suspended device would have 
to be woken up to save their context.

Regards
Axel

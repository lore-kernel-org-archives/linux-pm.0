From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] [RFC] PM / Domains: add multiple states
Date: Thu, 16 Apr 2015 15:05:15 +0200
Message-ID: <CAPDyKFo9W=AT3TO4T-Sdc7VTsRocA4o7JQiCep=ZNOPmS0k9cA@mail.gmail.com>
References: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>
	<1428507725-12205-2-git-send-email-ahaslam@baylibre.com>
	<CAPDyKFoSvY=G7PQ5EnacTDfmuxYw398A0h_TV--6E9exXJv-cg@mail.gmail.com>
	<552B9BAD.9050809@baylibre.com>
	<CAPDyKFrjzF0cmvCXo7PqJ6zhLJ+DPBimtekvANDzoZgLRbuS-Q@mail.gmail.com>
	<552E59F4.4080008@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34549 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097AbbDPNFQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 09:05:16 -0400
Received: by qkgx75 with SMTP id x75so122607636qkg.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2015 06:05:15 -0700 (PDT)
In-Reply-To: <552E59F4.4080008@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>

On 15 April 2015 at 14:30, Axel Haslam <ahaslam@baylibre.com> wrote:
> Hi Uffe,
>
>>>
>>> The idea is to add support to platforms where a power domain can be put
>>> into
>>> intermediate low power modes (retention), and not just on or off. context
>>> may be lost for only a subset of registers depending on how deep the
>>> retantion state is. Also the wakeup/sleep latency
>>> would differ. a  device constraint may not allow for a domain to go to
>>> off,
>>> but it may allow a Retention state.
>>
>>
>> These registers you are talking about, are those coupled with the PM
>> domain and/or the actual devices within the PM domain?
>>
>> Normally, save/restore of device's registers are handled from
>> driver's/subsystem's (bus) runtime PM callbacks and not from the PM
>> domain. That's why I wonder about the details.
>
>
> They are coupled with the devices. maybe a conceptual question, but i think
> each platform can choose to implement/use certain device registers with
> retention flip flops, which may not be the case for all platforms that use
> the same device and driver. in this case, save and restore becomes a
> platform issue and not a driver's?
>
> if platforms define the low power states of a power domain, and they
> define what context is lost, i guess its hard to know from a cross platform
> driver what is lost and what should be restored.
>
> Maybe its easier if drivers would just test if the context is lost
> and restore all context if it is.

That seems like a nice simplification.

I would even consider the option to _always_ save and restore the
context. No matter if it was lost or not. At least that is how those
drivers I have been working on does it.

Just reading and writing a some registers should in most cases not
introduce a noticeable latency. Of course it will vary between device
and SOC.

Anyway, if these latencies becomes non neglectable, drivers can use
the pm_runtime_use_autosuspend() feature to improve behaviour.

[...]

>>>
>>> so that the driver can save or not context depending on what state is
>>> beeing
>>> entered. also, there may be a subset of registers to save. but again, im
>>> not
>>> sure this was the intended purpose of these functions.
>>> i could not find examples of someone that uses them.
>>
>>
>> Then I first think you need to consider how to propagate this state to
>> the driver, because there are no way of doing that today.
>
>
>
> How about if the genpd state had a flag "state_looses_context", defined in
> by the platform. and runtime_pm a flag such as "is_context_lost".
>
> then, when genpd tries to go into one of the state that looses context, it
> would set the runtime_pm flag for each device.
>
> the device/bus could then query this flag on their resume callback
> to execute or not the restore.

I would like us to avoid this change, but if the latency do become a
real issue we could look into it.

>
>
> i guess we would have to  save context always, and restore only if context
> was lost", otherwise if genpd tries to go to a state that looses context and
> the context was not saved, the suspended device would have to be woken up to
> save their context.

Correct.

So what do you think of always saving and restoring context, would
that work for your case?

Kind regards
Uffe

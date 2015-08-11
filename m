From: Kevin Hilman <khilman@kernel.org>
Subject: Re: Q: cpuidle results in degredation in ethernet performance ?
Date: Tue, 11 Aug 2015 08:19:55 -0700
Message-ID: <7h8u9hsvhg.fsf@deeprootsystems.com>
References: <CAJ2oMhKw0gpFMKOd-iYe_hYh56Q62XgpW+MJmyiGhdkGn1RTMg@mail.gmail.com>
	<55C0CC17.604@linaro.org>
	<CAJ2oMhJgj02yzGQEqBZW1Fbdc1GEv0-4-NBOt97Mfdiz=tDXSg@mail.gmail.com>
	<55C1D76B.9000006@linaro.org> <7hio8msri4.fsf@deeprootsystems.com>
	<CAJ2oMhJGkdmDe6TSM3H=98L_dx9Uq+52o3Y_jYuLEGtNr-cY5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33444 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbHKPT5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 11:19:57 -0400
Received: by pabyb7 with SMTP id yb7so132320658pab.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 08:19:57 -0700 (PDT)
In-Reply-To: <CAJ2oMhJGkdmDe6TSM3H=98L_dx9Uq+52o3Y_jYuLEGtNr-cY5w@mail.gmail.com>
	(Ran Shalit's message of "Tue, 11 Aug 2015 09:39:09 +0300")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

Ran Shalit <ranshalit@gmail.com> writes:

> On Tue, Aug 11, 2015 at 1:33 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>>
>>> On 08/04/2015 05:24 PM, Ran Shalit wrote:
>>>> On Tue, Aug 4, 2015 at 5:28 PM, Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> wrote:
>>>>> On 08/01/2015 09:34 PM, Ran Shalit wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> Maybe if someone here understands cpuidel he can help me...
>>>>>>
>>>>>> I am using omap, with cpuidel and I have some strange behaviour only
>>>>>> when cpuidle is used:
>>>>>> 1.  I test ethernet bandwidth with iperf
>>>>>> 2. With large packet test (16k), I get same bandwidth in version with
>>>>>> cpuidle support as in version without cpuidel supported.
>>>>>> 3. With small packet test (<2000 bytes), I get high degredation in
>>>>>> performance in version with cpuidle. On viewing statistics I see that
>>>>>> the cpu gets into cpu inactive state (C3 state -  not retention yet,
>>>>>> only cpu not active). I guess this is the cuase of the degredation.
>>>>>> With large packets I get no increment in C3 state usage.
>>>>>> 4. I think that menu governer behaviour might explain this, but I
>>>>>> don't understand it deeply enough.
>>>>>>
>>>>>> Can anyone shed a light on this ? Is there anything I can do to overcome
>>>>>> this ?
>>>>>
>>>>>
>>>>> Is an omap3 or omap4 ?
>>>>>
>>>>>
>>>> Hi,
>>>>
>>>> It is omap3530.
>>>
>>> Ok, thanks.
>>>
>>> I was asking for the omap version because the cpuidle driver is
>>> different and behaves differently. The core are coupled and the IPI
>>> enters in the next prediction equation.
>>
>> What board are you using, what is network chip you're using, and how is
>> it wired to the OMAP3530, in particular the IRQ line.
>>
>> Lots depends on whether the eth NIC is capable of waking the OMAP from
>> deep sleep. Typically, this is done by wiring the NIC IRQ to a
>> wakeup-capable GPIO.
>>
>> If the NIC is not waking the OMAP from deep sleep, then the performance
>> degradation could also happen because the packets are not processed
>> until some other timer fires and wakes up the OMAP idle.
>>
>> Kevin
>
> I am using omap3530 with smsc911 ethernet controller.
> I need to check if there is some IRQ as you mentioned, but I guess
> there must be some, otherwise it wouldn't wakeup when doing ping from
> host after it gets into sleep, Right ?

Well, there are other wakeup sources, specifically timers, that may be
causing the wakeup from deep sleep, after which the NIC IRQ would fire
and the ping would be replied to.    So it's entirely possible that the
NIC is not wired up as wakeup capable but you'd still be able to ping.

> According to the given answers on this issue, it seems there is
> nothing I can really do with this issue, Right ?

Well, there will likely always be some slight degradation in performance
because the deeper idle states take longer to exit.

Note there is also a way from userspace to constrain the deepest idle state
that will be chosen.  You could always use that during your performance
critical tasks to limit the depth of the idle.

Kevin

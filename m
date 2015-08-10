From: Kevin Hilman <khilman@kernel.org>
Subject: Re: Q: cpuidle results in degredation in ethernet performance ?
Date: Mon, 10 Aug 2015 15:33:39 -0700
Message-ID: <7hio8msri4.fsf@deeprootsystems.com>
References: <CAJ2oMhKw0gpFMKOd-iYe_hYh56Q62XgpW+MJmyiGhdkGn1RTMg@mail.gmail.com>
	<55C0CC17.604@linaro.org>
	<CAJ2oMhJgj02yzGQEqBZW1Fbdc1GEv0-4-NBOt97Mfdiz=tDXSg@mail.gmail.com>
	<55C1D76B.9000006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35303 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbHJWdm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 18:33:42 -0400
Received: by pacgr6 with SMTP id gr6so35699827pac.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 15:33:42 -0700 (PDT)
In-Reply-To: <55C1D76B.9000006@linaro.org> (Daniel Lezcano's message of "Wed,
	05 Aug 2015 11:29:15 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ran Shalit <ranshalit@gmail.com>, linux-pm@vger.kernel.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 08/04/2015 05:24 PM, Ran Shalit wrote:
>> On Tue, Aug 4, 2015 at 5:28 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>> On 08/01/2015 09:34 PM, Ran Shalit wrote:
>>>>
>>>> Hello,
>>>>
>>>> Maybe if someone here understands cpuidel he can help me...
>>>>
>>>> I am using omap, with cpuidel and I have some strange behaviour only
>>>> when cpuidle is used:
>>>> 1.  I test ethernet bandwidth with iperf
>>>> 2. With large packet test (16k), I get same bandwidth in version with
>>>> cpuidle support as in version without cpuidel supported.
>>>> 3. With small packet test (<2000 bytes), I get high degredation in
>>>> performance in version with cpuidle. On viewing statistics I see that
>>>> the cpu gets into cpu inactive state (C3 state -  not retention yet,
>>>> only cpu not active). I guess this is the cuase of the degredation.
>>>> With large packets I get no increment in C3 state usage.
>>>> 4. I think that menu governer behaviour might explain this, but I
>>>> don't understand it deeply enough.
>>>>
>>>> Can anyone shed a light on this ? Is there anything I can do to overcome
>>>> this ?
>>>
>>>
>>> Is an omap3 or omap4 ?
>>>
>>>
>> Hi,
>>
>> It is omap3530.
>
> Ok, thanks.
>
> I was asking for the omap version because the cpuidle driver is
> different and behaves differently. The core are coupled and the IPI
> enters in the next prediction equation.

What board are you using, what is network chip you're using, and how is
it wired to the OMAP3530, in particular the IRQ line.

Lots depends on whether the eth NIC is capable of waking the OMAP from
deep sleep. Typically, this is done by wiring the NIC IRQ to a
wakeup-capable GPIO.

If the NIC is not waking the OMAP from deep sleep, then the performance
degradation could also happen because the packets are not processed
until some other timer fires and wakes up the OMAP idle.

Kevin

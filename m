From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Q: cpuidle results in degredation in ethernet performance ?
Date: Wed, 05 Aug 2015 11:29:15 +0200
Message-ID: <55C1D76B.9000006@linaro.org>
References: <CAJ2oMhKw0gpFMKOd-iYe_hYh56Q62XgpW+MJmyiGhdkGn1RTMg@mail.gmail.com>	<55C0CC17.604@linaro.org> <CAJ2oMhJgj02yzGQEqBZW1Fbdc1GEv0-4-NBOt97Mfdiz=tDXSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35531 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbbHEJ3T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 05:29:19 -0400
Received: by wibxm9 with SMTP id xm9so200166126wib.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 02:29:17 -0700 (PDT)
In-Reply-To: <CAJ2oMhJgj02yzGQEqBZW1Fbdc1GEv0-4-NBOt97Mfdiz=tDXSg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-pm@vger.kernel.org

On 08/04/2015 05:24 PM, Ran Shalit wrote:
> On Tue, Aug 4, 2015 at 5:28 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 08/01/2015 09:34 PM, Ran Shalit wrote:
>>>
>>> Hello,
>>>
>>> Maybe if someone here understands cpuidel he can help me...
>>>
>>> I am using omap, with cpuidel and I have some strange behaviour onl=
y
>>> when cpuidle is used:
>>> 1.  I test ethernet bandwidth with iperf
>>> 2. With large packet test (16k), I get same bandwidth in version wi=
th
>>> cpuidle support as in version without cpuidel supported.
>>> 3. With small packet test (<2000 bytes), I get high degredation in
>>> performance in version with cpuidle. On viewing statistics I see th=
at
>>> the cpu gets into cpu inactive state (C3 state -  not retention yet=
,
>>> only cpu not active). I guess this is the cuase of the degredation.
>>> With large packets I get no increment in C3 state usage.
>>> 4. I think that menu governer behaviour might explain this, but I
>>> don't understand it deeply enough.
>>>
>>> Can anyone shed a light on this ? Is there anything I can do to ove=
rcome
>>> this ?
>>
>>
>> Is an omap3 or omap4 ?
>>
>>
> Hi,
>
> It is omap3530.

Ok, thanks.

I was asking for the omap version because the cpuidle driver is=20
different and behaves differently. The core are coupled and the IPI=20
enters in the next prediction equation.

What you are observing may be related to the following behavior:

The deeper idle state the cpu is, the longer it takes to wake up.

  * When there are large packets, the packet processing time makes the=20
cpu wake up (exit latency) negligible. For example, the test uses 1000=20
packets. The time to process a packet is 100us and the exit latency of=20
the idle state is 10us.

    (1000 x 100) + (1000 x 10) =3D 110000 us

  * When there are small packets, the packet processing time is smaller=
,=20
let's say 10us:

    (1000 x 10) + (1000 x 10) =3D 20000us

In the first case, you have 90% time to process a packet, in the second=
=20
case 50% time to process a packet.

As the iperf program is probably not sending a fixed number of packet=20
but counts the maximum number of packet to be sent in a fixed time=20
interval, with small packets you spend half of the time to wake up the =
cpu.

Perhaps the menu governor is doing some bad decisions also but without=20
some traces you can't verify this [1]. I am working on another governor=
=20
which could improve the current situation

Other than that, if everything is ok (good idle decision), then you are=
=20
facing a normal behavior, that is save power at the cost of performance=
=20
loss. If you need to add constraints during a specific amount of time,=20
you can look at the cpu_dma_latency constraint which will prevent to=20
have the cpu to go to deep idle state.

   -- Daniel

[1]=20
https://git.linaro.org/people/daniel.lezcano/linux.git/commit/6febff6cd=
ce103fec523be9b66d5021a72d7febf


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


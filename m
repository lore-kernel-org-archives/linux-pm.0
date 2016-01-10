From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Sun, 10 Jan 2016 23:37:13 +0100
Message-ID: <5692DD19.4010808@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34779 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbcAJWhR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2016 17:37:17 -0500
Received: by mail-wm0-f54.google.com with SMTP id u188so194606249wmu.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2016 14:37:16 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On 01/06/2016 06:40 PM, Nicolas Pitre wrote:
> On Wed, 6 Jan 2016, Daniel Lezcano wrote:
>
>> Many IRQs are quiet most of the time, or they tend to come in bursts=
 of
>> fairly equal time intervals within each burst. It is therefore possi=
ble
>> to detect those IRQs with stable intervals and guestimate when the n=
ext
>> IRQ event is most likely to happen.
>>
>> Examples of such IRQs may include audio related IRQs where the FIFO =
size
>> and/or DMA descriptor size with the sample rate create stable interv=
als,
>> block devices during large data transfers, etc.  Even network stream=
ing
>> of multimedia content creates patterns of periodic network interface=
 IRQs
>> in some cases.
>>
>> This patch adds code to track the mean interval and variance for eac=
h IRQ
>> over a window of time intervals between IRQ events. Those statistics=
 can
>> be used to assist cpuidle in selecting the most appropriate sleep st=
ate
>> by predicting the most likely time for the next interrupt.
>>
>> Because the stats are gathered in interrupt context, the core comput=
ation
>> is as light as possible.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

>> +
>> +		diff =3D ktime_sub(now, w->timestamp);
>> +
>> +		/*
>> +		 * There is no point attempting predictions on interrupts more
>> +		 * than 1 second apart. This has no benefit for sleep state
>> +		 * selection and increases the risk of overflowing our variance
>> +		 * computation. Reset all stats in that case.
>> +		 */
>> +		if (unlikely(ktime_after(diff, ktime_set(1, 0)))) {
>> +			stats_reset(&w->stats);
>> +			continue;
>> +		}
>
> The above is wrong. It is not computing the interval between successi=
ve
> interruts but rather the interval between the last interrupt occurren=
ce
> and the present time (i.e. when we're about to go idle).  This won't
> prevent interrupt intervals greater than one second from being summed
> and potentially overflowing the variance if this code is executed les=
s
> than a second after one such IRQ interval.  This test should rather b=
e
> performed in sched_idle_irq().

Hi Nico,

I have been through here again and think we should duplicate the test=20
because there are two cases:

1. We did not go idle and the interval measured in sched_idle_irq is=20
more than one second, then the stats are reset. I suggest to use an=20
approximation of one second: (diff < (1 << 20)) as we are in the fast
path.

2. We are going idle and the latest interrupt happened one second apart=
=20
from now. So we keep the current test.

   -- Daniel



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


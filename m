From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Thu, 21 Jan 2016 11:03:36 +0100
Message-ID: <56A0ACF8.3050703@linaro.org>
References: <alpine.DEB.2.11.1601201634520.3575@nanos>
 <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1601201212170.2140@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34770 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758305AbcAUKDj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 05:03:39 -0500
Received: by mail-wm0-f49.google.com with SMTP id u188so219176316wmu.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2016 02:03:38 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1601201212170.2140@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org


Hi Nico,


On 01/20/2016 06:46 PM, Nicolas Pitre wrote:
> On Wed, 20 Jan 2016, Daniel Lezcano wrote:
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
>> ---

[ ... ]

>> +struct stats {
>> +	u64           sum;                     /* sum of values */
>> +	u32           values[STATS_NR_VALUES]; /* array of values */
>> +	unsigned char w_ptr;                   /* current window pointer *=
/
>
> Why did you change this from an unsigned int?
>
> This won't provide any memory space saving given that the structure h=
as
> to be padded up to the next 64-bit boundary.

Ok, I will change it back to unsigned int.

[ ... ]

>> +	for (i =3D 0; i < STATS_NR_VALUES; i++) {
>> +		s64 diff =3D s->values[i] - mean;
>> +		variance +=3D (u64)diff * diff;
>> +	}
>
> This is completely wrong.  Even more wrong than it used to be.  I mus=
t
> have expressed myself badly about this last time.
>
> To avoid any confusion, here's what the code should be:
>
> 	int i;
> 	u64 variance =3D 0;
>
> 	for (i =3D 0; i < STATS_NR_VALUES; i++) {
> 		s32 diff =3D s->values[i] - mean;
> 		variance +=3D (s64)diff * diff;
> 	}
>
> 	[...]

Aah, ok :)

[ ... ]

>> +	if (diff > (1 << 20)) {
>
> You could use the USEC_PER_SEC constant here. It is already widely us=
ed
> and would make the code even more obvious.

Indeed.

[ ... ]

>> +		/*
>> +		 * There is no point attempting predictions on interrupts more
>> +		 * than 1 second apart. This has no benefit for sleep state
>> +		 * selection and increases the risk of overflowing our variance
>> +		 * computation. Reset all stats in that case.
>> +		 */
>
> This comment is wrong.  It is relevant in sched_irq_timing_handler() =
but
> not here.  Instead this should be something like:
>
> 		/*
> 		 * This interrupt last triggered more than a second ago.
> 		 * It is definitely not predictable for our purpose anymore.
> 		 */

Ok.

[ ... ]

>> +		interval =3D w->stats.values[w->stats.w_ptr];
>> +		if ((u64)((interval - mean) * (interval - mean)) > variance)
>
> s/u64/s64/ please.

Noted.

Thanks Nico for the review.


   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


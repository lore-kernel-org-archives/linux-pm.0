From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Sun, 10 Jan 2016 23:58:42 +0100
Message-ID: <5692E222.6060905@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr>
 <5692DD19.4010808@linaro.org>
 <alpine.LFD.2.20.1601101739270.7882@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1601101739270.7882@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/10/2016 11:46 PM, Nicolas Pitre wrote:
> On Sun, 10 Jan 2016, Daniel Lezcano wrote:
>
>> On 01/06/2016 06:40 PM, Nicolas Pitre wrote:
>>> On Wed, 6 Jan 2016, Daniel Lezcano wrote:
>>>
>>>> Many IRQs are quiet most of the time, or they tend to come in burs=
ts of
>>>> fairly equal time intervals within each burst. It is therefore pos=
sible
>>>> to detect those IRQs with stable intervals and guestimate when the=
 next
>>>> IRQ event is most likely to happen.
>>>>
>>>> Examples of such IRQs may include audio related IRQs where the FIF=
O size
>>>> and/or DMA descriptor size with the sample rate create stable inte=
rvals,
>>>> block devices during large data transfers, etc.  Even network stre=
aming
>>>> of multimedia content creates patterns of periodic network interfa=
ce IRQs
>>>> in some cases.
>>>>
>>>> This patch adds code to track the mean interval and variance for e=
ach IRQ
>>>> over a window of time intervals between IRQ events. Those statisti=
cs can
>>>> be used to assist cpuidle in selecting the most appropriate sleep =
state
>>>> by predicting the most likely time for the next interrupt.
>>>>
>>>> Because the stats are gathered in interrupt context, the core comp=
utation
>>>> is as light as possible.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> [ ... ]
>>
>>>> +
>>>> +		diff =3D ktime_sub(now, w->timestamp);
>>>> +
>>>> +		/*
>>>> +		 * There is no point attempting predictions on interrupts more
>>>> +		 * than 1 second apart. This has no benefit for sleep state
>>>> +		 * selection and increases the risk of overflowing our
>>>> variance
>>>> +		 * computation. Reset all stats in that case.
>>>> +		 */
>>>> +		if (unlikely(ktime_after(diff, ktime_set(1, 0)))) {
>>>> +			stats_reset(&w->stats);
>>>> +			continue;
>>>> +		}
>>>
>>> The above is wrong. It is not computing the interval between succes=
sive
>>> interruts but rather the interval between the last interrupt occurr=
ence
>>> and the present time (i.e. when we're about to go idle).  This won'=
t
>>> prevent interrupt intervals greater than one second from being summ=
ed
>>> and potentially overflowing the variance if this code is executed l=
ess
>>> than a second after one such IRQ interval.  This test should rather=
 be
>>> performed in sched_idle_irq().
>>
>> Hi Nico,
>>
>> I have been through here again and think we should duplicate the tes=
t because
>> there are two cases:
>>
>> 1. We did not go idle and the interval measured in sched_idle_irq is=
 more than
>> one second, then the stats are reset. I suggest to use an approximat=
ion of one
>> second: (diff < (1 << 20)) as we are in the fast
>> path.
>>
>> 2. We are going idle and the latest interrupt happened one second ap=
art from
>> now. So we keep the current test.
>
> You don't need the current test if the interval is already limited
> earlier on.  Predictions that would otherwise trip that test will tar=
get
> a time in the past and be discarded.

Yes, but that wake up source should be discarded in the process of the=20
selection, so ignored in the loop, otherwise it can end up as the next=20
event (which is obviously wrong) and discarded at the end by returning=20
KTIME_MAX, instead of giving the opportunity to find another interrupt=20
as the next event with a greater value.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Mon, 22 Feb 2016 18:29:00 +0100
Message-ID: <56CB455C.3050701@linaro.org>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
 <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
 <56CB22F5.8010808@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34586 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbcBVR3E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 12:29:04 -0500
Received: by mail-wm0-f54.google.com with SMTP id b205so165646014wmb.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 09:29:03 -0800 (PST)
In-Reply-To: <56CB22F5.8010808@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 02/22/2016 04:02 PM, Shreyas B Prabhu wrote:
> Hi Daniel,
>
> On 02/16/2016 09:13 PM, Daniel Lezcano wrote:
>> +
>> +/**
>> + * sched_idle_next_wakeup - Predict the next wakeup on the current =
cpu
>> + *
>> + * The next event on the cpu is based on a statistic approach of th=
e
>> + * interrupt events and the timer deterministic value. From the tim=
er
>> + * or the irqs, we return the one expected to occur first.
>> + *
>> + * Returns the expected remaining idle time before being woken up b=
y
>> + * an interruption.
>> + */
>> +s64 sched_idle_next_wakeup(void)
>> +{
>> +	s64 next_timer =3D ktime_to_us(tick_nohz_get_sleep_length());
>> +	s64 next_irq =3D next_irq_event();
>
> Since next_irq_event() uses RCU and we are in idle this should probab=
ly
> be wrapped in RCU_NONIDLE().

That is a good point but the function is not supposed to be called in=20
the rcu_idle_enter/rcu_idle_exit section which is inside=20
cpuidle_idle_call().


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


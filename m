From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 15:16:44 +0100
Message-ID: <56950ACC.4090001@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601081631380.3575@nanos> <5694F490.3040300@linaro.org>
 <alpine.DEB.2.11.1601121441330.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38265 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762013AbcALOQr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 09:16:47 -0500
Received: by mail-wm0-f49.google.com with SMTP id b14so322420609wmb.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 06:16:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601121441330.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/12/2016 02:42 PM, Thomas Gleixner wrote:
> On Tue, 12 Jan 2016, Daniel Lezcano wrote:
>> On 01/08/2016 04:43 PM, Thomas Gleixner wrote:
>>>> +	/*
>>>> +	 * Register the setup/free irq callbacks, so new interrupt or
>>>> +	 * freed interrupt will update their tracking.
>>>> +	 */
>>>> +	ret =3D register_irq_timings(&irqt_ops);
>>>> +	if (ret) {
>>>> +		pr_err("Failed to register timings ops\n");
>>>> +		return ret;
>>>> +	}
>>>
>>> So that stuff is installed unconditionally. Is it used unconditiona=
lly as
>>> well?
>>
>> Sorry, I am not sure to understand your question. If the kernel is c=
ompiled
>> with CONFIG_CPU_IDLE_GOV_SCHED=3Dy, this code is enabled and use the=
 irq
>> timings. The condition comes from the compilation option.
>
> The question is whether the option also activates that thing or is th=
ere still
> some /sys/whatever/idlegov magic where you can (de)select it.

Yes, in the next patches of the series I did not send, we can switch to=
=20
the cpuidle's governor framework or idle-sched. I will look at how to=20
disable it when switching to the cpuidle's governors.

Thanks

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


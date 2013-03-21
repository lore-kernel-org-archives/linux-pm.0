From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4][resend] cpuidle : handle clockevent notify from the
 cpuidle framework
Date: Thu, 21 Mar 2013 14:52:44 +0100
Message-ID: <514B10AC.9090909@linaro.org>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org> <514B0417.6020401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:38858 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab3CUNwr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 09:52:47 -0400
Received: by mail-ea0-f174.google.com with SMTP id q10so914099eaj.33
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 06:52:46 -0700 (PDT)
In-Reply-To: <514B0417.6020401@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

On 03/21/2013 01:59 PM, Santosh Shilimkar wrote:
> On Thursday 21 March 2013 05:51 PM, Daniel Lezcano wrote:
>> When a cpu enters a deep idle state, the local timers are stopped an=
d
>> the time framework falls back to the timer device used as a broadcas=
t
>> timer.
>>
>> The different cpuidle drivers are calling clockevents_notify ENTER/E=
XIT
>> when the idle state stops the local timer.
>>
>> Add a new flag CPUIDLE_FLAG_TIMER_STOP which can be set by the cpuid=
le
>> drivers. If the flag is set, the cpuidle core code takes care of the
>> notification on behalf of the driver to avoid pointless code duplica=
tion.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/cpuidle/cpuidle.c |    9 +++++++++
>>  include/linux/cpuidle.h   |    1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index eba6929..c500370 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -8,6 +8,7 @@
>>   * This code is licenced under the GPL.
>>   */
>> =20
>> +#include <linux/clockchips.h>
>>  #include <linux/kernel.h>
>>  #include <linux/mutex.h>
>>  #include <linux/sched.h>
>> @@ -146,12 +147,20 @@ int cpuidle_idle_call(void)
>> =20
>>  	trace_cpu_idle_rcuidle(next_state, dev->cpu);
>> =20
>> +	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
>> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>> +				   &dev->cpu);
>> +
> Seems like good clean-up from drivers.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>=20
> How about taking care of cpu_pm_notifiers() as well with some
> additional flag for CPU and cluster power state. That can help
> to reduce and consolidate the code. What you say ?

Do you mean add a flag for different level of idle (idle, suspend, powe=
r
off) and then use the cpu_pm_enter/cpu_cluster_pm_enter in all the
drivers as a common framework ?

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] cpuidle: Fix last_residency division
Date: Fri, 24 Jun 2016 12:05:36 +0200
Message-ID: <576D05F0.6060900@linaro.org>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4E3E66@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38097 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbcFXKFi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 06:05:38 -0400
Received: by mail-wm0-f42.google.com with SMTP id r201so18520447wme.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jun 2016 03:05:38 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4E3E66@AcuExch.aculab.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>, "'Shreyas B. Prabhu'" <shreyas@linux.vnet.ibm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "anton@samba.org" <anton@samba.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On 06/24/2016 11:00 AM, David Laight wrote:
> From: Shreyas B. Prabhu
>> Sent: 24 June 2016 09:24
>>
>> Snooze is a poll idle state in powernv and pseries platforms. Snooze
>> has a timeout so that if a cpu stays in snooze for more than target
>> residency of the next available idle state, then it would exit there=
by
>> giving chance to the cpuidle governor to re-evaluate and
>> promote the cpu to a deeper idle state. Therefore whenever snooze ex=
its
>> due to this timeout, its last_residency will be target_residency of =
next
>> deeper state.
>>
>> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock(=
)")
>> changed the math around last_residency calculation. Specifically, wh=
ile
>> converting last_residency value from nanoseconds to microseconds it =
does
>> right shift by 10. Due to this, in snooze timeout exit scenarios
>> last_residency calculated is roughly 2.3% less than target_residency=
 of
>> next available state. This pattern is picked up get_typical_interval=
()
>> in the menu governor and therefore expected_interval in menu_select(=
) is
>> frequently less than the target_residency of any state but snooze.
>>
>> Due to this we are entering snooze at a higher rate, thereby affecti=
ng
>> the single thread performance.
>>
>> Fix this by replacing right shift by 10 with /1000 while calculating
>> last_residency.
>>
>> Reported-by: Anton Blanchard <anton@samba.org>
>> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
>> Changes in v2
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   - Fixing it in the cpuidle core code instead of driver code.
>>
>>   drivers/cpuidle/cpuidle.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index a4d0059..30d67a8 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -218,10 +218,10 @@ int cpuidle_enter_state(struct cpuidle_device =
*dev, struct cpuidle_driver *drv,
>>   		local_irq_enable();
>>
>>   	/*
>> -	 * local_clock() returns the time in nanosecond, let's shift
>> -	 * by 10 (divide by 1024) to have microsecond based time.
>> +	 * local_clock() returns the time in nanosecond, let's
>> +	 * divide by 1000 to have microsecond based time.
>>   	 */
>> -	diff =3D (time_end - time_start) >> 10;
>> +	diff =3D (time_end - time_start) / 1000;

do_div ?

>>   	if (diff > INT_MAX)
>>   		diff =3D INT_MAX;
>
> The intent of the >> 10 was probably to avoid an expensive 64bit divi=
de.
> So maybe something like:
> 	diff =3D time_end - time_start;
> 	if (diff >=3D INT_MAX/2)
> 		diff_32 =3D INT_MAX/2/1000;
> 	else
> 		diff_32 =3D diff;
> 		diff_32 +=3D diff_32 >> 6;
> 		diff_32 >>=3D 10;
> 	}
>
> Adding an extra 1/32 makes the division by be something slightly belo=
w 1000.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
Date: Wed, 27 May 2015 14:25:59 +0200
Message-ID: <5565B7D7.3000308@linaro.org>
References: <5494512.JcUbNX5Mxs@vostro.rjw.lan> <5565AB09.8090802@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36718 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbE0M0B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 08:26:01 -0400
Received: by wgbgq6 with SMTP id gq6so7953696wgb.3
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 05:26:00 -0700 (PDT)
In-Reply-To: <5565AB09.8090802@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>

On 05/27/2015 01:31 PM, Preeti U Murthy wrote:
> On 05/27/2015 07:06 AM, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The CPUIDLE_DRIVER_STATE_START symbol is defined as 1 only if
>> CONFIG_ARCH_HAS_CPU_RELAX is set, otherwise it is defined as 0.
>> However, if CONFIG_ARCH_HAS_CPU_RELAX is set, the first (index 0)
>> entry in the cpuidle driver's table of states is overwritten with
>> the default "poll" entry by the core.  The "state" defined by the
>> "poll" entry doesn't provide ->enter_dead and ->enter_freeze
>> callbacks and its exit_latency is 0.
>>
>> For this reason, it is not necessary to use CPUIDLE_DRIVER_STATE_STA=
RT
>> in cpuidle_play_dead() (->enter_dead is NULL, so the "poll state"
>> will be skipped by the loop) and in find_deepest_state() (since
>> exit_latency is 0, the "poll state" will become the default if the
>> "s->exit_latency <=3D latency_req" check is replaced with
>> "s->exit_latency < latency_req" which may only matter for drivers
>> providing different states with the same exit_latency).
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/cpuidle/cpuidle.c |    8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
> <snip>
>
>>
>> @@ -79,13 +79,13 @@ static int find_deepest_state(struct cpu
>>   			      bool freeze)
>>   {
>>   	unsigned int latency_req =3D 0;
>> -	int i, ret =3D freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
>> +	int i, ret =3D -ENXIO;
>>
>> -	for (i =3D CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) =
{
>> +	for (i =3D 0; i < drv->state_count; i++) {
>>   		struct cpuidle_state *s =3D &drv->states[i];
>>   		struct cpuidle_state_usage *su =3D &dev->states_usage[i];
>>
>> -		if (s->disabled || su->disable || s->exit_latency <=3D latency_re=
q
>> +		if (s->disabled || su->disable || s->exit_latency < latency_req
>
> Prior to this patch,
>
> For drivers on which CPUIDLE_DRIVER_STATE_START takes a value 0 and
> whose first idle state has an exit_latency of 0, find_deepest_state()
> would return -1 if it failed to find a deeper idle state.
> But as an effect of this patch, find_deepest_state() returns 0 in the
> above circumstance.

Except I am missing something, with an exit_latency =3D 0, the state wi=
ll=20
be never selected, because of the "s->exit_latency < latency_req"=20
condition (strictly greater than).

> My concern is if these drivers do not intend to enter a polling state
> during suspend, this will cause an issue, won't it? This also gets me
> wondering if polling state is an acceptable idle state during suspend=
,
> given that the drivers with ARCH_HAS_CPU_RELAX permit entry into it
> during suspend today.

Definitively poll can cause thermal issues, especially when suspending.=
=20
It is a dangerous state (let's imagine you close your laptop =3D>=20
suspend/poll and then put it in your bag for a travel).

I don't think with the code above we can reach this situation but I=20
agree this is something we have to take care carefully.

Actually, I am in favour of removing poll at all from the cpuidle drive=
r=20
and poll only when a cpuidle state selection fails under certain condit=
ion.

So I fully agree with your statement below.

> I would expect the cpus to be in a hardware
> defined idle state.




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


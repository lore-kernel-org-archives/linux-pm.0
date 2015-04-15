From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] sched: fair: Fix wrong idle timestamp usage
Date: Wed, 15 Apr 2015 17:43:17 +0200
Message-ID: <552E8715.4060601@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org> <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org> <20150415121831.GU5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33449 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbDOPnS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 11:43:18 -0400
Received: by wiax7 with SMTP id x7so115034974wia.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2015 08:43:17 -0700 (PDT)
In-Reply-To: <20150415121831.GU5029@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org, Ingo Molnar <mingo@redhat.com>

On 04/15/2015 02:18 PM, Peter Zijlstra wrote:
> On Wed, Apr 15, 2015 at 12:00:24PM +0200, Daniel Lezcano wrote:
>> The find_idlest_cpu is assuming the rq->idle_stamp information refle=
cts when
>> the cpu entered the idle state. This is wrong as the cpu may exit an=
d enter
>> the idle state several times without the rq->idle_stamp being update=
d.
>
> Sure, but you forgot to tell us why it matters.

Yes, right. Thanks for pointing this out.

Assuming we are in the situation where there are several idle cpus in=20
the same idle state.

With the current code, the function find_idlest_cpu will choose a cpu=20
with the shortest idle duration. This information is based on the=20
rq->idle_stamp variable and is correct until one of the idle cpu is=20
exiting the cpuidle_enter function and re-entering it again. As soon as=
=20
this happen, the rq->idle_stamp value is no longer a reliable informati=
on.

Example:

  * CPU0 and CPU1 are running
  * CPU2 and CPU3 are in the C3 state.
  * CPU2 entered idle at T2
  * CPU3 entered idle at T3
  * T2 < T3

The function find_idlest_cpu will choose CPU3 because it has a shorter=20
idle duration.

Then CPU3 is woken up by an interrupt, process it and re-enter idle C3.

The information will still give the out to date information T2 < T3 and=
=20
find_idlest_cpu will choose CPU2 instead of CPU3.

Even if that shouldn't have a big impact on the performance and energy=20
side, we are dealing with a wrong information preventing us to improve=20
the energy side later (eg. prevent to wakeup a cpu which did not reach=20
its target residency yet).

>> We have two informations here:
>>
>>   * rq->idle_stamp gives when the idle task has been scheduled
>>   * idle->idle_stamp gives when the cpu entered the idle state
>
> I'm not a native speaker, but I'm pretty sure 'information' is a word
> without a plural, a google search suggests it to be a non-countable
> noun.

Ha, sounds like it is a common mistake for non native speaker :)

"Informations" is correct but apparently very uncommon, so uncommon it=20
is considered incorrect.

Thanks for the tip, I will keep it in mind :)

>> The patch fixes that by using the latter information and fallbacks t=
o
>> the rq's timestamp when the idle state is not accessible
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++-------------=
-
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 46855d0..b44f1ad 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4704,21 +4704,35 @@ find_idlest_cpu(struct sched_group *group, s=
truct task_struct *p, int this_cpu)
>>   		if (idle_cpu(i)) {
>>   			struct rq *rq =3D cpu_rq(i);
>>   			struct cpuidle_state *idle =3D idle_get_state(rq);
>> +
>> +			if (idle) {
>> +				if (idle->exit_latency < min_exit_latency) {
>> +					/*
>> +					 * We give priority to a CPU
>> +					 * whose idle state has the
>> +					 * smallest exit latency
>> +					 * irrespective of any idle
>> +					 * timestamp.
>> +					 */
>> +					min_exit_latency =3D idle->exit_latency;
>> +					latest_idle_timestamp =3D idle->idle_stamp;
>> +					shallowest_idle_cpu =3D i;
>> +				} else if (idle->exit_latency =3D=3D min_exit_latency &&
>> +					   idle->idle_stamp > latest_idle_timestamp) {
>> +					/*
>> +					 * If the CPU is in the same
>> +					 * idle state, choose the more
>> +					 * recent one as it might have
>> +					 * a warmer cache
>> +					 */
>> +					latest_idle_timestamp =3D idle->idle_stamp;
>> +					shallowest_idle_cpu =3D i;
>> +				}
>> +			} else if (rq->idle_stamp > latest_idle_timestamp) {
>>   				/*
>> +				 * If no active idle state, then the
>> +				 * most recent idled CPU might have a
>> +				 * warmer cache
>>   				 */
>>   				latest_idle_timestamp =3D rq->idle_stamp;
>>   				shallowest_idle_cpu =3D i;
>
> Urgh, you made horrid code more horrible.
>
> And all without reason.

Ok. What is horrible ? The 'if then else' blocks or the algorithm itsel=
f ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


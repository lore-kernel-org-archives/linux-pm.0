From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] drivers: cpuidle: assign enter_freeze to same as enter
 callback function
Date: Wed, 9 Nov 2016 18:48:52 +0000
Message-ID: <c6f986a7-5a00-7a4f-bdb3-db783f585b3e@arm.com>
References: <1478713410-10727-1-git-send-email-sudeep.holla@arm.com>
 <20161109183925.GA19565@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751202AbcKISsz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Nov 2016 13:48:55 -0500
In-Reply-To: <20161109183925.GA19565@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Andy Gross <andy.gross@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>



On 09/11/16 18:39, Lorenzo Pieralisi wrote:
> On Wed, Nov 09, 2016 at 05:43:30PM +0000, Sudeep Holla wrote:
>> enter_freeze() callback is expected atleast to do the same as enter()
>> but it has to guarantee that interrupts aren't enabled at any point
>> in its execution, as the tick is frozen.
>>
>> CPUs execute ->enter_freeze with the local tick or entire timekeeping
>> suspended, so it must not re-enable interrupts at any point (even
>> temporarily) or attempt to change states of clock event devices.
>>
>> It will be called when the system goes to suspend-to-idle and will
>> reduce power usage because CPUs won't be awaken for unnecessary IRQs
>> (i.e. woken up only on IRQs from "wakeup sources")
>>
>> Since for all the states that have CPUIDLE_FLAG_TIMER_STOP flag set,
>> local tick is stopped, we can reuse the same code for both the enter()
>> and enter_freeze() callbacks. Only "coupled" cpuidle mechanism enables
>> interrupts and doing that with timekeeping suspended is generally not
>> safe. Since this generic DT based idle driver doesn't support "coupled"
>> states, it is safe to assume that the interrupts are not re-enabled.
>>
>> This patch assign enter_freeze to same as enter callback function which
>> helps to save power without any intermittent spurious wakeups from
>> suspend-to-idle.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/cpuidle/dt_idle_states.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
>> index a5c111b67f37..5a087d108475 100644
>> --- a/drivers/cpuidle/dt_idle_states.c
>> +++ b/drivers/cpuidle/dt_idle_states.c
>> @@ -79,8 +79,17 @@ static int init_state_node(struct cpuidle_state *idle_state,
>>  		desc = state_node->name;
>>
>>  	idle_state->flags = 0;
>> -	if (of_property_read_bool(state_node, "local-timer-stop"))
>> +	if (of_property_read_bool(state_node, "local-timer-stop")) {
>>  		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>> +		/*
>> +		 * CPUIDLE_FLAG_TIMER_STOP guarantees that the local tick is
>> +		 * stopped and since this is not a "coupled" state interrupts
>> +		 * won't be enabled when it exits allowing the tick to be
>> +		 * frozen safely. So enter() can be also enter_freeze()
>> +		 * callback.
>> +		 */
>
> I do not think that represents a guarantee for enter_freeze() to be
> functional, we can initialize enter_freeze() with a function that
> does _not_ enable IRQs while executing, it has not much to do with
> the local timer losing HW state.
>

I agree, and I didn't mean that with the above comment. But reading
again, I see your point.

> I would just init the enter_freeze() pointer and be done with that,
> adding code to check whether the idle back-end enables IRQs when it
> enters idle is a major PITA that really is not worth the hassle and
> apart from coupled C-states (which we do not support in DT as you said)
> I can't find another example (and on top of that it is not even
> something we can solve through DT since it is not a property of the idle
> state but more related to its kernel implementation).
>

Makes sense, I was just trying to avoid setting for a state like
CPU/Cluster retention but I agree, we need not do that.

> If we wanted to do it _properly_ we have to add an arch hook to check
> if the given idle state enter function back-end, ie cpu_ops on ARM64 or
> or cpuidle_ops on ARM, enables IRQs while executing, I would honestly
> avoid it but comments are nonetheless welcome.
>

Yes, that's may be unnecessary addition of some code when we can do it
in simple ways, but I am open to suggestions.

-- 
Regards,
Sudeep

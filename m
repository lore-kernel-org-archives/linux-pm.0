From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
Date: Wed, 27 May 2015 15:57:27 +0200
Message-ID: <CAJZ5v0hn__7KRqOTpBYAk8EfV28xD54G0MaetaJ6HH5uUE3wQw@mail.gmail.com>
References: <5494512.JcUbNX5Mxs@vostro.rjw.lan>
	<5565AB09.8090802@linux.vnet.ibm.com>
	<5565B7D7.3000308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5565B7D7.3000308@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 27, 2015 at 2:25 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 05/27/2015 01:31 PM, Preeti U Murthy wrote:
>>
>> On 05/27/2015 07:06 AM, Rafael J. Wysocki wrote:
>>>
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The CPUIDLE_DRIVER_STATE_START symbol is defined as 1 only if
>>> CONFIG_ARCH_HAS_CPU_RELAX is set, otherwise it is defined as 0.
>>> However, if CONFIG_ARCH_HAS_CPU_RELAX is set, the first (index 0)
>>> entry in the cpuidle driver's table of states is overwritten with
>>> the default "poll" entry by the core.  The "state" defined by the
>>> "poll" entry doesn't provide ->enter_dead and ->enter_freeze
>>> callbacks and its exit_latency is 0.
>>>
>>> For this reason, it is not necessary to use CPUIDLE_DRIVER_STATE_START
>>> in cpuidle_play_dead() (->enter_dead is NULL, so the "poll state"
>>> will be skipped by the loop) and in find_deepest_state() (since
>>> exit_latency is 0, the "poll state" will become the default if the
>>> "s->exit_latency <= latency_req" check is replaced with
>>> "s->exit_latency < latency_req" which may only matter for drivers
>>> providing different states with the same exit_latency).
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>   drivers/cpuidle/cpuidle.c |    8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> <snip>
>>
>>>
>>> @@ -79,13 +79,13 @@ static int find_deepest_state(struct cpu
>>>                               bool freeze)
>>>   {
>>>         unsigned int latency_req = 0;
>>> -       int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
>>> +       int i, ret = -ENXIO;
>>>
>>> -       for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
>>> +       for (i = 0; i < drv->state_count; i++) {
>>>                 struct cpuidle_state *s = &drv->states[i];
>>>                 struct cpuidle_state_usage *su = &dev->states_usage[i];
>>>
>>> -               if (s->disabled || su->disable || s->exit_latency <=
>>> latency_req
>>> +               if (s->disabled || su->disable || s->exit_latency <
>>> latency_req
>>
>>
>> Prior to this patch,
>>
>> For drivers on which CPUIDLE_DRIVER_STATE_START takes a value 0 and
>> whose first idle state has an exit_latency of 0, find_deepest_state()
>> would return -1 if it failed to find a deeper idle state.
>> But as an effect of this patch, find_deepest_state() returns 0 in the
>> above circumstance.
>
>
> Except I am missing something, with an exit_latency = 0, the state will be
> never selected, because of the "s->exit_latency < latency_req" condition
> (strictly greater than).

No, this is the condition to skip the state, so previously it wouldn't
be selected, but after the patch it will.

So yes, the patch changes behavior for systems with
CONFIG_ARCH_HAS_CPU_RELAX unset.

>> My concern is if these drivers do not intend to enter a polling state
>> during suspend, this will cause an issue, won't it?

The change in behavior happens for architectures where
CONFIG_ARCH_HAS_CPU_RELAX is not set.  In those cases the 0-index
state is supposed to be provided by the driver.  Is there a reason to
expect that this may not be a genuine idle state?

>> This also gets me
>> wondering if polling state is an acceptable idle state during suspend,
>> given that the drivers with ARCH_HAS_CPU_RELAX permit entry into it
>> during suspend today.

That actually is a good question.

> Definitively poll can cause thermal issues, especially when suspending. It
> is a dangerous state (let's imagine you close your laptop => suspend/poll
> and then put it in your bag for a travel).

With ARCH_HAS_CPU_RELAX set the "poll state" is supposed to be thermally safe.

> I don't think with the code above we can reach this situation but I agree
> this is something we have to take care carefully.
>
> Actually, I am in favour of removing poll at all from the cpuidle driver and
> poll only when a cpuidle state selection fails under certain condition.
>
> So I fully agree with your statement below.
>
>> I would expect the cpus to be in a hardware
>> defined idle state.

Well, except for the degenerate case in which all of them are disabled
and for the "broadcast timer stopping aviodance" use case for
find_deepest_state().

So there are two questions in my view:
(1) Should find_deepest_state() ever return states with exit_latency equal to 0?
(2) If the answer to (1) is "yes", should the "poll state" be ever
returned by find_deepest_state()?

In any case, find_deepest_state() will only return a state with
exit_latency equal to 0 if there's no other choice and if it returns
nothing, we'll fall back to the architecture idle method.  So the
question really is whether or not falling back to arch idle is any
better than using any state we have in the table.

The patch is based on the assumption that any state from the table
will be better than arch idle, including the "polling state".  If that
does not hold, we'll need to rethink a couple of other things in my
view.

Thanks,
Rafael

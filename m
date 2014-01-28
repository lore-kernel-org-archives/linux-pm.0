From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] cpuidle/governors: Fix logic in selection of idle
 states
Date: Tue, 28 Jan 2014 09:46:39 +0100
Message-ID: <52E76E6F.4000101@linaro.org>
References: <20140117043351.21531.14192.stgit@preeti.in.ibm.com> <52DF815D.50104@linaro.org> <52E0F9ED.2010506@linux.vnet.ibm.com> <52E22D8A.5000305@linaro.org> <52E23EA0.7010803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:39855 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbaA1Iqn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2014 03:46:43 -0500
Received: by mail-wg0-f48.google.com with SMTP id x13so176091wgg.27
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2014 00:46:39 -0800 (PST)
In-Reply-To: <52E23EA0.7010803@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, tuukka.tikkanen@linaro.org

On 01/24/2014 11:21 AM, Preeti U Murthy wrote:
> On 01/24/2014 02:38 PM, Daniel Lezcano wrote:
>> On 01/23/2014 12:15 PM, Preeti U Murthy wrote:
>>> Hi Daniel,
>>>
>>> Thank you for the review.

[ ... ]

>>> ---
>>>    drivers/cpuidle/cpuidle.c          |   15 +++++
>>>    drivers/cpuidle/governors/ladder.c |  101
>>> ++++++++++++++++++++++++++----------
>>>    drivers/cpuidle/governors/menu.c   |    7 +-
>>>    3 files changed, 90 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>> index a55e68f..19d17e8 100644
>>> --- a/drivers/cpuidle/cpuidle.c
>>> +++ b/drivers/cpuidle/cpuidle.c
>>> @@ -131,8 +131,9 @@ int cpuidle_idle_call(void)
>>>
>>>        /* ask the governor for the next state */
>>>        next_state =3D cpuidle_curr_governor->select(drv, dev);
>>> +
>>> +    dev->last_residency =3D 0;
>>>        if (need_resched()) {
>>
>> What about if (need_resched() || next_state < 0) ?
>
> Hmm.. I feel we need to distinguish between the need_resched() scenar=
io
> and the scenario when no idle state was suitable through the trace
> points at-least.

Well, I don't think so as soon as we don't care about the return value=20
of cpuidle_idle_call in both cases.

The traces are following a specific format. That is if the state is -1=20
(PWR_EVENT_EXIT), it means exiting the current idle state.

The idlestat tool [1] is using this traces to open - close transitions.

IMO, if the cpu is not entering idle, it should just exit without any=20
idle traces.

This portion of code is a bit confusing because it is introduced by the=
=20
menu governor updates post-poned when entering the next idle state (not=
=20
exiting the current idle state with good reasons).

   -- Daniel

[1] http://git.linaro.org/power/idlestat.git

> This could help while debugging when we could find situations where
> there are no tasks to run, yet the cpu is not entering any idle state=
=2E
> The traces could help clearly point that no idle state was thought
> suitable by the governor. Of course there are many other means to fin=
d
> this out, but this seems rather straightforward. Hence having the
> condition next_state < 0 between trace_cpu_idle*() would be apt IMHO.
>
> Regards
> Preeti U Murthy
>
>>
>>> -        dev->last_residency =3D 0;
>>>            /* give the governor an opportunity to reflect on the
>>> outcome */
>>>            if (cpuidle_curr_governor->reflect)
>>>                cpuidle_curr_governor->reflect(dev, next_state);
>>> @@ -141,6 +142,16 @@ int cpuidle_idle_call(void)
>>>        }
>>>
>>>        trace_cpu_idle_rcuidle(next_state, dev->cpu);
>>> +    /*
>>> +     * NOTE: The return code should still be success, since the
>>> verdict of
>>> +     * this call is "do not enter any idle state". It is not a fai=
led
>>> call
>>> +     * due to errors.
>>> +     */
>>> +    if (next_state < 0) {
>>> +        entered_state =3D next_state;
>>> +        local_irq_enable();
>>> +        goto out;
>>> +    }
>>>
>>>        broadcast =3D !!(drv->states[next_state].flags &
>>> CPUIDLE_FLAG_TIMER_STOP);
>>>
>>> @@ -156,7 +167,7 @@ int cpuidle_idle_call(void)
>>>        if (broadcast)
>>>            clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev=
->cpu);
>>>
>>> -    trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>>> +out:    trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>>>
>>>        /* give the governor an opportunity to reflect on the outcom=
e */
>>>        if (cpuidle_curr_governor->reflect)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


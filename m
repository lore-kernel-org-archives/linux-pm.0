From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Tue, 12 May 2015 20:04:50 +0200
Message-ID: <555240C2.9010602@linaro.org>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com> <2602092.6h7ufczYGd@vostro.rjw.lan> <5551BCBF.2000806@linaro.org> <2919083.VPTOth98op@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36445 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbbELSEy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 14:04:54 -0400
Received: by wggj6 with SMTP id j6so18872927wgg.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 11:04:53 -0700 (PDT)
In-Reply-To: <2919083.VPTOth98op@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org, Kevin Hilman <khilman@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

On 05/12/2015 03:23 PM, Rafael J. Wysocki wrote:
> On Tuesday, May 12, 2015 10:41:35 AM Daniel Lezcano wrote:
>> On 05/12/2015 01:31 AM, Rafael J. Wysocki wrote:
>>> On Monday, May 11, 2015 07:40:41 PM Daniel Lezcano wrote:
>>>> On 05/10/2015 01:15 AM, Rafael J. Wysocki wrote:
>>>>> On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
>>>>>> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
>>>>>>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
>>>>>>>> Hi Rafael,
>>>>>>>>
>>>>>>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>>>>>>>
>>>>>>> [cut]
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> +	/* Take note of the planned idle state. */
>>>>>>>>>> +	idle_set_state(smp_processor_id(), target_state);
>>>>>>>>>
>>>>>>>>> And I wouldn't do this either.
>>>>>>>>>
>>>>>>>>> The behavior here is pretty much as though the driver demoted=
 the state chosen
>>>>>>>>> by the governor and we don't call idle_set_state() again in t=
hose cases.
>>>>>>>>
>>>>>>>> Why is this wrong?
>>>>>>>
>>>>>>> It is not "wrong", but incomplete, because demotions done by th=
e cpuidle driver
>>>>>>> should also be taken into account in the same way.
>>>>>>>
>>>>>>> But I'm seeing that the recent patch of mine that made cpuidle_=
enter_state()
>>>>>>> call default_idle_call() was a mistake, because it might confus=
e find_idlest_cpu()
>>>>>>> significantly as to what state the CPU is in.  I'll drop that o=
ne for now.
>>>>>>
>>>>>> OK, done.
>>>>>>
>>>>>> So after I've dropped it I think we need to do three things:
>>>>>> (1) Move the idle_set_state() calls to cpuidle_enter_state().
>>>>>> (2) Make cpuidle_enter_state() call default_idle_call() again, b=
ut this time
>>>>>>        do that *before* it has called idle_set_state() for targe=
t_state.
>>>>>> (3) Introduce demotion as per my last patch.
>>>>>>
>>>>>> Let me cut patches for that.
>>>>>
>>>>> Done as per the above and the patches follow in replies to this m=
essge.
>>>>>
>>>>> All on top of the current linux-next branch of the linux-pm.git t=
ree.
>>>>
>>>> IMO the resulting code is more and more confusing.
>>>
>>> Why is it confusing?
>>>
>>> What part of it is confusing?
>>>
>>> Patches [1-2/3] simply replace https://patchwork.kernel.org/patch/6=
326761/
>>> and I'm not sure why that would be confusing.
>>>
>>> Patch [3/3] simply causes cpuidle_enter_state() to pick up a more s=
uitable
>>> state if tick_broadcast_enter() fails instead of returning an error=
 code
>>> in that case.  What exactly is confusing in that?
>>>
>>>> Except I miss something, the tick_broadcast_enter can fail only if=
 the
>>>> local timer of the current cpu is used as a broadcast timer (which=
 is
>>>> the case today for PPC only).
>>>
>>> well, why does this matter?
>>>
>>>> The correct fix would be to tie this local timer with the cpu powe=
r
>>>> domain and disable the idle state powering down this domain like i=
t was
>>>> done for the renesas cpuidle driver.
>>>>
>>>> IOW, the cpu power domain is in use (because of its local timer), =
so we
>>>> shouldn't shut it down.
>>>>
>>>> No ?
>>>
>>> Sorry, I'm not sure what you're talking about.
>>>
>>> The problem at hand is that tick_broadcast_enter() can fail and we =
need to
>>> handle that.  If we can prevent it from ever failing, that would be=
 awesome,
>>> but quite honestly I don't see how to do that ATM.
>>
>> Ok, sorry. Let me clarify.
>>
>> You did a mechanism two years ago with pm_genpd_attach_cpuidle and
>> power_on/off. That disables a cpuidle state when a power domain is i=
n use.
>>
>> The idea I was proposing is to reuse this approach.
>>
>> The logic is:
>>
>> "The local timer is in use, this idle state power downs this timer, =
then
>> disable it".
>
> I'm not sure it's about powering down.  Stopping rather (which may or=
 may
> not involve powering down).
>
>> So it is when the broadcast timer is 'bound_on' a cpu, we disable th=
e
>> idle states. That could be done via a loop looking for the TIMER_STO=
P
>> flag or via the power domain.
>>
>> Hence the cpuidle_select will never return a state which powers down=
s
>> the local cpu (because they are disabled) and tick_broadcast_enter c=
an't
>> fail because it is never called.
>>
>> Does it make more sense ?
>
> Well, you've not explained what's confusing in the code after this se=
ries
> in the first place. :-)

It is not the series itself but the sum of the recent changes in this=20
area makes the overall more and more difficult to maintain. But that's =
a=20
personal opinion. Sounds like we are trying to catch the corner cases=20
each time there is a change somewhere.

> Second, quite honestly, I don't see a connection to genpd here.

Probably I am not clear :)

The connection we have is the local timer and the cpuidle framework=20
shutting it down. Why ? Because the local timer belongs to the cpu's=20
power domain.

Using the genpd to describe this relation between an idle state and the=
=20
devices impacted by via a power domain is, in my opinion, a nice=20
abstraction and a good opportunity to integrate the different=20
subsystems. Furthermore it is consistent with Kevin's investigation=20
around the power domain and SoC idle.

Kevin ?

> What you seem to be saying is "maybe we can eliminate the need to che=
ck the
> return value of tick_broadcast_enter() in the idle loop if we proacti=
vely
> disable the TIMER_STOP idle states of a CPU when we start to use that=
 CPU's
> timer as a broadcast one".

Well, not exactly. That's the consequence.

I meant, using any devices in a specific power domain makes impossible=20
to shut it down.

The timer and the cpu belong to the same power domain, hence it should=20
be impossible to reach an idle state where it is shut down.

The consequence is the tick_broadcast_enter *can't* fail by using this=20
approach and we don't have to handle a corner case.

There are boards where some idle states are powering down the console=20
because the power controller has larger power domain including cpu and=20
console or i2c or dma. In order to handle this, there is some specific=20
code in the cpuidle driver to check if the bus is in use.

IMO, we have exactly the same constraint here with the timer and we are=
=20
handling it in another different way.

> So this seems to be about the timekeeping rather than power domains, =
because
> that's where the broadcast thing is done.

I disagree. It should be done via a common API (eg. pm_runtime_get/put)=
=2E

> So the code setting up the CPU's
> timer for broadcast would pretty much need to pause cpuidle, go throu=
gh the
> CPU's idle states and disable the TIMER_STOP ones.  And do the revers=
e when the
> timer is not going the be used for broadcast any more.  So question i=
s whether
> or not this is actually really more straightforward than checking the=
 return
> value of tick_broadcast_enter() in the idle loop after all.

I agree this is not straightforward and your changes are valid, even I=20
think we can do something better by redesigning a bit.

But I guess I would have to provide a patchset for that ... :)

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


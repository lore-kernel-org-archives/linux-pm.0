From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Tue, 12 May 2015 10:41:35 +0200
Message-ID: <5551BCBF.2000806@linaro.org>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com> <8965830.CMQzZzsqm0@vostro.rjw.lan> <5550E999.8080005@linaro.org> <2602092.6h7ufczYGd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35944 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbbELIlj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 04:41:39 -0400
Received: by wizk4 with SMTP id k4so141933636wiz.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 01:41:38 -0700 (PDT)
In-Reply-To: <2602092.6h7ufczYGd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org, Kevin Hilman <khilman@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 05/12/2015 01:31 AM, Rafael J. Wysocki wrote:
> On Monday, May 11, 2015 07:40:41 PM Daniel Lezcano wrote:
>> On 05/10/2015 01:15 AM, Rafael J. Wysocki wrote:
>>> On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
>>>> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
>>>>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
>>>>>> Hi Rafael,
>>>>>>
>>>>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>>>>>
>>>>> [cut]
>>>>>
>>>>>>>>
>>>>>>>> +	/* Take note of the planned idle state. */
>>>>>>>> +	idle_set_state(smp_processor_id(), target_state);
>>>>>>>
>>>>>>> And I wouldn't do this either.
>>>>>>>
>>>>>>> The behavior here is pretty much as though the driver demoted t=
he state chosen
>>>>>>> by the governor and we don't call idle_set_state() again in tho=
se cases.
>>>>>>
>>>>>> Why is this wrong?
>>>>>
>>>>> It is not "wrong", but incomplete, because demotions done by the =
cpuidle driver
>>>>> should also be taken into account in the same way.
>>>>>
>>>>> But I'm seeing that the recent patch of mine that made cpuidle_en=
ter_state()
>>>>> call default_idle_call() was a mistake, because it might confuse =
find_idlest_cpu()
>>>>> significantly as to what state the CPU is in.  I'll drop that one=
 for now.
>>>>
>>>> OK, done.
>>>>
>>>> So after I've dropped it I think we need to do three things:
>>>> (1) Move the idle_set_state() calls to cpuidle_enter_state().
>>>> (2) Make cpuidle_enter_state() call default_idle_call() again, but=
 this time
>>>>       do that *before* it has called idle_set_state() for target_s=
tate.
>>>> (3) Introduce demotion as per my last patch.
>>>>
>>>> Let me cut patches for that.
>>>
>>> Done as per the above and the patches follow in replies to this mes=
sge.
>>>
>>> All on top of the current linux-next branch of the linux-pm.git tre=
e.
>>
>> IMO the resulting code is more and more confusing.
>
> Why is it confusing?
>
> What part of it is confusing?
>
> Patches [1-2/3] simply replace https://patchwork.kernel.org/patch/632=
6761/
> and I'm not sure why that would be confusing.
>
> Patch [3/3] simply causes cpuidle_enter_state() to pick up a more sui=
table
> state if tick_broadcast_enter() fails instead of returning an error c=
ode
> in that case.  What exactly is confusing in that?
>
>> Except I miss something, the tick_broadcast_enter can fail only if t=
he
>> local timer of the current cpu is used as a broadcast timer (which i=
s
>> the case today for PPC only).
>
> well, why does this matter?
>
>> The correct fix would be to tie this local timer with the cpu power
>> domain and disable the idle state powering down this domain like it =
was
>> done for the renesas cpuidle driver.
>>
>> IOW, the cpu power domain is in use (because of its local timer), so=
 we
>> shouldn't shut it down.
>>
>> No ?
>
> Sorry, I'm not sure what you're talking about.
>
> The problem at hand is that tick_broadcast_enter() can fail and we ne=
ed to
> handle that.  If we can prevent it from ever failing, that would be a=
wesome,
> but quite honestly I don't see how to do that ATM.

Ok, sorry. Let me clarify.

You did a mechanism two years ago with pm_genpd_attach_cpuidle and=20
power_on/off. That disables a cpuidle state when a power domain is in u=
se.

The idea I was proposing is to reuse this approach.

The logic is:

"The local timer is in use, this idle state power downs this timer, the=
n=20
disable it".

So it is when the broadcast timer is 'bound_on' a cpu, we disable the=20
idle states. That could be done via a loop looking for the TIMER_STOP=20
flag or via the power domain.

Hence the cpuidle_select will never return a state which powers downs=20
the local cpu (because they are disabled) and tick_broadcast_enter can'=
t=20
fail because it is never called.

Does it make more sense ?

>> I am aware this is not easily fixable because the genpd framework is
>> incomplete and has some restrictions but I believe it is worth to ha=
ve a
>> discussion. Add Kevin and Ulf in Cc.
>
> So I'm going to queue up these patches for 4.2 and we can have a disc=
ussion
> just fine regardless.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


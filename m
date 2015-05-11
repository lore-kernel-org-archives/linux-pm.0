From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Mon, 11 May 2015 19:40:41 +0200
Message-ID: <5550E999.8080005@linaro.org>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com> <10239011.l6QLHlKIVm@vostro.rjw.lan> <3161640.llJtBoKCBr@vostro.rjw.lan> <8965830.CMQzZzsqm0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38310 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbEKRkq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 13:40:46 -0400
Received: by wiun10 with SMTP id n10so105692565wiu.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 10:40:44 -0700 (PDT)
In-Reply-To: <8965830.CMQzZzsqm0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org
Cc: tglx@linutronix.de, rafael.j.wysocki@intel.com, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org, Kevin Hilman <khilman@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 05/10/2015 01:15 AM, Rafael J. Wysocki wrote:
> On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
>> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
>>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
>>>> Hi Rafael,
>>>>
>>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>>>
>>> [cut]
>>>
>>>>>>
>>>>>> +	/* Take note of the planned idle state. */
>>>>>> +	idle_set_state(smp_processor_id(), target_state);
>>>>>
>>>>> And I wouldn't do this either.
>>>>>
>>>>> The behavior here is pretty much as though the driver demoted the=
 state chosen
>>>>> by the governor and we don't call idle_set_state() again in those=
 cases.
>>>>
>>>> Why is this wrong?
>>>
>>> It is not "wrong", but incomplete, because demotions done by the cp=
uidle driver
>>> should also be taken into account in the same way.
>>>
>>> But I'm seeing that the recent patch of mine that made cpuidle_ente=
r_state()
>>> call default_idle_call() was a mistake, because it might confuse fi=
nd_idlest_cpu()
>>> significantly as to what state the CPU is in.  I'll drop that one f=
or now.
>>
>> OK, done.
>>
>> So after I've dropped it I think we need to do three things:
>> (1) Move the idle_set_state() calls to cpuidle_enter_state().
>> (2) Make cpuidle_enter_state() call default_idle_call() again, but t=
his time
>>      do that *before* it has called idle_set_state() for target_stat=
e.
>> (3) Introduce demotion as per my last patch.
>>
>> Let me cut patches for that.
>
> Done as per the above and the patches follow in replies to this messg=
e.
>
> All on top of the current linux-next branch of the linux-pm.git tree.

IMO the resulting code is more and more confusing.

Except I miss something, the tick_broadcast_enter can fail only if the=20
local timer of the current cpu is used as a broadcast timer (which is=20
the case today for PPC only).

The correct fix would be to tie this local timer with the cpu power=20
domain and disable the idle state powering down this domain like it was=
=20
done for the renesas cpuidle driver.

IOW, the cpu power domain is in use (because of its local timer), so we=
=20
shouldn't shut it down.

No ?

I am aware this is not easily fixable because the genpd framework is=20
incomplete and has some restrictions but I believe it is worth to have =
a=20
discussion. Add Kevin and Ulf in Cc.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


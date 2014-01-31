From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Fri, 31 Jan 2014 17:35:45 +0100
Message-ID: <52EBD0E1.3030508@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org> <20140130153150.GD5002@laptop.programming.kicks-ass.net> <52EA7D8A.6080604@linaro.org> <20140130163501.GG5002@laptop.programming.kicks-ass.net> <52EA8B07.6020206@linaro.org> <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com> <20140131090230.GM5002@laptop.programming.kicks-ass.net> <52EB6F65.8050008@linux.vnet.ibm.com> <52EBBC23.8020603@linux.intel.com> <52EBC33A.6080101@linaro.org> <52EBC645.2040607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52EBC645.2040607@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>
Cc: Preeti Murthy <preeti.lkml@gmail.com>, nicolas.pitre@linaro.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 01/31/2014 04:50 PM, Arjan van de Ven wrote:
> On 1/31/2014 7:37 AM, Daniel Lezcano wrote:
>> On 01/31/2014 04:07 PM, Arjan van de Ven wrote:
>>>>>>
>>>>>> Hence I think this patch would make sense only with additional
>>>>>> information
>>>>>> like exit_latency or target_residency is present for the schedul=
er.
>>>>>> The idle
>>>>>> state index alone will not be sufficient.
>>>>>
>>>>> Alternatively, can we enforce sanity on the cpuidle infrastructur=
e to
>>>>> make the index naturally ordered? If not, please explain why :-)
>>>>
>>>> The commit id 71abbbf856a0e70 says that there are SOCs which could=
 have
>>>> their target_residency and exit_latency values change at runtime. =
This
>>>> commit thus removed the ordering of the idle states according to t=
heir
>>>> target_residency/exit_latency. Adding Len and Arjan to the CC.
>>>
>>> the ARM folks wanted a dynamic exit latency, so.... it makes much m=
ore
>>> sense
>>> to me to store the thing you want to use (exit latency) than the nu=
mber
>>> of the state.
>>>
>>> more than that, you can order either by target residency OR by exit
>>> latency,
>>> if you sort by one, there is no guarantee that you're also sorted b=
y the
>>> other
>>
>> IMO, it would be preferable to store the index for the moment as we
>> are integrating cpuidle with the scheduler. The index allows to acce=
ss
>> more informations. Then when
>> everything is fully integrated we can improve the result, no ?
>
> more information, yes. but if the information isn't actually accurate
> (because it keeps changing
> in the datastructure away from what it was for the cpu)... are you
> really achieving what you want?
>
> on x86 I don't care; we don't actually change these dynamically much[=
1].
> But if you have 1 or 2 things in mind to use,
> I would suggest copying those 2 integers instead as we go, rather tha=
n
> the index.
> Saves refcounting/locking etc etc nightmare as well on the other
> subsystems' datastructures..
> ... which you likely need to do to actually follow that index.

Hmm, yeah. That's a fair argument. That is true, the races and=20
locks/refcnt are something we have to worried about. But also we may=20
want to prevent duplicating the data across the subsystems.

> [1] Although in an ACPI world, the total number of C states can vary,
> for example it used to be quite common
> that you got an extra C state on battery versus on wall power. This s=
ort
> of dynamic thing requires refcounting
> if more than the local cpuidle uses the data structures.
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

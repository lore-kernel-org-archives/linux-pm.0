From: jonghwa3.lee@samsung.com
Subject: Re: [RFC PATCH 1/2] cpuidle: Add idle enter/exit time stamp for
 notifying current idle state.
Date: Wed, 03 Apr 2013 15:10:08 +0900
Message-ID: <515BC7C0.3090009@samsung.com>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
 <1364804657-16590-2-git-send-email-jonghwa3.lee@samsung.com>
 <515A65DB.8070803@linaro.org> <515A77FC.70008@samsung.com>
 <515A8A21.6070509@linaro.org> <515AA6C3.3060408@samsung.com>
 <515AAE2C.3040407@linaro.org> <515ABC0C.1090102@samsung.com>
 <515ABE83.3070200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43615 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761746Ab3DCGKM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 02:10:12 -0400
In-reply-to: <515ABE83.3070200@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com

On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 20:18, Daniel Lezcano wrote:

> On 04/02/2013 01:07 PM, jonghwa3.lee@samsung.com wrote:
>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 19:08, Daniel Lezcano wrote=
:
>>
>>> On 04/02/2013 11:37 AM, jonghwa3.lee@samsung.com wrote:
>>>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 16:34, Daniel Lezcano wro=
te:
>>>>
>>>>> On 04/02/2013 08:17 AM, jonghwa3.lee@samsung.com wrote:
>>>>>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 14:00, Daniel Lezcano w=
rote:
>>>>>>
>>>>>>> On 04/01/2013 10:24 AM, Jonghwa Lee wrote:
>>>>>>>> This patch adds idle state time stamp to cpuidle device struct=
ure to
>>>>>>>> notify its current idle state. If last enter time is newer tha=
n last
>>>>>>>> exit time, then it means that the core is in idle now.
>>>>>>>>
>>>>>>>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>>>>>>>> ---
>>>>>>>
>>>>>>> The patch description does not explain what problem you want to=
 solve,
>>>>>>> how to solve it and the patch itself shows nothing.
>>>>>>>
>>>>>>> Could you elaborate ?
>>>>>>
>>>>>>
>>>>>> I'm sorry for lacking description. I supplement more.
>>>>>>
>>>>>> This patch does add time-stamp for idle enter/exit only nothing =
more.
>>>>>> The reason why I needed them is that I wanted to know current cp=
u idle
>>>>>> state. It is hard to know whether cpu is in idle or not now.
>>>>>
>>>>> Did you looked at:
>>>>>
>>>>> include/linux/sched.h:extern int idle_cpu(int cpu);
>>>>>
>>>>
>>>>
>>>> Yes, I did.
>>>>
>>>>> ?
>>>>>
>>>>>> When I check the cpuidle state usage, sometimes the information =
is wrong.
>>>>>> Because it is updated only when the cpu exits the idle state. So=
 while the
>>>>>> cpu is idling, the cpuidle state usage holds past one. Therefore=
 I put
>>>>>> the time-stamp for cpuidle enter/exit for checking current idlin=
g and
>>>>>> calculating idle state usage correctly.
>>>>>>
>>>>>> I just make this patch temporary for my cpufreq governor work. S=
o, it just
>>>>>> use time-stamp for all idle state together. After RFC working, I=
 have a plan
>>>>>> to update this patch to use timestamp for each idle state.
>>>>>
>>>>> I suggest you look at the enter_idle / exit_idle function and mak=
e your
>>>>> governor to subscribe to the IDLE_START/EXIT notifiers.
>>>>>
>>>>> arch/x86/kernel/process.c
>>>>>
>>>>> These are defined for the x86 architecture, maybe worth to add it=
 to
>>>>> another architecture.
>>>>>
>>>>
>>>>
>>>> Thanks for your opinion.
>>>>
>>>> Actually, I work on ARM architecture and I knew that the attempt o=
f applying
>>>> idle notifier was failed. You probably knew it, because the link y=
ou gave me
>>>> before is that attempt. (https://lkml.org/lkml/2012/2/7/504) :)
>>>
>>> Yeah, now I recall this thread.
>>>
>>
>>
>> Oh my, I thought you gave the link but you didn't. It was Viresh Kum=
ar from
>> other patch of the patchset. Sorry.
>>
>>>> Currently, there
>>>> is only notifying call which is for led in arch/arm/kernel/process=
=2Ec and I think
>>>> it isn't for me to use. Anyway, Do you really think it is better w=
ay to use
>>>> notifier than my way? Because I think it is too heavy for me. On m=
y board,
>>>> sometimes entering idle happened hundreds times during the 100ms. =
I don't want
>>>> to call notifier that much time. IMO, just moving local variable t=
o per-cpu
>>>> variable for showing the enter/exit time looks better although it =
requires code
>>>> modification on cpudile side.  What do you think?
>>>
>>> Sorry, but it is hard to figure out what you are trying to achieve =
with
>>> a single patch.
>>>
>>> IIUC, you want to know how long the cpu is idle including the curre=
nt
>>> state, right ? So you need to know if the cpu is idle and when it
>>> entered the idle state, correct ?
>>>
>>
>>
>> Exactly.
>>
>> =20
>>> If the cpu is idle and the information is per cpu, how will you rea=
d
>>> this value from another cpu without introducing a locking mechanism=
 ?
>>>
>>
>>
>> I think it might be tolerated for incoherency of that data. Governor=
 reads the
>> data only, and if recoded start time or end time are different in fe=
w usec with
>> real one then it doesn't effect to the result much.
>>
>>
>>> Does it mean the cpufreq governor needs cpuidle ? I am wondering if
>>> these informations shouldn't be retrieved from the scheduler, not f=
rom
>>> cpuidle.
>>>
>>
>>
>> Yes, tick_sched per-cpu variable has all information that I need. Bu=
t it isn't
>> global variable. And I'm afraid to change static variable to global =
one as my
>> pleases.
>=20
> It is a global variable but there is a function to get access:
>=20
> extern struct tick_sched *tick_get_tick_sched(int cpu);
>=20
> Does it fit better for what you want to achieve ?


Yes, it seems exactly what I needed. I'll check it.
Thanks for your advice :)

Thanks,
Jonghwa.

>=20
> Thanks
>   -- Daniel
>=20
>=20



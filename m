From: jonghwa3.lee@samsung.com
Subject: Re: [RFC PATCH 1/2] cpuidle: Add idle enter/exit time stamp for
 notifying current idle state.
Date: Tue, 02 Apr 2013 20:07:56 +0900
Message-ID: <515ABC0C.1090102@samsung.com>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
 <1364804657-16590-2-git-send-email-jonghwa3.lee@samsung.com>
 <515A65DB.8070803@linaro.org> <515A77FC.70008@samsung.com>
 <515A8A21.6070509@linaro.org> <515AA6C3.3060408@samsung.com>
 <515AAE2C.3040407@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <515AAE2C.3040407@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 19:08, Daniel Lezcano wrote:

> On 04/02/2013 11:37 AM, jonghwa3.lee@samsung.com wrote:
>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 16:34, Daniel Lezcano wrote=
:
>>
>>> On 04/02/2013 08:17 AM, jonghwa3.lee@samsung.com wrote:
>>>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 14:00, Daniel Lezcano wro=
te:
>>>>
>>>>> On 04/01/2013 10:24 AM, Jonghwa Lee wrote:
>>>>>> This patch adds idle state time stamp to cpuidle device structur=
e to
>>>>>> notify its current idle state. If last enter time is newer than =
last
>>>>>> exit time, then it means that the core is in idle now.
>>>>>>
>>>>>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>>>>>> ---
>>>>>
>>>>> The patch description does not explain what problem you want to s=
olve,
>>>>> how to solve it and the patch itself shows nothing.
>>>>>
>>>>> Could you elaborate ?
>>>>
>>>>
>>>> I'm sorry for lacking description. I supplement more.
>>>>
>>>> This patch does add time-stamp for idle enter/exit only nothing mo=
re.
>>>> The reason why I needed them is that I wanted to know current cpu =
idle
>>>> state. It is hard to know whether cpu is in idle or not now.
>>>
>>> Did you looked at:
>>>
>>> include/linux/sched.h:extern int idle_cpu(int cpu);
>>>
>>
>>
>> Yes, I did.
>>
>>> ?
>>>
>>>> When I check the cpuidle state usage, sometimes the information is=
 wrong.
>>>> Because it is updated only when the cpu exits the idle state. So w=
hile the
>>>> cpu is idling, the cpuidle state usage holds past one. Therefore I=
 put
>>>> the time-stamp for cpuidle enter/exit for checking current idling =
and
>>>> calculating idle state usage correctly.
>>>>
>>>> I just make this patch temporary for my cpufreq governor work. So,=
 it just
>>>> use time-stamp for all idle state together. After RFC working, I h=
ave a plan
>>>> to update this patch to use timestamp for each idle state.
>>>
>>> I suggest you look at the enter_idle / exit_idle function and make =
your
>>> governor to subscribe to the IDLE_START/EXIT notifiers.
>>>
>>> arch/x86/kernel/process.c
>>>
>>> These are defined for the x86 architecture, maybe worth to add it t=
o
>>> another architecture.
>>>
>>
>>
>> Thanks for your opinion.
>>
>> Actually, I work on ARM architecture and I knew that the attempt of =
applying
>> idle notifier was failed. You probably knew it, because the link you=
 gave me
>> before is that attempt. (https://lkml.org/lkml/2012/2/7/504) :)
>=20
> Yeah, now I recall this thread.
>=20


Oh my, I thought you gave the link but you didn't. It was Viresh Kumar =
from
other patch of the patchset. Sorry.

>> Currently, there
>> is only notifying call which is for led in arch/arm/kernel/process.c=
 and I think
>> it isn't for me to use. Anyway, Do you really think it is better way=
 to use
>> notifier than my way? Because I think it is too heavy for me. On my =
board,
>> sometimes entering idle happened hundreds times during the 100ms. I =
don't want
>> to call notifier that much time. IMO, just moving local variable to =
per-cpu
>> variable for showing the enter/exit time looks better although it re=
quires code
>> modification on cpudile side.  What do you think?
>=20
> Sorry, but it is hard to figure out what you are trying to achieve wi=
th
> a single patch.
>=20
> IIUC, you want to know how long the cpu is idle including the current
> state, right ? So you need to know if the cpu is idle and when it
> entered the idle state, correct ?
>


Exactly.

=20
> If the cpu is idle and the information is per cpu, how will you read
> this value from another cpu without introducing a locking mechanism ?
>=20


I think it might be tolerated for incoherency of that data. Governor re=
ads the
data only, and if recoded start time or end time are different in few u=
sec with
real one then it doesn't effect to the result much.


> Does it mean the cpufreq governor needs cpuidle ? I am wondering if
> these informations shouldn't be retrieved from the scheduler, not fro=
m
> cpuidle.
>=20


Yes, tick_sched per-cpu variable has all information that I need. But i=
t isn't
global variable. And I'm afraid to change static variable to global one=
 as my
pleases.


Thanks,
Jonghwa


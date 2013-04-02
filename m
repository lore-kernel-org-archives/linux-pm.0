From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 1/2] cpuidle: Add idle enter/exit time stamp for notifying
 current idle state.
Date: Tue, 02 Apr 2013 13:18:27 +0200
Message-ID: <515ABE83.3070200@linaro.org>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com> <1364804657-16590-2-git-send-email-jonghwa3.lee@samsung.com> <515A65DB.8070803@linaro.org> <515A77FC.70008@samsung.com> <515A8A21.6070509@linaro.org> <515AA6C3.3060408@samsung.com> <515AAE2C.3040407@linaro.org> <515ABC0C.1090102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <515ABC0C.1090102@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

On 04/02/2013 01:07 PM, jonghwa3.lee@samsung.com wrote:
> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 19:08, Daniel Lezcano wrote:
>=20
>> On 04/02/2013 11:37 AM, jonghwa3.lee@samsung.com wrote:
>>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 16:34, Daniel Lezcano wrot=
e:
>>>
>>>> On 04/02/2013 08:17 AM, jonghwa3.lee@samsung.com wrote:
>>>>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 14:00, Daniel Lezcano wr=
ote:
>>>>>
>>>>>> On 04/01/2013 10:24 AM, Jonghwa Lee wrote:
>>>>>>> This patch adds idle state time stamp to cpuidle device structu=
re to
>>>>>>> notify its current idle state. If last enter time is newer than=
 last
>>>>>>> exit time, then it means that the core is in idle now.
>>>>>>>
>>>>>>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>>>>>>> ---
>>>>>>
>>>>>> The patch description does not explain what problem you want to =
solve,
>>>>>> how to solve it and the patch itself shows nothing.
>>>>>>
>>>>>> Could you elaborate ?
>>>>>
>>>>>
>>>>> I'm sorry for lacking description. I supplement more.
>>>>>
>>>>> This patch does add time-stamp for idle enter/exit only nothing m=
ore.
>>>>> The reason why I needed them is that I wanted to know current cpu=
 idle
>>>>> state. It is hard to know whether cpu is in idle or not now.
>>>>
>>>> Did you looked at:
>>>>
>>>> include/linux/sched.h:extern int idle_cpu(int cpu);
>>>>
>>>
>>>
>>> Yes, I did.
>>>
>>>> ?
>>>>
>>>>> When I check the cpuidle state usage, sometimes the information i=
s wrong.
>>>>> Because it is updated only when the cpu exits the idle state. So =
while the
>>>>> cpu is idling, the cpuidle state usage holds past one. Therefore =
I put
>>>>> the time-stamp for cpuidle enter/exit for checking current idling=
 and
>>>>> calculating idle state usage correctly.
>>>>>
>>>>> I just make this patch temporary for my cpufreq governor work. So=
, it just
>>>>> use time-stamp for all idle state together. After RFC working, I =
have a plan
>>>>> to update this patch to use timestamp for each idle state.
>>>>
>>>> I suggest you look at the enter_idle / exit_idle function and make=
 your
>>>> governor to subscribe to the IDLE_START/EXIT notifiers.
>>>>
>>>> arch/x86/kernel/process.c
>>>>
>>>> These are defined for the x86 architecture, maybe worth to add it =
to
>>>> another architecture.
>>>>
>>>
>>>
>>> Thanks for your opinion.
>>>
>>> Actually, I work on ARM architecture and I knew that the attempt of=
 applying
>>> idle notifier was failed. You probably knew it, because the link yo=
u gave me
>>> before is that attempt. (https://lkml.org/lkml/2012/2/7/504) :)
>>
>> Yeah, now I recall this thread.
>>
>=20
>=20
> Oh my, I thought you gave the link but you didn't. It was Viresh Kuma=
r from
> other patch of the patchset. Sorry.
>=20
>>> Currently, there
>>> is only notifying call which is for led in arch/arm/kernel/process.=
c and I think
>>> it isn't for me to use. Anyway, Do you really think it is better wa=
y to use
>>> notifier than my way? Because I think it is too heavy for me. On my=
 board,
>>> sometimes entering idle happened hundreds times during the 100ms. I=
 don't want
>>> to call notifier that much time. IMO, just moving local variable to=
 per-cpu
>>> variable for showing the enter/exit time looks better although it r=
equires code
>>> modification on cpudile side.  What do you think?
>>
>> Sorry, but it is hard to figure out what you are trying to achieve w=
ith
>> a single patch.
>>
>> IIUC, you want to know how long the cpu is idle including the curren=
t
>> state, right ? So you need to know if the cpu is idle and when it
>> entered the idle state, correct ?
>>
>=20
>=20
> Exactly.
>=20
> =20
>> If the cpu is idle and the information is per cpu, how will you read
>> this value from another cpu without introducing a locking mechanism =
?
>>
>=20
>=20
> I think it might be tolerated for incoherency of that data. Governor =
reads the
> data only, and if recoded start time or end time are different in few=
 usec with
> real one then it doesn't effect to the result much.
>=20
>=20
>> Does it mean the cpufreq governor needs cpuidle ? I am wondering if
>> these informations shouldn't be retrieved from the scheduler, not fr=
om
>> cpuidle.
>>
>=20
>=20
> Yes, tick_sched per-cpu variable has all information that I need. But=
 it isn't
> global variable. And I'm afraid to change static variable to global o=
ne as my
> pleases.

It is a global variable but there is a function to get access:

extern struct tick_sched *tick_get_tick_sched(int cpu);

Does it fit better for what you want to achieve ?

Thanks
  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


From: jonghwa3.lee@samsung.com
Subject: Re: [RFC PATCH 1/2] cpuidle: Add idle enter/exit time stamp for
 notifying current idle state.
Date: Tue, 02 Apr 2013 18:37:07 +0900
Message-ID: <515AA6C3.3060408@samsung.com>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
 <1364804657-16590-2-git-send-email-jonghwa3.lee@samsung.com>
 <515A65DB.8070803@linaro.org> <515A77FC.70008@samsung.com>
 <515A8A21.6070509@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <515A8A21.6070509@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 16:34, Daniel Lezcano wrote:

> On 04/02/2013 08:17 AM, jonghwa3.lee@samsung.com wrote:
>> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 14:00, Daniel Lezcano wrote=
:
>>
>>> On 04/01/2013 10:24 AM, Jonghwa Lee wrote:
>>>> This patch adds idle state time stamp to cpuidle device structure =
to
>>>> notify its current idle state. If last enter time is newer than la=
st
>>>> exit time, then it means that the core is in idle now.
>>>>
>>>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>>>> ---
>>>
>>> The patch description does not explain what problem you want to sol=
ve,
>>> how to solve it and the patch itself shows nothing.
>>>
>>> Could you elaborate ?
>>
>>
>> I'm sorry for lacking description. I supplement more.
>>
>> This patch does add time-stamp for idle enter/exit only nothing more=
=2E
>> The reason why I needed them is that I wanted to know current cpu id=
le
>> state. It is hard to know whether cpu is in idle or not now.
>=20
> Did you looked at:
>=20
> include/linux/sched.h:extern int idle_cpu(int cpu);
>=20


Yes, I did.

> ?
>=20
>> When I check the cpuidle state usage, sometimes the information is w=
rong.
>> Because it is updated only when the cpu exits the idle state. So whi=
le the
>> cpu is idling, the cpuidle state usage holds past one. Therefore I p=
ut
>> the time-stamp for cpuidle enter/exit for checking current idling an=
d
>> calculating idle state usage correctly.
>>
>> I just make this patch temporary for my cpufreq governor work. So, i=
t just
>> use time-stamp for all idle state together. After RFC working, I hav=
e a plan
>> to update this patch to use timestamp for each idle state.
>=20
> I suggest you look at the enter_idle / exit_idle function and make yo=
ur
> governor to subscribe to the IDLE_START/EXIT notifiers.
>=20
> arch/x86/kernel/process.c
>=20
> These are defined for the x86 architecture, maybe worth to add it to
> another architecture.
>=20


Thanks for your opinion.

Actually, I work on ARM architecture and I knew that the attempt of app=
lying
idle notifier was failed. You probably knew it, because the link you ga=
ve me
before is that attempt. (https://lkml.org/lkml/2012/2/7/504) :) Current=
ly, there
is only notifying call which is for led in arch/arm/kernel/process.c an=
d I think
it isn't for me to use. Anyway, Do you really think it is better way to=
 use
notifier than my way? Because I think it is too heavy for me. On my boa=
rd,
sometimes entering idle happened hundreds times during the 100ms. I don=
't want
to call notifier that much time. IMO, just moving local variable to per=
-cpu
variable for showing the enter/exit time looks better although it requi=
res code
modification on cpudile side.  What do you think?

Thanks,
Jonghwa.

> Thanks
>   -- Daniel
>=20



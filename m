From: jonghwa3.lee@samsung.com
Subject: Re: [RFC PATCH 0/2] cpufreq: Introduce LAB cpufreq governor.
Date: Tue, 09 Apr 2013 21:25:46 +0900
Message-ID: <516408CA.5030009@samsung.com>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAOh2x=nPJa0GReiN=OHLG=m4Gq51F=4VppdaQL20xi-aUa8x2Q@mail.gmail.com>
 <20130409123719.7399d5ad@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <20130409123719.7399d5ad@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi, sorry for my late reply.
I just want to add comment to assist Lukasz's.
I put my comments below of Lukasz's.

On 2013=EB=85=84 04=EC=9B=94 09=EC=9D=BC 19:37, Lukasz Majewski wrote:

> Hi Viresh,
>=20
> First of all I'd like to apologize for a late response.
> Please find my comments below.=20
>=20
>> On Mon, Apr 1, 2013 at 1:54 PM, Jonghwa Lee
>> <jonghwa3.lee@samsung.com> wrote:
>>> <<Purpose>>
>>>  One of the problem of ondemand is that it considers the most busy
>>> cpu only while doesn't care how many cpu is in busy state at the
>>> moment. This may results in unnecessary power consumption, and it'l=
l
>>> be critical for the system having limited power source.
>>>
>>>  To get the best energy efficiency, LAB governor considers not only
>>> idle time but also the number of idle cpus. It primarily focuses on
>>> supplying adequate performance to users within the limited resource=
=2E
>>> It checks the number of idle cpus then controls the maximum
>>> frequency dynamically. And it also applies different frequency
>>> increasing level depends on that information. In simple terms the
>>> less the number of busy cpus, the better performance will be given.
>>>  In addition, stable system's power consumption in the busy state
>>> can be achieved also with using LAB governor. This will help to
>>> manage and estimate power consumption in certain system.
>>
>> Hi Jonghwa,
>>
>> First of all, i should accept that i haven't got to the minute detai=
ls
>> about your
>> patch until now but have done a broad review of it.
>>
>> There are many things that i am concerned about:
>> - I don't want an additional governor to be added to cpufreq unless
>> there is a very very strong reason for it. See what happened to
>> earlier attempts:
>>
>> https://lkml.org/lkml/2012/2/7/504
>>
>> But it doesn't mean you can't get it in. :)
>>
>> - What the real logic behind your patchset: I haven't got it
>> completely with your
>> mails. So what you said is:
>>
>>   - The lesser the number of busy cpus: you want to run at higher
>> freqs
>>   - The more the number of busy cpus: you want to run at lower freqs
>>
>> But the basic idea i had about this stuff was: The more the number o=
f
>> busy cpus, the more loaded the system is, otherwise scheduler wouldn=
't
>> have used so many cpus and so there is need to run at higher frequen=
cy
>> rather than a lower one. Which would save power in a sense.. Finish
>> work early and let most of the cpus enter idle state as early as
>> possible. But with your solution we would run at lower frequencies
>> and so these cpus will take longer to get into idle state again. Thi=
s
>> will really kill lot of power.
>=20
> Our approach is a bit different than cpufreq_ondemand one. Ondemand
> takes the per CPU idle time, then on that basis calculates per cpu lo=
ad.
> The next step is to choose the highest load and then use this value t=
o
> properly scale frequency.
>=20
> On the other hand LAB tries to model different behavior:
>=20
> As a first step we applied Vincent Guittot's "pack small tasks" [*]
> patch to improve "race to idle" behavior:
> http://article.gmane.org/gmane.linux.kernel/1371435/match=3Dsched+pac=
k+small+tasks=09
>=20
> Afterwards, we decided to investigate different approach for power
> governing:
>=20
> Use the number of sleeping CPUs (not the maximal per-CPU load) to
> change frequency. We thereof depend on [*] to "pack" as many tasks to
> CPU as possible and allow other to sleep.=20
> On this basis we can increase (even overclock) frequency (when other
> CPUs sleep) to improve performance of the only running CPU.=20
>=20
> Contrary, when all cores are heavily loaded, we decided to reduce
> frequency by around 30%. With this approach user experience recution =
is
> still acceptable (with much less power consumption).
> When system is "idle" - only small background tasks are running, the
> frequency is reduced to minimum.=20
>=20
> To sum up:
>=20
> Different approach (number of idle CPUs) is used by us to control
> ondemand governor. We also heavily depend on [*] patch set.
>


In additions, it is hard to say just letting high performance to busy s=
ystem is
the best way for reducing the power consumption. Yes, as like Viresh sa=
id, we
can save the time of busy working, but that is not always perfect
solution. If we push all CPUs to keep high performance as much as they =
can,
the temperature will increase rapidly. In my test, on-demand governor r=
eached
the thermal limits frequently, while lab governor didn't. And the high
temperature also effects the power consumption increasing. I got a roug=
h result
which has 10% differences in power consumption between 20% temperature =
differed
conditions.

    <<Consumed power with maximum frequency at different temperature>>

      Temperature     Power consumption(mWh)         Loss(%)
         65'C                  53.89                  Base
         80'C                  59.88                   10

So, to reduce the power consumption, it looks we have to give our cares=
 more to
avoid the situation where system goes to high temperature. It is more m=
eaningful
for the mobile environment. In mobile devices, high temperature will al=
so affect
user's experience badly and can't be decreased easily.

Maybe temperature problem is not the duty of cpufreq governor. However,=
 if we
just take a look at power consumption gain, we can find the right of th=
e this
governor either.

    <<Consumed power during the web browsing with foreground movie play=
>>

        Governor     Power consumption(mWh)       Percentage(%)
        ondemand            70.28                     100
          lab               55.14                      78

    =3D=3D=3D> There is almost 22% gain for power consumption.


              <<Results of various performance test>>

    ## v8 benchmark test (http://v8.googlecode.com)
        Governor       score          Percentage(%)
        ondemand       1736.75            100
          lab          1576.75             91

    =3D=3D=3D> 10% performance loss.

    ## Dhrystone
    	Governor       dhrystone     Percentage(%)
        ondemand        2362204           100
          lab           2197802            93

    =3D=3D=3D> 7% performance loss.

    ## Egypt GLbenchmark (http://www.glbenchmark.com)
        Governor       Frames      FPS
        ondemand        5612      49.65
          lab           5559      49.19

    =3D=3D=3D> Almost no differences.

(Above whole tests were tested on the EXYNOS4412 SoC based board.)

Thanks,
Jonghwa

>>
>> Think about it.
>>
>> - In case you need some sort of support on this use case, why
>> replicate ondemand governor again by creating another governor. I
>> have had some hard time removing the amount of redundancy inside
>> governors and you are again going towards that direction. Modifying
>> ondemand governor for this response would be a better option.
>=20
> We have only posted the "RFC" so, we are open for suggestions.=20
>=20
> At cpufreq_governor.c file the dbs_check_cpu function is responsible
> for calculating the maximal load (among CPUs). I think that we could
> also count the number of sleeping CPUs (as the average of time
> accumulated data). Then we could pass this data to newly written
> function (e.g. lab_check_cpu) defined at cpufreq_ondemand.c (and
> pointed to by gov_check_cpu).
>=20
> This would require change to dbs_check_cpu function and extending
> ONDEMAND governor by lab_check_cpu() function.
>=20
>>
>> - You haven't rebased of latest code from linux-next :)
>>
>=20
> We have posted this "RFC" patch mainly for discussion, and I think it
> fits its purpose :-).
>=20
>=20
>=20



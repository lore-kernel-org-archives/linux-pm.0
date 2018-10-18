From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Thu, 18 Oct 2018 12:17:42 -0400
Message-ID: <5BC8B226.2040109@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com> <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018064849.GA42813@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 10/18/2018 02:48 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>> On 10/16/2018 03:33 AM, Ingo Molnar wrote:
>>>
>>> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>>
>>>>>> Regarding testing, basic build, boot and sanity testing have been
>>>>>> performed on hikey960 mainline kernel with debian file system.
>>>>>> Further aobench (An occlusion renderer for benchmarking realworld
>>>>>> floating point performance) showed the following results on hikey960
>>>>>> with debain.
>>>>>>
>>>>>>                                         Result          Standard        Standard
>>>>>>                                         (Time secs)     Error           Deviation
>>>>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>>>>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>>>>
>>>>> Wow, +13% speedup, impressive! We definitely want this outcome.
>>>>>
>>>>> I'm wondering what happens if we do not track and decay the thermal 
>>>>> load at all at the PELT level, but instantaneously decrease/increase 
>>>>> effective CPU capacity in reaction to thermal events we receive from 
>>>>> the CPU.
>>>>
>>>> The problem with instantaneous update is that sometimes thermal events 
>>>> happen at a much faster pace than cpu_capacity is updated in the 
>>>> scheduler. This means that at the moment when scheduler uses the 
>>>> value, it might not be correct anymore.
>>>
>>> Let me offer a different interpretation: if we average throttling events 
>>> then we create a 'smooth' average of 'true CPU capacity' that doesn't 
>>> fluctuate much. This allows more stable yet asymmetric task placement if 
>>> the thermal characteristics of the different cores is different 
>>> (asymmetric). This, compared to instantaneous updates, would reduce 
>>> unnecessary task migrations between cores.
>>>
>>> Is that accurate?
>>
>> Yes. I think it is accurate. I will also add that if we don't average
>> throttling events, we will miss the events that occur in between load
>> balancing(LB) period.
> 
> Yeah, so I'd definitely suggest to not integrate this averaging into 
> pelt.c in the fashion presented, because:
> 
>  - This couples your thermal throttling averaging to the PELT decay
>    half-time AFAICS, which would break the other user every time the
>    decay is changed/tuned.
Let me pose the question in this manner. Today rt utilization, dl
utilization etc is tracked via PELT. The inherent idea is that, a cpu
has some capacity stolen by let us say rt task and so subtract the
capacity utilized by the rt task from cpu when calculating the remaining
capacity for a CFS task. Now, the idea behind thermal pressure is that,
the maximum available capacity of a cpu is limited due to a thermal
event, so take it out of the remaining capacity of a cpu for a CFS task
(at-least to start with). If utilization for rt task, dl task etc is
calculated via PELT and the capacity constraint due to thermal event
calculated by another averaging algorithm, there can be some mismatch in
the "capacity stolen" calculations, right? Isnt't it better to track all
the events that can limit the capacity of a cpu via one algorithm ?

> 
>  - The boolean flag that changes behavior in pelt.c is not particularly
>    clean either and complicates the code.

I agree. Part of the idea behind this RFC patch set was to brainstorm if
there is a better approach to this.
> 
>  - Instead maybe factor out a decaying average library into
>    kernel/sched/avg.h perhaps (if this truly improves the code), and use
>    those methods both in pelt.c and any future thermal.c - and maybe
>    other places where we do decaying averages.
> 
>  - But simple decaying averages are not that complex either, so I think
>    your original solution of open coding it is probably fine as well. 
> 
> Furthermore, any logic introduced by thermal.c and the resulting change 
> to load-balancing behavior would have to be in perfect sync with cpufreq 
> governor actions - one mechanism should not work against the other.
I agree. I will go one step further and argue that the changes here make
best sense with sched util governor as it picks up the signals directly
from the scheduler to choose an OPP. Any other governor will be less
effective.


> 
> The only long term maintainable solution is to move all high level 
> cpufreq logic and policy handling code into kernel/sched/cpufreq*.c, 
> which has been done to a fair degree already in the past ~2 years - but 
> it's unclear to me to what extent this is true for thermal throttling 
> policy currently: there might be more governor surgery and code 
> reshuffling required?
> 
> The short term goal would be to at minimum have all the bugs lined up in 
> kernel/sched/* neatly, so that we have the chance to see and fix them in 
> a single place. ;-)

I see that Daniel has already sent some patches for this!
Regards
Thara
> 
> Thanks,
> 
> 	Ingo
> 


-- 
Regards
Thara

From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 17 Oct 2018 12:21:21 -0400
Message-ID: <5BC76181.90105@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016073305.GA64994@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 10/16/2018 03:33 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>>>> Regarding testing, basic build, boot and sanity testing have been
>>>> performed on hikey960 mainline kernel with debian file system.
>>>> Further aobench (An occlusion renderer for benchmarking realworld
>>>> floating point performance) showed the following results on hikey960
>>>> with debain.
>>>>
>>>>                                         Result          Standard        Standard
>>>>                                         (Time secs)     Error           Deviation
>>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>>
>>> Wow, +13% speedup, impressive! We definitely want this outcome.
>>>
>>> I'm wondering what happens if we do not track and decay the thermal 
>>> load at all at the PELT level, but instantaneously decrease/increase 
>>> effective CPU capacity in reaction to thermal events we receive from 
>>> the CPU.
>>
>> The problem with instantaneous update is that sometimes thermal events 
>> happen at a much faster pace than cpu_capacity is updated in the 
>> scheduler. This means that at the moment when scheduler uses the 
>> value, it might not be correct anymore.
> 
> Let me offer a different interpretation: if we average throttling events 
> then we create a 'smooth' average of 'true CPU capacity' that doesn't 
> fluctuate much. This allows more stable yet asymmetric task placement if 
> the thermal characteristics of the different cores is different 
> (asymmetric). This, compared to instantaneous updates, would reduce 
> unnecessary task migrations between cores.
> 
> Is that accurate?

Yes. I think it is accurate. I will also add that if we don't average
throttling events, we will miss the events that occur in between load
balancing(LB) period.

> 
> If the thermal characteristics of the cores is roughly symmetric and the 
> measured CPU-intense load itself is symmetric as well, then I have 
> trouble seeing why reacting to thermal events should make any difference 
> at all.
In this scenario, i agree that scheduler reaction to thermal events
should not make any difference in fact we should not observe any
improvement or degradation in performance.

> 
> Are there any inherent asymmetries in the thermal properties of the 
> cores, or in the benchmarked workload itself?

The benchmarked workload , meaning aobench? I don't think there arre any
asymmetries there. On Hikey960, there are two clusters with different
frequency domains. So yes I will say there is asymmetry there. Asides,
IMHO, any other tasks running on the system can create an inherent
asymmetry as cpu utilizations can vary.

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

From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Tue, 16 Oct 2018 11:28:29 +0200
Message-ID: <20181016092831eucas1p1d9fa0678c15afb01d72b6f3df80352f8~eDLkNsh6l0620706207eucas1p1V@eucas1p1.samsung.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
        <CGME20181016073315epcas4p1e0d57bf856cf95312a622004ce20391f@epcas4p1.samsung.com>
        <20181016073305.GA64994@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016073305.GA64994@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org, l.luba@partner.samsung.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org


On 10/16/2018 09:33 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>>>> Regarding testing, basic build, boot and sanity testing have been
>>>> performed on hikey960 mainline kernel with debian file system.
>>>> Further aobench (An occlusion renderer for benchmarking realworld
>>>> floating point performance) showed the following results on hikey960
>>>> with debain.
>>>>
>>>>                                          Result          Standard        Standard
>>>>                                          (Time secs)     Error           Deviation
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
> 
> If the thermal characteristics of the cores is roughly symmetric and the
> measured CPU-intense load itself is symmetric as well, then I have
> trouble seeing why reacting to thermal events should make any difference
> at all.
> 
> Are there any inherent asymmetries in the thermal properties of the
> cores, or in the benchmarked workload itself?
The aobench that at least I have built is a single threaded app.
If there is migration of the process to cluster and core which is in
avg faster, then it will gain.
The hikey960 platform has limited number of OPPs.
big cluster: 2.36, 2.1, 1.8, 1.4, 0.9 [GHz]
little cluster: 1.84, 1.7, 1.4, 1.0, 0.5 [GHz]
Comparing to Exynos5433 which has 15 OPPs for big cluster every 100MHZ,
it is harder to pick-up the right one.
I can imagine that the thermal governor is jumping around 1.8, 1.4, 0.9
for the big cluster. Maybe little cluster is at higher OPP
and running there longer would help. Thermal has time slots are 100ms
(based on this DT).

Regarding other asymmetries, there are different parts of the cluster
and core utilized depending of workload and data set.
There might be floating point or vectorized code utilizing long piplines
in NEON and also causing less cache misses.
That will warm up more than integer unit or copy using load/store unit
(which occupy less silicon (and C 'capacitance')) at the same frequency.

There are also SoCs which have single power rail from DCDC in PMIC
for both asymmetric clusters. In SoC on front of these clusters,
there is internal LDO, which reduces the voltage to the cluster.
In such system cpufreq driver chooses max of the voltages for the
clusters and sets it to the PMIC, then sets LDOx voltage diff for
cluster with smaller voltage. This causes another asymmetries,
because more current going through LDO causes more heat than
direct DCDC voltage (i.e. seen as a heat on big cluster).

There are also cache portion power down asymmetries.
I have been developing such driver. Based on memory traffic
and cache hit/miss ratio it chooses how much cache can be powered down.
I can image that some HW does it without the need of SW assist.

There are SoCs with DDR modules mounted on top - PoP.
I still have to investigate what is different in SoC power budget
in such setup (depending on workload).

There are also workloads for UI using GPU, which can also
be utilized in 'portions' (shader cores from 1 to 32).

These asymmetries cause that simple assumptio
P_dynamic = C * V^2 * f
is probably not enough.

I would suggest to choose platform with more fine grained OPPs or
add more points to hikey960 and repeat the tests.

Regards,
Lukasz Luba

> 
> Thanks,
> 
> 	Ingo
> 
> 

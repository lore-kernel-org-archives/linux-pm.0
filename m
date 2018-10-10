From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 17:35:50 +0200
Message-ID: <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Thara,

I have run it on Exynos5433 mainline.
When it is enabled with step_wise thermal governor,
some of my tests are showing ~30-50% regression (i.e. hackbench),
dhrystone ~10%.

Could you tell me which thermal governor was used in your case?
Please also share the name of that benchmark, i will give it a try.
Is it single threaded compute-intensive?

Regards,
Lukasz

On 10/09/2018 06:24 PM, Thara Gopinath wrote:
> Thermal governors can respond to an overheat event for a cpu by
> capping the cpu's maximum possible frequency. This in turn
> means that the maximum available compute capacity of the
> cpu is restricted. But today in linux kernel, in event of maximum
> frequency capping of a cpu, the maximum available compute
> capacity of the cpu is not adjusted at all. In other words, scheduler
> is unware maximum cpu capacity restrictions placed due to thermal
> activity. This patch series attempts to address this issue.
> The benefits identified are better task placement among available
> cpus in event of overheating which in turn leads to better
> performance numbers.
> 
> The delta between the maximum possible capacity of a cpu and
> maximum available capacity of a cpu due to thermal event can
> be considered as thermal pressure. Instantaneous thermal pressure
> is hard to record and can sometime be erroneous as there can be mismatch
> between the actual capping of capacity and scheduler recording it.
> Thus solution is to have a weighted average per cpu value for thermal
> pressure over time. The weight reflects the amount of time the cpu has
> spent at a capped maximum frequency. To accumulate, average and
> appropriately decay thermal pressure, this patch series uses pelt
> signals and reuses the available framework that does a similar
> bookkeeping of rt/dl task utilization.
> 
> Regarding testing, basic build, boot and sanity testing have been
> performed on hikey960 mainline kernel with debian file system.
> Further aobench (An occlusion renderer for benchmarking realworld
> floating point performance) showed the following results on hikey960
> with debain.
> 
>                                          Result          Standard        Standard
>                                          (Time secs)     Error           Deviation
> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> 
> Thara Gopinath (7):
>    sched/pelt: Add option to make load and util calculations frequency
>      invariant
>    sched/pelt.c: Add support to track thermal pressure
>    sched: Add infrastructure to store and update instantaneous thermal
>      pressure
>    sched: Initialize per cpu thermal pressure structure
>    sched/fair: Enable CFS periodic tick to update thermal pressure
>    sched/fair: update cpu_capcity to reflect thermal pressure
>    thermal/cpu-cooling: Update thermal pressure in case of a maximum
>      frequency capping
> 
>   drivers/base/arch_topology.c  |  1 +
>   drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
>   include/linux/sched.h         | 14 +++++++++
>   kernel/sched/Makefile         |  2 +-
>   kernel/sched/core.c           |  2 ++
>   kernel/sched/fair.c           |  4 +++
>   kernel/sched/pelt.c           | 40 ++++++++++++++++++--------
>   kernel/sched/pelt.h           |  7 +++++
>   kernel/sched/sched.h          |  1 +
>   kernel/sched/thermal.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/thermal.h        | 13 +++++++++
>   11 files changed, 157 insertions(+), 13 deletions(-)
>   create mode 100644 kernel/sched/thermal.c
>   create mode 100644 kernel/sched/thermal.h
> 

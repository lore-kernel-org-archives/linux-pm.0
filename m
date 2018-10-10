From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 11:43:27 -0400
Message-ID: <5BBE1E1F.3030308@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010061751.GA37224@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Hello Ingo,
Thank you for the review.

On 10/10/2018 02:17 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>> Thermal governors can respond to an overheat event for a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in linux kernel, in event of maximum
>> frequency capping of a cpu, the maximum available compute
>> capacity of the cpu is not adjusted at all. In other words, scheduler
>> is unware maximum cpu capacity restrictions placed due to thermal
>> activity. This patch series attempts to address this issue.
>> The benefits identif

ied are better task placement among available
>> cpus in event of overheating which in turn leads to better
>> performance numbers.
>>
>> The delta between the maximum possible capacity of a cpu and
>> maximum available capacity of a cpu due to thermal event can
>> be considered as thermal pressure. Instantaneous thermal pressure
>> is hard to record and can sometime be erroneous as there can be mismatch
>> between the actual capping of capacity and scheduler recording it.
>> Thus solution is to have a weighted average per cpu value for thermal
>> pressure over time. The weight reflects the amount of time the cpu has
>> spent at a capped maximum frequency. To accumulate, average and
>> appropriately decay thermal pressure, this patch series uses pelt
>> signals and reuses the available framework that does a similar
>> bookkeeping of rt/dl task utilization.
>>
>> Regarding testing, basic build, boot and sanity testing have been
>> performed on hikey960 mainline kernel with debian file system.
>> Further aobench (An occlusion renderer for benchmarking realworld
>> floating point performance) showed the following results on hikey960
>> with debain.
>>
>>                                         Result          Standard        Standard
>>                                         (Time secs)     Error           Deviation
>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> 
> Wow, +13% speedup, impressive! We definitely want this outcome.
> 
> I'm wondering what happens if we do not track and decay the thermal load at all at the PELT 
> level, but instantaneously decrease/increase effective CPU capacity in reaction to thermal 
> events we receive from the CPU.

The problem with instantaneous update is that sometimes thermal events
happen at a much faster pace than cpu_capacity is updated in
the scheduler. This means that at the moment when scheduler uses the
value, it might not be correct anymore.

Having said that, today Android common kernel has a solution which
instantaneously updates cpu_capacity in case of a thermal event.
To give a bit of background on the evolution of the solution I have
proposed, below is a time line of analysis I have done.

1.  I started this activity by analyzing the existing framework on
android common kernel. I ran android benchmark tests (Jankbench,
Vellamo, Geekbench) with and without the existing instantaneous update
mechanism. I found that there is no real performance difference to be
observed with an instantaneous updated of cpu_capacity at least in my
test scenarios.
2. Then I developed an algorithm to track, accumulate and decay the
capacity capping i.e an algorithm without using the pelt signals(this
was prior to the new pelt framework in mainline). With this android
benchmarks showed performance improvements. At this point I also ported
the solution to mainline kernel and ran the aobench analysis which again
showed a performance improvement.
3. Finally with the new pelt framework in place, I replaced my algorithm
with the one used for rt and dl utilization tracking which is the
current patch series. I have not been able to run tests with this on
Android yet.

All tests were performed on hikey960.
I have a Google spreadsheet, documenting results at various stages of
analysis. I am not sure how to share it with the group here.


> 
> You describe the averaging as:
> 
>> Instantaneous thermal pressure is hard to record and can sometime be erroneous as there can 
>> be mismatch between the actual capping of capacity and scheduler recording it.
> 
> Not sure I follow the argument here: are there bogus thermal throttling events? If so then
> they are hopefully not frequent enough and should average out over time even if we follow
> it instantly.

No bogus events. It is more like sometimes capping happens at a much
faster rate than cpu_capacity is updated and the scheduler looses these
events.

> 
> I.e. what is 'can sometimes be erroneous', exactly?
> 
> Thanks,
> 
> 	Ingo
> 


-- 
Regards
Thara

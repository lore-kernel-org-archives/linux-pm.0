From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 08:17:51 +0200
Message-ID: <20181010061751.GA37224@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

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
>                                         Result          Standard        Standard
>                                         (Time secs)     Error           Deviation
> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%

Wow, +13% speedup, impressive! We definitely want this outcome.

I'm wondering what happens if we do not track and decay the thermal load at all at the PELT 
level, but instantaneously decrease/increase effective CPU capacity in reaction to thermal 
events we receive from the CPU.

You describe the averaging as:

> Instantaneous thermal pressure is hard to record and can sometime be erroneous as there can 
> be mismatch between the actual capping of capacity and scheduler recording it.

Not sure I follow the argument here: are there bogus thermal throttling events? If so then
they are hopefully not frequent enough and should average out over time even if we follow
it instantly.

I.e. what is 'can sometimes be erroneous', exactly?

Thanks,

	Ingo

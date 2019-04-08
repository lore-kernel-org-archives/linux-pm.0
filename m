From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH v3 3/4] cpufreq: schedutil: Simplify iowait
 boosting
Date: Mon, 8 Apr 2019 11:24:45 +0530
Message-ID: <20190408055445.6civdatkw7crwxes@vireshk-i7>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan>
 <2864116.v8IU97Resm@aspire.rjw.lan>
 <3714586.Xfz7sSM4fi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3714586.Xfz7sSM4fi@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Quentin Perret <quentin.perret@arm.com>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 28-03-19, 11:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is not reason for the minimum iowait boost value in the
> schedutil cpufreq governor to depend on the available range of CPU
> frequencies.  In fact, that dependency is generally confusing,
> because it causes the iowait boost to behave somewhat differently
> on CPUs with the same maximum frequency and different minimum
> frequencies, for example.
> 
> For this reason, replace the min field in struct sugov_cpu
> with a constant and choose its values to be 1/8 of
> SCHED_CAPACITY_SCALE (for consistency with the intel_pstate
> driver's internal governor).
> 
> [Note that policy->cpuinfo.max_freq will not be a constant any more
>  after a subsequent change, so this change is depended on by it.]
> 
> Link: https://lore.kernel.org/lkml/20190305083202.GU32494@hirez.programming.kicks-ass.net/T/#ee20bdc98b7d89f6110c0d00e5c3ee8c2ced93c3d
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> As pointed out by Quentin, the original patch overlooked two kerneldoc
> comments that needed to be updated along with the code, so do that here.
> 
> No other changes with respect to the original.
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |   21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

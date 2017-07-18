From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: Update last_update from
 sugov_set_iowait_boost()
Date: Tue, 18 Jul 2017 12:20:25 +0100
Message-ID: <20170718112025.iujrikdrf2sechtp@e106622-lin>
References: <4927469221fa6b2ea7efffb2da923dac930ab313.1500353473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbdGRLUa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Jul 2017 07:20:30 -0400
Content-Disposition: inline
In-Reply-To: <4927469221fa6b2ea7efffb2da923dac930ab313.1500353473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, joelaf@google.com, linux-kernel@vger.kernel.org

Hi Viresh,

On 18/07/17 10:24, Viresh Kumar wrote:
> sg_cpu->last_update is always updated right after we call
> sugov_set_iowait_boost() and its better to update it from that routine
> itself. This makes it more readable.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 29a397067ffa..63557b9f36b6 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -177,6 +177,8 @@ static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  		if (delta_ns > TICK_NSEC)
>  			sg_cpu->iowait_boost = 0;
>  	}
> +
> +	sg_cpu->last_update = time;
>  }
>  
>  static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
> @@ -219,7 +221,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	bool busy;
>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
> -	sg_cpu->last_update = time;
>  
>  	if (!sugov_should_update_freq(sg_policy, time))
>  		return;
> @@ -299,7 +300,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	sg_cpu->flags = flags;
>  
>  	sugov_set_iowait_boost(sg_cpu, time, flags);
> -	sg_cpu->last_update = time;

It actually belongs here, IMHO. We update other fields (util, max,
flags) before looking at iowait. Why hiding the time update into a
function dealing with only one of such fields?

Best,

- Juri

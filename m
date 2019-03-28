From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 3/4] cpufreq: schedutil: Simplify iowait boosting
Date: Thu, 28 Mar 2019 09:48:24 +0000
Message-ID: <20190328094823.y6gyfb6ldq43gojw@queper01-lin>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan>
 <2864116.v8IU97Resm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2864116.v8IU97Resm@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Tuesday 26 Mar 2019 at 12:18:00 (+0100), Rafael J. Wysocki wrote:
> @@ -13,6 +13,8 @@
>  #include <linux/sched/cpufreq.h>
>  #include <trace/events/power.h>
>  
> +#define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
> +
>  struct sugov_tunables {
>  	struct gov_attr_set	attr_set;
>  	unsigned int		rate_limit_us;
> @@ -51,7 +53,6 @@ struct sugov_cpu {
>  	u64			last_update;
>  
>  	unsigned long		bw_dl;
> -	unsigned long		min;
>  	unsigned long		max;
>  
>  	/* The field below is for single-CPU policies only: */
> @@ -303,7 +304,7 @@ static bool sugov_iowait_reset(struct sua

The comment above this function needs updating I think.

>  	if (delta_ns <= TICK_NSEC)
>  		return false;
>  
> -	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
> +	sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
>  	sg_cpu->iowait_boost_pending = set_iowait_boost;
>  
>  	return true;
> @@ -349,7 +350,7 @@ static void sugov_iowait_boost(struct su

Ditto.

>  	}
>  
>  	/* First wakeup after IO: start with minimum boost */
> -	sg_cpu->iowait_boost = sg_cpu->min;
> +	sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
>  }
>  
>  /**
> @@ -389,7 +390,7 @@ static unsigned long sugov_iowait_apply(
>  		 * No boost pending; reduce the boost value.
>  		 */
>  		sg_cpu->iowait_boost >>= 1;
> -		if (sg_cpu->iowait_boost < sg_cpu->min) {
> +		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
>  			sg_cpu->iowait_boost = 0;
>  			return util;
>  		}
> @@ -826,9 +827,6 @@ static int sugov_start(struct cpufreq_po
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu			= cpu;
>  		sg_cpu->sg_policy		= sg_policy;
> -		sg_cpu->min			=
> -			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> -			policy->cpuinfo.max_freq;
>  	}
>  
>  	for_each_cpu(cpu, policy->cpus) {
> 

Other than that, I tried a backport of this on a Pixel 3 with Snapdragon
845 (which is relevant because it has tons of OPPs, so starting at 128
makes it ramp up faster) to check the impact on power, but the only
differences appeared to be in the noise margin, so it's all good :)

Full test results available at [1]. Note that I did enable the iowait
boost feature for these tests -- it is disabled by default on P3 ...

Thanks,
Quentin

---
[1] https://nbviewer.jupyter.org/gist/qperret/69c9bde13aad2d783689e78c9ba2d9bc

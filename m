From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 12:25:30 +0000
Message-ID: <20171222122530.GC30968@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
 <20171222100626.7g5yklspjofcp2we@hirez.programming.kicks-ass.net>
 <20171222110206.GA6414@e110439-lin>
 <20171222114618.mlbqdbagrbr7oert@hirez.programming.kicks-ass.net>
 <20171222121015.3otsnoibduurmhio@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171222121015.3otsnoibduurmhio@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 22-Dec 13:10, Peter Zijlstra wrote:
> On Fri, Dec 22, 2017 at 12:46:18PM +0100, Peter Zijlstra wrote:
> > Blergh that'd make a mess of things again.
> 
> Something like so then..
> 
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -187,11 +187,16 @@ static void sugov_get_util(struct sugov_
>  
>  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  {
> -	unsigned long util = sg_cpu->util_cfs + sg_cpu->util_dl;
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util;
>  
> -	if (rq->rt.rt_nr_running)
> +	if (rq->rt.rt_nr_running) {
>  		util = sg_cpu->max;
> +	} else {
> +		util = sg_cpu->util_dl;
> +		if (rq->cfs.h_nr_running)
> +			util += sg_cpu->util_cfs;

Since sugov_aggregate_util always follow sugov_get_util, maybe we
can move these checks into the latter and remove the first one?

That way, sg_cpu->util_{dl,rt,cfs} will always report exactly the
requests of each class considering also which tasks are RUNNABLE at
sugov_get_util time.

Still the observation of Juri is valid: do we wanna really disregard
all the CFS blocked load as soon as there are not CFS tasks?

> +	}
>  
>  	/*
>  	 * Ideally we would like to set util_dl as min/guaranteed freq and

-- 
#include <best/regards.h>

Patrick Bellasi

From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Tue, 12 Dec 2017 14:38:24 +0100
Message-ID: <20171212133824.GH4635@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
 <20171207124510.GP31247@e110439-lin>
 <20171212113727.GO25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212113727.GO25177@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 12/12/17 17:07, Viresh Kumar wrote:

[...]

> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 12 Dec 2017 15:43:26 +0530
> Subject: [PATCH] sched: Keep track of cpufreq utilization update flags
> 
> Currently the schedutil governor overwrites the sg_cpu->flags field on
> every call to the utilization handler. It was pretty good as the initial
> implementation of utilization handlers, there are several drawbacks
> though.
> 
> The biggest drawback is that the sg_cpu->flags field doesn't always
> represent the correct type of tasks that are enqueued on a CPU's rq. For
> example, if a fair task is enqueued while a RT or DL task is running, we
> will overwrite the flags with value 0 and that may take the CPU to lower
> OPPs unintentionally. There can be other corner cases as well which we
> aren't aware of currently.
> 
> This patch changes the current implementation to keep track of all the
> task types that are currently enqueued to the CPUs rq. There are two
> flags for every scheduling class now, one to set the flag and other one
> to clear it. The flag is set by the scheduling classes from the existing
> set of calls to cpufreq_update_util(), and the flag is cleared when the
> last task of the scheduling class is dequeued. For now, the util update
> handlers return immediately if they were called to clear the flag.
> 
> We can add more optimizations over this patch separately.
> 
> The last parameter of sugov_set_iowait_boost() is also dropped as the
> function can get it from sg_cpu anyway.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

[...]

> @@ -655,7 +669,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu = cpu;
>  		sg_cpu->sg_policy = sg_policy;
> -		sg_cpu->flags = SCHED_CPUFREQ_RT;
> +		sg_cpu->flags = 0;
>  		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
>  	}

Why this change during initialization?

Thanks,

- Juri

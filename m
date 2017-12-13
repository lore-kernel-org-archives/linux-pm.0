From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 4/4] cpufreq: schedutil: Don't call sugov_get_util()
 unnecessarily
Date: Wed, 13 Dec 2017 12:34:35 +0100
Message-ID: <20171213113435.GF30887@localhost.localdomain>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <7b0698a61bcb959704f58dbabe8c70d657210301.1513158452.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7b0698a61bcb959704f58dbabe8c70d657210301.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 13/12/17 15:23, Viresh Kumar wrote:
> sugov_update_shared() may get called to clear the scheduling class flags
> and we would return immediately in that case. Calling sugov_get_util()
> in that case isn't going to be of any use then. Move invocation of
> sugov_get_util() after the clear flag is checked.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7edfdc59ee8f..b69c37c867fe 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -349,8 +349,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	unsigned long util, max;
>  	unsigned int next_f;
>  
> -	sugov_get_util(&util, &max, sg_cpu->cpu);
> -
>  	raw_spin_lock(&sg_policy->update_lock);
>  
>  	if (unlikely(flags & SCHED_CPUFREQ_CLEAR)) {
> @@ -358,6 +356,8 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  		goto unlock;
>  	}
>  
> +	sugov_get_util(&util, &max, sg_cpu->cpu);
> +
>  	sg_cpu->util = util;
>  	sg_cpu->max = max;
>  	sg_cpu->flags |= flags;

It seems that Patrick already posted basically the same change:

https://patchwork.kernel.org/patch/10084669/

Also, Cc-ing him for this.. I just noticed he wasn't Cc-ed to the series.

Best,

- Juri

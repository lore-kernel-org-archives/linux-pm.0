From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Thu, 8 Mar 2018 16:03:05 +0530
Message-ID: <20180308103305.GK6842@vireshk-i7>
References: <1520504950-8544-1-git-send-email-claudio@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520504950-8544-1-git-send-email-claudio@evidence.eu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08-03-18, 11:29, Claudio Scordino wrote:
> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> we should not wait for the rate limit, otherwise we may miss some
> deadline.
> 
> Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
> shown reductions of even 10% of deadline misses with a negligible
> increase of energy consumption (measured through Baylibre Cape).
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Morten Rasmussen <morten.rasmussen@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Todd Kjos <tkjos@android.com>
> CC: Joel Fernandes <joelaf@google.com>
> CC: linux-pm@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
> Changes from v2:
>  - Rate limit ignored also in case of "fast switch"
>  - Specific routine added
> ---
> Changes from v1:
>  - Logic moved from sugov_should_update_freq() to
>    sugov_update_single()/_shared() to not duplicate data structures
>  - Rate limit not ignored in case of "fast switch"
> ---
>  kernel/sched/cpufreq_schedutil.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7936f54..13f9cce 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -260,6 +260,17 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
>  static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
> +/*
> + * Make sugov_should_update_freq() ignore the rate limit when DL
> + * has increased the utilization.
> + */
> +static inline
> +void set_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)

Maybe it could be renamed as ignore_dl_rate_limit() ? Lets see what others have
to say. But looks fine otherwise.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

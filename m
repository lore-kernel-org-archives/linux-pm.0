From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Fix kobject memleak
Date: Wed, 01 May 2019 12:44:15 +0200
Message-ID: <1632168.ncxJcclsFx@kreacher>
References: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, tobin@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 30, 2019 8:05:52 AM CEST Viresh Kumar wrote:
> Currently the error return path from kobject_init_and_add() is not
> followed by a call to kobject_put() - which means we are leaking the
> kobject.
> 
> Fix it by adding a call to kobject_put() in the error path of
> kobject_init_and_add().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Tobin fixed this for schedutil already.
> 
>  drivers/cpufreq/cpufreq.c          | 1 +
>  drivers/cpufreq/cpufreq_governor.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e10922709d13..bbf79544d0ad 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1098,6 +1098,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  				   cpufreq_global_kobject, "policy%u", cpu);
>  	if (ret) {
>  		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> +		kobject_put(&policy->kobj);
>  		goto err_free_real_cpus;
>  	}
>  
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index ffa9adeaba31..9d1d9bf02710 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -459,6 +459,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  	/* Failure, so roll back. */
>  	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
>  
> +	kobject_put(&dbs_data->attr_set.kobj);
> +
>  	policy->governor_data = NULL;
>  
>  	if (!have_governor_per_policy())
> 

Applied, thanks!

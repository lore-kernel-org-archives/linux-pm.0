From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: use cpufreq_cpu_get to avoid cpufreq_get race conditions
Date: Thu, 06 Mar 2014 02:23:39 +0100
Message-ID: <2327882.a9zobM63G6@vostro.rjw.lan>
References: <1393965735-15610-1-git-send-email-aplattner@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1393965735-15610-1-git-send-email-aplattner@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Aaron Plattner <aplattner@nvidia.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 04, 2014 12:42:15 PM Aaron Plattner wrote:
> If a module calls cpufreq_get while cpufreq is initializing, it's possible for
> it to be called after cpufreq_driver is set but before cpufreq_cpu_data is
> written during subsys_interface_register.  This happens because cpufreq_get
> doesn't take the cpufreq_driver_lock around its use of cpufreq_cpu_data.

Is this a theoretical race, or can you actually reproduce it?  If so, on what
system/driver?  Or are there any bug reports related to this you can point me
to?

> Fix this by using cpufreq_cpu_get(cpu) to look up the policy rather than reading
> it out of cpufreq_cpu_data directly.  cpufreq_cpu_get takes the appropriate
> locks to prevent this race from happening.
> 
> Since it's possible for policy to be NULL if the caller passes in an invalid CPU
> number or calls the function before cpufreq is initialized, delete the
> BUG_ON(!policy) and simply return 0.  Don't try to return -ENOENT because that's
> negative and the function returns an unsigned integer.
> 
> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>

Viresh, have you seen this?

> ---
>  drivers/cpufreq/cpufreq.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8d19f7c..158d0b5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1447,23 +1447,16 @@ static unsigned int __cpufreq_get(unsigned int cpu)
>   */
>  unsigned int cpufreq_get(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  	unsigned int ret_freq = 0;
>  
> -	if (cpufreq_disabled() || !cpufreq_driver)
> -		return -ENOENT;
> -
> -	BUG_ON(!policy);
> -
> -	if (!down_read_trylock(&cpufreq_rwsem))
> -		return 0;
> -
> -	down_read(&policy->rwsem);
> -
> -	ret_freq = __cpufreq_get(cpu);
> +	if (policy) {
> +		down_read(&policy->rwsem);
> +		ret_freq = __cpufreq_get(cpu);
> +		up_read(&policy->rwsem);
>  
> -	up_read(&policy->rwsem);
> -	up_read(&cpufreq_rwsem);
> +		cpufreq_cpu_put(policy);
> +	}
>  
>  	return ret_freq;
>  }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Improve kerneldoc comments for
 cpufreq_cpu_get/put()
Date: Wed, 6 Mar 2019 08:47:19 +0530
Message-ID: <20190306031719.clpdezdpblypwp5x@vireshk-i7>
References: <1633242.5muNhsBLsY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1633242.5muNhsBLsY@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05-03-19, 11:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fix the formatting of the cpufreq_cpu_get() and cpufreq_cpu_put()
> kerneldoc comments and rework them to be somewhat easier to follow.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -201,17 +201,15 @@ unsigned int cpufreq_generic_get(unsigne
>  EXPORT_SYMBOL_GPL(cpufreq_generic_get);
>  
>  /**
> - * cpufreq_cpu_get: returns policy for a cpu and marks it busy.
> + * cpufreq_cpu_get - Return policy for a CPU and mark it as busy.
> + * @cpu: CPU to find the policy for.
>   *
> - * @cpu: cpu to find policy for.
> + * Call cpufreq_cpu_get_raw() to obtain a cpufreq policy for @cpu and increment
> + * the kobject reference counter of that policy.  Return a valid policy on
> + * success or NULL on failure.
>   *
> - * This returns policy for 'cpu', returns NULL if it doesn't exist.
> - * It also increments the kobject reference count to mark it busy and so would
> - * require a corresponding call to cpufreq_cpu_put() to decrement it back.
> - * If corresponding call cpufreq_cpu_put() isn't made, the policy wouldn't be
> - * freed as that depends on the kobj count.
> - *
> - * Return: A valid policy on success, otherwise NULL on failure.
> + * The policy returned by this function has to be released with the help of
> + * cpufreq_cpu_put() to balance its kobject reference counter properly.
>   */
>  struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>  {
> @@ -238,12 +236,8 @@ struct cpufreq_policy *cpufreq_cpu_get(u
>  EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
>  
>  /**
> - * cpufreq_cpu_put: Decrements the usage count of a policy
> - *
> - * @policy: policy earlier returned by cpufreq_cpu_get().
> - *
> - * This decrements the kobject reference count incremented earlier by calling
> - * cpufreq_cpu_get().

Shouldn't we always try to keep some description?

> + * cpufreq_cpu_put - Decrement kobject usage counter for cpufreq policy.
> + * @policy: cpufreq policy returned by cpufreq_cpu_get().
>   */
>  void cpufreq_cpu_put(struct cpufreq_policy *policy)
>  {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

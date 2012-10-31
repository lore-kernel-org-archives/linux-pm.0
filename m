From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH RESEND] cpufreq: Make sure target freq is within limits
Date: Wed, 31 Oct 2012 01:44:18 +0100
Message-ID: <5507910.WhiOUESWao@vostro.rjw.lan>
References: <f79c0841be1ae16e1f2bd9084ed9a158eb171eb0.1351254846.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <f79c0841be1ae16e1f2bd9084ed9a158eb171eb0.1351254846.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Friday, October 26, 2012 06:05:21 PM Viresh Kumar wrote:
> __cpufreq_driver_target() must not pass target frequency beyond the limits of
> current policy.
> 
> Today most of cpufreq platform drivers are doing this check in their target
> routines. Why not move it to __cpufreq_driver_target().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Hi Rafael,
> 
> Resend doesn't contain any change, but fixed commit log

Applied to the linux-next branch of linux-pm.git as v3.8 material.

Thanks,
Rafael


>  drivers/cpufreq/cpufreq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 28dc134..2f5ac2d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1470,12 +1470,19 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>  			    unsigned int relation)
>  {
>  	int retval = -EINVAL;
> +	unsigned int old_target_freq = target_freq;
>  
>  	if (cpufreq_disabled())
>  		return -ENODEV;
>  
> -	pr_debug("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
> -		target_freq, relation);
> +	/* Make sure that target_freq is within supported range */
> +	if (target_freq > policy->max)
> +		target_freq = policy->max;
> +	if (target_freq < policy->min)
> +		target_freq = policy->min;
> +
> +	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
> +			policy->cpu, target_freq, relation, old_target_freq);
>  
>  	if (target_freq == policy->cur)
>  		return 0;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

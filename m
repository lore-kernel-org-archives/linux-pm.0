From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: fix jiffies/cputime mixup in conservative/ondemand governors
Date: Wed, 24 Oct 2012 23:16:49 +0200
Message-ID: <1448859.RJLWEdIAIe@vostro.rjw.lan>
References: <m21ugq1vfi.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <m21ugq1vfi.fsf@igel.home>
Sender: cpufreq-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 22 of October 2012 15:35:29 Andreas Schwab wrote:
> The function get_cpu_idle_time_jiffy in both the conservative and
> ondemand governors use jiffies_to_usecs to convert a cputime value to
> usecs which gives the wrong value on architectures where cputime and
> jiffies use different units.  Only matters if NO_HZ is disabled, since
> otherwise get_cpu_idle_time_us should already return a valid value, and
> get_cpu_idle_time_jiffy isn't actually called.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

I have rebased your patch on top of some other changes in linux-pm.git/linux-next.

Please have a look at

http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=shortlog;h=refs/heads/linux-next

and let me know if that's what you meant.

Thanks,
Rafael


> ---
>  drivers/cpufreq/cpufreq_conservative.c | 4 ++--
>  drivers/cpufreq/cpufreq_ondemand.c     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index a152af7..96af7d5 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -112,9 +112,9 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
>  
>  	idle_time = cur_wall_time - busy_time;
>  	if (wall)
> -		*wall = jiffies_to_usecs(cur_wall_time);
> +		*wall = cputime_to_usecs(cur_wall_time);
>  
> -	return jiffies_to_usecs(idle_time);
> +	return cputime_to_usecs(idle_time);
>  }
>  
>  static inline cputime64_t get_cpu_idle_time(unsigned int cpu, cputime64_t *wall)
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 396322f..6c19a66 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -136,9 +136,9 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
>  
>  	idle_time = cur_wall_time - busy_time;
>  	if (wall)
> -		*wall = jiffies_to_usecs(cur_wall_time);
> +		*wall = cputime_to_usecs(cur_wall_time);
>  
> -	return jiffies_to_usecs(idle_time);
> +	return cputime_to_usecs(idle_time);
>  }
>  
>  static inline cputime64_t get_cpu_idle_time(unsigned int cpu, cputime64_t *wall)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

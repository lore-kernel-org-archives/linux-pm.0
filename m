From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] Cpufreq: Keep cpufreq sysfs nodes across S2RAM/S2DISK when using intel_pstate driver.
Date: Mon, 22 Sep 2014 16:07:42 +0200
Message-ID: <8879768.rKXiR3iWPo@vostro.rjw.lan>
References: <1411023787-11458-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411023787-11458-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>, viresh.kumar@linaro.org, 'Dirk Brandewie' <dirk.j.brandewie@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Dirk Brandewie' <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 18, 2014 03:03:07 PM Lan Tianyu wrote:
> Cpufreq core introduces cpufreq_suspended flag to let cpufreq sysfs nodes
> across S2RAM/S2DISK. But the flag is only set in the cpufreq_suspend()
> for cpufreq drivers which have target or target_index callback. This
> skips intel_pstate driver. This patch is to set the flag before checking
> target or target_index callback.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Viresh, Dirk, this looks like a fix that should go into 3.17, so I'm
queuing it up accordingly.  Please let me know if that's not correct.

> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d9fdedd..eb9bb78 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1656,6 +1656,8 @@ void cpufreq_suspend(void)
>  	if (!cpufreq_driver)
>  		return;
>  
> +	cpufreq_suspended = true;
> +
>  	if (!has_target())
>  		return;
>  
> @@ -1670,8 +1672,6 @@ void cpufreq_suspend(void)
>  			pr_err("%s: Failed to suspend driver: %p\n", __func__,
>  				policy);
>  	}
> -
> -	cpufreq_suspended = true;
>  }
>  
>  /**
> @@ -1687,13 +1687,13 @@ void cpufreq_resume(void)
>  	if (!cpufreq_driver)
>  		return;
>  
> +	cpufreq_suspended = false;
> +
>  	if (!has_target())
>  		return;
>  
>  	pr_debug("%s: Resuming Governors\n", __func__);
>  
> -	cpufreq_suspended = false;
> -
>  	list_for_each_entry(policy, &cpufreq_policy_list, policy_list) {
>  		if (cpufreq_driver->resume && cpufreq_driver->resume(policy))
>  			pr_err("%s: Failed to resume driver: %p\n", __func__,
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

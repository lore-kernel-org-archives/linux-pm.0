From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Cpufreq: Acquire read lock in the cpufreq_policy_restore() rather than write lock
Date: Thu, 12 Sep 2013 00:56:03 +0200
Message-ID: <2039668.8La2a0cgXT@vostro.rjw.lan>
References: <1378883105-1411-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1378883105-1411-1-git-send-email-tianyu.lan@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: tianyu.lan@intel.com
Cc: viresh.kumar@linaro.org, srivatsa.bhat@linux.vnet.ibm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 11, 2013 03:05:05 PM tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> In the cpufreq_policy_restore(), policy before system suspend is read from
> from percpu's cpufreq_cpu_data_fallback. It's read operation rather than
> write operation. So convert write lock to read lock
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Applied, thanks Tianyu!

> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 81ceea6..b762f9b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -912,11 +912,11 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>  	struct cpufreq_policy *policy;
>  	unsigned long flags;
>  
> -	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	read_lock_irqsave(&cpufreq_driver_lock, flags);
>  
>  	policy = per_cpu(cpufreq_cpu_data_fallback, cpu);
>  
> -	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
>  	return policy;
>  }
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

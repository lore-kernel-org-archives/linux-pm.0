From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] Cpufreq: Acquire read lock in the cpufreq_policy_restore()
 rather than write lock
Date: Wed, 11 Sep 2013 13:39:33 +0530
Message-ID: <5230253D.6040308@linux.vnet.ibm.com>
References: <1378883105-1411-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1378883105-1411-1-git-send-email-tianyu.lan@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: tianyu.lan@intel.com
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/11/2013 12:35 PM, tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> In the cpufreq_policy_restore(), policy before system suspend is read from
> from percpu's cpufreq_cpu_data_fallback. It's read operation rather than
> write operation. So convert write lock to read lock
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

I noticed it too yesterday, while looking at something else. Thanks for
fixing this!

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
 
Regards,
Srivatsa S. Bhat


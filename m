From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: qoriq: clean up unused code
Date: Tue, 21 Feb 2017 14:34:56 +0530
Message-ID: <20170221090456.GX21911@vireshk-i7>
References: <1487659884-29040-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487659884-29040-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuantian.tang@nxp.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 21-02-17, 14:51, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> This snip code is not needed anymore since its user
> get_hard_smp_processor_id() has been removed.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 53d8c3f..02031a3 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -22,10 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/smp.h>
>  
> -#if !defined(CONFIG_ARM)
> -#include <asm/smp.h>	/* for get_hard_smp_processor_id() in UP configs */
> -#endif
> -
>  /**
>   * struct cpu_data
>   * @pclk: the parent clock of cpu

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

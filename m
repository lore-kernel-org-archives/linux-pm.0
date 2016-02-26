From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC v2 06/12] PM / cpu_domains: Record CPUs that are part of
 the domain
Date: Fri, 26 Feb 2016 11:20:33 -0800
Message-ID: <20160226192033.GX28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-7-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455310238-8963-7-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On 02/12, Lina Iyer wrote:
> diff --git a/include/linux/cpu_domains.h b/include/linux/cpu_domains.h
> index bab4846..0c539f0 100644
> --- a/include/linux/cpu_domains.h
> +++ b/include/linux/cpu_domains.h
> @@ -11,8 +11,10 @@
>  #ifndef __CPU_DOMAINS_H__
>  #define __CPU_DOMAINS_H__
>  
> +#include <linux/cpumask.h>

Just forward declare struct cpumask instead?

> +
>  struct cpu_pd_ops {
> -	int (*power_off)(u32 state_idx, u32 param);
> +	int (*power_off)(u32 state_idx, u32 param, const struct cpumask *mask);
>  	int (*power_on)(void);
>  };

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

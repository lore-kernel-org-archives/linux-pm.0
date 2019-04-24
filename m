From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: qoriq: Add ls1028a chip support
Date: Wed, 24 Apr 2019 09:31:13 +0530
Message-ID: <20190424040113.aiyaia2p7xrn5ywo@vireshk-i7>
References: <20190424023223.29614-1-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424023223.29614-1-andy.tang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.tang@nxp.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24-04-19, 10:32, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> Enable cpufreq feature on ls1028a chip by adding its compatible
> string.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 4295e54..d308c4d 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
>  
>  	{ .compatible = "fsl,ls1012a-clockgen", },
>  	{ .compatible = "fsl,ls1021a-clockgen", },
> +	{ .compatible = "fsl,ls1028a-clockgen", },
>  	{ .compatible = "fsl,ls1043a-clockgen", },
>  	{ .compatible = "fsl,ls1046a-clockgen", },
>  	{ .compatible = "fsl,ls1088a-clockgen", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

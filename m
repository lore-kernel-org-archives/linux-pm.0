From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Add support for APM X-Gene 2
Date: Mon, 2 Jan 2017 12:36:20 +0530
Message-ID: <20170102070620.GA8588@vireshk-i7>
References: <1481842500-11836-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481842500-11836-1-git-send-email-hotran@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>
List-Id: linux-pm@vger.kernel.org

On 15-12-16, 14:55, Hoan Tran wrote:
> Add the compatible string for supporting the generic device tree cpufreq-dt
> driver on APM's X-Gene 2 SoC.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index bc97b6a..7fcaf26 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -26,6 +26,8 @@
>  	{ .compatible = "allwinner,sun8i-a83t", },
>  	{ .compatible = "allwinner,sun8i-h3", },
>  
> +	{ .compatible = "apm,xgene-shadowcat", },
> +
>  	{ .compatible = "arm,integrator-ap", },
>  	{ .compatible = "arm,integrator-cp", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

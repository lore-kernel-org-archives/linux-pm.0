From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3] cpufreq: imx6q: add of_init_opp_table
Date: Fri, 20 Dec 2013 15:00:22 +0800
Message-ID: <20131220070020.GP7172@S2101-09.ap.freescale.net>
References: <1387522588-13114-1-git-send-email-john.tobias.ph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387522588-13114-1-git-send-email-john.tobias.ph@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, rjw@rjwysocki.net, festevam@gmail.com, b20788@freescale.com, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 10:56:28PM -0800, John Tobias wrote:
> Add a routine check to see if the platform supplied the OPP table.
> Incase there's no OPP table exist, it will try to initialise it.
> 
> It's been tested on iMX6SL board where the platform doesn't have
> an OPP table.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 4b3f18e..e125aed 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -187,12 +187,25 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_node;
>  	}
>  
> -	/* We expect an OPP table supplied by platform */
> +	/*
> +	 * We expect an OPP table supplied by platform.
> +	 * Just, incase the platform did not supply the OPP
> +	 * table, it will try to get it.
> +	 */
>  	num = dev_pm_opp_get_opp_count(cpu_dev);
>  	if (num < 0) {
> -		ret = num;
> -		dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> -		goto put_node;
> +		ret = of_init_opp_table(cpu_dev);
> +		if (ret < 0) {
> +			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> +			goto put_node;
> +		}
> +
> +		num = dev_pm_opp_get_opp_count(cpu_dev);
> +		if (num < 0) {
> +			ret = num;
> +			dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
> +			goto put_node;
> +		}
>  	}
>  
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> -- 
> 1.8.3.2
> 


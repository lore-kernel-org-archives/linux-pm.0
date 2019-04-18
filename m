From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 04/16] PM / devfreq: tegra: Don't ignore clk errors
Date: Thu, 18 Apr 2019 09:23:26 +0900
Message-ID: <8aa843d3-f1db-2309-8684-2d3a6f576a35@samsung.com>
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224039epcas5p2562b745e90f4f8fdc788c69f8eb12b5a@epcas5p2.samsung.com>
        <20190417222925.5815-5-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417222925.5815-5-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> The clk_set_min_rate() could fail and in this case clk_set_rate() sets
> rate to 0, which may drop EMC rate to minimum and make machine very
> difficult to use.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 7d7b9a5895b2..c7428c5eee23 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -484,8 +484,10 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  				u32 flags)
>  {
>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> +	struct devfreq *devfreq = tegra->devfreq;
>  	struct dev_pm_opp *opp;
>  	unsigned long rate;
> +	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(opp)) {
> @@ -495,10 +497,20 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	rate = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
> -	clk_set_min_rate(tegra->emc_clock, rate);
> -	clk_set_rate(tegra->emc_clock, 0);
> +	err = clk_set_min_rate(tegra->emc_clock, rate);
> +	if (err)
> +		return err;
> +
> +	err = clk_set_rate(tegra->emc_clock, 0);
> +	if (err)
> +		goto restore_min_rate;
>  
>  	return 0;
> +
> +restore_min_rate:
> +	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> +
> +	return err;
>  }
>  
>  static int tegra_devfreq_get_dev_status(struct device *dev,
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

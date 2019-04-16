From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 03/19] PM / devfreq: tegra: Don't ignore clk errors
Date: Tue, 16 Apr 2019 10:52:44 +0900
Message-ID: <1e4038d1-0fd3-f6d2-4e01-d34b16aeddbd@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145811epcas2p45772ac8ae956928341d76b80d3fa5e91@epcas2p4.samsung.com>
        <20190415145505.18397-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-4-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The clk_set_min_rate() could fail and in this case clk_set_rate() sets
> rate to 0, which may drop EMC rate to minimum and make machine very
> difficult to use.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 0c0909fba545..69581c9082d4 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -487,6 +487,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>  	struct dev_pm_opp *opp;
>  	unsigned long rate;
> +	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(opp)) {
> @@ -496,8 +497,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
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

Why don't you restore the previous minimum clock for tegra->emc_clock
when failed to execute 'clk_set_rate(tegra->emc_clock, 0);'?

I think that if you control the restoring the previous minimum clock,
it is more nice to handle the error handling.

> +		return err;
>  
>  	return 0;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

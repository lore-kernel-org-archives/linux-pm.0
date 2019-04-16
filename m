From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 04/19] PM / devfreq: tegra: Don't set EMC clock rate
 to maximum on probe
Date: Tue, 16 Apr 2019 10:59:46 +0900
Message-ID: <9fa3c0c3-0ef4-2d86-b6a8-7bd0fbc131e6@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145546epcas3p2dd7b6049da59458b165eb54e4cc8162d@epcas3p2.samsung.com>
        <20190415145505.18397-5-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-5-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> There is no real benefit from doing so, hence let's drop that rate setting
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 69581c9082d4..d62fb1b0d9bb 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -648,8 +648,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return PTR_ERR(tegra->emc_clock);
>  	}
>  
> -	clk_set_rate(tegra->emc_clock, ULONG_MAX);
> -

It seems like that initialize the emc_clock as the supported maximum clock.
But, if the rate for emc_clock initialized by either bootloader or clock driver
and it's well working until this code, actually, it is not necessary.

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


>  	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
>  	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
>  	if (err) {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

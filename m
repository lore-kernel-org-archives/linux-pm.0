From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 13/19] PM / devfreq: tegra: Mark ACTMON's governor as
 immutable
Date: Tue, 16 Apr 2019 16:17:20 +0900
Message-ID: <6df81b00-8d6a-8aca-d191-8a214a50232c@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145721epcas1p2f14027ba26bed3e3361d6a261d851c68@epcas1p2.samsung.com>
        <20190415145505.18397-14-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-14-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> The ACTMON's governor supports only the Tegra's devfreq device and there
> is no need to use any other governor, hence let's mark Tegra governor as
> immutable to permanently stick it with Tegra's devfreq device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig         | 1 -
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d338f6d..a78dffe603c1 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -94,7 +94,6 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  config ARM_TEGRA_DEVFREQ
>  	tristate "Tegra DEVFREQ Driver"
>  	depends on ARCH_TEGRA_124_SOC
> -	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index f1a6f951813a..832e4f5aa11b 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -593,6 +593,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
>  	.name = "tegra_actmon",
>  	.get_target_freq = tegra_governor_get_target,
>  	.event_handler = tegra_governor_event_handler,
> +	.immutable = true,
>  };
>  
>  static int tegra_devfreq_probe(struct platform_device *pdev)
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

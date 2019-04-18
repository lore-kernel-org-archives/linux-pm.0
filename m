From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 13/16] PM / devfreq: tegra: Support Tegra30
Date: Thu, 18 Apr 2019 09:21:55 +0900
Message-ID: <0df0f931-ae07-77d1-330e-6b33a34d4071@samsung.com>
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224121epcas5p11781595ff22c987a9a9f81738b4a10ca@epcas5p1.samsung.com>
        <20190417222925.5815-14-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417222925.5815-14-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> The devfreq driver can be used on Tegra30 without any code change and
> it works perfectly fine, the default Tegra124 parameters are good enough
> for Tegra30.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig         | 4 ++--
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index a78dffe603c1..56db9dc05edb 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  This does not yet operate with optimal voltages.
>  
>  config ARM_TEGRA_DEVFREQ
> -	tristate "Tegra DEVFREQ Driver"
> -	depends on ARCH_TEGRA_124_SOC
> +	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> +	depends on ARCH_TEGRA
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index e9ab49394d35..029afc5fb6a9 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -738,6 +738,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id tegra_devfreq_of_match[] = {
> +	{ .compatible = "nvidia,tegra30-actmon" },
>  	{ .compatible = "nvidia,tegra124-actmon" },
>  	{ },
>  };
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

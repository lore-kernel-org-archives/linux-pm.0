From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 02/19] PM / devfreq: tegra: Replace readl-writel with
 relaxed versions
Date: Wed, 17 Apr 2019 10:02:13 +0900
Message-ID: <127f2e0c-1cd0-25d9-1029-92af86775af8@samsung.com>
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145804epcas1p2c0d9f207713ae198599d34468261d64b@epcas1p2.samsung.com>
        <20190415145505.18397-3-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-3-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> There is no need to insert memory barrier on each readl/writel
> invocation, hence use the relaxed versions.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 02905978abe1..0c0909fba545 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -191,23 +191,23 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
>  
>  static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
>  {
> -	return readl(tegra->regs + offset);
> +	return readl_relaxed(tegra->regs + offset);
>  }
>  
>  static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
>  {
> -	writel(val, tegra->regs + offset);
> +	writel_relaxed(val, tegra->regs + offset);
>  }
>  
>  static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
>  {
> -	return readl(dev->regs + offset);
> +	return readl_relaxed(dev->regs + offset);
>  }
>  
>  static void device_writel(struct tegra_devfreq_device *dev, u32 val,
>  			  u32 offset)
>  {
> -	writel(val, dev->regs + offset);
> +	writel_relaxed(val, dev->regs + offset);
>  }
>  
>  static unsigned long do_percent(unsigned long val, unsigned int pct)
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

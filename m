From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCHv3 5/8] devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro
Date: Mon, 17 Mar 2014 09:17:10 +0900
Message-ID: <001501cf4176$3d23daa0$b76b8fe0$%han@samsung.com>
References: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
 <1394789408-14648-6-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1394789408-14648-6-git-send-email-cw00.choi@samsung.com>
Content-language: ko
Sender: linux-doc-owner@vger.kernel.org
To: 'Chanwoo Choi' <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Friday, March 14, 2014 6:30 PM, Chanwoo Choi wrote:
> 
> This patch use SET_SYSTEM_SLEEP_PM_OPS macro instead of legacy method.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/exynos/exynos4_bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
> index 60539e8..e5d2c5a 100644
> --- a/drivers/devfreq/exynos/exynos4_bus.c
> +++ b/drivers/devfreq/exynos/exynos4_bus.c
> @@ -1247,6 +1247,7 @@ static int exynos4_busfreq_remove(struct platform_device *pdev)
>  	return 0;
>  }
> 
> +#ifdef CONFIG_PM_SLEEP
>  static int exynos4_busfreq_resume(struct device *dev)
>  {
>  	struct busfreq_data *data = dev_get_drvdata(dev);
> @@ -1254,9 +1255,10 @@ static int exynos4_busfreq_resume(struct device *dev)
>  	busfreq_mon_reset(data);
>  	return 0;
>  }
> +#endif
> 
>  static const struct dev_pm_ops exynos4_busfreq_pm = {
> -	.resume	= exynos4_busfreq_resume,
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, exynos4_busfreq_resume)

Hi Chanwoo Choi,

How about using SIMPLE_DEV_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS?
SIMPLE_DEV_PM_OPS is simpler as below.

static SIMPLE_DEV_PM_OPS(exynos4_busfreq_pm, NULL, exynos4_busfreq_resume);

However, if runtime pm functions will be added later,
SIMPLE_DEV_PM_OPS is not necessary.

Best regards,
Jingoo Han

>  };
> 
>  static const struct platform_device_id exynos4_busfreq_id[] = {
> --
> 1.8.0


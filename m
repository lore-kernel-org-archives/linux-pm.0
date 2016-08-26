From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: fix Kconfig indent style
Date: Fri, 26 Aug 2016 11:22:10 +0900
Message-ID: <57BFA7D2.4000807@samsung.com>
References: <CGME20160825121110epcas1p4e388645a033341ce2a85e39115e9bb57@epcas1p4.samsung.com>
 <20160825120614.511-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160825120614.511-1-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jisheng,

Looks good to me. But, you need to rebase it
on latest devfreq.git because the related patch
is already merged[1] for COMPILE_TEST.
So, the merge conflict may happen.

[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit/?h=for-rc&id=c2f9bf4e49c12a3d9fcbee2cd48c9f5d769d8cc8

If you resend it with rebase on devfreq.git,
Feel free to add my reviewed-by tag:
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

On 2016년 08월 25일 21:06, Jisheng Zhang wrote:
> Use tab rather than space to indent, and tab + two spaces to indent
> help message.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/devfreq/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index a5be56e..86d06ab 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -91,14 +91,14 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  This does not yet operate with optimal voltages.
>  
>  config ARM_TEGRA_DEVFREQ
> -       tristate "Tegra DEVFREQ Driver"
> -       depends on ARCH_TEGRA_124_SOC
> -       select DEVFREQ_GOV_SIMPLE_ONDEMAND
> -       select PM_OPP
> -       help
> -         This adds the DEVFREQ driver for the Tegra family of SoCs.
> -         It reads ACTMON counters of memory controllers and adjusts the
> -         operating frequencies and voltages with OPP support.
> +	tristate "Tegra DEVFREQ Driver"
> +	depends on ARCH_TEGRA_124_SOC
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	select PM_OPP
> +	help
> +	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> +	  It reads ACTMON counters of memory controllers and adjusts the
> +	  operating frequencies and voltages with OPP support.
>  
>  source "drivers/devfreq/event/Kconfig"
>  
> 


-- 
Best Regards,
Chanwoo Choi

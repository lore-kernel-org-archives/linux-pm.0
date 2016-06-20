From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] thermal: hisilicon: Add dependency on the clock driver
 to allow frequency scaling
Date: Mon, 20 Jun 2016 21:16:16 +0800
Message-ID: <20160620131616.GA400@leoy-linaro>
References: <32d418f24a4da44ad4ca5b2b1276ffcea2aa7d6c.1466424352.git.amit.kucheria@linaro.org>
 <f6bbd7ddf978001aa0f1c6fb8fc454a30241d0a8.1466424352.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f6bbd7ddf978001aa0f1c6fb8fc454a30241d0a8.1466424352.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On Mon, Jun 20, 2016 at 05:46:36PM +0530, Amit Kucheria wrote:
> The Hisilicon clock stub driver is needed to allow the thermal drivers to
> actually scale the frequency. Make it an automatic dependency.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 22ae1f7..4e843f7 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -178,6 +178,7 @@ config THERMAL_EMULATION
>  config HISI_THERMAL
>  	tristate "Hisilicon thermal driver"
>  	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
> +	select STUB_CLK_HI6220

Acked-by: Leo Yan <leo.yan@linaro.org>

>  	help
>  	  Enable this to plug hisilicon's thermal sensor driver into the Linux
>  	  thermal framework. cpufreq is used as the cooling device to throttle
> -- 
> 2.5.0
> 

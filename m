From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: hisilicon: fix COMPILE_TEST dependencies
Date: Mon, 29 Aug 2016 10:00:52 +0800
Message-ID: <1472436052.3996.1.camel@intel.com>
References: <20160826154434.992160-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160826154434.992160-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Leo Yan <leo.yan@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 五, 2016-08-26 at 17:44 +0200, Arnd Bergmann wrote:
> As we now 'select STUB_CLK_HI6220', all dependencies for that driver
> have
> to be present in order to enable HISI_THERMAL, as pointed out by
> Kconfig:
> 
> warning: (HISI_THERMAL) selects STUB_CLK_HI6220 which has unmet
> direct dependencies (COMMON_CLK && COMMON_CLK_HI6220 && MAILBOX)
> 
> This rearranges the dependencies for this symbol, so all the
> dependencies
> aside from ARCH_HISI are always met when building it for compile
> testing.
> This mainly helps for randconfig testing, as an "allmodconfig" kernel
> will
> enable them anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5f63581ce68e ("thermal: hisilicon: Add dependency on the clock
> driver to allow frequency scaling")

As commit 5f63581ce68e has not been shipped in upstream yet, please
fold this patch into the original one. I'd prefer one good patch
instead of a broken patch + a fix.

thanks,
rui
> ---
>  drivers/thermal/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5cba072c3a62..3c8607c07352 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -177,7 +177,8 @@ config THERMAL_EMULATION
>  
>  config HISI_THERMAL
>  	tristate "Hisilicon thermal driver"
> -	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
> +	depends on ARCH_HISI || COMPILE_TEST
> +	depends on CPU_THERMAL && OF && COMMON_CLK_HI6220 && MAILBOX
>  	depends on HAS_IOMEM
>  	select STUB_CLK_HI6220
>  	help

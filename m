From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: reset: reboot mode: fix build error of missing
 ioremap/iounmap on UM
Date: Mon, 8 Aug 2016 18:54:10 +0200
Message-ID: <20160808165410.GA5959@kozik-book>
References: <1470575661-22325-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470575661-22325-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: sre@kernel.org, richard@nod.at, matthias.bgg@gmail.com, moritz.fischer@ettus.com, fengguang.wu@intel.com, alexandre.belloni@free-electrons.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, k.kozlowski@samsung.com, dwmw2@infradead.org, nicolas.ferre@atmel.com
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 07, 2016 at 09:14:21PM +0800, Andy Yan wrote:
> Add missing HAS_IOMEM dependency for MFD_SYSCON to fix the um-allyesconfig
> build error:
> 
> drivers/mfd/syscon.c: In function 'of_syscon_register':
> drivers/mfd/syscon.c:67:9: error: implicit declaration of function 'ioremap' [-Werror=implicit-function-declaration]
>   base = ioremap(res.start, resource_size(&res));
>          ^
> drivers/mfd/syscon.c:67:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   base = ioremap(res.start, resource_size(&res));
>        ^
> drivers/mfd/syscon.c:109:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
>   iounmap(base);
>   ^
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Missing credits for reported by.

That does not look proper... The driver itself is not using ioremap.
Error is triggered by selecting MFD_SYSCON... Some time ago I sent a
bulk of similar fixes for stuff like this but there were some comments
against. Finally the fixes were merged but ultimately the COMPILE_TEST
was changed to !UM. Here it happens even without COMPILE_TEST... Maybe
it should just depend on MFD_SYSCON?

Best regards,
Krzysztof


> ---
> 
>  drivers/power/reset/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 7053abc..1388be3 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -190,6 +190,7 @@ config REBOOT_MODE
>  config SYSCON_REBOOT_MODE
>  	tristate "Generic SYSCON regmap reboot mode driver"
>  	depends on OF
> +	depends on HAS_IOMEM
>  	select REBOOT_MODE
>  	select MFD_SYSCON
>  	help
> -- 
> 2.7.4
> 
> 

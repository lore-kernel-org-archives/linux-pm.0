From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m
Date: Tue, 30 Apr 2019 11:38:38 +0200
Message-ID: <6e72de15-f507-fb86-f806-9b1647f2dfe2@linaro.org>
References: <20190430092832.7376-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190430092832.7376-1-geert+renesas@glider.be>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "David S . Miller" <davem@davemloft.net>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 30/04/2019 11:28, Geert Uytterhoeven wrote:
> The THERMAL configuration option was changed from tristate to bool, but
> a dependency on THERMAL=m was forgotten, leading to a warning when
> running "make savedefconfig":
> 
>     boolean symbol THERMAL tested for 'm'? test forced to 'n'
> 
> Fixes: be33e4fbbea581ea ("thermal/drivers/core: Remove the module Kconfig's option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/net/ethernet/mellanox/mlxsw/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
> index b6b3ff0fe17f5c4e..7ccb950aa7d4aa30 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
> +++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
> @@ -22,7 +22,6 @@ config MLXSW_CORE_HWMON
>  config MLXSW_CORE_THERMAL
>  	bool "Thermal zone support for Mellanox Technologies Switch ASICs"
>  	depends on MLXSW_CORE && THERMAL
> -	depends on !(MLXSW_CORE=y && THERMAL=m)
>  	default y
>  	---help---
>  	 Say Y here if you want to automatically control fans speed according
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

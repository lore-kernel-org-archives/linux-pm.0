From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RESEND PATCH 1/8] clk: rockchip: add id of the tsadc clock found on
 rk3228 SoCs
Date: Tue, 16 Feb 2016 14:43:01 -0800
Message-ID: <20160216224301.2278.88600@quark.deferred.io>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
 <1455521613-27340-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1455521613-27340-2-git-send-email-wxt@rock-chips.com>
Sender: linux-clk-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Quoting Caesar Wang (2016-02-14 23:33:26)
> This patch adds 'SCLK_TSADC' and 'PCLK_TSADC' id found on rk3228 SoCs.
> That will be needed by TSADC controller.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Michael Turquette <mturquette@baylibre.com>

> ---
> 
>  include/dt-bindings/clock/rk3228-cru.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
> index a78dd89..cd2e06b 100644
> --- a/include/dt-bindings/clock/rk3228-cru.h
> +++ b/include/dt-bindings/clock/rk3228-cru.h
> @@ -29,6 +29,7 @@
>  #define SCLK_SDMMC             68
>  #define SCLK_SDIO              69
>  #define SCLK_EMMC              71
> +#define SCLK_TSADC             72
>  #define SCLK_UART0             77
>  #define SCLK_UART1             78
>  #define SCLK_UART2             79
> @@ -68,6 +69,7 @@
>  #define PCLK_UART0             341
>  #define PCLK_UART1             342
>  #define PCLK_UART2             343
> +#define PCLK_TSADC             344
>  #define PCLK_PWM               350
>  #define PCLK_TIMER             353
>  #define PCLK_PERI              363
> -- 
> 1.9.1
> 

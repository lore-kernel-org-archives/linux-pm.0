From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RESEND PATCH 2/8] clk: rockchip: add the tsadc clocks found on rk3228
 SoCs
Date: Tue, 16 Feb 2016 14:43:10 -0800
Message-ID: <20160216224310.2278.75088@quark.deferred.io>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
 <1455521613-27340-3-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1455521613-27340-3-git-send-email-wxt@rock-chips.com>
Sender: linux-clk-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Quoting Caesar Wang (2016-02-14 23:33:27)
> This patch adds the needed clocks for rk3228 tsadc.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Michael Turquette <mturquette@baylibre.com>

> ---
> 
>  drivers/clk/rockchip/clk-rk3228.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
> index c515915..ac014b9 100644
> --- a/drivers/clk/rockchip/clk-rk3228.c
> +++ b/drivers/clk/rockchip/clk-rk3228.c
> @@ -424,7 +424,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
>         GATE(0, "sclk_otgphy1", "xin24m", 0,
>                         RK2928_CLKGATE_CON(1), 6, GFLAGS),
>  
> -       COMPOSITE_NOMUX(0, "sclk_tsadc", "xin24m", 0,
> +       COMPOSITE_NOMUX(SCLK_TSADC, "sclk_tsadc", "xin24m", 0,
>                         RK2928_CLKSEL_CON(24), 6, 10, DFLAGS,
>                         RK2928_CLKGATE_CON(2), 8, GFLAGS),
>  
> @@ -584,7 +584,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
>         GATE(PCLK_UART0, "pclk_uart0", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 12, GFLAGS),
>         GATE(PCLK_UART1, "pclk_uart1", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 13, GFLAGS),
>         GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 14, GFLAGS),
> -       GATE(0, "pclk_tsadc", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 15, GFLAGS),
> +       GATE(PCLK_TSADC, "pclk_tsadc", "pclk_cpu", 0, RK2928_CLKGATE_CON(9), 15, GFLAGS),
>         GATE(PCLK_GRF, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 0, GFLAGS),
>         GATE(0, "pclk_cru", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 1, GFLAGS),
>         GATE(0, "pclk_sgrf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(10), 2, GFLAGS),
> -- 
> 1.9.1
> 

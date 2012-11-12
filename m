From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 2/6 v4] clk, highbank: Prevent glitches in non-bypass reset mode
Date: Mon, 12 Nov 2012 13:24:12 -0800
Message-ID: <20121112212412.20034.37835@nucleus>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-3-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352313166-28980-3-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

Quoting Mark Langsdorf (2012-11-07 10:32:42)
> The highbank clock will glitch with the current code if the
> clock rate is reset without relocking the PLL. Program the PLL
> correctly to preven glitches.
> 
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: mturquette@linaro.org

Hi Mark,

Looks fine to me.

I seem to be missing the rest of this series in my mail.  Did you want
me to take only this patch (2/6) into clk-next or were you only looking
for my ACK?

Regards,
Mike

> ---
> Changes from v3
>         Changelog text and patch name now correspond to the actual patch
>         was clk, highbank: remove non-bypass reset mode
> Changes from v2
>         None
> Changes from v1:
>         Removed erroneous reformating.
> 
>  drivers/clk/clk-highbank.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
> index 52fecad..3a0b723 100644
> --- a/drivers/clk/clk-highbank.c
> +++ b/drivers/clk/clk-highbank.c
> @@ -182,8 +182,10 @@ static int clk_pll_set_rate(struct clk_hw *hwclk, unsigned long rate,
>                 reg |= HB_PLL_EXT_ENA;
>                 reg &= ~HB_PLL_EXT_BYPASS;
>         } else {
> +               writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
>                 reg &= ~HB_PLL_DIVQ_MASK;
>                 reg |= divq << HB_PLL_DIVQ_SHIFT;
> +               writel(reg | HB_PLL_EXT_BYPASS, hbclk->reg);
>         }
>         writel(reg, hbclk->reg);
>  
> -- 
> 1.7.11.7

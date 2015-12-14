From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] clk: exynos: use irqsave version of spin_lock to avoid
 deadlock with irqs
Date: Mon, 14 Dec 2015 17:40:44 +0100
Message-ID: <566EF10C.2000705@samsung.com>
References: <1449844798-27384-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1449844798-27384-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Abraham <thomas.ab@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Lukasz Majewski <l.majewski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/12/15 15:38, Marek Szyprowski wrote:
> It is allowed to enable/disable clocks from interrupts, so common Exynos
> ARM clock management code for CPUfreq should use 'irqsave' version of
> spin_lock calls to avoid potential deadlock caused by spin_lock recursion.
> The same spin_lock is used by gate/mux clocks during enable/disable calls.
> 
> This deadlock, can be reproduced by enabling CPUfreq (ondemand or
> userspace) and decoding video with s5p-mfc driver.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: stable@vger.kernel.org  # v4.2+

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Mike, Stephen, could you apply this patch directly?
It would be nice to have it in 4.4 as the bug fixed here causes
some of exynos boards in mainline to fail booting with default
config. I could resend the patch directly to you if needed.

Thanks,
Sylwester

> ---
>  drivers/clk/samsung/clk-cpu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
> index 2fe37f708dc7..813003d6ce09 100644
> --- a/drivers/clk/samsung/clk-cpu.c
> +++ b/drivers/clk/samsung/clk-cpu.c
> @@ -148,6 +148,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
>  	unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
>  	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
>  	unsigned long div0, div1 = 0, mux_reg;
> +	unsigned long flags;
>  
>  	/* find out the divider values to use for clock data */
>  	while ((cfg_data->prate * 1000) != ndata->new_rate) {
> @@ -156,7 +157,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
>  		cfg_data++;
>  	}
>  
> -	spin_lock(cpuclk->lock);
> +	spin_lock_irqsave(cpuclk->lock, flags);
>  
>  	/*
>  	 * For the selected PLL clock frequency, get the pre-defined divider
> @@ -212,7 +213,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
>  				DIV_MASK_ALL);
>  	}
>  
> -	spin_unlock(cpuclk->lock);
> +	spin_unlock_irqrestore(cpuclk->lock, flags);
>  	return 0;
>  }
>  
> @@ -223,6 +224,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
>  	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
>  	unsigned long div = 0, div_mask = DIV_MASK;
>  	unsigned long mux_reg;
> +	unsigned long flags;
>  
>  	/* find out the divider values to use for clock data */
>  	if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
> @@ -233,7 +235,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
>  		}
>  	}
>  
> -	spin_lock(cpuclk->lock);
> +	spin_lock_irqsave(cpuclk->lock, flags);
>  
>  	/* select mout_apll as the alternate parent */
>  	mux_reg = readl(base + E4210_SRC_CPU);
> @@ -246,7 +248,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
>  	}
>  
>  	exynos_set_safe_div(base, div, div_mask);
> -	spin_unlock(cpuclk->lock);
> +	spin_unlock_irqrestore(cpuclk->lock, flags);
>  	return 0;
>  }

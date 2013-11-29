From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/1] cpufreq: exynos5250: Set APLL rate using CCF API
Date: Fri, 29 Nov 2013 07:11:39 +0100
Message-ID: <20131129071139.46eff334@amdc2363>
References: <1385009046-22070-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1385009046-22070-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-samsung-soc@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, kgene.kim@samsung.com, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Sachin,

> Use common clock framework (CCF) APIs to set the clock rates
> instead of direct register manipulation. This now updates the
> sysfs entry (cpuinfo_cur_freq) correctly which did not reflect
> the correct value until now. While at it clean up the PLL s-div
> parameter setting as it is handled by the PLL driver.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> To fully test this, the following 2 patches would be necessary:
> * clk: exynos5250: register APLL rate table
> http://www.spinics.net/lists/arm-kernel/msg285103.html
> * clk: exynos5250: Add CLK_SET_RATE_PARENT flag to mout_apll
> http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/24906
> ---
> 
>  drivers/cpufreq/exynos5250-cpufreq.c |   74
> +++++----------------------------- 1 file changed, 10 insertions(+),
> 64 deletions(-)
> 
> diff --git a/drivers/cpufreq/exynos5250-cpufreq.c
> b/drivers/cpufreq/exynos5250-cpufreq.c index
> 8feda86fe42c..86fb1a105601 100644 ---
> a/drivers/cpufreq/exynos5250-cpufreq.c +++
> b/drivers/cpufreq/exynos5250-cpufreq.c @@ -102,12 +102,12 @@ static
> void set_clkdiv(unsigned int div_index) cpu_relax();
>  }
>  
> -static void set_apll(unsigned int new_index,
> -			     unsigned int old_index)
> +static void set_apll(unsigned int index)
>  {
> -	unsigned int tmp, pdiv;
> +	unsigned int tmp;
> +	unsigned int freq = apll_freq_5250[index].freq;
>  
> -	/* 1. MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
> +	/* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
>  	clk_set_parent(moutcore, mout_mpll);
>  
>  	do {
> @@ -116,24 +116,9 @@ static void set_apll(unsigned int new_index,
>  		tmp &= 0x7;
>  	} while (tmp != 0x2);
>  
> -	/* 2. Set APLL Lock time */
> -	pdiv = ((apll_freq_5250[new_index].mps >> 8) & 0x3f);
> -
> -	__raw_writel((pdiv * 250), EXYNOS5_APLL_LOCK);
> +	clk_set_rate(mout_apll, freq * 1000);
>  
> -	/* 3. Change PLL PMS values */
> -	tmp = __raw_readl(EXYNOS5_APLL_CON0);
> -	tmp &= ~((0x3ff << 16) | (0x3f << 8) | (0x7 << 0));
> -	tmp |= apll_freq_5250[new_index].mps;
> -	__raw_writel(tmp, EXYNOS5_APLL_CON0);
> -
> -	/* 4. wait_lock_time */
> -	do {
> -		cpu_relax();
> -		tmp = __raw_readl(EXYNOS5_APLL_CON0);
> -	} while (!(tmp & (0x1 << 29)));
> -
> -	/* 5. MUX_CORE_SEL = APLL */
> +	/* MUX_CORE_SEL = APLL */
>  	clk_set_parent(moutcore, mout_apll);
>  
>  	do {
> @@ -141,55 +126,17 @@ static void set_apll(unsigned int new_index,
>  		tmp = __raw_readl(EXYNOS5_CLKMUX_STATCPU);
>  		tmp &= (0x7 << 16);
>  	} while (tmp != (0x1 << 16));
> -
> -}
> -
> -static bool exynos5250_pms_change(unsigned int old_index, unsigned
> int new_index) -{
> -	unsigned int old_pm = apll_freq_5250[old_index].mps >> 8;
> -	unsigned int new_pm = apll_freq_5250[new_index].mps >> 8;
> -
> -	return (old_pm == new_pm) ? 0 : 1;
>  }
>  
>  static void exynos5250_set_frequency(unsigned int old_index,
>  				  unsigned int new_index)
>  {
> -	unsigned int tmp;
> -
>  	if (old_index > new_index) {
> -		if (!exynos5250_pms_change(old_index, new_index)) {
> -			/* 1. Change the system clock divider values
> */
> -			set_clkdiv(new_index);
> -			/* 2. Change just s value in apll m,p,s
> value */
> -			tmp = __raw_readl(EXYNOS5_APLL_CON0);
> -			tmp &= ~(0x7 << 0);
> -			tmp |= apll_freq_5250[new_index].mps & 0x7;
> -			__raw_writel(tmp, EXYNOS5_APLL_CON0);
> -
> -		} else {
> -			/* Clock Configuration Procedure */
> -			/* 1. Change the system clock divider values
> */
> -			set_clkdiv(new_index);
> -			/* 2. Change the apll m,p,s value */
> -			set_apll(new_index, old_index);
> -		}
> +		set_clkdiv(new_index);
> +		set_apll(new_index);
>  	} else if (old_index < new_index) {
> -		if (!exynos5250_pms_change(old_index, new_index)) {
> -			/* 1. Change just s value in apll m,p,s
> value */
> -			tmp = __raw_readl(EXYNOS5_APLL_CON0);
> -			tmp &= ~(0x7 << 0);
> -			tmp |= apll_freq_5250[new_index].mps & 0x7;
> -			__raw_writel(tmp, EXYNOS5_APLL_CON0);
> -			/* 2. Change the system clock divider values
> */
> -			set_clkdiv(new_index);
> -		} else {
> -			/* Clock Configuration Procedure */
> -			/* 1. Change the apll m,p,s value */
> -			set_apll(new_index, old_index);
> -			/* 2. Change the system clock divider values
> */
> -			set_clkdiv(new_index);
> -		}
> +		set_apll(new_index);
> +		set_clkdiv(new_index);
>  	}
>  }
>  
> @@ -222,7 +169,6 @@ int exynos5250_cpufreq_init(struct
> exynos_dvfs_info *info) info->volt_table = exynos5250_volt_table;
>  	info->freq_table = exynos5250_freq_table;
>  	info->set_freq = exynos5250_set_frequency;
> -	info->need_apll_change = exynos5250_pms_change;
>  
>  	return 0;
>  

Looks good to me.

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

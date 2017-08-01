From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpufreq: imx6q: imx6ull: use PLL1 for frequency higher than 528MHz
Date: Wed, 02 Aug 2017 01:25:14 +0200
Message-ID: <1790312.mdBOOMI6jx@aspire.rjw.lan>
References: <1501230993-15812-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501230993-15812-1-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Julien Boibessot <julien.boibessot@armadeus.com>
List-Id: linux-pm@vger.kernel.org

On Friday, July 28, 2017 10:36:33 AM Sébastien Szymanski wrote:
> Setting the frequency higher than 528Mhz actually sets the ARM
> clock to 528MHz. That's because PLL2 is used as the root clock when the
> frequency is higher than 396MHz.
> 
> cpupower frequency-set -f 792000
> 
> arm_clk_root on the CCM_CLKO2 signal is 528MHz instead of 792MHz.
> 
> [   61.606383] cpu cpu0: 396 MHz, 1025 mV --> 792 MHz, 1225 mV
> 
> pll2                         1  1  528000000 0 0
>    pll2_bypass               1  1  528000000 0 0
>       pll2_bus               3  3  528000000 0 0
> 	 ca7_secondary_sel   1  1  528000000 0 0
> 	    step             1  1  528000000 0 0
> 	       pll1_sw       1  1  528000000 0 0
> 		  arm        1  1  528000000 0 0
> 
> Fixes this by using the PLL1 as the root clock when the frequency is
> higher than 528MHz.
> 
> cpupower frequency-set -f 792000
> 
> arm_clk_root on the CCM_CLKO2 signal is now 792MHz as expected.
> 
> [   69.717987] cpu cpu0: 198 MHz, 950 mV --> 792 MHz, 1225 mV
> 
> pll1               1 1 792000000 0 0
>    pll1_bypass     1 1 792000000 0 0
>       pll1_sys     1 1 792000000 0 0
> 	 pll1_sw   1 1 792000000 0 0
> 	    arm    1 1 792000000 0 0
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index b6edd3c..e5fba50 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -18,6 +18,7 @@
>  
>  #define PU_SOC_VOLTAGE_NORMAL	1250000
>  #define PU_SOC_VOLTAGE_HIGH	1275000
> +#define FREQ_528_MHZ		528000000
>  #define FREQ_1P2_GHZ		1200000000
>  
>  static struct regulator *arm_reg;
> @@ -110,14 +111,20 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  		 * voltage of 528MHz, so lower the CPU frequency to one
>  		 * half before changing CPU frequency.
>  		 */
> -		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> -		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +		if ((old_freq * 1000) <= FREQ_528_MHZ) {
> +			clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> +			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +		}
>  		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
>  			clk_set_parent(secondary_sel_clk, pll2_bus_clk);
>  		else
>  			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
>  		clk_set_parent(step_clk, secondary_sel_clk);
>  		clk_set_parent(pll1_sw_clk, step_clk);
> +		if (freq_hz > FREQ_528_MHZ) {
> +			clk_set_rate(pll1_sys_clk, freq_hz);
> +			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +		}
>  	} else {
>  		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>  		clk_set_parent(pll1_sw_clk, step_clk);
> 

Any comments anyone?  Good, bad, ugly?

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for i.MX6UL/ULL
Date: Fri, 09 Feb 2018 12:52:22 +0100
Message-ID: <1619001.eqAapW3X4z@aspire.rjw.lan>
References: <20180118235836.17393-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180118235836.17393-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: viresh.kumar@linaro.org, fabio.estevam@nxp.com, octavian.purdila@nxp.com, shawnguo@kernel.org, max.oss.09@gmail.com, marcel.ziswiler@toradex.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, January 19, 2018 12:58:36 AM CET Stefan Agner wrote:
> Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
> Use PLL1 sys clock for all operating points higher than 528MHz.
> 
> Note: For higher operating points VDD_SOC_IN needs to be 125mV
> higher than the ARM set-point (see datasheet). Specifically, the
> i.MX6UL/ULL EVK boards have an external DC regulator which needs
> adjustment. The regulator adjustment is not covered with this
> change.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

This makes sense to me, but I need someone with the requisite platform
knowledge to review it.

> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 628fe899cb48..840f6386c780 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  		 */
>  		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
>  		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> -		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> -			clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> -		else
> -			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> -		clk_set_parent(step_clk, secondary_sel_clk);
> -		clk_set_parent(pll1_sw_clk, step_clk);
> +		if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
> +			if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> +				clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> +			else
> +				clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> +			clk_set_parent(step_clk, secondary_sel_clk);
> +			clk_set_parent(pll1_sw_clk, step_clk);
> +		}
>  	} else {
>  		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>  		clk_set_parent(pll1_sw_clk, step_clk);
> 

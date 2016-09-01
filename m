From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 5/5] clocks: exynos5433: add runtime pm support
Date: Thu, 01 Sep 2016 18:55:38 +0200
Message-ID: <2519946.fIx2ZfLU7C@amdc1976>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1472737551-15272-6-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Thursday, September 01, 2016 03:45:51 PM Marek Szyprowski wrote:
> Add runtime pm support for all clock controller units (CMU), which belongs
> to power domains and require special handling during on/off operations.
> Typically special values has to be written to MUX registers to change
> internal clocks parents to OSC clock before turning power off. During such
> operation all clocks, which enters CMU has to be enabled to let MUX to
> stabilize. Also for each CMU there is one special parent clock, which has
> to be enabled all the time when any access to CMU registers is done.
> 
> This patch solves most of the mysterious external abort and freeze issues
> caused by a lack of proper parent CMU clock enabled or incorrect turn off
> procedure.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 462 +++++++++++++++++++++++++++--------
>  1 file changed, 363 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index ea1608682d7f..9fb896b56ddf 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -9,9 +9,14 @@
>   * Common Clock Framework support for Exynos5443 SoC.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
>  
>  #include <dt-bindings/clock/exynos5433.h>
>  
> @@ -19,6 +24,37 @@
>  #include "clk-cpu.h"
>  #include "clk-pll.h"
>  
> +struct exynos5433_cmu_info {
> +	/* total number of clocks with IDs assigned*/
> +	unsigned int nr_clk_ids;
> +	/* list of pll clocks and respective count */
> +	const struct samsung_pll_clock *pll_clks;
> +	unsigned int nr_pll_clks;
> +	/* list of mux clocks and respective count */
> +	const struct samsung_mux_clock *mux_clks;
> +	unsigned int nr_mux_clks;
> +	/* list of div clocks and respective count */
> +	const struct samsung_div_clock *div_clks;
> +	unsigned int nr_div_clks;
> +	/* list of gate clocks and respective count */
> +	const struct samsung_gate_clock *gate_clks;
> +	unsigned int nr_gate_clks;
> +	/* list of fixed clocks and respective count */
> +	const struct samsung_fixed_rate_clock *fixed_clks;
> +	unsigned int nr_fixed_clks;
> +	/* list of fixed factor clocks and respective count */
> +	const struct samsung_fixed_factor_clock *fixed_factor_clks;
> +	unsigned int nr_fixed_factor_clks;
> +	/* list and number of clocks registers */
> +	const unsigned long *clk_regs;
> +	unsigned int nr_clk_regs;
> +	/* list and number of clocks registers to set before suspend */
> +	const struct samsung_clk_reg_dump *suspend_regs;
> +	unsigned int nr_suspend_regs;
> +	/* name of the parent clock needed for CMU register access */
> +	const char *clk_name;
> +};

Have you considered extending struct samsung_cmu_info instead
(all instances are __initdata anyway so slight increase of struct's
size shouldn't be a problem)?

> +static const struct samsung_clk_reg_dump g2d_suspend_regs[] = {
> +	{MUX_SEL_G2D0, 0},

Minor nit: preferred CodingStyle is:

	{ MUX_SEL_G2D0, 0 },

( ditto for other struct samsung_clk_reg_dump instances )

> +	clk_table = devm_kcalloc(dev, info->nr_clk_ids, sizeof(struct clk *),
> +				 GFP_KERNEL);
> +	if (!clk_table) {
> +		dev_err(dev, "could not allocate clock lookup table\n");
> +		return -ENOMEM;
> +	}

checkpatch.pl complains with:

WARNING: Possible unnecessary 'out of memory' message
#681: FILE: drivers/clk/samsung/clk-exynos5433.c:5541:
+       if (!clk_table) {
+               dev_err(dev, "could not allocate clock lookup table\n");

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

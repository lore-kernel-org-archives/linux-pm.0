From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH v10 05/17] clk: tegra: Introduce ability for SoC-specific
 reset control callbacks
Date: Tue, 19 May 2015 14:46:32 +0300
Message-ID: <555B2298.4050809@kapsi.fi>
References: <1431529131-16710-6-git-send-email-mikko.perttunen@kapsi.fi> <1432035567-19008-1-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432035567-19008-1-git-send-email-mikko.perttunen-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Forgot to write it in the patch description, but v10 for patches 5 and 6 
changes the base for custom resets from 0x40000000 to periph_banks * 32 
and also makes the SoC-specific code tell the core how many special 
resets it has. This is quite a bit cleaner than the previous version.

Thanks to Thierry for the idea.

Mikko

On 05/19/15 14:39, Mikko Perttunen wrote:
> This patch allows SoC-specific CAR initialization routines to register
> their own reset_assert and reset_deassert callbacks with the common Tegra
> CAR code. If defined, the common code will call these callbacks when a
> reset control with number >= num_periph_banks * 32 is attempted to be asserted
> or deasserted respectively. Numbers greater than or equal to num_periph_banks * 32
> are used to avoid clashes with low numbers that are automatically mapped to
> standard CAR reset lines.
>
> Each SoC with these special resets should specify the defined reset control
> numbers in a device tree header file.
>
> Signed-off-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
> Acked-by: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/clk/tegra/clk.c | 39 +++++++++++++++++++++++++++++++--------
>   drivers/clk/tegra/clk.h |  3 +++
>   2 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index 41cd87c..c093ed9 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -49,7 +49,6 @@
>   #define RST_DEVICES_L			0x004
>   #define RST_DEVICES_H			0x008
>   #define RST_DEVICES_U			0x00C
> -#define RST_DFLL_DVCO			0x2F4
>   #define RST_DEVICES_V			0x358
>   #define RST_DEVICES_W			0x35C
>   #define RST_DEVICES_X			0x28C
> @@ -79,6 +78,11 @@ static struct clk **clks;
>   static int clk_num;
>   static struct clk_onecell_data clk_data;
>
> +/* Handlers for SoC-specific reset lines */
> +static int (*special_reset_assert)(unsigned long);
> +static int (*special_reset_deassert)(unsigned long);
> +static int special_reset_num;
> +
>   static struct tegra_clk_periph_regs periph_regs[] = {
>   	[0] = {
>   		.enb_reg = CLK_OUT_ENB_L,
> @@ -152,19 +156,29 @@ static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
>   	 */
>   	tegra_read_chipid();
>
> -	writel_relaxed(BIT(id % 32),
> -			clk_base + periph_regs[id / 32].rst_set_reg);
> +	if (id < periph_banks * 32) {
> +		writel_relaxed(BIT(id % 32),
> +			       clk_base + periph_regs[id / 32].rst_set_reg);
> +		return 0;
> +	} else if (id < periph_banks * 32 + special_reset_num) {
> +		return special_reset_assert(id);
> +	}
>
> -	return 0;
> +	return -EINVAL;
>   }
>
>   static int tegra_clk_rst_deassert(struct reset_controller_dev *rcdev,
>   		unsigned long id)
>   {
> -	writel_relaxed(BIT(id % 32),
> -			clk_base + periph_regs[id / 32].rst_clr_reg);
> +	if (id < periph_banks * 32) {
> +		writel_relaxed(BIT(id % 32),
> +			       clk_base + periph_regs[id / 32].rst_clr_reg);
> +		return 0;
> +	} else if (id < periph_banks * 32 + special_reset_num) {
> +		return special_reset_deassert(id);
> +	}
>
> -	return 0;
> +	return -EINVAL;
>   }
>
>   struct tegra_clk_periph_regs *get_reg_bank(int clkid)
> @@ -286,10 +300,19 @@ void __init tegra_add_of_provider(struct device_node *np)
>   	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>
>   	rst_ctlr.of_node = np;
> -	rst_ctlr.nr_resets = periph_banks * 32;
> +	rst_ctlr.nr_resets = periph_banks * 32 + special_reset_num;
>   	reset_controller_register(&rst_ctlr);
>   }
>
> +void __init tegra_init_special_resets(int num,
> +				      int (*assert)(unsigned long),
> +				      int (*deassert)(unsigned long))
> +{
> +	special_reset_num = num;
> +	special_reset_assert = assert;
> +	special_reset_deassert = deassert;
> +}
> +
>   void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
>   {
>   	int i;
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 75ddc8ff..f42cbbe 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -591,6 +591,9 @@ struct tegra_devclk {
>   	char		*con_id;
>   };
>
> +void tegra_init_special_resets(int num, int (*assert)(unsigned long),
> +			       int (*deassert)(unsigned long));
> +
>   void tegra_init_from_table(struct tegra_clk_init_table *tbl,
>   		struct clk *clks[], int clk_max);
>
>

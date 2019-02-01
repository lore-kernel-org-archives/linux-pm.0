From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
Date: Fri, 1 Feb 2019 17:07:09 +0900
Message-ID: <768b4147-35fb-64ad-5da8-6b348e962c70@samsung.com>
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p1ca478545c107086d427909c88d3b232e@eucas1p1.samsung.com>
        <1548924594-19084-3-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548924594-19084-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

When I reviewed this patch, the almost changes are wrong.
Frankly, I can't believe that you had tested and verified it
on real board. Please check my comments.
If I misunderstood, please let me know.

On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
> This patch provides support for clocks needed for Dynamic Memory Controller
> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
> GATE entries.
> 
> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-clk@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 48 +++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 34cce3c..3e87421 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -132,6 +132,8 @@
>  #define BPLL_LOCK		0x20010
>  #define BPLL_CON0		0x20110
>  #define SRC_CDREX		0x20200
> +#define GATE_BUS_CDREX0		0x20700
> +#define GATE_BUS_CDREX1		0x20704
>  #define DIV_CDREX0		0x20500
>  #define DIV_CDREX1		0x20504
>  #define KPLL_LOCK		0x28000
> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>  	DIV_CDREX1,
>  	SRC_KFC,
>  	DIV_KFC0,
> +	GATE_BUS_CDREX0,
> +	GATE_BUS_CDREX1,
>  };
>  
>  static const unsigned long exynos5800_clk_regs[] __initconst = {
> @@ -425,6 +429,10 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>  PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>  PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>  PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_dpll_ctrl",
> +					"mout_mpll_ctrl", "ff_dout_spll2",
> +					"mout_sclk_spll"};

- mout_dpll_ctrl was not defined. This patch doesn't define it.
- mout_mpll_ctrl was not defined. ditto.
- ff_dout_spll2 was only registered when SOC is EXYNOS5800.
  It meant that ff_dout_spll2 was not registered on exynos5422 board.

It is wrong patch. You would have not checked the parent clocks
except for sclk_bpll.

Also,
In the exynos5422 datasheet, MUX_MX_MSPLL_CCORE_PHY_SEL is possible
having the six parents as following:
- sclk_bpll
- sclk_dpll
- sclk_mpll
- sclk_spll2
- sclk_spll
- sclk_epll

Why do you missing last 'sclk_epll'?


> +
>  
>  /* fixed rate clocks generated outside the soc */
>  static struct samsung_fixed_rate_clock
> @@ -450,7 +458,7 @@ static const struct samsung_fixed_factor_clock
>  static const struct samsung_fixed_factor_clock
>  		exynos5800_fixed_factor_clks[] __initconst = {
>  	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),

It doesn't affect the Exynos5422 because exynos5800_fixed_factor_clks[]
is registered when SOC is EXYNOS5800. Exynos5422 board cannot use this clock.

>  };
>  
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
> @@ -472,11 +480,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>  	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>  
> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
> +

Why do you modify the exynos5800_mux_clks instead of exynos5420_mux_clks
or exynos5x_mux_clks? In the coverletter this patch is for Exynos5422 board.
Did you test it?

>  	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),

ditto.

>  	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>  			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),

ditto.

>  	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>  
>  	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
> @@ -648,7 +659,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  
>  	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>  	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>  	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>  	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>  	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
> @@ -814,9 +825,13 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  			DIV_CDREX0, 16, 3),
>  	DIV(CLK_DOUT_CCLK_DREX0, "dout_cclk_drex0", "dout_clk2x_phy0",
>  			DIV_CDREX0, 8, 3),
> +	DIV(0, "dout_cclk_drex1", "dout_clk2x_phy0", DIV_CDREX0, 8, 3),

Hmm. CLK_DIV_CDREX0[10:8] of DIV_CDREX0 register was already implemented
by CLK_DOUT_CCLK_DREX0. It is fault.

Also, PCLK_CORE_MEM_RATIO[10:8] of DIV_CDREX1 register was defined as following
in clock-exynos5420.c.
- DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex", DIV_CDREX1, 8, 3), 


>  	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>  			DIV_CDREX0, 3, 5),
>  
> +	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
> +	DIV(0, "dout_pclk_drex1", "dout_cclk_drex1", DIV_CDREX0, 28, 3),

dout_cclk_drex1 is wrong. It is fault.

> +
>  	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>  			DIV_CDREX1, 8, 3),
>  
> @@ -1170,6 +1185,31 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>  			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>  
>  	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
> +
> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 0, 0, 0),
> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 1, 0, 0),
> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>  };
>  
>  static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

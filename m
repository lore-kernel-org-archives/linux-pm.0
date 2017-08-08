From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 3/4] clk: samsung: exynos5433: Add runtime PM support
Date: Tue, 8 Aug 2017 18:11:19 +0200
Message-ID: <20170808161119.GC2646@kozik-book>
References: <1501839294-478-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170804093516eucas1p2267f819dad7c2e84eeca81a81d2687f2@eucas1p2.samsung.com>
 <1501839294-478-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501839294-478-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 04, 2017 at 11:34:53AM +0200, Marek Szyprowski wrote:
> Add runtime pm support for all clock controller units (CMU), which belongs

s/belongs/belong/

> to power domains and require special handling during on/off operations.
> Typically special values has to be written to MUX registers to change
> internal clocks parents to OSC clock before turning power off. During such
> operation all clocks, which enters CMU has to be enabled to let MUX to

s/enters/enter/

Beside that, how about unifying the title with previous mail ("Add
support for runtime PM")?

> stabilize. Also for each CMU there is one special parent clock, which has
> to be enabled all the time when any access to CMU registers is done.
> 
> This patch solves most of the mysterious external abort and freeze issues
> caused by a lack of proper parent CMU clock enabled or incorrect turn off
> procedure.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../devicetree/bindings/clock/exynos5433-clock.txt |  16 +
>  drivers/clk/samsung/clk-exynos5433.c               | 409 ++++++++++++++++-----
>  drivers/clk/samsung/clk.h                          |   6 +
>  3 files changed, 346 insertions(+), 85 deletions(-)
> 

Looks okay for me, few minor nits below and:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


> diff --git a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> index 1dc80f8811fe..5c7dd12e667a 100644
> --- a/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos5433-clock.txt
> @@ -168,6 +168,11 @@ Required Properties:
>  		- aclk_cam1_400
>  		- aclk_cam1_552
>  
> +Optional properties:
> +  - power-domains: a phandle to respective power domain node as described by
> +	generic PM domain bindings (see power/power_domain.txt for more
> +	information).
> +
>  Each clock is assigned an identifier and client nodes can use this identifier
>  to specify the clock which they consume.
>  
> @@ -270,6 +275,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  		clocks = <&xxti>,
>  		       <&cmu_top CLK_ACLK_G2D_266>,
>  		       <&cmu_top CLK_ACLK_G2D_400>;
> +		power-domains = <&pd_g2d>;
>  	};
>  
>  	cmu_disp: clock-controller@13b90000 {
> @@ -295,6 +301,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  		       <&cmu_mif CLK_SCLK_DECON_ECLK_DISP>,
>  		       <&cmu_mif CLK_SCLK_DECON_TV_VCLK_DISP>,
>  		       <&cmu_mif CLK_ACLK_DISP_333>;
> +		power-domains = <&pd_disp>;
>  	};
>  
>  	cmu_aud: clock-controller@114c0000 {
> @@ -304,6 +311,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  
>  		clock-names = "oscclk", "fout_aud_pll";
>  		clocks = <&xxti>, <&cmu_top CLK_FOUT_AUD_PLL>;
> +		power-domains = <&pd_aud>;
>  	};
>  
>  	cmu_bus0: clock-controller@13600000 {
> @@ -340,6 +348,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  
>  		clock-names = "oscclk", "aclk_g3d_400";
>  		clocks = <&xxti>, <&cmu_top CLK_ACLK_G3D_400>;
> +		power-domains = <&pd_g3d>;
>  	};
>  
>  	cmu_gscl: clock-controller@13cf0000 {
> @@ -353,6 +362,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  		clocks = <&xxti>,
>  			<&cmu_top CLK_ACLK_GSCL_111>,
>  			<&cmu_top CLK_ACLK_GSCL_333>;
> +		power-domains = <&pd_gscl>;
>  	};
>  
>  	cmu_apollo: clock-controller@11900000 {
> @@ -384,6 +394,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  		clocks = <&xxti>,
>  		       <&cmu_top CLK_SCLK_JPEG_MSCL>,
>  		       <&cmu_top CLK_ACLK_MSCL_400>;
> +		power-domains = <&pd_mscl>;
>  	};
>  
>  	cmu_mfc: clock-controller@15280000 {
> @@ -393,6 +404,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  
>  		clock-names = "oscclk", "aclk_mfc_400";
>  		clocks = <&xxti>, <&cmu_top CLK_ACLK_MFC_400>;
> +		power-domains = <&pd_mfc>;
>  	};
>  
>  	cmu_hevc: clock-controller@14f80000 {
> @@ -402,6 +414,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  
>  		clock-names = "oscclk", "aclk_hevc_400";
>  		clocks = <&xxti>, <&cmu_top CLK_ACLK_HEVC_400>;
> +		power-domains = <&pd_hevc>;
>  	};
>  
>  	cmu_isp: clock-controller@146d0000 {
> @@ -415,6 +428,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  		clocks = <&xxti>,
>  		       <&cmu_top CLK_ACLK_ISP_DIS_400>,
>  		       <&cmu_top CLK_ACLK_ISP_400>;
> +		power-domains = <&pd_isp>;
>  	};
>  
>  	cmu_cam0: clock-controller@120d0000 {
> @@ -430,6 +444,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  		       <&cmu_top CLK_ACLK_CAM0_333>,
>  		       <&cmu_top CLK_ACLK_CAM0_400>,
>  		       <&cmu_top CLK_ACLK_CAM0_552>;
> +		power-domains = <&pd_cam0>;
>  	};
>  
>  	cmu_cam1: clock-controller@145d0000 {
> @@ -451,6 +466,7 @@ Example 2: Examples of clock controller nodes are listed below.
>  		       <&cmu_top CLK_ACLK_CAM1_333>,
>  		       <&cmu_top CLK_ACLK_CAM1_400>,
>  		       <&cmu_top CLK_ACLK_CAM1_552>;
> +		power-domains = <&pd_cam1>;
>  	};
>  
>  Example 3: UART controller node that consumes the clock generated by the clock
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index 11343a597093..7ae9bccb1192 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -9,9 +9,14 @@
>   * Common Clock Framework support for Exynos5433 SoC.
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

Why you need slab.h?

>  
>  #include <dt-bindings/clock/exynos5433.h>
>  
> @@ -1991,6 +1996,14 @@ static void __init exynos5433_cmu_peris_init(struct device_node *np)
>  	ENABLE_IP_FSYS1,
>  };
>  
> +static const struct samsung_clk_reg_dump fsys_suspend_regs[] = {
> +	{ MUX_SEL_FSYS0, 0 },
> +	{ MUX_SEL_FSYS1, 0 },
> +	{ MUX_SEL_FSYS2, 0 },
> +	{ MUX_SEL_FSYS3, 0 },
> +	{ MUX_SEL_FSYS4, 0 },
> +};
> +
>  static const struct samsung_fixed_rate_clock fsys_fixed_clks[] __initconst = {
>  	/* PHY clocks from USBDRD30_PHY */
>  	FRATE(CLK_PHYCLK_USBDRD30_UDRD30_PHYCLOCK_PHY,
> @@ -2296,16 +2309,11 @@ static void __init exynos5433_cmu_peris_init(struct device_node *np)
>  	.nr_clk_ids		= FSYS_NR_CLK,
>  	.clk_regs		= fsys_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(fsys_clk_regs),
> +	.suspend_regs		= fsys_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(fsys_suspend_regs),
> +	.clk_name		= "aclk_fsys_200",
>  };
>  
> -static void __init exynos5433_cmu_fsys_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &fsys_cmu_info);
> -}
> -
> -CLK_OF_DECLARE(exynos5433_cmu_fsys, "samsung,exynos5433-cmu-fsys",
> -		exynos5433_cmu_fsys_init);
> -
>  /*
>   * Register offset definitions for CMU_G2D
>   */
> @@ -2335,6 +2343,10 @@ static void __init exynos5433_cmu_fsys_init(struct device_node *np)
>  	DIV_ENABLE_IP_G2D_SECURE_SMMU_G2D,
>  };
>  
> +static const struct samsung_clk_reg_dump g2d_suspend_regs[] = {
> +	{ MUX_SEL_G2D0, 0 },
> +};
> +
>  /* list of all parent clock list */
>  PNAME(mout_aclk_g2d_266_user_p)		= { "oscclk", "aclk_g2d_266", };
>  PNAME(mout_aclk_g2d_400_user_p)		= { "oscclk", "aclk_g2d_400", };
> @@ -2420,16 +2432,11 @@ static void __init exynos5433_cmu_fsys_init(struct device_node *np)
>  	.nr_clk_ids		= G2D_NR_CLK,
>  	.clk_regs		= g2d_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(g2d_clk_regs),
> +	.suspend_regs		= g2d_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(g2d_suspend_regs),
> +	.clk_name		= "aclk_g2d_400",
>  };
>  
> -static void __init exynos5433_cmu_g2d_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &g2d_cmu_info);
> -}
> -
> -CLK_OF_DECLARE(exynos5433_cmu_g2d, "samsung,exynos5433-cmu-g2d",
> -		exynos5433_cmu_g2d_init);
> -
>  /*
>   * Register offset definitions for CMU_DISP
>   */
> @@ -2494,6 +2501,18 @@ static void __init exynos5433_cmu_g2d_init(struct device_node *np)
>  	CLKOUT_CMU_DISP_DIV_STAT,
>  };
>  
> +static const struct samsung_clk_reg_dump disp_suspend_regs[] = {
> +	/* PLL has to be enabled for suspend */
> +	{ DISP_PLL_CON0, 0x85f40502 },
> +	/* ignore status of external PHY muxes during suspend to avoid hangs */
> +	{ MUX_IGNORE_DISP2, 0x00111111 },
> +	{ MUX_SEL_DISP0, 0 },
> +	{ MUX_SEL_DISP1, 0 },
> +	{ MUX_SEL_DISP2, 0 },
> +	{ MUX_SEL_DISP3, 0 },
> +	{ MUX_SEL_DISP4, 0 },
> +};
> +
>  /* list of all parent clock list */
>  PNAME(mout_disp_pll_p)			= { "oscclk", "fout_disp_pll", };
>  PNAME(mout_sclk_dsim1_user_p)		= { "oscclk", "sclk_dsim1_disp", };
> @@ -2841,16 +2860,11 @@ static void __init exynos5433_cmu_g2d_init(struct device_node *np)
>  	.nr_clk_ids		= DISP_NR_CLK,
>  	.clk_regs		= disp_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(disp_clk_regs),
> +	.suspend_regs		= disp_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(disp_suspend_regs),
> +	.clk_name		= "aclk_disp_333",
>  };
>  
> -static void __init exynos5433_cmu_disp_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &disp_cmu_info);
> -}
> -
> -CLK_OF_DECLARE(exynos5433_cmu_disp, "samsung,exynos5433-cmu-disp",
> -		exynos5433_cmu_disp_init);
> -
>  /*
>   * Register offset definitions for CMU_AUD
>   */
> @@ -2885,6 +2899,11 @@ static void __init exynos5433_cmu_disp_init(struct device_node *np)
>  	ENABLE_IP_AUD1,
>  };
>  
> +static const struct samsung_clk_reg_dump aud_suspend_regs[] = {
> +	{ MUX_SEL_AUD0, 0 },
> +	{ MUX_SEL_AUD1, 0 },
> +};
> +
>  /* list of all parent clock list */
>  PNAME(mout_aud_pll_user_aud_p)	= { "oscclk", "fout_aud_pll", };
>  PNAME(mout_sclk_aud_pcm_p)	= { "mout_aud_pll_user", "ioclk_audiocdclk0",};
> @@ -3011,16 +3030,11 @@ static void __init exynos5433_cmu_disp_init(struct device_node *np)
>  	.nr_clk_ids		= AUD_NR_CLK,
>  	.clk_regs		= aud_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
> +	.suspend_regs		= aud_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(aud_suspend_regs),
> +	.clk_name		= "fout_aud_pll",
>  };
>  
> -static void __init exynos5433_cmu_aud_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &aud_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_aud, "samsung,exynos5433-cmu-aud",
> -		exynos5433_cmu_aud_init);
> -
> -
>  /*
>   * Register offset definitions for CMU_BUS{0|1|2}
>   */
> @@ -3222,6 +3236,10 @@ static void __init exynos5433_cmu_aud_init(struct device_node *np)
>  	CLK_STOPCTRL,
>  };
>  
> +static const struct samsung_clk_reg_dump g3d_suspend_regs[] = {
> +	{ MUX_SEL_G3D, 0 },
> +};
> +
>  /* list of all parent clock list */
>  PNAME(mout_aclk_g3d_400_p)	= { "mout_g3d_pll", "aclk_g3d_400", };
>  PNAME(mout_g3d_pll_p)		= { "oscclk", "fout_g3d_pll", };
> @@ -3295,15 +3313,11 @@ static void __init exynos5433_cmu_aud_init(struct device_node *np)
>  	.nr_clk_ids		= G3D_NR_CLK,
>  	.clk_regs		= g3d_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
> +	.suspend_regs		= g3d_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(g3d_suspend_regs),
> +	.clk_name		= "aclk_g3d_400",
>  };
>  
> -static void __init exynos5433_cmu_g3d_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &g3d_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_g3d, "samsung,exynos5433-cmu-g3d",
> -		exynos5433_cmu_g3d_init);
> -
>  /*
>   * Register offset definitions for CMU_GSCL
>   */
> @@ -3342,6 +3356,12 @@ static void __init exynos5433_cmu_g3d_init(struct device_node *np)
>  	ENABLE_IP_GSCL_SECURE_SMMU_GSCL2,
>  };
>  
> +static const struct samsung_clk_reg_dump gscl_suspend_regs[] = {
> +	{ MUX_SEL_GSCL, 0 },
> +	{ ENABLE_ACLK_GSCL, 0xfff },
> +	{ ENABLE_PCLK_GSCL, 0xff },
> +};
> +
>  /* list of all parent clock list */
>  PNAME(aclk_gscl_111_user_p)	= { "oscclk", "aclk_gscl_111", };
>  PNAME(aclk_gscl_333_user_p)	= { "oscclk", "aclk_gscl_333", };
> @@ -3436,15 +3456,11 @@ static void __init exynos5433_cmu_g3d_init(struct device_node *np)
>  	.nr_clk_ids		= GSCL_NR_CLK,
>  	.clk_regs		= gscl_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(gscl_clk_regs),
> +	.suspend_regs		= gscl_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(gscl_suspend_regs),
> +	.clk_name		= "aclk_gscl_111",
>  };
>  
> -static void __init exynos5433_cmu_gscl_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &gscl_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_gscl, "samsung,exynos5433-cmu-gscl",
> -		exynos5433_cmu_gscl_init);
> -
>  /*
>   * Register offset definitions for CMU_APOLLO
>   */
> @@ -3970,6 +3986,11 @@ static void __init exynos5433_cmu_atlas_init(struct device_node *np)
>  	ENABLE_IP_MSCL_SECURE_SMMU_JPEG,
>  };
>  
> +static const struct samsung_clk_reg_dump mscl_suspend_regs[] = {
> +	{ MUX_SEL_MSCL0, 0 },
> +	{ MUX_SEL_MSCL1, 0 },
> +};
> +
>  /* list of all parent clock list */
>  PNAME(mout_sclk_jpeg_user_p)		= { "oscclk", "sclk_jpeg_mscl", };
>  PNAME(mout_aclk_mscl_400_user_p)	= { "oscclk", "aclk_mscl_400", };
> @@ -4082,15 +4103,11 @@ static void __init exynos5433_cmu_atlas_init(struct device_node *np)
>  	.nr_clk_ids		= MSCL_NR_CLK,
>  	.clk_regs		= mscl_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(mscl_clk_regs),
> +	.suspend_regs		= mscl_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(mscl_suspend_regs),
> +	.clk_name		= "aclk_mscl_400",
>  };
>  
> -static void __init exynos5433_cmu_mscl_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &mscl_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_mscl, "samsung,exynos5433-cmu-mscl",
> -		exynos5433_cmu_mscl_init);
> -
>  /*
>   * Register offset definitions for CMU_MFC
>   */
> @@ -4120,6 +4137,10 @@ static void __init exynos5433_cmu_mscl_init(struct device_node *np)
>  	ENABLE_IP_MFC_SECURE_SMMU_MFC,
>  };
>  
> +static const struct samsung_clk_reg_dump mfc_suspend_regs[] = {
> +	{ MUX_SEL_MFC, 0 },
> +};
> +
>  PNAME(mout_aclk_mfc_400_user_p)		= { "oscclk", "aclk_mfc_400", };
>  
>  static const struct samsung_mux_clock mfc_mux_clks[] __initconst = {
> @@ -4190,15 +4211,11 @@ static void __init exynos5433_cmu_mscl_init(struct device_node *np)
>  	.nr_clk_ids		= MFC_NR_CLK,
>  	.clk_regs		= mfc_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
> +	.suspend_regs		= mfc_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(mfc_suspend_regs),
> +	.clk_name		= "aclk_mfc_400",
>  };
>  
> -static void __init exynos5433_cmu_mfc_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &mfc_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_mfc, "samsung,exynos5433-cmu-mfc",
> -		exynos5433_cmu_mfc_init);
> -
>  /*
>   * Register offset definitions for CMU_HEVC
>   */
> @@ -4228,6 +4245,10 @@ static void __init exynos5433_cmu_mfc_init(struct device_node *np)
>  	ENABLE_IP_HEVC_SECURE_SMMU_HEVC,
>  };
>  
> +static const struct samsung_clk_reg_dump hevc_suspend_regs[] = {
> +	{ MUX_SEL_HEVC, 0 },
> +};
> +
>  PNAME(mout_aclk_hevc_400_user_p)	= { "oscclk", "aclk_hevc_400", };
>  
>  static const struct samsung_mux_clock hevc_mux_clks[] __initconst = {
> @@ -4300,15 +4321,11 @@ static void __init exynos5433_cmu_mfc_init(struct device_node *np)
>  	.nr_clk_ids		= HEVC_NR_CLK,
>  	.clk_regs		= hevc_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(hevc_clk_regs),
> +	.suspend_regs		= hevc_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(hevc_suspend_regs),
> +	.clk_name		= "aclk_hevc_400",
>  };
>  
> -static void __init exynos5433_cmu_hevc_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &hevc_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_hevc, "samsung,exynos5433-cmu-hevc",
> -		exynos5433_cmu_hevc_init);
> -
>  /*
>   * Register offset definitions for CMU_ISP
>   */
> @@ -4342,6 +4359,10 @@ static void __init exynos5433_cmu_hevc_init(struct device_node *np)
>  	ENABLE_IP_ISP3,
>  };
>  
> +static const struct samsung_clk_reg_dump isp_suspend_regs[] = {
> +	{ MUX_SEL_ISP, 0 },
> +};
> +
>  PNAME(mout_aclk_isp_dis_400_user_p)	= { "oscclk", "aclk_isp_dis_400", };
>  PNAME(mout_aclk_isp_400_user_p)		= { "oscclk", "aclk_isp_400", };
>  
> @@ -4553,15 +4574,11 @@ static void __init exynos5433_cmu_hevc_init(struct device_node *np)
>  	.nr_clk_ids		= ISP_NR_CLK,
>  	.clk_regs		= isp_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(isp_clk_regs),
> +	.suspend_regs		= isp_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(isp_suspend_regs),
> +	.clk_name		= "aclk_isp_400",
>  };
>  
> -static void __init exynos5433_cmu_isp_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &isp_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_isp, "samsung,exynos5433-cmu-isp",
> -		exynos5433_cmu_isp_init);
> -
>  /*
>   * Register offset definitions for CMU_CAM0
>   */
> @@ -4625,6 +4642,15 @@ static void __init exynos5433_cmu_isp_init(struct device_node *np)
>  	ENABLE_IP_CAM02,
>  	ENABLE_IP_CAM03,
>  };
> +
> +static const struct samsung_clk_reg_dump cam0_suspend_regs[] = {
> +	{ MUX_SEL_CAM00, 0 },
> +	{ MUX_SEL_CAM01, 0 },
> +	{ MUX_SEL_CAM02, 0 },
> +	{ MUX_SEL_CAM03, 0 },
> +	{ MUX_SEL_CAM04, 0 },
> +};
> +
>  PNAME(mout_aclk_cam0_333_user_p)	= { "oscclk", "aclk_cam0_333", };
>  PNAME(mout_aclk_cam0_400_user_p)	= { "oscclk", "aclk_cam0_400", };
>  PNAME(mout_aclk_cam0_552_user_p)	= { "oscclk", "aclk_cam0_552", };
> @@ -5030,15 +5056,11 @@ static void __init exynos5433_cmu_isp_init(struct device_node *np)
>  	.nr_clk_ids		= CAM0_NR_CLK,
>  	.clk_regs		= cam0_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(cam0_clk_regs),
> +	.suspend_regs		= cam0_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(cam0_suspend_regs),
> +	.clk_name		= "aclk_cam0_400",
>  };
>  
> -static void __init exynos5433_cmu_cam0_init(struct device_node *np)
> -{
> -	samsung_cmu_register_one(np, &cam0_cmu_info);
> -}
> -CLK_OF_DECLARE(exynos5433_cmu_cam0, "samsung,exynos5433-cmu-cam0",
> -		exynos5433_cmu_cam0_init);
> -
>  /*
>   * Register offset definitions for CMU_CAM1
>   */
> @@ -5085,6 +5107,12 @@ static void __init exynos5433_cmu_cam0_init(struct device_node *np)
>  	ENABLE_IP_CAM12,
>  };
>  
> +static const struct samsung_clk_reg_dump cam1_suspend_regs[] = {
> +	{ MUX_SEL_CAM10, 0 },
> +	{ MUX_SEL_CAM11, 0 },
> +	{ MUX_SEL_CAM12, 0 },
> +};
> +
>  PNAME(mout_sclk_isp_uart_user_p)	= { "oscclk", "sclk_isp_uart_cam1", };
>  PNAME(mout_sclk_isp_spi1_user_p)	= { "oscclk", "sclk_isp_spi1_cam1", };
>  PNAME(mout_sclk_isp_spi0_user_p)	= { "oscclk", "sclk_isp_spi0_cam1", };
> @@ -5403,11 +5431,222 @@ static void __init exynos5433_cmu_cam0_init(struct device_node *np)
>  	.nr_clk_ids		= CAM1_NR_CLK,
>  	.clk_regs		= cam1_clk_regs,
>  	.nr_clk_regs		= ARRAY_SIZE(cam1_clk_regs),
> +	.suspend_regs		= cam1_suspend_regs,
> +	.nr_suspend_regs	= ARRAY_SIZE(cam1_suspend_regs),
> +	.clk_name		= "aclk_cam1_400",
> +};
> +
> +
> +struct exynos5433_cmu_data {
> +	struct samsung_clk_reg_dump *clk_save;
> +	unsigned int nr_clk_save;
> +	const struct samsung_clk_reg_dump *clk_suspend;
> +	unsigned int nr_clk_suspend;
> +
> +	struct clk *clk;
> +	struct clk **pclks;
> +	int nr_pclks;
> +
> +	/* must be the last entry */
> +	struct samsung_clk_provider ctx;
> +};
> +
> +static int exynos5433_cmu_suspend(struct device *dev)
> +{
> +	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
> +	int i;
> +
> +	samsung_clk_save(data->ctx.reg_base, data->clk_save,
> +			 data->nr_clk_save);
> +
> +	for (i = 0; i < data->nr_pclks; i++)
> +		clk_prepare_enable(data->pclks[i]);
> +
> +	samsung_clk_restore(data->ctx.reg_base, data->clk_suspend,
> +			    data->nr_clk_suspend);

This looks surprising and requires one to read the commit message to get
the idea. How about adding a comment why this is not usual save
operation?

> +
> +	for (i = 0; i < data->nr_pclks; i++)
> +		clk_disable_unprepare(data->pclks[i]);
> +
> +	clk_disable_unprepare(data->clk);
> +
> +	return 0;
> +}
> +
> +static int exynos5433_cmu_resume(struct device *dev)
> +{
> +	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
> +	int i;
> +
> +	clk_prepare_enable(data->clk);
> +
> +	for (i = 0; i < data->nr_pclks; i++)
> +		clk_prepare_enable(data->pclks[i]);
> +
> +	samsung_clk_restore(data->ctx.reg_base, data->clk_save,
> +			    data->nr_clk_save);
> +
> +	for (i = 0; i < data->nr_pclks; i++)
> +		clk_disable_unprepare(data->pclks[i]);
> +
> +	return 0;
> +}
> +
> +static int __init exynos5433_cmu_probe(struct platform_device *pdev)
> +{
> +	const struct samsung_cmu_info *info;
> +	struct exynos5433_cmu_data *data;
> +	struct samsung_clk_provider *ctx;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *reg_base;
> +	int i;
> +
> +	info = of_device_get_match_data(dev);
> +
> +	data = devm_kzalloc(dev, sizeof(*data) +
> +			    sizeof(*data->ctx.clk_data.hws) * info->nr_clk_ids,
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	ctx = &data->ctx;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg_base)) {
> +		dev_err(dev, "failed to map registers\n");
> +		return PTR_ERR(reg_base);
> +	}
> +
> +	for (i = 0; i < info->nr_clk_ids; ++i)
> +		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
> +
> +	ctx->clk_data.num = info->nr_clk_ids;
> +	ctx->reg_base = reg_base;
> +	ctx->dev = dev;
> +	spin_lock_init(&ctx->lock);
> +
> +	data->clk_save = samsung_clk_alloc_reg_dump(info->clk_regs,
> +						    info->nr_clk_regs);
> +	data->nr_clk_save = info->nr_clk_regs;
> +	data->clk_suspend = info->suspend_regs;
> +	data->nr_clk_suspend = info->nr_suspend_regs;
> +	data->nr_pclks = of_count_phandle_with_args(dev->of_node, "clocks",
> +						    "#clock-cells");
> +	if (data->nr_pclks > 0) {
> +		data->pclks = devm_kcalloc(dev, sizeof(struct clk *),
> +					   data->nr_pclks, GFP_KERNEL);
> +
> +		for (i = 0; i < data->nr_pclks; i++) {
> +			struct clk *clk = of_clk_get(dev->of_node, i);
> +
> +			if (IS_ERR(clk))
> +				return PTR_ERR(clk);
> +			data->pclks[i] = clk;
> +		}
> +	}
> +
> +	if (info->clk_name)
> +		data->clk = clk_get(dev, info->clk_name);
> +	clk_prepare_enable(data->clk);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	/*
> +	 * Enable runtime PM here to allow the clock core using runtime PM
> +	 * for the registered clocks. Additionally, we increase the runtime
> +	 * PM usage count before registering the clocks, to prevent the
> +	 * clock core from runtime suspending the device.
> +	 */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	if (info->pll_clks)
> +		samsung_clk_register_pll(ctx, info->pll_clks, info->nr_pll_clks,
> +					 reg_base);
> +	if (info->mux_clks)
> +		samsung_clk_register_mux(ctx, info->mux_clks,
> +					 info->nr_mux_clks);
> +	if (info->div_clks)
> +		samsung_clk_register_div(ctx, info->div_clks,
> +					 info->nr_div_clks);
> +	if (info->gate_clks)
> +		samsung_clk_register_gate(ctx, info->gate_clks,
> +					  info->nr_gate_clks);
> +	if (info->fixed_clks)
> +		samsung_clk_register_fixed_rate(ctx, info->fixed_clks,
> +						info->nr_fixed_clks);
> +	if (info->fixed_factor_clks)
> +		samsung_clk_register_fixed_factor(ctx, info->fixed_factor_clks,
> +						  info->nr_fixed_factor_clks);
> +
> +	samsung_clk_of_add_provider(dev->of_node, ctx);
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id exynos5433_cmu_of_match[] = {

Since this is used only when matching devices maybe it can be also
marked as refdata?


Best regards,
Krzysztof

> +	{
> +		.compatible = "samsung,exynos5433-cmu-aud",
> +		.data = &aud_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-cam0",
> +		.data = &cam0_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-cam1",
> +		.data = &cam1_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-disp",
> +		.data = &disp_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-g2d",
> +		.data = &g2d_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-g3d",
> +		.data = &g3d_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-fsys",
> +		.data = &fsys_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-gscl",
> +		.data = &gscl_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-mfc",
> +		.data = &mfc_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-hevc",
> +		.data = &hevc_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-isp",
> +		.data = &isp_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos5433-cmu-mscl",
> +		.data = &mscl_cmu_info,
> +	}, {
> +	},
> +};
> +
> +static const struct dev_pm_ops exynos5433_cmu_pm_ops = {
> +	SET_RUNTIME_PM_OPS(exynos5433_cmu_suspend, exynos5433_cmu_resume,
> +			   NULL)
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				     pm_runtime_force_resume)
> +};
> +
> +static struct platform_driver exynos5433_cmu_driver __refdata = {
> +	.driver	= {
> +		.name = "exynos5433-cmu",
> +		.of_match_table = exynos5433_cmu_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = &exynos5433_cmu_pm_ops,
> +	},
> +	.probe = exynos5433_cmu_probe,
>  };
>  
> -static void __init exynos5433_cmu_cam1_init(struct device_node *np)
> +static int __init exynos5433_cmu_init(void)
>  {
> -	samsung_cmu_register_one(np, &cam1_cmu_info);
> +	return platform_driver_register(&exynos5433_cmu_driver);
>  }
> -CLK_OF_DECLARE(exynos5433_cmu_cam1, "samsung,exynos5433-cmu-cam1",
> -		exynos5433_cmu_cam1_init);
> +core_initcall(exynos5433_cmu_init);
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index f0acae4f5d1b..d93031e94387 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -353,6 +353,12 @@ struct samsung_cmu_info {
>  	/* list and number of clocks registers */
>  	const unsigned long *clk_regs;
>  	unsigned int nr_clk_regs;
> +
> +	/* list and number of clocks registers to set before suspend */
> +	const struct samsung_clk_reg_dump *suspend_regs;
> +	unsigned int nr_suspend_regs;
> +	/* name of the parent clock needed for CMU register access */
> +	const char *clk_name;
>  };
>  
>  extern struct samsung_clk_provider *__init samsung_clk_init(
> -- 
> 1.9.1
> 

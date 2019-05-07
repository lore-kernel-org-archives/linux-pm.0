From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v7 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
Date: Tue, 7 May 2019 10:59:00 +0200
Message-ID: <c6f4cf53-0238-073a-eeee-28a62835c914@partner.samsung.com>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b@eucas1p2.samsung.com>
        <1557155521-30949-3-git-send-email-l.luba@partner.samsung.com>
        <3446b2d0-bf6a-66e9-9841-533fae4b27af@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3446b2d0-bf6a-66e9-9841-533fae4b27af@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 5/7/19 9:36 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
>> This patch provides support for clocks needed for Dynamic Memory Controller
>> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
>> GATE entries.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 58 +++++++++++++++++++++++++++++++++---
>>   1 file changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 34cce3c..af62b6d 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -134,6 +134,8 @@
>>   #define SRC_CDREX		0x20200
>>   #define DIV_CDREX0		0x20500
>>   #define DIV_CDREX1		0x20504
>> +#define GATE_BUS_CDREX0		0x20700
>> +#define GATE_BUS_CDREX1		0x20704
>>   #define KPLL_LOCK		0x28000
>>   #define KPLL_CON0		0x28100
>>   #define SRC_KFC			0x28200
>> @@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>>   	DIV_CDREX1,
>>   	SRC_KFC,
>>   	DIV_KFC0,
>> +	GATE_BUS_CDREX0,
>> +	GATE_BUS_CDREX1,
>>   };
>>   
>>   static const unsigned long exynos5800_clk_regs[] __initconst = {
>> @@ -425,6 +429,9 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>>   PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>>   PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>>   PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
>> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
>> +					"mout_sclk_mpll", "ff_dout_spll2",
>> +					"mout_sclk_spll", "mout_sclk_epll"};
>>   
>>   /* fixed rate clocks generated outside the soc */
>>   static struct samsung_fixed_rate_clock
>> @@ -450,7 +457,7 @@ static const struct samsung_fixed_factor_clock
>>   static const struct samsung_fixed_factor_clock
>>   		exynos5800_fixed_factor_clks[] __initconst = {
>>   	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
>> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>>   };
>>   
>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>> @@ -472,11 +479,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>>   	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>>   
>> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
>> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
>> +
>>   	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
>> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>>   	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>>   			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
>> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>>   	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>>   
>>   	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>> @@ -648,7 +658,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>   
>>   	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>>   	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
>> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>>   	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>>   	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>   	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>> @@ -806,8 +816,21 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>   			"mout_aclk400_disp1", DIV_TOP2, 4, 3),
>>   
>>   	/* CDREX Block */
>> +	/*
>> +	 * The three clocks below are controlled using the same register and
>> +	 * bits. They are put into one because there is a need of
>> +	 * synchronization between the BUS and DREXs (two external memory
>> +	 * interfaces).
>> +	 * They are put here to show this HW assumption and for clock
>> +	 * information summary completeness.
>> +	 */
>>   	DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
>>   			DIV_CDREX0, 28, 3),
>> +	DIV(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
>> +			DIV_CDREX0, 28, 3),
>> +	DIV(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
>> +			DIV_CDREX0, 28, 3),
>> +
>>   	DIV_F(CLK_DOUT_SCLK_CDREX, "dout_sclk_cdrex", "mout_mclk_cdrex",
>>   			DIV_CDREX0, 24, 3, CLK_SET_RATE_PARENT, 0),
>>   	DIV(CLK_DOUT_ACLK_CDREX1, "dout_aclk_cdrex1", "dout_clk2x_phy0",
>> @@ -817,6 +840,7 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>>   	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>>   			DIV_CDREX0, 3, 5),
>>   
>> +
> 
> Maybe, it is not related to this patch? Please remove it.
OK
> 
>>   	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>>   			DIV_CDREX1, 8, 3),
>>   
>> @@ -1170,6 +1194,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>>   			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>>   
>>   	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
>> +
>> +	/* CDREX */
>> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
>> +			GATE_BUS_CDREX0, 0, 0, 0),
>> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
>> +			GATE_BUS_CDREX0, 1, 0, 0),
>> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
>> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
>> +
>> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
>> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
>> +
>> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
>> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
>> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
>>   };
>>   
>>   static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
>>
> 
> If you fix minor issue about adding the unneeded blanke line,
> feel free to add my acked-by tag:
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you.

Regards,
Lukasz
> 

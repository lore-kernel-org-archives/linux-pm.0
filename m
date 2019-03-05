From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 6/8] DT: arm: exynos: add DMC device for exynos5422
Date: Tue, 5 Mar 2019 12:36:59 +0100
Message-ID: <CAJKOXPdXQuGotKONE4GR8AZr1gMZHM3dgAu-TSKSDqVeYw5zWw@mail.gmail.com>
References: <CGME20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023@eucas1p2.samsung.com>
 <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com> <1551781151-5562-7-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551781151-5562-7-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, kgene@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, s.nawrocki@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Mar 2019 at 11:19, Lukasz Luba <l.luba@partner.samsung.com>
wrote:>> Add description of Dynamic Memory Controller and PPMU
counters.> They are used by exynos5422-dmc driver.>> Signed-off-by:
Lukasz Luba <l.luba@partner.samsung.com>In previous email I asked to
fix the subject prefix in case of resend. Please fix it.

> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 83 +++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 87 +++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..fc00fda 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -235,6 +235,41 @@
>                         status = "disabled";
>                 };
>
> +               dmc: memory-controller@10c20000 {
> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                               <0x10000000 0x1000>;
> +                       clocks = <&clock CLK_FOUT_SPLL>,
> +                                <&clock CLK_MOUT_SCLK_SPLL>,
> +                                <&clock CLK_FF_DOUT_SPLL2>,
> +                                <&clock CLK_FOUT_BPLL>,
> +                                <&clock CLK_MOUT_BPLL>,
> +                                <&clock CLK_SCLK_BPLL>,
> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                                <&clock CLK_MOUT_MCLK_CDREX>,
> +                                <&clock CLK_DOUT_CLK2X_PHY0>,
> +                                <&clock CLK_CLKM_PHY0>,
> +                                <&clock CLK_CLKM_PHY1>,
> +                                <&clock CLK_CDREX_PAUSE>,
> +                                <&clock CLK_CDREX_TIMING_SET>;
> +                       clock-names = "fout_spll",
> +                                     "mout_sclk_spll",
> +                                     "ff_dout_spll2",
> +                                     "fout_bpll",
> +                                     "mout_bpll",
> +                                     "sclk_bpll",
> +                                     "mout_mx_mspll_ccore",
> +                                     "mout_mx_mspll_ccore_phy",
> +                                     "mout_mclk_cdrex",
> +                                     "dout_clk2x_phy0",
> +                                     "clkm_phy0",
> +                                     "clkm_phy1",
> +                                     "clk_cdrex_pause",
> +                                     "clk_cdrex_timing_set";
> +                       status = "disabled";
> +               };
> +
>                 nocp_mem0_0: nocp@10ca1000 {
>                         compatible = "samsung,exynos5420-nocp";
>                         reg = <0x10CA1000 0x200>;
> @@ -271,6 +306,54 @@
>                         status = "disabled";
>                 };
>
> +               ppmu_dmc0_0: ppmu@10d00000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d00000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                                       event-name = "ppmu-event3-dmc0_0";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc0_1: ppmu@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d10000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                                       event-name = "ppmu-event3-dmc0_1";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_0: ppmu@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d60000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                                       event-name = "ppmu-event3-dmc1_0";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_1: ppmu@10d70000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d70000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                                       event-name = "ppmu-event3-dmc1_1";
> +                               };
> +                       };
> +               };
> +
>                 gsc_pd: power-domain@10044000 {
>                         compatible = "samsung,exynos4210-pd";
>                         reg = <0x10044000 0x20>;
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index bf09eab..6b28fb3 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -34,6 +34,69 @@
>                         clock-frequency = <24000000>;
>                 };
>         };
> +
> +       dmc_opp_table: opp_table2 {
> +               compatible = "operating-points-v2";
> +
> +               opp00 {
> +                       opp-hz = /bits/ 64 <165000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp01 {
> +                       opp-hz = /bits/ 64 <206000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp02 {
> +                       opp-hz = /bits/ 64 <275000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp03 {
> +                       opp-hz = /bits/ 64 <413000000>;
> +                       opp-microvolt = <887500>;
> +               };
> +               opp04 {
> +                       opp-hz = /bits/ 64 <543000000>;
> +                       opp-microvolt = <937500>;
> +               };
> +               opp05 {
> +                       opp-hz = /bits/ 64 <633000000>;
> +                       opp-microvolt = <1012500>;
> +               };
> +               opp06 {
> +                       opp-hz = /bits/ 64 <728000000>;
> +                       opp-microvolt = <1037500>;
> +               };
> +               opp07 {
> +                       opp-hz = /bits/ 64 <825000000>;
> +                       opp-microvolt = <1050000>;
> +               };
> +       };
> +
> +       dmc_bypass_mode: bypass_mode {
> +               compatible = "samsung,dmc-bypass-mode";
> +
> +               freq-hz = <400000000>;
> +               volt-uv = <887500>;
> +               dram-timing-row = <0x365a9713>;
> +               dram-timing-data = <0x4740085e>;
> +               dram-timing-power = <0x543a0446>;
> +       };
> +
> +       dram_timing: timing {
> +               compatible = "samsung,dram-timing";
> +
> +               dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
> +                                   "543MHz", "633MHz", "728MHz", "825MHz";
> +               dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
> +                                 <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
> +                                 <0x30598651>, <0x365A9713>;
> +               dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
> +                                  <0x2720085E>, <0x3730085E>, <0x3730085E>,
> +                                  <0x3730085E>, <0x4740085E>;
> +               dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
> +                                   <0x2C1D0225>, <0x38270335>, <0x402D0335>,
> +                                   <0x4C330336>, <0x543A0446>;
> +       };
>  };
>
>  &bus_wcore {
> @@ -127,6 +190,14 @@
>         cpu-supply = <&buck2_reg>;
>  };
>
> +&dmc {
> +       devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                       <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +
> +       operating-points-v2 = <&dmc_opp_table>;

The opp-tables have voltage entry but I do not see the regulator
supply. How do you change the voltage?

Best regards,
Krzysztof

From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 2/3] arm64: dts: exynos: Add TMU sensor dt node for
 Exynos5433 SoC
Date: Wed, 04 Mar 2015 11:48:02 +0100
Message-ID: <20150304114802.33101b6f@amdc2363>
References: <1424950521-6236-1-git-send-email-cw00.choi@samsung.com>
 <1424950521-6236-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1424950521-6236-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, inki.dae@samsung.com, amit.daniel@samsung.com, kgene@kernel.org, a.kesavan@samsung.com, chanho61.park@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

> This patch adds the TMU (Thermal Management Unit) sensor devicetree
> node for Exynos5433. The Exynos5433 includes the five temperature
> sensors as following:
> - two temperature sensor for Cortex-A57 (ATLAS)
> - one temperature sensor for Cortex-A53 (APOLLO)
> - one temperature sensor for G3D IP
> - one temperature sensor for ISP IP
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> ---
>  .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     | 22 +++++++++
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 55
> ++++++++++++++++++++++ 2 files changed, 77 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
> 
> diff --git
> a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
> b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi new file
> mode 100644 index 0000000..396e60f --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
> @@ -0,0 +1,22 @@
> +/*
> + * Device tree sources for Exynos5433 TMU sensor configuration
> + *
> + * Copyright (c) 2015 Chanwoo Choi <cw00.choi@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <dt-bindings/thermal/thermal_exynos.h>
> +
> +#thermal-sensor-cells = <0>;
> +samsung,tmu_gain = <8>;
> +samsung,tmu_reference_voltage = <16>;
> +samsung,tmu_noise_cancel_mode = <4>;
> +samsung,tmu_efuse_value = <75>;
> +samsung,tmu_min_efuse_value = <40>;
> +samsung,tmu_max_efuse_value = <150>;
> +samsung,tmu_first_point_trim = <25>;
> +samsung,tmu_second_point_trim = <85>;
> +samsung,tmu_default_temp_offset = <50>;
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> b/arch/arm64/boot/dts/exynos/exynos5433.dtsi index 0776b6d..b44ddcc
> 100644 --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -872,6 +872,61 @@
>  			status = "disabled";
>  		};
>  
> +		tmu_atlas0: tmu@10060000 {
> +			compatible = "samsung,exynos5433-tmu";
> +			reg = <0x10060000 0x200>;
> +			interrupts = <0 95 0>;
> +			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
> +				 <&cmu_peris CLK_SCLK_TMU0>;
> +			clock-names = "tmu_apbif", "tmu_sclk";
> +			#include "exynos5433-tmu-sensor-conf.dtsi"
> +			status = "disabled";
> +		};
> +
> +		tmu_atlas1: tmu@10068000 {
> +			compatible = "samsung,exynos5433-tmu";
> +			reg = <0x10068000 0x200>;
> +			interrupts = <0 96 0>;
> +			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
> +				 <&cmu_peris CLK_SCLK_TMU0>;
> +			clock-names = "tmu_apbif", "tmu_sclk";
> +			#include "exynos5433-tmu-sensor-conf.dtsi"
> +			status = "disabled";
> +		};
> +
> +		tmu_g3d: tmu@10070000 {
> +			compatible = "samsung,exynos5433-tmu";
> +			reg = <0x10070000 0x200>;
> +			interrupts = <0 99 0>;
> +			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
> +				 <&cmu_peris CLK_SCLK_TMU1>;
> +			clock-names = "tmu_apbif", "tmu_sclk";
> +			#include "exynos5433-tmu-sensor-conf.dtsi"
> +			status = "disabled";
> +		};
> +
> +		tmu_apollo: tmu@10078000 {
> +			compatible = "samsung,exynos5433-tmu";
> +			reg = <0x10078000 0x200>;
> +			interrupts = <0 115 0>;
> +			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
> +				 <&cmu_peris CLK_SCLK_TMU1>;
> +			clock-names = "tmu_apbif", "tmu_sclk";
> +			#include "exynos5433-tmu-sensor-conf.dtsi"
> +			status = "disabled";
> +		};
> +
> +		tmu_isp: tmu@1007c000 {
> +			compatible = "samsung,exynos5433-tmu";
> +			reg = <0x1007c000 0x200>;
> +			interrupts = <0 94 0>;
> +			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
> +				 <&cmu_peris CLK_SCLK_TMU1>;
> +			clock-names = "tmu_apbif", "tmu_sclk";
> +			#include "exynos5433-tmu-sensor-conf.dtsi"
> +			status = "disabled";
> +		};
> +
>  		pmu_system_controller: system-controller@105c0000 {
>  			compatible = "samsung,exynos5433-pmu",
> "syscon"; reg = <0x105c0000 0x5008>;

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

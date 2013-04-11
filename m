From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [9/9] ARM: dts: Add device tree node for exynos5440 TMU controller
Date: Thu, 11 Apr 2013 17:15:50 -0400
Message-ID: <51672806.5040501@ti.com>
References: <1364297642-2746-10-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364297642-2746-10-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, grant.likely@secretlab.ca, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

Amit,

Copying Grant for DT.

On 26-03-2013 07:34, Amit Daniel Kachhap wrote:
> This patch adds device node for TMU controller. There are 3
> instances of the controllers so 3 nodes are created.
>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>
> ---
> arch/arm/boot/dts/exynos5440.dtsi |   43 +++++++++++++++++++++++++++++++++++++
>   1 files changed, 43 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 5f3562a..b74ce9f 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -16,6 +16,12 @@
>
>   	interrupt-parent = <&gic>;
>
> +	aliases {
> +		tmuctrl0 = &tmuctrl_0;
> +		tmuctrl1 = &tmuctrl_1;
> +		tmuctrl2 = &tmuctrl_2;
> +	};
> +
>   	gic:interrupt-controller@2E0000 {
>   		compatible = "arm,cortex-a15-gic";
>   		#interrupt-cells = <3>;
> @@ -156,4 +162,41 @@
>   		reg = <0x130000 0x1000>;
>   		interrupts = <0 17 0>, <0 16 0>;
>   	};
> +
> +	tmu_ctrl_info: tmu-ctrl-info {
> +		gain = <5>;
> +		reference-voltage = <16>;
> +		noise-cancel-mode = <4>;
> +		cal-type = <2>;
> +		cal-mode = <0>;
> +		efuse-value = <0x5b2c>;
> +		threshold-falling = <5>;
> +	};
> +
> +	tmuctrl_0: tmuctrl@160118 {
> +		compatible = "samsung,exynos5440-tmu";
> +		reg = <0x160118 0x300>;
> +		interrupts = <0 58 0>;
> +		clocks = <&clock 8>;
> +		clock-names = "tmu_apbif";
> +		tmu-ctrl-data = <&tmu_ctrl_info>;
> +	};
> +
> +	tmuctrl_1: tmuctrl@16011C {
> +		compatible = "samsung,exynos5440-tmu";
> +		reg = <0x16011C 0x300>;
> +		interrupts = <0 58 0>;
> +		clocks = <&clock 8>;
> +		clock-names = "tmu_apbif";
> +		tmu-ctrl-data = <&tmu_ctrl_info>;
> +	};
> +
> +	tmuctrl_2: tmuctrl@160120 {
> +		compatible = "samsung,exynos5440-tmu";
> +		reg = <0x160120 0x300>;
> +		interrupts = <0 58 0>;
> +		clocks = <&clock 8>;
> +		clock-names = "tmu_apbif";
> +		tmu-ctrl-data = <&tmu_ctrl_info>;
> +	};

Grant, how the above thermal data must be handled in DT? Is it fine to 
create private phandles like that?

>   };
>
Please consider the comments on patch 8.

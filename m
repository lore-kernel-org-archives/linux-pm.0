From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 19/19] ARM: dts: Add support of bus frequency for
 exynos4412-trats/odroidu3
Date: Thu, 10 Dec 2015 16:08:22 +0900
Message-ID: <566924E6.6070203@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-20-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-20-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09.12.2015 13:08, Chanwoo Choi wrote:
> THis patch adds the bus device tree nodes for both MIF (Memory) and INT
> (Internal) block to enable the bus frequency.
> 
> The DMC bus is parent device in MIF block using VDD_MIF and the LEFTBUS
> bus is parent device in INT block using VDD_INT.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 47 +++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4412-trats2.dts         | 47 +++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 171dea1e3e4a..12d08242a179 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -544,3 +544,50 @@
>  		};
>  	};
>  };
> +
> +&bus_dmc {
> +	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> +	vdd-supply = <&buck1_reg>;
> +	status = "okay";
> +};
> +
> +&bus_acp {
> +	devfreq = <&bus_dmc>;
> +	status = "okay";
> +};
> +
> +&bus_c2c {
> +	devfreq = <&bus_dmc>;
> +	status = "okay";
> +};
> +
> +&bus_leftbus {
> +	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> +	vdd-supply = <&buck3_reg>;
> +	status = "okay";
> +};
> +
> +&bus_rightbus {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_display {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_fsys {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_peri {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_mfc {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 40a474c4374b..aecd545803ad 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -1286,3 +1286,50 @@
>  	vtmu-supply = <&ldo10_reg>;
>  	status = "okay";
>  };
> +
> +&bus_dmc {
> +	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> +	vdd-supply = <&buck1_reg>;
> +	status = "okay";
> +};
> +
> +&bus_acp {
> +	devfreq = <&bus_dmc>;
> +	status = "okay";
> +};
> +
> +&bus_c2c {
> +	devfreq = <&bus_dmc>;
> +	status = "okay";
> +};
> +
> +&bus_leftbus {
> +	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> +	vdd-supply = <&buck3_reg>;
> +	status = "okay";
> +};
> +
> +&bus_rightbus {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_display {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_fsys {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_peri {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};
> +
> +&bus_mfc {
> +	devfreq = <&bus_leftbus>;
> +	status = "okay";
> +};

The nodes in both files are mostly sorted alphabetically. Could you
place them in such order as well?

Best regards,
Krzysztof

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 7/7] ARM: dts: Add support of Bus frequency using VDD_INT
 for exynos5422-odroidxu3
Date: Tue, 12 Apr 2016 12:59:03 +0200
Message-ID: <570CD4F7.6000700@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-8-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1460091646-28701-8-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
> This patch adds the bus device tree nodes for INT (Internal) block
> to enable the AMBA bus frequency scaling and add the NoC (Network on Chip)
> Probe Device Tree node to measure the bandwidht for AMBA AXI bus.
> 
> The WCORE bus bus is parent device in INT block using VDD_INT.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 1bd507bfa750..2a74abe6fc5d 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -361,6 +361,22 @@
>  	cap-sd-highspeed;
>  };
>  
> +&nocp_mem0_0 {
> +	status = "okay";
> +};
> +
> +&nocp_mem0_1 {
> +	status = "okay";
> +};
> +
> +&nocp_mem0_2 {
> +	status = "okay";
> +};
> +
> +&nocp_mem0_3 {
> +	status = "okay";
> +};
> +
>  &pinctrl_0 {
>  	hdmi_hpd_irq: hdmi-hpd-irq {
>  		samsung,pins = "gpx3-7";
> @@ -432,3 +448,86 @@
>  	vdd33-supply = <&ldo9_reg>;
>  	vdd10-supply = <&ldo11_reg>;
>  };
> +
> +&bus_wcore {
> +	devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
> +			<&nocp_mem0_2>, <&nocp_mem0_3>;
> +	vdd-supply = <&buck3_reg>;
> +	exynos,saturation-ratio = <100>;
> +	status = "okay";
> +};
> +
> +&bus_noc {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_fsys_apb {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_fsys {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_fsys2 {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_mfc {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_gen {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_peri {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_g2d {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_g2d_acp {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_jpeg {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_jpeg_apb {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_disp1_fimd {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_disp1 {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_gscl_scaler {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};
> +
> +&bus_mscl {
> +	devfreq = <&bus_wcore>;
> +	status = "okay";
> +};

Could you put the bus nodes in alphabetical order, both between them and
in relation to others (so before &clock_audss)? Let's keep the file ordered.

Best regards,
Krzysztof

From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v2 03/17] dt-bindings: cpufreq: Add binding for
 NVIDIA Tegra20/30
Date: Mon, 5 Nov 2018 15:30:00 -0600
Message-ID: <20181105213000.GA13425@bogus>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181021205501.23943-4-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Oct 21, 2018 at 11:54:47PM +0300, Dmitry Osipenko wrote:
> Add device-tree binding that describes CPU frequency-scaling hardware
> found on NVIDIA Tegra20/30 SoC's.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> new file mode 100644
> index 000000000000..a8023ea7a99f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> @@ -0,0 +1,96 @@
> +Binding for NVIDIA Tegra20 CPUFreq
> +==================================
> +
> +Required properties:
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - pll_x: main-parent for CPU clock, must be the first entry
> +  - intermediate: intermediate-parent for CPU clock
> +  - cclk: the CPU clock
> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
> +- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
> +
> +For each opp entry in 'operating-points-v2' table:
> +- opp-supported-hw: Two bitfields indicating:
> +	On Tegra20:
> +	1. CPU process ID mask
> +	2. SoC speedo ID mask
> +
> +	On Tegra30:
> +	1. CPU process ID mask
> +	2. CPU speedo ID mask
> +
> +	A bitwise AND is performed against these values and if any bit
> +	matches, the OPP gets enabled.
> +
> +- opp-microvolt: CPU voltage triplet.
> +
> +Optional properties:
> +- cpu-supply: Phandle to the CPU power supply.
> +- core-supply: Phandle to the CORE power supply.
> +- rtc-supply: Phandle to the RTC power supply, required only for Tegra20.
> +
> +Voltage supply requirements:
> +- Tegra20:
> +	CORE and RTC regulators must be coupled using the regulator-coupled-with
> +	property and regulator-coupled-max-spread property must be set to no
> +	more than 170mV.
> +
> +	See ../regulator/regulator.txt for more detail about the properties.
> +
> +- Tegra30:
> +	CORE and CPU regulators must be coupled using the regulator-coupled-with
> +	property and regulator-coupled-max-spread property must be set to no
> +	more than 300mV. Each of CORE and CPU regulators must set
> +	regulator-max-step-microvolt property to no more than 100mV.
> +
> +	See ../regulator/regulator.txt for more detail about the properties.
> +
> +
> +Example:
> +	regulators {
> +		cpu_reg: regulator0 {
> +			regulator-name = "vdd_cpu";
> +		};
> +
> +		core_reg: regulator1 {
> +			regulator-name = "vdd_core";
> +			regulator-coupled-with = <&rtc_reg>;
> +			regulator-coupled-max-spread = <170000>;
> +		};
> +
> +		rtc_reg: regulator2 {
> +			regulator-name = "vdd_rtc";
> +			regulator-coupled-with = <&core_reg>;
> +			regulator-coupled-max-spread = <170000>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +
> +		opp@456000000 {
> +			clock-latency-ns = <125000>;
> +			opp-microvolt = <825000 825000 1125000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		...
> +	};
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
> +				 <&tegra_car TEGRA20_CLK_PLL_P>,
> +				 <&tegra_car TEGRA20_CLK_CCLK>;
> +			clock-names = "pll_x", "intermediate", "cclk";

I still object to having clocks (and supplies) which don't reflect the 
h/w and are documented in the CA9 TRM.

> +			operating-points-v2 = <&cpu0_opp_table>;
> +			cpu-supply = <&cpu_reg>;
> +			core-supply = <&core_reg>;
> +			rtc-supply = <&rtc_reg>;

Supplies are suspect too, but perhaps supplies and power domains are 
beyond the scope of the TRM and part of the physical design.

Rob

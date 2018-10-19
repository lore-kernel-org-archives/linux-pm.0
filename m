From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Fri, 19 Oct 2018 14:30:13 -0700
Message-ID: <20181019213013.GW22824@google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 11, 2018 at 05:06:00PM +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..712643f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,173 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-hw".
> +
> +- clocks
> +	Usage:		required
> +	Value type:	<phandle> From common clock binding.
> +	Definition:	clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +	Usage:		required
> +	Value type:	<string> From common clock binding.
> +	Definition:	must be "xo", "cpu_clk".
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the HW bases in
> +			each frequency domain.
> +- reg-names
> +	Usage:		Optional
> +	Value type:	<string>
> +	Definition:	Frequency domain name i.e.
> +			"freq-domain0", "freq-domain1".
> +
> +- freq-domain-cells:
> +	Usage:		required.
> +	Definition:	Number of cells in a freqency domain specifier.
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
> +
> +
> +Example:
> +
> +Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
> +DCVS state together.
> +
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +				L3_0: l3-cache {
> +				      compatible = "cache";
> +				};
> +			};
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_100>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_100: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_200>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_200: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_300>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_300: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x400>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_400>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_400: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x500>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_500>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_500: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x600>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_600>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_600: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x700>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_700>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_700: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +	};
> +
> + soc {
> +	cpufreq_hw: cpufreq@17d43000 {
> +		compatible = "qcom,cpufreq-hw";
> +		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +		reg-names = "freq-domain0", "freq-domain1";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +		clock-names = "xo", "cpu_clk";
> +
> +		#freq-domain-cells = <1>

semicolon is missing.

> +

delete empty line

> +	};
> +}

Thanks

Matthias

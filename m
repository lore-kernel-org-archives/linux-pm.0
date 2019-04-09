From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Date: Tue, 9 Apr 2019 15:37:30 +0530
Message-ID: <20190409100730.2rtxyy66knjning6@vireshk-i7>
References: <20190405102455.15311-1-tiny.windzz@gmail.com>
 <20190405102455.15311-3-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190405102455.15311-3-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05-04-19, 06:24, Yangtao Li wrote:
> +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <1>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <2>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <3>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
> +		};
> +        };
> +
> +	cpu_opp_table: opp_table {
> +		compatible = "operating-points-v2-sunxi-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +		opp-shared;
> +
> +		opp-480000000-0 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-720000000-0 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-816000000-0 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-888000000-0 {
> +			opp-hz = /bits/ 64 <888000000>;
> +			opp-microvolt = <940000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1080000000-0 {
> +			opp-hz = /bits/ 64 <1080000000>;
> +			opp-microvolt = <1060000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1320000000-0 {
> +			opp-hz = /bits/ 64 <1320000000>;
> +			opp-microvolt = <1160000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1488000000-0 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <1160000>;
> +			opp-supported-hw = <0x1>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp-480000000-1 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-720000000-1 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-816000000-1 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-888000000-1 {
> +			opp-hz = /bits/ 64 <888000000>;
> +			opp-microvolt = <820000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1080000000-1 {
> +			opp-hz = /bits/ 64 <1080000000>;
> +			opp-microvolt = <880000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1320000000-1 {
> +			opp-hz = /bits/ 64 <1320000000>;
> +			opp-microvolt = <940000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1488000000-1 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <1000000>;
> +			opp-supported-hw = <0x2>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp-480000000-2 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-720000000-2 {
> +			opp-hz = /bits/ 64 <720000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-816000000-2 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-888000000-2 {
> +			opp-hz = /bits/ 64 <888000000>;
> +			opp-microvolt = <800000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1080000000-2 {
> +			opp-hz = /bits/ 64 <1080000000>;
> +			opp-microvolt = <840000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1320000000-2 {
> +			opp-hz = /bits/ 64 <1320000000>;
> +			opp-microvolt = <900000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1488000000-2 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <960000>;
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +	};

Well, this is pure duplication of all the OPPs which isn't great. If I have
understood things correctly from the above example, then all you want is a
different microvolt value for each OPP, right ?

Then you are using the wrong feature of OPP core I am afraid. What you should
rather look for is opp-microvolt-<name> property, look in opp.txt bindings.

And these are the helper you need to use:
dev_pm_opp_set_prop_name()/dev_pm_opp_put_prop_name().

-- 
viresh

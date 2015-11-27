From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 02/15] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Fri, 27 Nov 2015 14:30:45 -0600
Message-ID: <20151127203045.GA3159@rob-hp-laptop>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
 <1448545659-32287-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448545659-32287-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, k.kozlowski@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 26, 2015 at 10:47:26PM +0900, Chanwoo Choi wrote:
> This patch adds the documentation for generic exynos bus frequency
> driver.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> new file mode 100644
> index 000000000000..5d90623bd173
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -0,0 +1,92 @@
> +* Generic Exynos Bus frequency device
> +
> +The Samsung Exynos SoC have many buses for data transfer between DRAM
> +and sub-blocks in SoC. Almost Exynos SoC have the common architecture
> +for buses. Generally, the each bus of Exynos SoC includes the source clock
> +and power line and then is able to change the clock according to the usage
> +of each buses on runtime. When gathering the usage of each buses on runtime,
> +thie driver uses the exynos-ppmu.c driver with DEVFREQ-EVENT framework.

Please don't refer to Linux subsystem specifics in bindings. It looks 
like you are creating devices to match what you have for drivers, not 
what the h/w looks like.


> +There are a little different composition among Exynos SoC because each Exynos
> +SoC has the different sub-blocks. So, this difference should be specified
> +in devicetree file instead of each device driver. In result, this driver
> +is able to support the bus frequency for all Exynos SoCs.
> +
> +Required properties for bus device:
> +- compatible: Should be "samsung,exynos-bus".
> +- clock-names : the name of clock used by the bus, "bus".
> +- clocks : phandles for clock specified in "clock-names" property.
> +- #clock-cells: should be 1.
> +- operating-points-v2: the OPP table including frequency/voltage information
> +  to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
> +- vdd-supply: the regulator to provide the buses with the voltage.
> +- devfreq-events: the devfreq-event device to monitor the curret utilization
> +  of buses.
> +
> +Optional properties for bus device:
> +- exynos,saturation-ratio: the percentage value which is used to calibrate
> +                   the performance count againt total cycle count.
> +
> +Example1:
> +	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
> +	power line (regulator). The MIF (Memory Interface) AXI bus is used to
> +	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
> +
> +	- power line(VDD_MIF) --> bus for DMC block (dmc clock)
> +
> +	- MIF bus's frequency/voltage table
> +	-----------------------
> +	|Lv| Freq   | Voltage |
> +	-----------------------
> +	|L1| 50000  |800000   |
> +	|L2| 100000 |800000   |
> +	|L3| 133000 |800000   |
> +	|L4| 200000 |800000   |
> +	|L5| 400000 |875000   |
> +	-----------------------
> +
> +Example2 :
> +	The bus of DMC block in exynos3250.dtsi are listed below:

What is DMC?

> +
> +	bus_dmc: bus_dmc {
> +		compatible = "samsung,exynos-bus";

I would expect the children of this bus to be under this node.

> +		clocks = <&cmu_dmc CLK_DIV_DMC>;
> +		clock-names = "bus";
> +		operating-points-v2 = <&bus_dmc_opp_table>;
> +		status = "disabled";
> +	};
> +
> +	bus_dmc_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <50000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <133000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <800000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <875000>;
> +		};
> +	};
> +
> +	Usage case to handle the frequency and voltage of bus on runtime
> +	in exynos3250-rinato.dts are listed below:
> +
> +	&bus_dmc {
> +		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;

What do these phandles point to exactly?

> +		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
> +		status = "okay";
> +	};
> -- 
> 1.9.1
> 

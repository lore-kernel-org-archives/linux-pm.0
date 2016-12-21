From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Wed, 21 Dec 2016 15:47:12 -0800
Message-ID: <20161221234712.GH8288@codeaurora.org>
References: <20161220225530.96699-1-code@mmayer.net>
 <20161220225530.96699-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161220225530.96699-2-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/20, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add binding document for brcm,brcmstb-cpu-clk-div.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 83 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> new file mode 100644
> index 0000000..3bc99c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> @@ -0,0 +1,83 @@
> +The CPU divider node serves as the sole clock for the CPU complex. It supports
> +power-of-2 clock division, with a divider of "1" as the default highest-speed
> +setting.
> +
> +Required properties:
> +- compatible: shall be "brcm,brcmstb-cpu-clk-div"
> +- reg: address and width of the divider configuration register
> +- #clock-cells: shall be set to 0
> +- clocks: phandle of clock provider which provides the source clock
> +          (this would typically be a "fixed-clock" type PLL)
> +- div-table: list of (raw_value,divider) ordered pairs that correspond to the
> +             allowed clock divider settings
> +- div-shift-width: least-significant bit position and width of divider value
> +
> +Optional properties:
> +- clocks: additional clocks can be specified if needed
> +- clock-names: clocks can be named, so they can be looked up
> +
> +Example:
> +	sw_scb: sw_scb {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <432000000>;
> +	};
> +

Is this a PLL?

> +	fixed0: fixed0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <54000000>;
> +	};

And perhaps some sort of oscillator?

> +
> +	cpu_pdiv: cpu_pdiv@f04e0008 {
> +		compatible = "divider-clock";
> +		#clock-cells = <0>;
> +		reg = <0xf04e0008 0x4>;
> +		bit-shift = <10>;
> +		bit-mask = <0xf>;
> +		index-starts-at-one;
> +		clocks = <&fixed0>;
> +		clock-names = "fixed0";
> +	};
> +
> +	cpu_ndiv_int: cpu_ndiv_int {
> +		compatible = "fixed-factor-clock";

Ok..

> +		#clock-cells = <0>;
> +		clock-div = <1>;
> +		clock-mult = <167>;
> +		clocks = <&cpu_pdiv>;
> +		clock-names = "cpu_pdiv";
> +	};
> +
> +	cpu_mdiv_ch0: cpu_mdiv_ch0@f04e0000 {
> +		compatible = "divider-clock";

Is there a binding for this?

> +		#clock-cells = <0>;
> +		reg = <0xf04e0000 0x4>;
> +		bit-shift = <1>;
> +		bit-mask = <0xff>;
> +		index-starts-at-one;
> +		clocks = <&cpu_ndiv_int>;
> +		clock-names = "cpu_ndiv_int";
> +	};
> +
> +	cpupll: cpupll@0 {
> +		#clock-cells = <0>;
> +		clock-frequency = <1503000000>;
> +		compatible = "fixed-clock";
> +	};
> +
> +	cpuclkdiv: cpu-clk-div@0 {

Wrong unit address. Should be f03e257c?

> +		#clock-cells = <0>;
> +		clock-names = "cpupll",
> +			"cpu_mdiv_ch0",
> +			"cpu_ndiv_int",
> +			"sw_scb";
> +		clocks = <&cpupll,
> +			&cpu_mdiv_ch0,
> +			&cpu_ndiv_int,
> +			&sw_scb>;
> +		compatible = "brcm,brcmstb-cpu-clk-div";
> +		reg = <0xf03e257c 0x4>;
> +		div-table = <0x00 1>;
> +		div-shift-width = <0 5>;

This entire DT design seems wrong. We don't put these sorts of
register level details into DT. There should be a driver that
knows the type of device that is present and how to drive that
hardware.

>From what I can tell there's something like a mux controller at
0xf04e0000 and then there's some sort of divider controller at
0xf03e0000. Perhaps those are two different devices that need
independent drivers? My wild guess is the PLL control is in those
register regions too, but we're not exposing control of them.
That's ok, but don't put the PLL into the DT as a fixed clock.
Just register it from the driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

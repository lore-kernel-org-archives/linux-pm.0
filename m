From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Date: Sat, 3 Feb 2018 11:11:03 -0800
Message-ID: <20180203191103.GB9465@builder>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-3-ilina@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119000157.7380-3-ilina@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 18 Jan 16:01 PST 2018, Lina Iyer wrote:

> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the first element specifies the base address of the DRV,
> +	            the second element specifies the size of the region.

This doesn't capture the fact that there are two memory regions that
needs to be described.

[..]
> +- qcom, tcs-config:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the tuple definining the configuration of TCS.
> +	            Must have 2 cells which describe each TCS type.
> +	            <type number_of_tcs>

I think this definition should capture that it's a list of tuples and
they are describing the functional allocation of the available TCSs.

> +	- Cell #1 (TCS Type): TCS types can be specified -
> +		SLEEP_TCS
> +		WAKE_TCS
> +		ACTIVE_TCS
> +		CONTROL_TCS
> +	- Cell #2 (Number of TCS): <u32>
> +
[..]
> +EXAMPLE 1:
> +
> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV of 2, the
> +register offsets for DRV2 start at 0D00, the register calculations are like
> +this -
> +First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> +Second tuple: 0x179E0000 + 0xD00  = 0x179E0D00

So the first region is the DRV base and the second describe the TCSs? I
think that the purpose of the two regions should be clarified.

If this is the case then I would suggest also adding a

	reg-names = "drv", "tcs";

in order to make the dts self-explaining.

> +
> +	apps_rsc: rsc@179e000 {
> +		compatible = "qcom,rpmh-rsc";
> +		label = "apps_rsc";
> +		reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;
> +		interrupts = <0 5 0>;

<GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;

> +		qcom,drv-id = <2>;
> +		qcom,tcs-config = <SLEEP_TCS   3>,
> +				  <WAKE_TCS    3>,
> +				  <ACTIVE_TCS  2>,
> +				  <CONTROL_TCS 1>;
> +
> +		foo-clk {
> +			compatible = "foo-clk";
> +		};
> +	};
> +

Regards,
Bjorn

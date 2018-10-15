From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
Date: Mon, 15 Oct 2018 11:28:35 -0500
Message-ID: <20181015162835.GA20955@bogus>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Wei Xu <xuwei5@hisilicon.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/HISILICON SOC SUPPORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 25, 2018 at 11:03:06AM +0200, Daniel Lezcano wrote:
> Add the interrupt names for the sensors, so the code can rely on them
> instead of dealing with index which are prone to error.
> 
> The name comes from the Hisilicon documentation found on internet.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/thermal/hisilicon-thermal.txt         |  3 ++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 63 +++++++++++-----------
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  1 +
>  3 files changed, 36 insertions(+), 31 deletions(-)

Lots of whitespace errors reported by checkpatch.pl.

> 
> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> index cef716a..3edfae3 100644
> --- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> @@ -7,6 +7,7 @@
>    region.
>  - interrupt: The interrupt number to the cpu. Defines the interrupt used
>    by /SOCTHERM/tsensor.
> +- interrupt-names: The interrupt names for the different sensors

Need to define what the names are.

>  - clock-names: Input clock name, should be 'thermal_clk'.
>  - clocks: phandles for clock specified in "clock-names" property.
>  - #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
> @@ -18,6 +19,7 @@ for Hi6220:
>  		compatible = "hisilicon,tsensor";
>  		reg = <0x0 0xf7030700 0x0 0x1000>;
>  		interrupts = <0 7 0x4>;
> +		interrupt-names = "tsensor_intr";

That name seems pretty pointless.

>  		clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
>  		clock-names = "thermal_clk";
>  		#thermal-sensor-cells = <1>;
> @@ -28,5 +30,6 @@ for Hi3660:
>  		compatible = "hisilicon,hi3660-tsensor";
>  		reg = <0x0 0xfff30000 0x0 0x1000>;
>  		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tsensor_a73";

Just 'a73' is sufficient.

>  		#thermal-sensor-cells = <1>;
>  	};

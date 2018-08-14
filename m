From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Date: Tue, 14 Aug 2018 13:20:53 -0600
Message-ID: <20180814192053.GA28118@rob-hp-laptop>
References: <20180804070355.14857-1-manu@freebsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180804070355.14857-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Emmanuel Vadot <manu@freebsd.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> This patch adds documentation for Device-Tree bindings for the Allwinner
> Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  .../bindings/thermal/allwinner-thermal.txt    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt b/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
> new file mode 100644
> index 000000000000..5810d44cf495
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/allwinner-thermal.txt
> @@ -0,0 +1,41 @@
> +* Thermal Sensor Controller on Allwinner SoCs
> +
> +Required properties:
> +- compatible : should be "allwinner,<name>-ths"
> +   "allwinner,sun8i-h3-ths": found on H3 and H2+ SoCs
> +   "allwinner,sun50i-h5-ths": found on H5 SoC
> +   "allwinner,sun50i-a64-ths": found on H5 SoC
> +- reg : physical base address of the controller and length of memory mapped
> +	region.
> +- interrupts : The interrupt number to the cpu. The interrupt specifier format
> +	       depends on the interrupt controller.

Just need to say how many entries (and order if more than one).

> +- clocks : Must contain an entry for each entry in clock-names.
> +- clock-names : Shall be "apb" for the bus, and "ths" for
> +		the peripheral clock.
> +- resets : Must contain an entry for each entry in reset-names.
> +	   See ../reset/reset.txt for details.
> +- reset-names : Must be "apb".
> +- #thermal-sensor-cells : Depend on the SoC
> +   For H3 should be 0
> +   For H5 should be 1
> +   For A64 should be 2
> +   See ./thermal.txt for a description.
> +- nvmem-cells : Phandle to the calibration data
> +- nvmem-cell-names = Should be "ths-calib"
> +
> +Example:
> +
> +ths: thermal_sensor@1c25000 {

thermal-sensor@...

> +	compatible = "allwinner,sun8i-h3-ths";
> +	reg = <0x01c25000 0x100>;
> +	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +	clock-names = "apb", "ths";
> +	resets = <&ccu RST_BUS_THS>;
> +	reset-names = "apb";
> +	#thermal-sensor-cells = <0>;
> +	status = "disabled";
> +
> +	nvmem-cells = <&ths_calib>;
> +	nvmem-cell-names = "ths-calib";
> +};
> -- 
> 2.18.0
> 

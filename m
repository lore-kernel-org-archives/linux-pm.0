From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 17/27] dt-bindings: ap806: add the thermal node in the
 syscon file
Date: Fri, 27 Apr 2018 16:07:22 -0500
Message-ID: <20180427210722.obyujepjvqc5hwcd@rob-hp-laptop>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
 <20180421151255.29929-18-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180421151255.29929-18-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 21, 2018 at 05:12:45PM +0200, Miquel Raynal wrote:
> Explain the thermal bindings now that the thermal IP is described being
> inside of a system controller. Add a reference to the thermal-zone node.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt        | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index a856eb9a4e05..c95f3ac5c728 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -11,6 +11,9 @@ For the top level node:
>   - compatible: must be: "syscon", "simple-mfd";
>   - reg: register area of the AP806 system controller
>  
> +SYSTEM CONTROLLER 0
> +===================
> +
>  Clocks:
>  -------
>  
> @@ -98,3 +101,43 @@ ap_syscon: system-controller@6f4000 {
>  		gpio-ranges = <&ap_pinctrl 0 0 19>;
>  	};
>  };
> +
> +SYSTEM CONTROLLER 1
> +===================
> +
> +Thermal:
> +--------
> +
> +For common binding part and usage, refer to
> +Documentation/devicetree/bindings/thermal/thermal.txt
> +
> +The thermal IP can probe the temperature all around the processor. It
> +may feature several channels, each of them wired to one sensor.
> +
> +It is possible to setup an overheat interrupt by giving at least one
> +critical point to any subnode of the thermal-zone node.
> +
> +Required properties:
> +- compatible: "marvell,armada-ap806-thermal"
> +
> +Optional properties:
> +- interrupt-parent/interrupts: overheat interrupt handle. Should point to
> +  line 18 of the SEI irqchip.
> +  See interrupt-controller/interrupts.txt
> +- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
> +  to this IP and represents the channel ID. There is one sensor per
> +  channel. O refers to the thermal IP internal channel, while positive
> +  IDs refer to each CPU.
> +
> +Example:
> +ap_syscon1: system-controller@6f8000 {
> +	compatible = "syscon", "simple-mfd";
> +	reg = <0x6f8000 0x1000>;
> +
> +	ap_thermal: ap-thermal {
> +		compatible = "marvell,armada-ap806-thermal";

Is there a register range associated with the thermal functions?

> +		interrupt-parent = <&sei>;
> +		interrupts = <18>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +};
> -- 
> 2.14.1
> 
